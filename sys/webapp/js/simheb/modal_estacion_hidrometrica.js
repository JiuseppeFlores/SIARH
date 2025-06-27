
$( document ).ready(function() {
	
	$('.datepicker').datepicker();
	
	//$('.nav-tabs a').on('shown.bs.tab', function(event){
	$('#nav-tabs-estacion-hidrometrica a').on('shown.bs.tab', function(event){
		
		if (event.target.hash == '#tab-estacion-hidrometrica-monitoreo') {
			EstacionHidrometrica_CrearGraficoMonitoreo();
		}
		if (event.target.hash == '#tab-estacion-hidrometrica-medias-mensuales') {
			EstacionHidrometrica_crearGraficoNivelMensual();
		}
	});

});

var EstacionHidrometrica_CrearGraficoMonitoreo = function() {
	
	let data_N = [3685.45,3683.57,3682.86,3683.33,3683.85,3684.68,3685.71,3684.90,3686.88,3687.50,3688.56,3690.10,3691.27,3692.62,3693.69,3694.55,3695.50,3696.18,3696.64,3697.04,3697.31,3697.55,3697.79,3698.03,3698.36,3698.72,3699.00,3699.25,3699.40,3699.55,3699.66,3699.78,3699.89,3699.97,3700.16,3700.55,3700.94,3701.20,3701.40,3701.55,3701.67,3701.84,3701.95,3702.06,3702.17,3702.25,3702.30,3702.51,3702.84,3703.15,3703.46,3703.86,3704.54,3705.28,3706.01,3706.56,3707.23,3708.25,3709.36,3710.90,3711.70,3712.36,3713.46,3714.30,3715.77,3717.28,3718.26,3718.90,3719.38,3719.74,3720.10,3720.35,3720.70,3720.97,3721.30,3721.58,3721.82,3722.00,3722.20,3722.32,3722.45,3722.60,3722.74,3722.88,3723.02,3723.17,3723.40,3723.68,3724.00,3724.30,3724.54,3724.71,3724.90,3725.10,3725.33,3725.55,3725.68,3725.80,3725.89,3725.98,3726.08,3726.18,3726.26,3726.32,3726.37,3726.42,3726.48,3726.52,3726.55,3726.58,3726.62,3726.62,3726.65,3726.68,3726.69,3726.71,3726.72,3726.73,3726.74,3726.74,3726.75,3726.76,3726.78,3726.79,3726.80,3726.81,3726.81,3726.82,3726.82,3726.83,3726.83,3726.83,3726.83,3726.83,3726.83,3726.83,3726.83,3726.83,3726.83,3726.83,3726.83,3726.82,3726.82,3726.97,3727.06,3727.19,3727.27,3727.33,3727.40,3727.45,3727.50,3727.53,3727.58,3727.61,3727.64,3727.66,3727.67,3727.68,3727.69,3727.70,3727.70,3727.71,3727.71,3727.72,3727.73,3727.73,3727.73,3727.73,3727.73,3727.73,3727.73,3727.72,3727.73,3727.73,3727.73,3727.72,3727.72,3727.71,3727.71,3727.71,3727.70,3727.70,3727.70,3727.70,3727.69,3727.68,3727.68,3727.67,3727.66,3727.65,3727.64,3727.64,3727.63,3727.62,3727.62,3727.61,3727.60,3727.60,3727.59,3727.58,3727.58,3727.57,3727.56,3727.55,3727.55,3727.54,3727.55,3727.55,3727.56,3727.56,3727.57,3727.58,3727.57,3727.58,3727.58,3727.59,3727.59,3727.59,3727.59,3727.59,3727.58,3727.58,3727.58,3727.58,3727.57,3727.56,3727.56,3727.55,3727.55,3727.56,3727.56,3727.55,3727.55,3727.54,3727.54,3727.53,3727.52,3727.51,3727.51,3727.52,3727.50,3727.49,3727.49,3727.48,3727.45,3727.43,3727.41,3727.41,3727.40,3727.39,3727.38,3727.36,3727.35,3727.33,3727.28,3727.27,3727.26,3727.25,3727.23,3727.22,3727.22,3727.18,3727.16,3727.15,3727.14,3727.13,3727.12,3727.03,3727.02,3727.01,3727.00,3727.00,3726.96,3726.95,3726.94,3726.91,3726.89,3726.86,3726.83,3726.79,3726.79,3726.76,3726.74,3726.72,3726.70,3726.69,3726.67,3726.66,3726.64,3726.63,3726.60,3726.53,3726.48,3726.47,3726.45,3726.48,3726.42,3726.38,3726.40,3726.40,3726.38,3726.35,3726.33,3726.29,3726.26,3726.24,3726.19,3726.16,3726.15,3726.11,3726.12,3726.12,3726.10,3726.09,3726.07,3726.05,3726.03,3726.01,3726.00,3725.97,3725.95,3725.93,3725.91,3725.91,3725.77,3725.76,3725.75,3725.74,3725.73,3725.72,3725.70,3725.68,3725.66,3725.60,3725.62,3725.65,3725.64,3725.65,3725.66,3725.78,3725.78,3725.78,3725.88,3725.90,3726.00,3726.01,3726.02,3726.02,3726.00,3725.99,3725.98,3725.98,3725.98,3726.04,3726.08,3726.18,3726.49,3726.89,3727.20,3727.42,3727.59,3727.73,3727.85,3728.15,3728.35];
	setTimeout(function(){
		
		// Crear el chart
		$("#container-hc-tab-estacion-hidrometrica-monitoreo").highcharts(EstacionHidrometrica_monitor_chart_opt);
		let chart = $("#container-hc-tab-estacion-hidrometrica-monitoreo").highcharts();
		
		// Rellenar el chart.
		chart.addSeries({
			name : 'Nivel (m.s.n.m.)', type: 'spline', yAxis: 0, color: '#68CFE8', data : data_N, 
			dataLabels: {
				enabled: true,
				formatter: function () { return parseFloat(this.y).toFixed(1); },
				style: { fontSize: '8px', color: 'gray' }
			},
			tooltip: { valueSuffix: ' m.s.n.m.' }
		}, true, true);
		chart.reflow();
	}, 0);
};

var EstacionHidrometrica_crearGraficoNivelMensual = function() {
	
	setTimeout(function(){
		
		// Crear el chart BoxPlot (media, cuantiles y valores anómalos)
		$("#container-hc-tab-estacion-hidrometrica-medias-mensuales").highcharts(EstacionHidrometrica_nivel_mensual_boxplot_chart_opt);
		let chart = $("#container-hc-tab-estacion-hidrometrica-medias-mensuales").highcharts();
		chart.reflow();
		
		// Crear el chart N-Q
		$("#container-hc-tab-estacion-hidrometrica-medias-mensuales-nq").highcharts(EstacionHidrometrica_nivel_cauda_mensual_chart_opt);
		chart = $("#container-hc-tab-estacion-hidrometrica-medias-mensuales-nq").highcharts();
		chart.reflow();
		
		// Crear el gráfico de medias mensuales
		let N_mes_medias = [848,939,817,806,864,848,939,817,806,864,848,939];
		let N_mes_medias_historica = [858,919,917,906,894,818,839,887,886,834,818,909];
		let N_mes_max_historica = [965, 1080, 918, 950, 910, 965, 1080, 918, 950, 910, 965,1080];
		let N_mes_min_historica = [ 760, 733, 714, 724,834,760, 733, 714, 724,834, 760,733 ];
		let nivel_anyo = { type: 'line', name: 'Año 2017', data: N_mes_medias };
		let nivel_media_historica = { type: 'line', name: 'Media histórica', color: '#000000', data: N_mes_medias_historica };
		let nivel_max_historica = { type: 'line', name: 'Media histórica', color: '#000000', data: N_mes_max_historica };
		let nivel_min_historica = { type: 'line', name: 'Media histórica', color: '#000000', data: N_mes_min_historica };
		
		// Año actual vs Año comparación media
		$("#container-hc-tab-estacion-hidrometrica-medias-mensuales-media").highcharts(EstacionHidrometrica_nivel_mensual_chart_opt);
		chart = $("#container-hc-tab-estacion-hidrometrica-medias-mensuales-media").highcharts();
		chart.addSeries(nivel_anyo, true, true);
		chart.addSeries(nivel_media_historica, true, true);
		chart.reflow();
		
		// Año actual vs Año comparación maximos
		$("#container-hc-tab-estacion-hidrometrica-medias-mensuales-maximo").highcharts(EstacionHidrometrica_nivel_mensual_chart_opt);
		chart = $("#container-hc-tab-estacion-hidrometrica-medias-mensuales-maximo").highcharts();
		chart.addSeries(nivel_anyo, true, true);
		chart.addSeries(nivel_max_historica, true, true);
		chart.reflow();
		
		// Año actual vs Año comparación mínimos
		$("#container-hc-tab-estacion-hidrometrica-medias-mensuales-minimo").highcharts(EstacionHidrometrica_nivel_mensual_chart_opt);
		chart = $("#container-hc-tab-estacion-hidrometrica-medias-mensuales-minimo").highcharts();
		chart.addSeries(nivel_anyo, true, true);
		chart.addSeries(nivel_min_historica, true, true);
		chart.reflow();
		
	}, 0);
};

var EstacionHidrometrica_monitor_chart_opt = ({
	chart: { zoomType: 'x', type: 'spline', panning: true, panKey: 'shift' },
	title : null,
	xAxis: {
		categories:["01-01","01-02","01-03","01-04","01-05","01-06","01-07","01-08","01-09","01-10","01-11","01-12","01-13","01-14","01-15","01-16","01-17","01-18","01-19","01-20","01-21","01-22","01-23","01-24","01-25","01-26","01-27","01-28","01-29","01-30","01-31","02-01","02-02","02-03","02-04","02-05","02-06","02-07","02-08","02-09","02-10","02-11","02-12","02-13","02-14","02-15","02-16","02-17","02-18","02-19","02-20","02-21","02-22","02-23","02-24","02-25","02-26","02-27","02-28","03-01","03-02","03-03","03-04","03-05","03-06","03-07","03-08","03-09","03-10","03-11","03-12","03-13","03-14","03-15","03-16","03-17","03-18","03-19","03-20","03-21","03-22","03-23","03-24","03-25","03-26","03-27","03-28","03-29","03-30","03-31","04-01","04-02","04-03","04-04","04-05","04-06","04-07","04-08","04-09","04-10","04-11","04-12","04-13","04-14","04-15","04-16","04-17","04-18","04-19","04-20","04-21","04-22","04-23","04-24","04-25","04-26","04-27","04-28","04-29","04-30","05-01","05-02","05-03","05-04","05-05","05-06","05-07","05-08","05-09","05-10","05-11","05-12","05-13","05-14","05-15","05-16","05-17","05-18","05-19","05-20","05-21","05-22","05-23","05-24","05-25","05-26","05-27","05-28","05-29","05-30","05-31","06-01","06-02","06-03","06-04","06-05","06-06","06-07","06-08","06-09","06-10","06-11","06-12","06-13","06-14","06-15","06-16","06-17","06-18","06-19","06-20","06-21","06-22","06-23","06-24","06-25","06-26","06-27","06-28","06-29","06-30","07-01","07-02","07-03","07-04","07-05","07-06","07-07","07-08","07-09","07-10","07-11","07-12","07-13","07-14","07-15","07-16","07-17","07-18","07-19","07-20","07-21","07-22","07-23","07-24","07-25","07-26","07-27","07-28","07-29","07-30","07-31","08-01","08-02","08-03","08-04","08-05","08-06","08-07","08-08","08-09","08-10","08-11","08-12","08-13","08-14","08-15","08-16","08-17","08-18","08-19","08-20","08-21","08-22","08-23","08-24","08-25","08-26","08-27","08-28","08-29","08-30","08-31","09-01","09-02","09-03","09-04","09-05","09-06","09-07","09-08","09-09","09-10","09-11","09-12","09-13","09-14","09-15","09-16","09-17","09-18","09-19","09-20","09-21","09-22","09-23","09-24","09-25","09-26","09-27","09-28","09-29","09-30","10-01","10-02","10-03","10-04","10-05","10-06","10-07","10-08","10-09","10-10","10-11","10-12","10-13","10-14","10-15","10-16","10-17","10-18","10-19","10-20","10-21","10-22","10-23","10-24","10-25","10-26","10-27","10-28","10-29","10-30","10-31","11-01","11-02","11-03","11-04","11-05","11-06","11-07","11-08","11-09","11-10","11-11","11-12","11-13","11-14","11-15","11-16","11-17","11-18","11-19","11-20","11-21","11-22","11-23","11-24","11-25","11-26","11-27","11-28","11-29","11-30","12-01","12-02","12-03","12-04","12-05","12-06","12-07","12-08","12-09","12-10","12-11","12-12","12-13","12-14","12-15","12-16","12-17","12-18","12-19","12-20","12-21","12-22","12-23","12-24","12-25","12-26","12-27","12-28","12-29","12-30","12-31"],
	},
	yAxis: [
		{ 
			allowDecimals: true,
			title: { text: 'Nivel (m.s.n.m.)', style: { color: '#8085E9' } },
			labels:{ style: { color:'#8085E9' } } 
		}
	],
	plotOptions: {
		series: { label: { connectorAllowed: true }, marker: { enabled: false } }
	},
	tooltip: { crosshairs: true, shared: true },
	colors: ['#8085E9', '#76CBF1', '#A4E152', '#374365','#FB931D','#F45B5F'],
	series : [],
	credits: { enabled: false }
});

var EstacionHidrometrica_nivel_mensual_chart_opt = ({
	chart: { zoomType: 'x', type: 'area', panning: true, panKey: 'shift' },
	title : null,
	xAxis: {
		categories: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
	},
	yAxis: [
		{
			allowDecimals: true,
			title: { text: 'Nivel (m.s.n.m.)', style: { color: '#8085E9' } },
			labels:{ style: { color:'#8085E9' } } 
		}
	],

	plotOptions: {
		series: { label: { connectorAllowed: true }, marker: { enabled: false } }
	},
	tooltip: { crosshairs: true, shared: true },
	colors: ['#8085E9', '#76CBF1', '#A4E152', '#374365','#FB931D','#F45B5F'],
	series : [],
	credits: { enabled: false }
});

var EstacionHidrometrica_nivel_mensual_boxplot_chart_opt = ({
    chart: { type: 'boxplot' },
    title: null,
	legend: { enabled: false },
	xAxis: {
		categories: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
		title: null
	},
    yAxis: {
        title: { text: 'Nivel (m.s.n.m.)' },
        plotLines: [{
            value: 932,
            color: 'red',
            width: 1,
            label: {
                text: 'Media teórica: 932',
                align: 'center',
                style: { color: 'gray' }
            }
        }]
    },

    series: [
	{
        name: 'Observaciones',
        data: [
            [760, 801, 848, 895, 965], [733, 853, 939, 980, 1080], [714, 762, 817, 870, 918], [724, 802, 806, 871, 950],
            [834, 836, 864, 882, 910], [760, 801, 848, 895, 965], [733, 853, 939, 980, 1080], [714, 762, 817, 870, 918],
            [724, 802, 806, 871, 950], [834, 836, 864, 882, 910], [724, 802, 806, 871, 950], [834, 836, 864, 882, 910]
        ],
        tooltip: {
            headerFormat: '<em>Mes {point.x} (key:{point.key})</em><br/>'
        }
    }, 
	{
        name: 'Valores anómalos',
        color: Highcharts.getOptions().colors[0],
        type: 'scatter',
        data: [ // x, y positions where 0 is the first category
            [0, 644],
            [4, 718],
            [4, 951],
            [4, 969]
        ],
        marker: {
            fillColor: 'white',
            lineWidth: 1,
            lineColor: Highcharts.getOptions().colors[0]
        },
        tooltip: { pointFormat: 'Nivel: {point.y} m.s.n.m.' }
    }],
	credits: { enabled: false }
});

var EstacionHidrometrica_nivel_cauda_mensual_chart_opt = ({
    chart: { zoomType: 'xy' },
    title: null,
	xAxis: {
		categories: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
		title: null
	},
	yAxis: [{ // Primary yAxis
		title: {
			text: 'Nivel (m.s.n.m.)',
			style: { color: Highcharts.getOptions().colors[1] }
		}
	},
	{ // Secondary yAxis
        title: {
            text: 'Caudal m3/s',
            style: { color: Highcharts.getOptions().colors[0] }
        },
        opposite: true
    }],
    tooltip: { shared: true },
    legend: {
        layout: 'vertical', align: 'left', x: 120, verticalAlign: 'top', y: 100,
        floating: true,
        backgroundColor: Highcharts.defaultOptions.legend.backgroundColor || 'rgba(255,255,255,0.25)'
    },
    series: [{
        name: 'Caudal', type: 'column', yAxis: 1,
        data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4],
        tooltip: { valueSuffix: ' m3/s' }

    }, {
        name: 'Nivel',
        type: 'spline',
        data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6],
        tooltip: { valueSuffix: ' m.s.n.m.' }
    }]
});
