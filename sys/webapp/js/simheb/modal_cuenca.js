
$( document ).ready(function() {
	
	//$('.nav-tabs a').on('shown.bs.tab', function(event){
	$('#nav-tabs-cuenca a').on('shown.bs.tab', function(event){
		//var x = $(event.target).text();         // active tab
		//var y = $(event.relatedTarget).text();  // previous tab
		let charts = $(event.target.hash).find('.hc_chart');
		$(charts).each(function() {
			
			$(this).highcharts(chart_opt);
			let chart = $(this).highcharts();
			
			setTimeout(function(){
				
				// Rellenar el chart.
				chart.addSeries( 
					{ name : 'P mm', type: 'column', yAxis: 0, color: '#68CFE8', data : [380.19, 365.85, 200.24, 262.54, 196.61, 138.41, 208.8, 164.94, 220.66, 198.92, 224.57, 282.72], 
						groupPadding: 0, pointPadding: 0, grouping: false,
						dataLabels: {
							enabled: true,
							formatter: function () { if (this.y >= 0.1 ) { return parseFloat(this.y).toFixed(1); } },
							style: { fontSize: '8px', color: 'gray' }
						},
						tooltip: { valueSuffix: ' mm' }
					}, true, true);
				chart.addSeries( { name : 'Caudal', type: 'spline', visible: true, yAxis: 1, data : [4416.28, 5490.643, 3077.255, 3853.738, 3130.756, 2806.728, 3071.231, 2481.767, 2985.382, 2938.388, 2928.096, 3163.533] }, true, true);
				
				chart.reflow();
			}, 0);
		});
	}); 


});



var chart_opt = {
	title: { text: null },
	plotBorderWidth: 1,
	scrollablePlotArea: { minWidth: 720 },
	xAxis: { 
		type: 'category',
		categories: [], 
		crosshair: true, 
		showLastLabel: true,
		gridLineWidth: 1,
		gridLineColor: 'rgba(128, 128, 128, 0.1)',
		spacingBottom: 15, spacingTop: 10, spacingLeft: 10, spacingRight: 10,
		labels: {
			formatter: function() {
				let x = this.value;
				if (!moment.isMoment(x)) return null;
				return String(x.isSame(moment(x).startOf('day')) ? x.format('DD-MM HH:mm') : x.format('HH:mm'));
			}
		}
	},
	yAxis: [
		{ 
			title: { text: 'Precipitación', style: { color: Highcharts.getOptions().colors[0] } },
			labels: { x:0, y:-2, format: '{value}', style: { color: Highcharts.getOptions().colors[0] } }
		},
		{ 
			allowDecimals: false,
			title: { 
				text: 'm3/s', offset: 0, align: 'high', rotation: 0,
				style: { fontSize: '10px', color: Highcharts.getOptions().colors[1] },
				textAlign: 'left', x: -5
			},
			labels: { style: { fontSize: '8px', color: Highcharts.getOptions().colors[1] }, y: 2, x: -13 },
			gridLineWidth: 0, opposite: true, showLastLabel: false
		}],
	tooltip: {
		shared: true, useHTML: true,
		headerFormat: '<small>{point.x:%A, %b %e, %Y-%m-%d %H:%M}</small><br> <b>{point.point.symbolName}</b><br>'
	},
	legend: {
		layout: 'horizontal', align: 'left', verticalAlign: 'top',
		backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || 'rgba(255,255,255,0.25)'
	},
	plotOptions: {
		series: { label: { connectorAllowed: true }, marker: { enabled: false } }
	},
	series: [],
	responsive: {
		rules: [{
			condition: { maxWidth: 500 },
			chartOptions: { 
				legend: { layout: 'horizontal', align: 'center', verticalAlign: 'top' }
				//, yAxis: [
				//	{labels: { enabled: false }, title: { text: null } },
				//	{labels: { enabled: false }, title: { text: null } },
				//	{labels: { enabled: false }, title: { text: null } }
				//]
			}
		}]
	},
	credits: { enabled: false }
};

