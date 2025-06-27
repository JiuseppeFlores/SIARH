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

/***
 * 
 */
var getMousePositionControl = function(target) {
	var mousePositionControl = new ol.control.MousePosition({
	      coordinateFormat: ol.coordinate.createStringXY(3),
	      projection: 'EPSG:4326',
	      className: '', 
	      target: target,
	      undefinedHTML: ''
		});
	return mousePositionControl;
};

var getOverviewControl = function(target) {
	var OverviewControl = new ol.control.OverviewMap({
        className: 'ol-overviewmap ol-custom-overviewmap',
        label: '\u00BB',
        collapseLabel: '\u00AB',
        collapsed: false,
        layers: [
        	new ol.layer.Tile({
        		id: 'LAYER.BASE.OPEN_STREET_MAPS',
				title: 'OpenStreetMap',
				type: 'base',
				visible: true,
				source:  new ol.source.TileWMS({
							url: '/mapproxy/service?',
							params: {'LAYERS': 'osm_tiles', 'TILED': true, 'TRANSPARENT': true},
							crossOrigin: 'anonymous'
				})
			})
        ]
	});
	return OverviewControl;
};

/**
 * Control de búsqueda.
 * Se utiliza ol.control.Search para buscar tanto en todas las capas cargadas en el mapa
 * como para realizar una geolocalización inversa en el servicio OSM Nominatim
 */
var getSearchControl = function(target, viewbox) {
	
	let map = $('#map').data('map');
	
	// The search control
	var search = new ol.control.Search(
	{
		target: target,
		placeholder: "buscar...",
		label: "búsqueda",
		typing: 800,
		minLength: 4,
		maxItems: 20,
		// Título a usar en la lista. 
		getTitle: function(f) {
			let ret = "";
			ret = f.get('name');
			if (ret=="") ret = "Desconocido";
			return ret;
		},
		// Búsqueda de resultados (en OSM Nominatim)
		autocomplete: async function (s,cback) {
			var performSearch = async function (s, map) {
				var ret = [];
				try {
					var r2 = await searchInNominatim(s, map.getView().getProjection(), viewbox);
					// Comprobar que los resultados están dentro de los límites del mapa
					r2.forEach(function(feature) {
						if ( ol.extent.intersects(feature.getGeometry().getExtent(), map_config.maxExtents) )
							ret.push(feature);
					});
				} catch (e) { console.log('Error en busqueda: ' + e.stack); }
				return ret;
			};
			performSearch(s,map).then(results => { cback(results); });
	    	return false;
		}
		
	});
	
	// Centrar el mapa al seleccionar un elemento del buscador
	search.on('select', function(e) {
		var extent = e.search.getGeometry().getExtent();
		this.getMap().getView().fit(extent, {duration: 1500});
	});
	
	return search;
};

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
			
			setTimeout(function () { resolve ([]); }, 2500); // Por si el servicio Nominatim no responde correctamente
			
			nominatimSearcher.autocomplete(s, function(res) {
				var ret = [];
				// Añadir la geometría a cada resultado (para centrar el mapa)
				res.forEach(function(f) {
					try {
						var bbox = [Number(f.boundingbox[2]), Number(f.boundingbox[0]), Number(f.boundingbox[3]), Number(f.boundingbox[1])];
						var ext = ol.proj.transformExtent(bbox, 'EPSG:4326', proj);
						var ftr = new ol.Feature({ name: f.display_name, local_id: f.type, data: f, geometry: ol.geom.Polygon.fromExtent(ext) });
						ret.push(ftr);
					} catch(e) { console.log(e.stack);};	
				});
				resolve (ret);
			});
		} 
		catch (error) {
		    resolve ([]);
		}
	});
};

/**
 * Layers control. (depends on ol-ext library)
 */
var getLayerSwitcherControl = function(target) {
	var layerSwitcher = new ol.control.LayerSwitcher({	
		show_progress:false,
		extent: true,
		target: target,
		trash: false,
		oninfo: null,
		reordering: true
	});
	return layerSwitcher;
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
	var sidebar = new ol.control.Sidebar({ element: target, position: (position||'left') });
	return sidebar;
};
