const maxExtents = ol.extent.boundingExtent([ol.proj.fromLonLat([-69.59, -22.87]), ol.proj.fromLonLat([-57.50, -9.76])]);

var createMap = function() {
    var map = new ol.Map({
        target: $('#map').get(0),
        loadTilesWhileAnimating: true,
        loadTilesWhileInteracting: true,
        view: new ol.View({
            extent: maxExtents,
            center: ol.extent.getCenter(maxExtents),
            resolution: 2000,
            minResolution: 0.01,
            maxResolution: 2000
        }),
        layers: []
    });
    $('#map').data('map', map);

    return map;
}

var loadBaseMapping = function(map) {
    let baseLayers = new ol.layer.Group({
        id: 'BASE_LAYERS',
        title: 'Mapas base',
        opacity: 1.0,
        openInLayerSwitcher: false,
        layers: [new ol.layer.Tile({ baseLayer: true, visible: true, title: "OpenStreetMaps", source: new ol.source.OSM() })]
    });
    map.addLayer(baseLayers);
}

var addOverlayLayer = function(map) {
    let overlay = new ol.Overlay({
        id: 'feature-tooltip',
        element: $('#feature_tooltip').get(0),
        autoPan: true,
        autoPanAnimation: { duration: 250 }
    });
    map.addOverlay(overlay);
}

var addMapControls = function(map) {
    map.addControl(getScaleLineControl(undefined));
    let ext = ol.proj.transformExtent(maxExtents, map.getView().getProjection(), ol.proj.get('EPSG:4326'))
    map.addControl(getSearchControl(undefined, ext));
    map.addControl(getAttributionControl(undefined));
    map.addControl(getSidebarControl('map-sidebar', 'left'));

    // Registrar en Proj4 las proyecciones desconocidas por OL (todas las proyecciones excepto 4326 y 3857)
    proj4.defs('EPSG:32717', '+proj=utm +zone=17 +south +ellps=WGS84 +datum=WGS84 +units=m +no_defs ');
    proj4.defs('EPSG:32718', '+proj=utm +zone=18 +south +ellps=WGS84 +datum=WGS84 +units=m +no_defs ');
    proj4.defs('EPSG:32719', '+proj=utm +zone=19 +south +ellps=WGS84 +datum=WGS84 +units=m +no_defs ');
    ol.proj.proj4.register(proj4);
}

$(document).ready(function() {

    var map = createMap();
    loadBaseMapping(map);
    addOverlayLayer(map);
    addMapControls(map);

});