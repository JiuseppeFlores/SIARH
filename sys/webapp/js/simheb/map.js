
var spinner = null;
var dialog_wait = null;

Highcharts.setOptions({
	global: { 
		useUTC: false,  // true by default
        time: {
            timezone: 'America/La_Paz'
        }
	}    
});

$( document ).ready(function() {
	
	spinner = createSpinner();
	setTimeout(function(){ 
		spinner.spin($('#map').get(0)); 
		dialog_wait = createWaitDialog('Cargando mapa...');
		}, 
	0);

	//------------------------------
	// Crear el mapa
	//------------------------------
	let lyrs = [];
	lyrs.push(map_config.layers);
	var map = new ol.Map({
		target: $('#map').get(0),
		loadTilesWhileAnimating: true,
		loadTilesWhileInteracting: true,
		view: new ol.View({
			extent: map_config.maxExtents,
			center: ol.extent.getCenter(map_config.maxExtents),
			resolution: 2000, minResolution: 0.01, maxResolution: 2000
		}),
		layers: []
	});
	$('#map').data('map', map);
	
	//------------------------------
	// Cargar cartografía base
	//------------------------------
	// A group layer for base layers
	let baseLayers = new ol.layer.Group({
		id: 'BASE_LAYERS', title: 'Mapas base', opacity: 1.0,
		openInLayerSwitcher: false, layers: map_config.baseLayers
	});
	map.addLayer(baseLayers);
	
	//------------------------------
	// Cargar capas generales
	//------------------------------
	map_config.layers.forEach(function(lyr) {
		
		// Cargar la capa
		lyr.setStyle ( getDefaultStyleFunction( lyr.get('id') ) );
		map.addLayer(lyr);
		
		// Lectura de geojson con las features de cada capa
		let params = {
			command: 'GET_LAYER',
			layerId: lyr.get('id')
		};
		d3.json(api_url + encodeQueryStringObject(params)).then(function(data){ 
			let features = (new ol.format.GeoJSON()).readFeatures( data, { dataProjection : 'EPSG:4326', featureProjection: 'EPSG:3857' } );
			lyr.getSource().addFeatures(features);
		}).catch((error) => { console.log(error); });
	});
	
	//-------------------------
	// Features pop-up
	//-------------------------
	let overlay = new ol.Overlay({
		id: 'feature-tooltip',
		element: $('#feature_tooltip').get(0),
		autoPan: true,
		autoPanAnimation: { duration: 250 }
	});
	map.addOverlay(overlay);
	
	//-------------------------
	// Controles del mapa
	//-------------------------
	map.addControl( getLayerSwitcherControl(undefined) );
	map.addControl( getScaleLineControl(undefined) );
	let ext = ol.proj.transformExtent(map_config.maxExtents, map.getView().getProjection(), ol.proj.get('EPSG:4326'))
	map.addControl( getSearchControl(undefined, ext) );
	map.addControl( getAttributionControl(undefined) );
	map.addControl( getSidebarControl('map-sidebar', 'left') );
	
	// Registrar en Proj4 las proyecciones desconocidas por OL (todas las proyecciones excepto 4326 y 3857)
	proj4.defs('EPSG:32717','+proj=utm +zone=17 +south +ellps=WGS84 +datum=WGS84 +units=m +no_defs ');
	proj4.defs('EPSG:32718','+proj=utm +zone=18 +south +ellps=WGS84 +datum=WGS84 +units=m +no_defs ');
	proj4.defs('EPSG:32719','+proj=utm +zone=19 +south +ellps=WGS84 +datum=WGS84 +units=m +no_defs ');
	ol.proj.proj4.register(proj4);
	// Añadir los controles con la posición para cada proyección requerida
	var mousePositionProjections = ['4326'];//['3857','4326','32717','32718','32719'];
	var mousePositionDecimalPlaces = [3];//[0,3,0,0];
	$.each(mousePositionProjections, function(i, proj) {
		var mousePositionControl = new ol.control.MousePosition({
			//target: $("#mousePosition" + proj).get(0), className: 'mouse-position',
			coordinateFormat: ol.coordinate.createStringXY( mousePositionDecimalPlaces[i] ),
			projection: 'EPSG:' + proj, undefinedHTML: '&nbsp;'
		});
		map.addControl(mousePositionControl);
	});
	
	setTimeout(function(){ 
		spinner.stop(); 
		if (dialog_wait) dialog_wait.close();
	}, 5000);
	
	
	let layer_filter_options = {
		layerFilter: function(l) { 
			if (!l.get('id')) return false;
			return l.get('id').startsWith('GENERAL.'); 
		}, 
		hitTolerance: 0
	};
	
	map.on('pointermove', function(e) {
		
		if (e.dragging) return;
		
		let feature_found = this.forEachFeatureAtPixel(e.pixel, function(ftr, lyr) {
			return { event: e, layer: lyr, feature: ftr };
		}, layer_filter_options);
		
		showFeatureToolTip( feature_found );
		this.getTargetElement().style.cursor = feature_found ? 'pointer' : '';
	});
	
	map.on('click', function(e) {
		this.forEachFeatureAtPixel(e.pixel, function(ftr, lyr) {
			
			// Ocultar el tooltip
			showFeatureToolTip( undefined );
			
			// Mostrar el modal de detalle
			switch ( ftr.get('simheb')['entity_type'] ) {
				case 'dam': $('#modalPresa').modal('show'); break;
				case 'catchment': $('#modalCuenca').modal('show'); break;
				case 'station_hydro': 
				case 'station_meteo': 
					showStationModal(ftr); break;
			};
			return true;
			
		}, layer_filter_options);
	});

});

/**
 * 
 * ol/MapBrowserEvent
 * ol/Layer
 * ol/Feature
 **/
var showFeatureToolTip = function( feature_found ) {
	
	let map = $('#map').data('map');
	if (!map) return;
	
	let feature_tooltip = map.getOverlayById('feature-tooltip');
	if (!feature_tooltip) return;
	
	let feature = feature_found ? feature_found.feature: undefined;
	let last_feature = $(feature_tooltip).data('current_feature');
	$(feature_tooltip).data('current_feature', feature);
	
	if (!feature) {
		feature_tooltip.setPosition(undefined); 
		return;
	}
	
	// Desplazar "un poco" el tooltip
	let pixel = [feature_found.event.pixel[0] + 50, feature_found.event.pixel[1] - 50];
	
	// Si no hay cambio de feature: movel el tooltip
	if (last_feature == feature) {
		feature_tooltip.setPosition( map.getCoordinateFromPixel(pixel) );
		return;
	}
	
	// Si hay cambio de feature: rehacer el tooltip
	let coord = ol.proj.toLonLat(feature_found.event.coordinate);

	let title = feature.get('simheb')['name'];
	let text = "";
	let props = feature.get('data');
	for (var property in props) {
		if (props.hasOwnProperty(property)) {
			text += property + ': ' + props[property] + "<br />";
		}
	}
	let svgfile = svg_resources_url + getSvgIconByEntityType( feature.get('simheb')['entity_type'] );
	$div = $('<div class="card text-justify bg-light" style="min-width: 18rem;"> <div class="card-header"> <img src="'+svgfile+'" class="img-fluid"> ' + title + '</div> <div class="card-body"> <h5 class="card-title">' + title + '</h5> <p class="card-text">' + text + '</p> </div>  <div class="card-footer text-muted">' + ol.coordinate.toStringHDMS(coord) + '</div> </div>');
	$( feature_tooltip.getElement() ).find(".tooltip_content").html($div);
	
	feature_tooltip.setPosition( map.getCoordinateFromPixel(pixel) );
	
};