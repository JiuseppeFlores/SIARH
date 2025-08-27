{literal}
<script>
    var canvas = document.getElementById("lienzo");
    // var dtb;
    // var de;

    var datos = '{/literal}{$datos}{literal}';
    var lista = JSON.parse(datos);
    var tipo = '{/literal}{$tipo}{literal}';

    var tiposBombeo = JSON.parse('{/literal}{$tiposBombeo}{literal}');
    var esEscalonado = (tiposBombeo[tipo]).toLowerCase() === 'escalonado';
    var esContinuo = (tiposBombeo[tipo]).toLowerCase() === 'continuo';
    var esDesconocido = (tiposBombeo[tipo]).toLowerCase() === 'desconocido';

    // function RecuperarDatosEscalon(){
    //     var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemEscalon{literal}&tipoId={/literal}{$tipoId}{literal}";

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
    //         //de = datos;
    //         //alert("Nivel dinamico"+datos[0].nivel_dinamico);
    //         CargarGrafica(datos);
    //     });
    // }

    function Redondeo(numero){
        return Math.round(numero * 100) / 100;
    }

    function CargarGrafica(de,tipo){

        if(esEscalonado){
            $("#exampleModalLongTitle").text("Prueba de bombeo escalonada");
        }else if(esContinuo){
            $("#exampleModalLongTitle").text("Prueba de bombeo continua");
        }else if(esDesconocido){
            $("#exampleModalLongTitle").text("Prueba de bombeo desconocido");
        }

        var abatimiento = [];
        var tiempo = [];
        var etap = [];
        var etapa1 = 0;
        var etapa2 = 0;
        var etapa3 = 0;
        var etapa4 = 0;
        var etapa5 = 0;

        var acumulados = [];
        var acumulado = 0;
        var coloresPuntos = [];
        var colores = [
          'rgba(27, 79, 114, 0.5)',
          'rgba(46, 134, 193, 0.5)',
          'rgba(27, 79, 114, 0.5)',
          'rgba(52, 152, 219, 0.5)',
          'rgba(27, 79, 114, 0.5)',
        ];

        for (var i=0; i<=de.length-1; i++){
            abatimiento[i] = Redondeo(de[i].nivel_estatico - de[i].nivel_dinamico);
            tiempo[i] = Math.round(de[i].tiempo/60); // + "(min)";
            
            if(i > 0 && tiempo[i-1] > tiempo[i]){
              acumulado = acumulados[i-1];
            }
            acumulados.push(tiempo[i]+acumulado);

            if(de[i].etapa != ""){
                etap[i] = de[i].etapa;
                coloresPuntos[i] = colores[parseInt(de[i].etapa) - 1];
                switch (de[i].etapa) {
                  case "1":                
                    etapa1++;
                    break;
                  case "2":                
                    etapa2++;
                    break;
                  case "3":
                    etapa3++;
                    break;
                  case "4":
                    etapa4++;
                    break;
                  case "5":
                    etapa5++;
                    break;
                }
            }            
        }

        //Filtra todos los valores repetidos
        var unicos = etap.filter(function(item, index, array) {
          return array.indexOf(item) === index;
        })

        var ctx = canvas.getContext("2d");

        if(esEscalonado){
            
            var unico = unicos.reduce((mayor, actual) => actual > mayor ? actual : mayor, '');
            var gradiente = ctx.createLinearGradient(0, 0, 750, 0);       

            switch (unico) {
              case "1": 
                gradiente.addColorStop(0, 'rgba(27, 79, 114, 0.5)');   
                gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(27, 79, 114, 0.5)');   
                gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(46, 134, 193, 0.5)');
                gradiente.addColorStop(1, 'rgba(46, 134, 193, 0.5)');
                break;
              case "2":    
                //alert((Math.round((etapa1*100)/de.length))/100+" - "+(Math.round((etapa2*100)/de.length))/100+" - "+(Math.round((etapa3*100)/de.length))/100);              
                gradiente.addColorStop(0, 'rgba(27, 79, 114, 0.5)');   
                gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(27, 79, 114, 0.5)');   
                gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(46, 134, 193, 0.5)');
                gradiente.addColorStop(((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(46, 134, 193, 0.5)');
                gradiente.addColorStop(((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');
                gradiente.addColorStop(1, 'rgba(27, 79, 114, 0.5)');
                break;
              case "3":
                gradiente.addColorStop(0, 'rgba(27, 79, 114, 0.5)');   
                gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(27, 79, 114, 0.5)');   
                gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(52, 152, 219, 0.5)');
                gradiente.addColorStop(((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(52, 152, 219, 0.5)');   
                gradiente.addColorStop(((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');
                gradiente.addColorStop(((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');   
                gradiente.addColorStop(((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(52, 152, 219, 0.5)');
                gradiente.addColorStop(1, 'rgba(52, 152, 219, 0.5)');
                break;
              case "4":
                gradiente.addColorStop(0, 'rgba(27, 79, 114, 0.5)');   
                gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(27, 79, 114, 0.5)');   
                gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(52, 152, 219, 0.5)');
                gradiente.addColorStop(((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(52, 152, 219, 0.5)');   
                gradiente.addColorStop(((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');
                gradiente.addColorStop(((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');   
                gradiente.addColorStop(((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(52, 152, 219, 0.5)');
                gradiente.addColorStop(((Math.round((etapa4*100)/de.length))/100)+((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(52, 152, 219, 0.5)');   
                gradiente.addColorStop(((Math.round((etapa4*100)/de.length))/100)+((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');
                gradiente.addColorStop(1, 'rgba(27, 79, 114, 0.5)');
                break;
              case "5":
                gradiente.addColorStop(0, 'rgba(27, 79, 114, 0.5)');   
                gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(27, 79, 114, 0.5)');   
                gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(52, 152, 219, 0.5)');
                gradiente.addColorStop(((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(52, 152, 219, 0.5)');   
                gradiente.addColorStop(((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');
                gradiente.addColorStop(((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');   
                gradiente.addColorStop(((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(52, 152, 219, 0.5)');
                gradiente.addColorStop(((Math.round((etapa4*100)/de.length))/100)+((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(52, 152, 219, 0.5)');   
                gradiente.addColorStop(((Math.round((etapa4*100)/de.length))/100)+((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');
                gradiente.addColorStop(((Math.round((etapa5*100)/de.length))/100)+((Math.round((etapa4*100)/de.length))/100)+((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');   
                gradiente.addColorStop(((Math.round((etapa5*100)/de.length))/100)+((Math.round((etapa4*100)/de.length))/100)+((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(52, 152, 219, 0.5)');
                gradiente.addColorStop(1, 'rgba(52, 152, 219, 0.5)');
                break;
            }  
        }

        var barChart = new Chart(ctx, {
          type: 'line',
          data: {
            labels: esEscalonado ? acumulados : null,
            datasets: [{
              label: 'Abatimiento',
              data: esEscalonado ? abatimiento : tiempo.map((t, index) => ({ x: t, y: abatimiento[index] })),
              backgroundColor: [
                'rgba(42, 127, 255, 0)',
              ],
              borderWidth: 5,
              borderColor: esEscalonado ? coloresPuntos : 'rgba(27, 79, 114, 0.5)', //'rgba(42, 127, 0, 0.5)'
              pointBackgroundColor: coloresPuntos,
              pointBorderColor: esEscalonado ? coloresPuntos : 'rgba(27, 79, 114, 0.5)',
              fill: false,
              tension: 0.3,
            }]
          },
          options: {
                showLines: true,
                title: {
                    display: true,
                    text: esEscalonado 
                            ? "Prueba de Bombeo Escalonada - Nombre Pozo: "+de[0].nombre 
                            : esContinuo
                                ? "Prueba de Bombeo Continua - Nombre Pozo: "+de[0].nombre 
                                : "Prueba de Bombeo Desconocido - Nombre Pozo: "+de[0].nombre
                },
                scales: {
                    xAxes: [{
                        type: esEscalonado ? 'category' : 'linear',
                        position: 'bottom',
                        scaleLabel: {
                            display: true,
                            labelString: 'Tiempo (minutos)'
                        },
                        ticks: {
                            beginAtZero: !esEscalonado,
                            //stepSize: 1,
                        },
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

    function GuardarGrafica(de){
        if(esEscalonado){
            Canvas2Image.saveAsPNG(canvas, canvas.width, canvas.height, "PruebaBombeoEscalonada");
        }else if(esContinuo){
            Canvas2Image.saveAsPNG(canvas, canvas.width, canvas.height, "PruebaBombeoContinua");
        }else if(esDesconocido){
            Canvas2Image.saveAsPNG(canvas, canvas.width, canvas.height, "PruebaBombeoDesconocido");
        }         
    }

    $("#btn_guardar_grafica").click(function(){
        GuardarGrafica(lista);
    });

    $(document).ready(function(){
        //RecuperarDatosEscalon();
        
        CargarGrafica(lista, tipo)        
    });

</script>
{/literal}