/**
 * Creación de controles y barras de herramientas para el mapa
 * 
 */

/***
 * Create the scale line control to be added to a OL map
 */
var getScaleLineControl = function(target) {
    var scaleLine = new ol.control.ScaleLine({
        target: target,
        units: 'metric'
    });
    return scaleLine;
};

/**
 * Control de búsqueda.
 * Se utiliza ol.control.Search para buscar tanto en todas las capas cargadas en el mapa
 * como para realizar una geolocalización inversa en el servicio OSM Nominatim
 */
var getSearchControl = function(target, viewbox) {

    let map = $('#map').data('map');

    // The search control
    var search = new ol.control.Search({
        target: target,
        placeholder: "buscar...",
        label: "búsqueda",
        typing: 800,
        minLength: 4,
        maxItems: 20,
        // Título a usar en la lista.
        getTitle: function(f) {
            let ret = "";
            ret = f.get('data').nombre;
            if (ret === undefined ||  ret === "") {
                ret = f.get('name');
                if (ret === undefined) {
                    ret = f.get('data').nombre_sistema;
                } else if (ret === "") {
                    ret = "Desconocido"
                }
            };

            if (f.get('data').nombre !== undefined) {
                return getImageByEntityType(f.values_.simheb.entity_type) + f.get('data').nombre;
            } else if (f.get('data').nombre_sistema !== undefined) {
                return getImageByEntityType(f.values_.simheb.entity_type) + f.get('data').nombre_sistema;
            }

            return ret;
        },
        // Búsqueda de resultados (en OSM Nominatim)
        autocomplete: function(s, cback) {
            return new Promise((resolve, reject) => {
                let ret = []
                let searchPromises = [];

                //Search in nominatim
                searchPromises.push(searchInNominatim(s, map.getView().getProjection()).then(results => {
                    ret = ret.concat(results);
                }));

                //Search in features
                searchPromises.push(searchInSimhebFeatures(s, map).then(results => {
                    ret = ret.concat(results);
                }));

                //cuando acaban todas llamo al callback y acabo
                let result = [];
                Promise.all(searchPromises).then(function() {
                    if (cback !== null && typeof cback === 'function') {
                        // Comprobar que los resultados están dentro de los límites del mapa
                        ret.forEach(function(feature) {
                            if (feature.getGeometry() !== null && ol.extent.intersects(feature.getGeometry().getExtent(), maxExtents)) {
                                result.push(feature);
                            }
                        });

                        cback(result);
                    }
                    resolve();
                }).catch(function(e) {
                    console.log('Error en busqueda: ' + e.stack);
                    reject();
                })
            });

        }

    });

    // Centrar el mapa al seleccionar un elemento del buscador
    search.on('select', function(e) {
        var extent = e.search.getGeometry().getExtent();
        this.getMap().getView().fit(extent, { duration: 1500 });
    });

    return search;
};

/**
 * Given an entity type, return the font-awesome-based icon to display related to the element type
 * @param element_type
 * @returns HTML with the icon representation for the element type
 */
function getImageByEntityType(entity_type) {
    var icon = getIconByEntityType(entity_type);
    var color = "rgba(145,145,145,1)";

    if (icon !== "") {
        return '<span class="fa-stack"><img src="' + icon + '" class="img-fluid"></span>';
    }
    return '';
}

/**
 * Para cada tipo de entidad devuelve un icon asociado
 */
function getIconByEntityType(tipo) {
    var ret = "";
    // Icon: depending on the entity type
    if (tipo == 'station_hydro') ret = 'js/simheb/sprint_0/images/hydro_gauge.svg';
    if (tipo == 'station_meteo') ret = 'js/simheb/sprint_0/images/pluvio.svg';
    if (tipo == 'reservoir') ret = 'js/simheb/sprint_0/images/catchment.svg';
    if (tipo == 'dam') ret = 'js/simheb/sprint_0/images/dam.svg';
    if (tipo == 'catchment') ret = 'js/simheb/sprint_0/images/catchment.svg';
    if (tipo == 'system') ret = 'js/simheb/sprint_0/images/zone.svg';

    return ret;
}

/**
 * Búsqueda dentro de las capas del mapa mediante JsSearch
 * @param {string} s search string
 * @param {function} mapa del que obtener las capas
 * @return {Array|false} an array of search solutions or false if the array is send with the cback argument
 */
let featuresSearcher = null;

function searchInSimhebFeatures(s, map) {
    //-------------------------------------------
    // Crear el ojeto buscador
    // (se debe crear en cada llamada por si el mapa tiene nuevas capas)
    //-------------------------------------------
    featuresSearcher = new JsSearch.Search('id_');
    featuresSearcher.indexStrategy = new JsSearch.AllSubstringsIndexStrategy();
    featuresSearcher.searchIndex = new JsSearch.UnorderedSearchIndex();
    featuresSearcher.addIndex(['values_', 'name']);
    featuresSearcher.addIndex(['values_', 'data', 'codigo']);
    featuresSearcher.addIndex(['values_', 'data', 'nombre']);
    featuresSearcher.addIndex(['values_', 'data', 'nombre_sistema']);

    //-------------------------------------------
    // Realizar la búsqueda
    //-------------------------------------------
    return new Promise(resolve => {
        let contId = 0;
        map.getLayers().array_.forEach(function(lyr) {
            if (lyr.values_.id !== "BASE_LAYERS") {
                var ftrs = lyr.getSource().getFeatures();
                for (item in ftrs) {
                    contId++;
                    ftrs[item].id_ = contId;
                }
                featuresSearcher.addDocuments(ftrs);
            }
        });
        resolve(featuresSearcher.search(s));
    });
}

/**
 * Búsqueda en el servido de georreferenciación inverva OSN Nominatim.
 * @param {string} s search string
 * @param {proj} proyección del mapa en el que obtener los resultados
 * @param {viewBox} coordenadas latlong del bbox en el que realizar la búsqueda
 * @return {Array|false} an array of search solutions or false if the array is send with the cback argument
 */
var nominatimSearcher = null;

function searchInNominatim(s, proj, viewBox) {

    //-------------------------------------------
    // Crear el ojeto buscador
    //-------------------------------------------
    if (!nominatimSearcher) nominatimSearcher = new ol.control.SearchNominatim({ viewbox: viewBox });

    //-------------------------------------------
    // Realizar la búsqueda
    //-------------------------------------------
    return new Promise(resolve => {
        try {

            setTimeout(function() { resolve([]); }, 2500); // Por si el servicio Nominatim no responde correctamente

            nominatimSearcher.autocomplete(s, function(res) {
                var ret = [];
                // Añadir la geometría a cada resultado (para centrar el mapa)
                res.forEach(function(f) {
                    try {
                        var bbox = [Number(f.boundingbox[2]), Number(f.boundingbox[0]), Number(f.boundingbox[3]), Number(f.boundingbox[1])];
                        var ext = ol.proj.transformExtent(bbox, 'EPSG:4326', proj);
                        var ftr = new ol.Feature({ name: f.display_name, local_id: f.type, data: f, geometry: ol.geom.Polygon.fromExtent(ext) });
                        ret.push(ftr);
                    } catch (e) { console.log(e.stack); };
                });
                resolve(ret);
            });
        } catch (error) {
            resolve([]);
        }
    });
};

/***
 * Attributions para los mapas base
 */
var getAttributionControl = function(target) {
    var attribution = new ol.control.Attribution({ collapsible: true, target: target });
    return attribution;
};

/***
 * Create the side bar added to a OL map (depends on sidebarv2 library)
 */
var getSidebarControl = function(target, position) {
    var sidebar = new ol.control.Sidebar({ element: target, position: (position || 'left') });
    return sidebar;
};