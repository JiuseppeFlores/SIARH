{literal}
<script>

    var canvas = document.getElementById("lienzorecuperacion");
    // var dtr;
    // var der;

    var datos = '{/literal}{$datos}{literal}';
    var lista = JSON.parse(datos);

    // function RecuperarDatosEscalonRecuperacion(){
    //     var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemEscalonRecuperacion{literal}&recuperacionId={/literal}{$recuperacionId}{literal}";

    //     swal({
    //         title: 'Cargando tab!',
    //         text: 'Procesando datos',
    //         imageUrl: 'images/loading/loading05.gif',
    //         showConfirmButton: false,
    //         allowEnterKey: false,
    //         allowOutsideClick: false,
    //         allowEscapeKey: false,
    //     });

    //     $.get(url, function(respuesta) {
    //         swal.close();
    //         var datos = JSON.parse(respuesta);
    //         der = datos;
    //         //alert("Nivel dinamico"+datos[0].nivel_dinamico);
    //     });
    // }

    function CargarGrafica(der){
        
        $("#etiquetatitulo").text("Prueba de recuperación");        

        var abatimiento = [];
        var tiempo = [];

        for (var i=0; i<=der.length-1; i++){
            abatimiento[i] = der[i].nivel_estatico - der[i].nivel_dinamico;
        }

        for (var j=0; j<=der.length-1; j++){
            tiempo[j] = Math.round(der[j].tiempo/60); // + "(min)";
        }

        var ctx = canvas.getContext("2d");
        var barChart = new Chart(ctx, {
          type: 'line',
          data: {
            labels: tiempo,
            datasets: [{
              label: 'Escalones',
              data: abatimiento,
              backgroundColor: [
                'rgba(42, 127, 255, 0)'
              ],
              borderWidth: 5,
              borderColor: 'rgba(231, 76, 60, 0.5)'            
            }]
          },
          options: {
                showLines: true,
                title: {
                    display: true,
                    text: 'Prueba de recuperación - Nombre Pozo: '+der[0].nombre,
                },
                scales: {
                    xAxes: [{
                        scaleLabel: {
                            display: true,
                            labelString: 'Tiempo (minutos)'
                        }
                    }],
                    yAxes: [{
                        stacked: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Abatimiento (m)'
                        }
                    }]
                }
          },
        });        
    }

    function GuardarGrafica(){
        Canvas2Image.saveAsPNG(canvas, canvas.width, canvas.height, "PruebaRecuperacion");
    }

    $(document).ready(function(){
        //RecuperarDatosEscalon();
        CargarGrafica(lista)
    });

</script>
{/literal}