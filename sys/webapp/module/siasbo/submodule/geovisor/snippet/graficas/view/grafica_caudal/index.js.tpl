{literal}
<script>
    var canvas = document.getElementById("lienzo");

    //var dtc = [];

    function RecuperarDatosCaudal(){
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemCaudal{literal}&id={/literal}{$id}{literal}";

        swal({
            title: 'Cargando!',
            text: 'Procesando datos',
            imageUrl: 'images/loading/loading05.gif',
            showConfirmButton: false,
            allowEnterKey: false,
            allowOutsideClick: false,
            allowEscapeKey: false,
        });

        $.get(url, function(respuesta){
            swal.close();
            var datos = JSON.parse(respuesta);          
            if (VerificarCaudal(datos) == false){
                CargarGraficaCaudal(datos);
            }else{
                swal("Advertencia","No existen datos para mostrar grafica","error");
            }
            // if (respuesta != 0){
            //     var datos = JSON.parse(respuesta);
            //     dtc = datos;
            //     CargarGraficaCaudal();
            // }else{
            //     swal("ADBERTENCIA", "No existen datos", "warning");
            // }
        });
    }

    function VerificarCaudal(datos){
        var cont = 0;
        for (var i=0; i<=datos.length-1; i++){
            if (datos[i].caudal == "" || datos[i].caudal == null || datos[i].caudal == 0 || datos[i].caudal == "NULL"){
                cont++;
            }
        }
        
        if (cont == datos.length){
            return true;
        }else{
            return false;
        }
    }

    function CargarGraficaCaudal(dtc){
        //RecuperarDatosCaudal();

        var datosfechacaudal = [];
        var datoscaudal = [];
        var datoscaudalautorizado = [];
        var formatofecha;

        for (var i=0; i<=dtc.length-1; i++){
            formatofecha = dtc[i].fecha.split("-");
            datosfechacaudal[i] = formatofecha[2]+"-"+formatofecha[1]+"-"+formatofecha[0];
            //datosfechacaudal[i] = dtc[i].fecha;
        }

        for (var i=0; i<=dtc.length-1; i++){
            datoscaudal[i] = dtc[i].caudal;
        }

        for (var i=0; i<=dtc.length-1; i++){
            datoscaudalautorizado[i] = dtc[i].caudalautorizado;
        }

        var ctx = canvas.getContext("2d");
        var barChart = new Chart(ctx, {
          type: 'line',
          data: {
            labels: datosfechacaudal,
            datasets: [{
              label: 'Variación del caudal vs tiempo',
              data: datoscaudal,
              backgroundColor: [
                'rgba(27, 79, 114, 0.1)'
              ],
              //borderWidth: 5,
              radius: 1,
              borderColor: 'rgba(27, 79, 114, 0.5)'              
            },
            {
              label: 'Caudal autorizado',
              data: datoscaudalautorizado,
              backgroundColor: [
                'rgba(255, 255, 255, 0)'
              ],
              //borderWidth: 5,
              radius: 0,
              borderColor: 'rgba(255, 0, 0, 0.5)'              
            }]            
          },
          options: {
                showLines: true, // disable for all datasets
                title: {
                    display: true,
                    text: 'Variacion del Caudal - Nombre Pozo: '+dtc[0].nombre,
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
                            labelString: 'Caudal (l / s)'
                        },
                        // ticks: {
                        //   beginAtZero: false,
                        // }
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
    }

    function GuardarGrafica(){
        Canvas2Image.saveAsPNG(canvas, canvas.width, canvas.height, "MonitoreoCantidad");
    }

    $(document).ready(function(){
        RecuperarDatosCaudal();
    });    

</script>
{/literal}