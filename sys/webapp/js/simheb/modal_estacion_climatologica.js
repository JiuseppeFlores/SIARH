
var variables = null, unidades = null;;
var estacion = null;

$( document ).ready(function() {

	d3.json('index.php?module=simheb&smodule=viewer&accion=api_&params={"command": "GET_VARIABLES"}').then(function(data_variables) {
		if (data_variables !== null && data_variables.length > 0) variables = data_variables;
		d3.json('index.php?module=simheb&smodule=viewer&accion=api_&params={"command": "GET_UNIDADES"}').then(function(data_unidades) {
			if (data_unidades !== null && data_unidades.length > 0) unidades = data_unidades;
		});
	});
	
	$('.datepicker').datepicker();

	$('.datepicker.selector-dia').val(moment().startOf('day').add(-1, 'day').format('DD/MM/YYYY'));
	$('.datepicker.selector-mes').val(moment().startOf('month').format('MM-YYYY'));

	$('#nav-tabs-estacion-climatologica a').on('shown.bs.tab', function(event){
		$('.weather-station.hc_chart').each(function(){
			let chart = $(this).highcharts();
			if (chart) chart.reflow();
		});
	});


	$('.ver-datos').on('click', function(){
		let periodicidad = $(this).attr('data-periodicidad');
		let calendarioVisible = $('.calendario[data-periodicidad="' + periodicidad + '"]:visible');
		let intervalo = calendarioVisible.attr('data-intervalo');
		let fechaDesde = moment($('.selector-' + intervalo + '[data-periodicidad="' + periodicidad + '"]' ).val(), intervalo === 'dia' ? 'DD/MM/YYYY' : 'MM-YYYY').startOf(intervalo === 'dia' ? 'day' : 'month');
		let fechaHasta = moment(fechaDesde).add(1, intervalo === 'dia' ? 'day' : 'month').add(-1, 'second');
		
		let codigoEstacion = $(this).attr('data-station');
		let variablesEstacion = $(this).attr('data-variables');
		let variablesIds = variablesEstacion.split(';');

		let chart = $('#container-hc-tab-estacion-climatologica-monitoreo').highcharts();
		chart.reflow();
		while(chart.series.length > 0) chart.series[0].remove();
		chart.xAxis[0].setExtremes(moment.tz(fechaDesde.format('YYYY-MM-DD HH:mm:ss'), 'America/La_Paz'), moment.tz(fechaHasta.format('YYYY-MM-DD HH:mm:ss'), 'America/La_Paz'));

		$.each(variablesIds, function(index, idVariable){
			// Get variable corresponding to the given id from the data retrieved in page load.
			let variable = $.grep(variables, function(element, index){
				return element.id === parseInt(idVariable);
			});

			// // Find variable information in the station, just in case the unit to be used is different from the regular configuration
			let variable_estacion = $.grep(estacion.variables, function(element, index){
					return element.variable === parseInt(idVariable);
			});
			
			// Get unit to be used
			let unidad = $.grep(unidades, function(element, index){
				let unidadAUsar = variable_estacion !== null && variable_estacion.length > 0 && variable_estacion[0].hasOwnProperty("id_unidad") ? variable_estacion[0].unidad_id : variable[0].unidad_id;
				return element.id === parseInt(unidadAUsar);
			});

			if (variable.length === 1 && variable[0].hasOwnProperty('periodicidad') && variable[0].periodicidad.hasOwnProperty(periodicidad) && variable[0].periodicidad[periodicidad] === true){
				d3.json('index.php?module=simheb&smodule=info_meteo&accion=api_&params={"command": "GET_DATOS_ESTACION", "id_estacion": "' + codigoEstacion + '", "id_variable": "' + idVariable + '", "fecha_desde": "' + fechaDesde.format('YYYY-MM-DD-HH-mm-ss') + '", "fecha_hasta": "' + fechaHasta.format('YYYY-MM-DD-HH-mm-ss') + '", "frecuencia": "MINUTAL", "proceso": "VAUTO"}').then(function(timeseriesData) {
					let yAxis = getYAxisByVariable(variable[0].codigo);
					let chartType = getChartTypeByVariable(variable[0].codigo);
					chart.yAxis[yAxis].visible = true;
					let series = {name: variable[0].descripcion, data: timeseriesData, color: getColorByVariable(variable[0].codigo), yAxis: yAxis, unit: (unidad !== null && unidad.length > 0) ? unidad[0].simbolo : ''};
					if (chartType !== null) series.type = chartType;
					chart.addSeries(series);
				});
			}
		});
	});
});

var showStationModal = function (feature){
	$('.weather-station.hc_chart').each(function(){
		let periodicidad = $(this).attr('data-periodicidad');
		let tipoGrafica = $(this).attr('data-chart-type');

		let chartOpts = null;
		if (typeof periodicidad !== "undefined" && periodicidad !== "" && typeof tipoGrafica !== "undefined" && tipoGrafica !== ""){
			chartOpts = getChartOpts(periodicidad, tipoGrafica);
		}
		if (chartOpts !== null) {
			$(this).highcharts(chartOpts);
		}
	});
	
	let props = feature.get('data');
	if (props.hasOwnProperty('codigo')){
		d3.json('index.php?module=simheb&smodule=viewer&accion=api_&params={"command": "GET_ESTACION", "codigo_estacion": "' + props.codigo + '"}').then(function(datosEstacion) {
			if (datosEstacion){
				estacion = datosEstacion;

				$('#modalEstacionClimatologica').modal('show');
				$('#nombre-estacion').text(estacion.nombre);
				
				if (estacion.hasOwnProperty('tipo_estacion')){
					$('#tipo-estacion').text(estacion.tipo_estacion);
				}

				if (estacion.hasOwnProperty('codigo')){
					$('#codigo-estacion').text(estacion.codigo);
					$('.ver-datos').attr('data-station', estacion.codigo);
				}

				if (estacion.hasOwnProperty('frecuencia')){
					let frecuenciaReal = estacion.frecuencia; let unidad = 'minutos'; // MINUTOS
					if (frecuenciaReal > 60 && frecuenciaReal%60 === 0){ frecuenciaReal = frecuenciaReal / 60; unidad = 'horas'; } // HORAS
					if (frecuenciaReal > 1440 && frecuenciaReal%1440 === 0){ frecuenciaReal = frecuenciaReal / 1440; unidad = 'días'; } // DIAS
					$('#frecuencia-estacion').text(frecuenciaReal + ' ' + unidad);

					$('.calendario').show();
					if (estacion.frecuencia >= 1440)  {
						$('#calendario-dia').hide();
					} else {
						$('#calendario-mes').hide();
					}
				}

				$('#variables-estacion').html('');
				if (estacion.hasOwnProperty('variables')){
					let nombreVariables = ""; let idVariables = [];
					$.each(estacion.variables, function(index, variable){
						nombreVariables += '<div class="row"><div class="col-12">' + variable.nombre_variable + '</div></div>';
						idVariables.push(variable.variable);
					});
					$('#variables-estacion').html(nombreVariables);
					$('.ver-datos').attr('data-variables', idVariables.join(';'));
				}

				$('#propiedades-estacion').html('');
				if (estacion.hasOwnProperty('propiedades')){
					let propiedades = "";
					for(let propiedad in estacion.propiedades){
						if (estacion.propiedades.hasOwnProperty(propiedad)){
							propiedades += '<div class="row"><div class="col-3">' + propiedad + '</div><div class="col-md-9">' + estacion.propiedades[propiedad] + '</div></div>';
						}
					};
					$('#propiedades-estacion').html(propiedades);
				}

			}
		});
	}
}

var getChartOpts = function (periodicidad, tipoGrafica){
	let opts = {};
	switch (periodicidad){
		case 'MINUTAL':
			opts = {
				chart: { zoomType: 'x', type: 'spline', panning: true, panKey: 'shift' },
				title : null,
				xAxis: {
					type: 'datetime', 
					lineColor: 'transparent',
					labels: {enabled: false}
				},
				yAxis: [
					// PRECIPITACION
					{ 
						reversed: true,  title : { enabled : false },  labels : { enabled: false }, visible: false ,
						dataLabels: {
							enabled: true, style: { fontSize: '8px', color: 'gray' }, 
							formatter: function () { if (this.y >= 0.1 ) { return parseFloat(this.y).toFixed(1); } }
						}
					},
					// TEMPERATURA
					{ 
						title: { text: null }, maxPadding: 0.3, minRange: 8, tickInterval: 1, gridLineColor: 'rgba(128, 128, 128, 0.1)', 
						labels: { format: '{value}°C',	x: -3, style: { fontSize: '10px', color: getColorByVariable('TI') } }
					},
					// HUMEDAD RELATIVA
					{ 
						title: { text: null }, visible: false, min: 0, max: 100, allowDecimals: true, tickInterval:1, opposite: true, 
						labels:{ format: '{value}%', x: 3, style: { fontSize: '10px', color: getColorByVariable('HR') } }
					},
					//RADIACION SOLAR
					{ 
						title: { text: null }, opposite: true, visible: false,
						labels:{ useHTML: true, format: '{value} W/m<sup>2</sup>', x: 5, style: { fontSize: '10px', color: getColorByVariable('RS') } }
					},
					// CAUDAL DE SALIDA
					{ 
						title: { text: null }, visible: false,
						labels:{ useHTML: true, format: '{value} m<sup>3</sup>/s', x: -5, style: { fontSize: '10px', color: getColorByVariable('CS') } }
					},
					// VOLUMEN
					{ 
						title: { text: null }, visible: false,
						labels:{ useHTML: true, format: '{value} m<sup>3</sup>', x: -7, style: { fontSize: '10px', color: getColorByVariable('VOL') } }
					},
					// NIVEL
					{ 
						title: { text: null }, visible: false, opposite: true,
						labels:{ format: '{value} msnm', x: 7, style: { fontSize: '10px', color: getColorByVariable('NIV') } }
					},
					// DIRECCION DEL VIENTO (TODO: Montar las flechas)
					{ 
						title: { text: null }, visible: false, min: 0, max: 360, 
						labels:{ format: '{value}º', x: -9, style: { fontSize: '10px', color: getColorByVariable('DV') } }
					},
					// VELOCIDAD DEL VIENTO (TODO: Montar las flechas)
					{ 
						title: { text: null }, opposite: true, visible: false,
						labels:{ format: '{value} m/s', x: 9, style: { fontSize: '10px', color: getColorByVariable('VV') } }
					},
					{ 
						title: { text: null }, visible: false,
						labels:{ format: '{value} mBar', x: -11, style: { fontSize: '10px', color: getColorByVariable('PB') } }
					}
				],
				plotOptions: {
					series: { label: { connectorAllowed: true }, marker: { enabled: false } }
				},
				tooltip: {
					shared: true,
					useHTML: true,
					//crosshairs: true,
					formatter: function() {
						ret = '';
						ret += '<i class="fa fa-clock-o"></i><span class="small"> ' + moment.utc(new Date(this.x)).tz('America/La_Paz').format('YYYY-MM-DD HH:mm') + '</span>';
						$.each(this.points, function () {
							ret += '<div class="row" style="width: 400px"> <div class="col-md-8"><span class="text-left" style="color:' + this.series.color + '"><h5>' + this.series.name + ': </h5></span></div>'
							ret += '<div class="col-md-4"><span class="text-right"><h5> ' + this.y.toFixed(0) + ' ' + this.series.options.unit + '</h5></span></div> </div>';
						});
						return ret;
					}
				},
				series : [ ],
				credits: { enabled: false }
			};
			break;
		case 'DIA':
			break;
		case 'MES':
			switch (tipoGrafica) {
				case 'pie': 
					opts = {
						chart: { plotBackgroundColor: null, plotBorderWidth: null, plotShadow: false, type: 'pie' },
						title: null,
						tooltip: { pointFormat: '{series.name}: <b>{point.y:.1f}mm </b> <b>{point.percentage:.1f}%</b>' },
						plotOptions: {
							pie: { allowPointSelect: true, cursor: 'pointer', dataLabels: { enabled: true, format: '<b>{point.name}</b>: <b>{point.y:.1f}mm </b> <b>{point.percentage:.1f}%</b>' } }
						},
						series: [], credits: { enabled: false }
					};
					break;
				
				case 'polar':
					opts = {
						chart: { polar: true },
						title: null, subtitle: null,
						pane: { size: '90%' },
						xAxis: {
							categories: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
							tickmarkPlacement: 'on',
							lineWidth: 0
						},
						yAxis: { gridLineInterpolation: 'polygon', lineWidth: 0, min: 0 },
						plotOptions: { },
						series: [], credits: { enabled: false }
					};
					break;
			}
			break;
		case 'AÑO':
			break;
	}
	return opts;
}