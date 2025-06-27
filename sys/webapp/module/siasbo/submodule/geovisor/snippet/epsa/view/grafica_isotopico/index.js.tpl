{literal}
<script>
    var canvas = document.getElementById('grafico_isotopico');
    var ctx = canvas.getContext('2d');

    var datos = {/literal}{$campanias}{literal};
    var epsaId = {/literal}{$epsaId}{literal};
    var dimension = 0; 

    function GraficarIsotopos(dato){
        var parmezcla = {};
        var datamezcla = [];
        var dato1 = dato[0].valor.split(",");
        var dato2 = dato[1].valor.split(",");
        dimension = dato1.length;

        if (dato1[0] < dato2[0]){
            for (var i=0; i<=dimension-1; i++) {
                parmezcla = {x:dato2[i], y:dato1[i]};
                datamezcla.push(parmezcla);
            }
        }else{
            for (var i=0; i<=dimension-1; i++) {
                parmezcla = {x:dato1[i], y:dato2[i]};
                datamezcla.push(parmezcla);
            }
        }  

        var scatterChartData = {
            datasets: [
                {
                    label: 'Mezcla',
                    borderColor: '#2980B9', //'#E74C3C',
                    backgroundColor: '#2980B980', //'#E74C3C80',            
                    data: datamezcla,
                },
            ]
        };
        
        var myScatter = new Chart.Scatter(ctx, {
            data: scatterChartData,
            options: {
                title: {
                    display: true,
                    text: 'Gráfica Isótopos - '+ dato[0].nombre,    // +' Numero de Pozos: '+dimension
                },
                scales: {
                    xAxes: [{
                        //type: 'logarithmic',
                        position: 'bottom',                    
                        scaleLabel: {
                            labelString: 'Oxígeno 18 (\u2030 Vsmow)',
                            display: true,
                        }
                    }],
                    yAxes: [{
                        type: 'linear',
                        scaleLabel: {
                            labelString: 'Deuterio (\u2030 Vsmow)',
                            display: true
                        }
                    }]
                },
                legend: {
                    display: false
                }
            }
        });
    }    

    function GuardarGrafica(){
        Canvas2Image.saveAsPNG(canvas, canvas.width, canvas.height, "MonitoreoIsotopicoAcuifero");
    }

    function RecuperarDatosIsotopos(campania){
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getDatosIsotopicos{literal}&epsaId="+epsaId+"&campaniaId="+campania;

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

            if (datos[0].valor.split(",").length != 0){
                GraficarIsotopos(datos);             
            }else{
                var ctx = canvasstiff.getContext("2d");
                ctx.clearRect(0, 0, canvasstiff.width, canvasstiff.height);  
                swal("Advertencia!", "No existen datos para esta campaña.", "error");
            }
        });
    }

    // function CargarSelect(){
    //     var array = ["01/2010", "01/2011", "01/2013", "01/2014"];
    //     for(var i in array){ 
    //         document.getElementById("campaniaIsotopicoId").innerHTML += "<option value='"+array[i]+"'>"+array[i]+"</option>";
    //     }
    // }

    $(document).ready(function(){
        Object.keys(datos).forEach(function(key) {
          document.getElementById("campaniaIsotopicoId").innerHTML += "<option value='"+datos[key]+"'>"+datos[key]+"</option>";
        })

        // CargarSelect();
        // $('#campaniaIsotopicoId').val('01/2010');

        // $('.select2').select2({
        //     placeholder: "Seleccione una opción",
        //     dropdownParent: $("#modal_stiff")
        // });

        select_campania_stiff = $('#campaniaIsotopicoId');

        select_campania_stiff.change(function() {
            var campania = $('#campaniaIsotopicoId').val();
            RecuperarDatosIsotopos(campania);
        });
    }); 

</script>
{/literal}





<!-- {literal}
<script>
    var canvas = document.getElementById('grafico_isotopico');
    var ctx = canvas.getContext('2d');

    var datos = {/literal}{$datosIsotopicos}{literal};

    var dimension =datos.length;
    var valores = [];
    var parmezcla = {};
    var datamezcla = [];
    var par = {};
    var data = [];

    var ecuacion = 0;
    var dataecuacion = [];

    for (var i=0; i<=dimension-1; i++) {

        valores = datos[i].valor.split(",");

        if(Mezcla(valores[0], valores[1]) == true){
            parmezcla = {x:valores[0],y:valores[1]};
            datamezcla.push(parmezcla);
        }else{
            par = {x:valores[0],y:valores[1]};
            data.push(par);
        }
        
        ecuacion = Math.round(((7.17*parseFloat(valores[0]))-5.28) * 100) / 100;
        dataecuacion.push({x:valores[0],y:ecuacion});

        valores = 0;
    };

    function Mezcla(a, b){
        var sum = parseInt(a)+parseInt(b);
        if(sum >= -136 && sum <= -128.1){
            return true;
        }else{
            return false;
        }
    }

    var scatterChartData = {
        datasets: [{
            label: 'Mezcla',
            borderColor: '#E74C3C',
            backgroundColor: '#E74C3C80',            
            data: datamezcla,
        },
        {
            label: 'Recarga Antigua',
            borderColor: '#F39C12',
            backgroundColor: '#F39C1280',            
            data: data,
        },
        {
            label: "Lineal (Agua Subterránea)",
            data: dataecuacion,
            backgroundColor: '#2980B9',
        }]
    };

    var myScatter = Chart.Scatter(ctx, {
        data: scatterChartData,
        options: {
            title: {
                display: true,
                text: 'Gráfica Isótopos - Numero de Pozos: '+datos.length,
            },
            scales: {
                xAxes: [{
                    //type: 'logarithmic',
                    position: 'bottom',                    
                    scaleLabel: {
                        labelString: 'Oxígeno 18 (% Vsmaw)',
                        display: true,
                    }
                }],
                yAxes: [{
                    type: 'linear',
                    scaleLabel: {
                        labelString: 'Deuterio (% Vsmaw)',
                        display: true
                    }
                }]
            },
            legend: {
                display: false
            }
        }
    });

    function GuardarGrafica(){
        Canvas2Image.saveAsPNG(canvas, canvas.width, canvas.height, "MonitoreoIsotopicoAcuifero");
    }

</script>
{/literal} -->