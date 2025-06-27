//-----------------------------------------------------
// Caché de estilos.
//-----------------------------------------------------
var stylesCache_ = {};
var imagesCache_ = {};

/**
 * Filtro de presas
 */
var getFilterToApply_ = function(entity_type){
	let filter = null;

	$(".filtro[data-entity-type='" + entity_type + "']").each(function( i ) { 
        var valor = $(this).val();
		var field = $(this).attr('data-filter-field');
		if (valor !== null && valor !== ""){
			if (filter == null){
				filter = {};
			}
			filter[field] = valor;
		} 
	});  
	return filter;
}

/**
 * StyleFunction para estaciones
 */

var applyStationStyle_ = function(f, res) {

	let filter = getFilterToApply_(f.get('simheb')['entity_type']);
	let visible = true;

	if (filter !== null){
		for (var key in filter){
			if (f.values_.data[key] != filter[key]) visible = false;
		}
	}
	let ret = null;
	if (visible){
		ret = stationPatternStyle_;
		let label = f.get('simheb')['name'];
		imagen = getIconImage(f);
		if (imagen) {
			imagen.setScale( getIconScale() ) 
			ret[0].setImage(imagen);
		}
		// Labels
		var drawLabels = (res < 200);
		ret[1].getText().setText( drawLabels ? label : null );
	}

	return ret;
};


/*
 * Computa el factor de escala de un icono, tomando como referencia la mayor resolución posible del mapa
 */
var getIconScale = function() {
	let map = $('#map').data('map');
	if (!map) return 1.0;
	let scale = map.getView().getResolutionForZoom(3) / map.getView().getResolution();
	scale = Math.max(1, scale);
	scale = Math.min(2, scale);
	return scale
}
/*
 * Obtiene una imagen para añadir al estilo de la feature indicada
 */ 
var getIconImage = function(feature) {
	
	let ret = null;
	let hash = feature.get('simheb')['entity_type'];
	ret = imagesCache_[hash];
	if (ret) return ret;
	
	// Buscar el icono SVG
	let svgfile = svg_resources_url + getSvgIconByEntityType( feature.get('simheb')['entity_type'] );
	if (svgfile) {
		ret = new ol.style.Icon({ opacity: 1, src: svgfile, scale: 1.0 })
	}
	
	// Si se ha generado el icono: forzar su carga y almacenarlo en caché
	if (ret) {
		ret.load();
		imagesCache_[hash] = ret;
	}
	return ret;
};

var style_cuencas = [
	new ol.style.Style({
		fill:   new ol.style.Fill( { color: [120,120,120, 0.05] } ),
		stroke: new ol.style.Stroke( { color: 'brown', width: 1.25 } )
	})
];

/*
 * Estilo ÚNICO para todas las cuencas de embalses.
 * Es el patrón para todos que después se modifica en función del valor requerido
 */
var cuencasEmbalsesPatternStyle_ = [
	new ol.style.Style({
		fill:   new ol.style.Fill( { color: [120,120,120, 0] } ),
		stroke: new ol.style.Stroke( { color: 'blue', width: 1.75 } )
	}),
	new ol.style.Style({ 
		text: new ol.style.Text({ 
			font: 'bold 15px "Open Sans", "sans-serif"',
			placement: 'point',
			fill: new ol.style.Fill({ color: '#ccc' }),
			stroke: new ol.style.Stroke({ color: 'blue', width: 2 })
		})
	})
];

/*
 * Estilo ÚNICO para todos los elementos puntuales.
 * Es el patrón para todos que después se modifica en función del tipo de elemento (entity_type)
 */
var stationPatternStyle_ = [
	new ol.style.Style({
		image: null,
		zIndex: Infinity
	}),
	new ol.style.Style({ 
		text: new ol.style.Text({ 
			font: 'bold 15px "Open Sans", "sans-serif"',
			placement: 'point',
			offsetY: 40,
			fill: new ol.style.Fill({ color: '#ccc' }),
			stroke: new ol.style.Stroke({ color: '#333', width: 2 })
		})
	}),
	new ol.style.Style({ 
		text: new ol.style.Text({ 
			font: 'bold 20px "Open Sans", "sans-serif"',
			placement: 'point',
			offsetY: -20, offsetX: 0,
			fill: new ol.style.Fill({ color: 'red' }),
			stroke: new ol.style.Stroke({ color: '#333', width: 4 })
		})
	})
];

//-----------------------------------------------------
// Rellenar la caché de estilos
//-----------------------------------------------------
stylesCache_['GENERAL.CUENCAS']						= function(ftr, res) { return style_cuencas; };
stylesCache_['GENERAL.ESTACIONES_HIDROMETRICAS']	= applyStationStyle_;
stylesCache_['GENERAL.ESTACIONES_CLIMATOLOGICAS']	= applyStationStyle_;
stylesCache_['GENERAL.PRESAS']						= applyStationStyle_;

//-----------------------------------------------------
// Retorna el SVG correspondiente en función del tipo de entidad a mostrar en el mapa
//-----------------------------------------------------
let getSvgIconByEntityType = function(entity_type) {
	var ret = null;
	switch (entity_type) {
		case 'station_hydro': 	ret = 'hydro_gauge.svg'; break;
		case 'station_meteo': 	ret = 'pluvio.svg'; break;
		case 'dam': 			ret = 'dam.svg'; break;
		case 'catchment': 		ret = 'catchment.svg'; break;
		default:
			ret = 'dam.svg'; break;
	};
	return ret;
};

//-----------------------------------------------------
// Obtener estilo por defecto para todas las capas cargadas
//-----------------------------------------------------
var getDefaultStyleFunction = function(layerId) {
	
	//----------------------------------------------
	// Buscar en la caché de objetos stylesCache_
	//----------------------------------------------
	let ret = stylesCache_[layerId];
	if (ret) return ret;
	
	//----------------------------------------------
	// Buscar en la caché del local storage
	// si no existe, getLayerColorsConfigFromLocalCache crea un estilo por defecto
	//----------------------------------------------
	let styleConfig = getLayerColorsConfigFromLocalCache(layerId);
	ret = createDefaultStyleFunction_(styleConfig.fill_color, styleConfig.stroke_color);
	stylesCache_[layerId] = ret;
	return ret;
};

var createDefaultStyleFunction_ = function (fill_color, stroke_color) {
	let ret = function(feature, resolution) {
		var fill = new ol.style.Fill({ color: fill_color.toString() });
		var stroke = new ol.style.Stroke({ color: stroke_color.toString(), width: 1.25 });
		var style = [
			new ol.style.Style({
				image: new ol.style.Circle({ fill: fill, stroke: stroke, radius: 5 }),
				fill: fill,
				stroke: stroke
			})
		];
		return style;
	};
	return ret;
};

var getLayerColorsConfigFromLocalCache = function(layerId) {
	
	let ret = null;
	var loc = JSON.parse( localStorage.getItem('layers_styles_settings') );
	if (loc) {
		if (loc[layerId]) ret = loc[layerId];
	};
	// Si no existía en la caché local: crear uno por defecto
	if (!ret) {
		let colors = ['#FF6633', '#FFB399', '#FF33FF', '#FFFF99', '#00B3E6', 
			'#E6B333', '#3366E6', '#999966', '#99FF99', '#B34D4D',
			'#80B300', '#809900', '#E6B3B3', '#6680B3', '#66991A', 
			'#FF99E6', '#CCFF1A', '#FF1A66', '#E6331A', '#33FFCC',
			'#66994D', '#B366CC', '#4D8000', '#B33300', '#CC80CC', 
			'#66664D', '#991AFF', '#E666FF', '#4DB3FF', '#1AB399',
			'#E666B3', '#33991A', '#CC9999', '#B3B31A', '#00E680', 
			'#4D8066', '#809980', '#E6FF80', '#1AFF33', '#999933',
			'#FF3380', '#CCCC00', '#66E64D', '#4D80CC', '#9900B3', 
			'#E64D66', '#4DB380', '#FF4D4D', '#99E6E6', '#6666FF'];
		let index = Math.floor(Math.random() * colors.length);
		let fill_color = d3.rgb(colors[index]);
		fill_color.opacity = .4;
		index = Math.floor(Math.random() * colors.length);
		let stroke_color = d3.rgb(colors[index]);
		ret = { fill_color: fill_color.toString(), stroke_color: stroke_color.toString() };
		setLayerColorsConfigFromLocalCache(layerId, ret.fill_color, ret.stroke_color);
	}
	
	return ret;
};

var setLayerColorsConfigFromLocalCache = function(layerId, fill_color, stroke_color) {
	
	var loc = JSON.parse( localStorage.getItem('layers_styles_settings') );
	if (!loc) loc = {};
	loc[layerId] = { fill_color: fill_color, stroke_color: stroke_color };
	
	localStorage.setItem('layers_styles_settings', JSON.stringify(loc));
};

