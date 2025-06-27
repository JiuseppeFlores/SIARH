{literal}
<script>
    var canvas = document.getElementById('grafico_caudal');
    var ctx = canvas.getContext('2d');

    var datos = {/literal}{$datosCaudales}{literal};
    var dimension = datos.length;
    var nombre = [];
    var fechas = [];
    var caudales = [];
    var caudalautorizados = [];

     // Genera una lista de colores
    // var colores = [
    //     '#cd6155',
    //     '#a569bd',
    //     '#5499c7',
    //     '#45b39d',
    //     '#f4d03f',
    //     '#dc7633',
    //     '#af7ac5',
    //     '#ec7063',
    //     '#5dade2',
    //     '#48c9b0',
    //     '#f5b041',
    //     '#58d68d',
    //     '#eb984e',
    //     '#52be80' 
    // ];

    for (var i=0; i<=dimension-1; i++) {
        //nombre = nombre.concat(nombre[i].nombre);
        fechas = fechas.concat(datos[i].fechas.split(","));
        caudales = caudales.concat(datos[i].caudales.split(","));
        caudalautorizados = caudalautorizados.concat(datos[i].caudalautorizados.split(","));
    };

    var barChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: fechas,
            datasets: [{
                label: 'Variación del caudal vs tiempo',
                data: caudales,
                backgroundColor: [
                    'rgba(27, 79, 114, 0.1)'
                ],
                radius: 1,
                borderColor: 'rgba(27, 79, 114, 0.5)'              
            },
            {
                label: 'Caudal autorizado',
                data: caudalautorizados,
                backgroundColor: [
                'rgba(255, 255, 255, 0)'
                ],
                radius: 0,
                borderColor: 'rgba(255, 0, 0, 0.5)'              
            }]            
        },
        options: {
            showLines: true,
            title: {
                display: true,
                text: 'Variacion del Caudal en Acuifero - N° de Pozos '+datos.length,
            },
            scales: {
                xAxes: [{
                    scaleLabel: {
                        display: true,
                        labelString: 'Tiempo (fecha)'
                    }
                }],
                yAxes: [{
                    stacked: false,
                    scaleLabel: {
                        display: true,
                        labelString: 'Caudal'
                    }
                }]
            },
            elements: {
                point: {
                    //radius: 4,
                    borderWidth: 8,
                    borderColor: 'rgba(27, 79, 114, 0.5)',
                },
                line: {
                    tension: 0,
                    borderWidth: 1.9,
                    borderColor: 'rgba(27, 79, 114, 0.5)',
                }
            }                
        },
    });

    function GuardarGrafica(){
        Canvas2Image.saveAsPNG(canvas, canvas.width, canvas.height, "MonitoreoCantidadAcuifero");
    }

</script>
{/literal}