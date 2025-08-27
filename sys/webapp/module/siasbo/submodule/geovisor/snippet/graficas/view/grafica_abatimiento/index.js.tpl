{literal}
<script>
    var canvas = document.getElementById("lienzo");

    //var dta = [];

    function RecuperarDatosAbatimiento(){
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemAbatimiento{literal}&id={/literal}{$id}{literal}";

        swal({
            title: 'Cargando!',
            text: 'Procesando datos',
            imageUrl: 'images/loading/loading05.gif',
            showConfirmButton: false,
            allowEnterKey: false,
            allowOutsideClick: false,
            allowEscapeKey: false,
        });

        $.get(url, function(respuesta) {
            swal.close();
            var datos = JSON.parse(respuesta);
            if (VerificarNivelEstatico(datos) == false){
                CargarGraficaAbatimiento(datos);
            }else{
                swal("Advertencia","No existen datos para mostrar grafica","error");
            }
            // if (respuesta != 0){
            //     var datos = JSON.parse(respuesta);
            //     dta = datos;
            //     CargarGraficaAbatimiento();
            // }else{
            //     swal("ADBERTENCIA", "No existen datos", "warning");
            // }
            
        });
    }

    function VerificarNivelEstatico(datos){
        var cont = 0;
        for (var i=0; i<=datos.length-1; i++){
            if (datos[i].nivel_estatico == "" || datos[i].nivel_estatico == null || datos[i].nivel_estatico == 0 || datos[i].nivel_estatico == "NULL"){
                cont++;
            }
        }

        if (cont == datos.length){
            return true;
        }else{
            return false;
        }
    }

    function CargarGraficaAbatimiento(dta){
        //RecuperarDatosAbatimiento();
        var datosfecha = [];
        var datosnivelestatico = [];
        var formatofecha;

        for (var i=0; i<=dta.length-1; i++){
            formatofecha = dta[i].fecha.split("-");
            datosfecha[i] = formatofecha[2]+"-"+formatofecha[1]+"-"+formatofecha[0];
            //datosfecha[i] = dta[i].fecha;
        }

        for (var i=0; i<=dta.length-1; i++){
            datosnivelestatico[i] = dta[i].nivel_estatico;
        }

        var ctx = canvas.getContext("2d");
        var barChart = new Chart(ctx, {
          type: 'line',
          data: {
            labels: datosfecha,
            datasets: [{
              label: 'Variación del nivel estatico en el tiempo',
              data: datosnivelestatico,
              backgroundColor: [
                'rgba(42, 127, 255, 0)'
              ],
              // borderWidta: 3,
              borderColor: 'rgba(27, 79, 114, 0.5)'              
            }]
          },
          options: {
                showLines: true, // disable for all datasets
                title: {
                    display: true,
                    text: 'Abatimiento - Nombre Pozo: '+dta[0].nombre,
                },
                scales: {
                    xAxes: [{
                        scaleLabel: {
                            display: true,
                            labelString: 'Tiempo (fecha)'
                        }
                    }],
                    yAxes: [{
                        stacked: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Nivel Estatico'
                        },
                        ticks: {
                            reverse: true,
                        }
                    }]
                },
                elements: {
                    point: {
                        radius: 4,
                        borderWidth: 8,
                        borderColor: 'rgba(27, 79, 114, 0.5)',
                        //backgroundColor: 'rgba(27, 79, 114, 0.5)',
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
        RecuperarDatosAbatimiento();
    });    

</script>
{/literal}