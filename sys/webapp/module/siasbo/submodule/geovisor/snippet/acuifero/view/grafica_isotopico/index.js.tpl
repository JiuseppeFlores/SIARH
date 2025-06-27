{literal}
<script>
    var canvas = document.getElementById('grafico_isotopico');
    var ctx = canvas.getContext('2d');

    var datos = {/literal}{$campanias}{literal};
    var acuiferoId = {/literal}{$acuiferoId}{literal};
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
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getDatosIsotopicos{literal}&acuiferoId="+acuiferoId+"&campaniaId="+campania;

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
            //alert(campania);
        });
    }); 

</script>
{/literal}