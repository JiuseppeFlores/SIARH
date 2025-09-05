{literal}
<script>
    var table_list_escalon;

    function item_update_escalon(id) { //,tipobombeo
        //var url = '{/literal}{$getModule}{literal}&accion=sev_itemUpdate&id='+id+'&type=update';
        //location = url;
        get_form_escalon(id, "update"); //,tipobombeo
    }

    function item_delete_escalon(id) {
        swal({
            title: 'Está seguro de borrar el registro?',
            text: "Recuerde que el registro se eliminará permanentemente. ID="+id+", ",
            type: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Si, eliminar!!!',
            cancelButtonText: "No, cancelar"
        }).then(function(result) {
            if (result.value) {
                itemDeleteActionEscalon(id);
            }
        });
    }

    function item_print_escalon(id) {
        alert("Imprime el dato:"+id);
    }

    function itemDeleteActionEscalon(id) {
        randomnumber=Math.floor(Math.random()*11);
        $.get( "{/literal}{$getModule}{literal}",
            {accion:"{/literal}{$subcontrol}_itemDeleteEscalon{literal}", random:randomnumber, id:id},
            function(res){
                if(res.res == 1){
                    swal('Eliminado!','El registro fue eliminado con éxito.','success');
                    //swal({position: 'top-center',type: 'success',title: 'El registro fue eliminado.',showConfirmButton: false,timer: 1200});
                    table_list_escalon.draw();
                }else if(res.res == 2){
                    swal("Ocurrió un error!", res.msg, "error");
                }else{
                    swal("ocurrió un error!", res.msg, "error");
                }
            },"json");
    }

    function item_opcion_editar_escalon(id) {
        return '<a class="dropdown-item" href="javascript:item_update_escalon(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-warning m-btn--icon m-btn--icon-only m-btn--pill" title="Editar"><i class="la flaticon-edit-1 m--font-brand"></i>&nbsp;Editar</a>';
    }

    function item_opcion_eliminar_escalon(id) {
        return '<a class="dropdown-item" href="javascript:item_delete_escalon(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-danger m-btn--icon m-btn--icon-only m-btn--pill" title="Eliminar"><i class="la flaticon-delete-2 m--font-brand"></i>&nbsp;Eliminar</a>';
    }

    function get_form_escalon(id, type) {//tipobombeo
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemUpdateEscalon{literal}&tipoId={/literal}{$tipoId}{literal}&id="+id+"&type="+type+"&tipobombeo={/literal}{$tipobombeo}{literal}"; //+tipobombeo

        $('#modal_content_escalon').html(" Cargando Tab.. ");
        swal({
            title: 'Cargando tab!',
            text: 'Procesando datos',
            imageUrl: 'images/loading/loading05.gif',
            showConfirmButton: false,
            allowEnterKey: false,
            allowOutsideClick: false,
            allowEscapeKey: false,
        });

        $.get(url, function(respuesta) {
            $('#modal_content_escalon').html(respuesta);
            swal.close();
            $('#modal_window_escalon').modal("show");            
        });
    }
    
    var snippet_datatable_list_escalon = function () {
        $.fn.dataTable.Api.register('column().title()', function() {
            return $(this.header()).text().trim();
        });

        var exporta_titulo = "SIASBO - LISTA DE ESCALONES";
        var exporta_columnas = [':visible :not(.noExport)'];

        var initTable = function() {
            // begin first table
            table_list_escalon = $('#lista_escalon').DataTable({

                initComplete: function(settings, json) {
                    $('#lista_escalon').removeClass('m--hide');
                },
                responsive: true,
                keys: {
                    blurable: false,
                    columns: exporta_columnas,
                    clipboard: false,
                },
                //stateSave: true,
                colReorder: true,
                //== Pagination settings
                dom:
                "<'row'<'col-sm-12 col-md-12 dataTables_pager'lp>>" +
                    `<'row'<'col-sm-5 text-left'f><'col-sm-7 text-right'B>>
                     <'row'<'col-sm-12'tr>>
                     <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'lp>>`,
                // read more: https://datatables.net/examples/basic_init/dom.html
                buttons: [
                    {extend:'colvis',text:'Ver '
                        ,columnText: function ( dt, idx, title ) {
                            return (idx+1)+': '+title;
                        }
                    },
                    {extend:'excelHtml5'
                        ,exportOptions: {columns: exporta_columnas}
                        , title: exporta_titulo
                    },
                    {extend:'pdfHtml5'
                        ,exportOptions: {columns: exporta_columnas}
                        , title: exporta_titulo
                        , download: 'open'
                        //, orientation: 'landscape'
                        , pageSize: 'LETTER'
                        ,customize: function(doc) {
                            doc.styles.tableHeader.fontSize = 7;
                            doc.defaultStyle.fontSize = 7;
                            doc.pageMargins= [ 20, 20];
                        }
                    },

                ],

                // read more: https://datatables.net/examples/basic_init/dom.html
                language: {"url": "language/datatable.spanish.json"},
                lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "Todo"]], //[5, 10, 25, 50],
                pageLength: 10,
                order: [[ 2, "asc" ]], // Por que campo ordenara al momento de desplegar
                searchDelay: 500,
                processing: true,
                serverSide: true,
                ajax: {
                    url: '{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemListEscalon{literal}&tipoId={/literal}{$tipoId}{literal}',
                    type: 'POST',
                    data: {},
                },
                columns: [
                    {/literal}
                    {foreach from=$grill_list item=row key=idx}
                        {literal}{data: '{/literal}{$row.field}{literal}'} ,{/literal}
                    {/foreach}
                    {literal}
                ],
                columnDefs: [
                    {
                        targets: 0,
                        title: 'Acción',
                        orderable: false,
                        render: function(data, type, full, meta) {
                            // var boton = '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-h m--font-brand"></i></a><div class="dropdown-menu dropdown-menu-left">{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar_escalon(data) + '{/literal}{/if}{literal}{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar_escalon(data) + '{/literal}{/if}{literal}</div></span>';
                            // return boton;

                            var boton = '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-h m--font-brand"></i></a><div class="dropdown-menu dropdown-menu-left">';

                            // var permisoedit = 1;
                            // var permisodelete = 1;
                            // var permisoreadonly = 1;
                            var botonedit = "";
                            var botondelete = ""; 
                            //var botonreadonly = "";               

                            if (obj_permiso[0].editar == 1){ //permisoedit
                                botonedit = '{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar_escalon(data) + '{/literal}{/if}{literal}';
                            }

                            if (obj_permiso[0].eliminar == 1){ //permisodelete
                                botondelete = '{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar_escalon(data) + '{/literal}{/if}{literal}';
                            }
                            
                            //botonreadonly = '{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_sololeer(data) + '{/literal}{/if}{literal}';
                            //table_list.column(0).visible(false); //Solo funciona con false
                            
                            return boton+botonedit+botondelete+'</div></span>'; //+botonreadonly;
                        }
                    },
                    {
                        targets: 1,
                        visible: false,
                    },
                ],
            });

        };

        return {

            //main function to initiate the module
            init: function() {
                initTable();
            },

        };

    }();

    //Grafica de escalones
    function get_grafica(id,tipo) {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemEscalon{literal}&id="+id+"&tipo="+tipo;
        
        //$('#window_content_data').html("Cargando...");
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
            if (respuesta == 0) {
                swal.close();
                swal('Advertencia!','No existen datos.','warning');
            } else {
                //var datos = JSON.parse(respuesta);
                $('#modal_escalon_contenido').html(respuesta);
                $("#modal_escalon").modal("show");
                swal.close();
            }
        });
    }

    // var canvas = document.getElementById("lienzo");
    // var dtb;
    // var de;

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
    //         de = datos;
    //         //alert("Nivel dinamico"+datos[0].nivel_dinamico);
    //     });
    // }

    // function Redondeo(numero){
    //     return Math.round(numero * 100) / 100;
    // }

    // function CargarGrafica(){

    //     RecuperarDatosEscalon();

    //     AbrirModal();

    //     if(de[0].tipo == 2){
    //         $("#exampleModalLabel").text("Prueba de bombeo escalonada");
    //     }else if(de[0].tipo == 3){
    //         $("#exampleModalLabel").text("Prueba de bombeo continua");
    //     }        

    //     var abatimiento = [];
    //     var tiempo = [];
    //     var etap = [];
    //     var etapa1 = 0;
    //     var etapa2 = 0;
    //     var etapa3 = 0;
    //     var etapa4 = 0;
    //     var etapa5 = 0;

    //     for (var i=0; i<=de.length-1; i++){
    //         abatimiento[i] = Redondeo(de[i].nivel_estatico - de[i].nivel_dinamico);
    //         tiempo[i] = Math.round(de[i].tiempo/60); // + "(min)";

    //         if(de[i].etapa != ""){
    //             etap[i] = de[i].etapa;

    //             switch (de[i].etapa) {
    //               case "1":                
    //                 etapa1++;
    //                 break;
    //               case "2":                
    //                 etapa2++;
    //                 break;
    //               case "3":
    //                 etapa3++;
    //                 break;
    //               case "4":
    //                 etapa4++;
    //                 break;
    //               case "5":
    //                 etapa5++;
    //                 break;
    //             }
    //         }            
    //     }

    //     //Filtra todos los valores repetidos
    //     var unicos = etap.filter(function(item, index, array) {
    //       return array.indexOf(item) === index;
    //     })

    //     var ctx = canvas.getContext("2d");

    //     if(de[0].tipo == 1){
    //         var gradiente = ctx.createLinearGradient(0, 0, 750, 0);       

    //         for (var i=0; i<=unicos.length-2; i++){
    //             switch (unicos[i]) {
    //               case "1": 
    //                 gradiente.addColorStop(0, 'rgba(27, 79, 114, 0.5)');   
    //                 gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(27, 79, 114, 0.5)');   
    //                 gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(46, 134, 193, 0.5)');
    //                 gradiente.addColorStop(1, 'rgba(46, 134, 193, 0.5)');
    //                 break;
    //               case "2":    
    //                 //alert((Math.round((etapa1*100)/de.length))/100+" - "+(Math.round((etapa2*100)/de.length))/100+" - "+(Math.round((etapa3*100)/de.length))/100);              
    //                 gradiente.addColorStop(0, 'rgba(27, 79, 114, 0.5)');   
    //                 gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(27, 79, 114, 0.5)');   
    //                 gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(46, 134, 193, 0.5)');
    //                 gradiente.addColorStop(((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(46, 134, 193, 0.5)');
    //                 gradiente.addColorStop(((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');
    //                 gradiente.addColorStop(1, 'rgba(27, 79, 114, 0.5)');
    //                 break;
    //               case "3":
    //                 gradiente.addColorStop(0, 'rgba(27, 79, 114, 0.5)');   
    //                 gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(27, 79, 114, 0.5)');   
    //                 gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(52, 152, 219, 0.5)');
    //                 gradiente.addColorStop(((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(52, 152, 219, 0.5)');   
    //                 gradiente.addColorStop(((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');
    //                 gradiente.addColorStop(((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');   
    //                 gradiente.addColorStop(((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(52, 152, 219, 0.5)');
    //                 gradiente.addColorStop(1, 'rgba(52, 152, 219, 0.5)');
    //                 break;
    //               case "4":
    //                 gradiente.addColorStop(0, 'rgba(27, 79, 114, 0.5)');   
    //                 gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(27, 79, 114, 0.5)');   
    //                 gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(52, 152, 219, 0.5)');
    //                 gradiente.addColorStop(((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(52, 152, 219, 0.5)');   
    //                 gradiente.addColorStop(((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');
    //                 gradiente.addColorStop(((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');   
    //                 gradiente.addColorStop(((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(52, 152, 219, 0.5)');
    //                 gradiente.addColorStop(((Math.round((etapa4*100)/de.length))/100)+((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(52, 152, 219, 0.5)');   
    //                 gradiente.addColorStop(((Math.round((etapa4*100)/de.length))/100)+((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');
    //                 gradiente.addColorStop(1, 'rgba(27, 79, 114, 0.5)');
    //                 break;
    //               case "5":
    //                 gradiente.addColorStop(0, 'rgba(27, 79, 114, 0.5)');   
    //                 gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(27, 79, 114, 0.5)');   
    //                 gradiente.addColorStop((Math.round((etapa1*100)/de.length))/100, 'rgba(52, 152, 219, 0.5)');
    //                 gradiente.addColorStop(((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(52, 152, 219, 0.5)');   
    //                 gradiente.addColorStop(((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');
    //                 gradiente.addColorStop(((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');   
    //                 gradiente.addColorStop(((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(52, 152, 219, 0.5)');
    //                 gradiente.addColorStop(((Math.round((etapa4*100)/de.length))/100)+((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(52, 152, 219, 0.5)');   
    //                 gradiente.addColorStop(((Math.round((etapa4*100)/de.length))/100)+((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');
    //                 gradiente.addColorStop(((Math.round((etapa5*100)/de.length))/100)+((Math.round((etapa4*100)/de.length))/100)+((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(27, 79, 114, 0.5)');   
    //                 gradiente.addColorStop(((Math.round((etapa5*100)/de.length))/100)+((Math.round((etapa4*100)/de.length))/100)+((Math.round((etapa3*100)/de.length))/100)+((Math.round((etapa2*100)/de.length))/100)+((Math.round((etapa1*100)/de.length))/100), 'rgba(52, 152, 219, 0.5)');
    //                 gradiente.addColorStop(1, 'rgba(52, 152, 219, 0.5)');
    //                 break;
    //             }
    //         }   
    //     }             

    //     var barChart = new Chart(ctx, {
    //       type: 'line',
    //       data: {
    //         labels: tiempo,
    //         datasets: [{
    //           label: 'Escalones',
    //           data: abatimiento,
    //           backgroundColor: [
    //             'rgba(42, 127, 255, 0)',                
    //           ],
    //           borderWidth: 5,
    //           borderColor: (de[0].tipo == 1)? gradiente : 'rgba(27, 79, 114, 0.5)', //'rgba(42, 127, 0, 0.5)'
    //         }]
    //       },
    //       options: {
    //             showLines: true,
    //             title: {
    //                 display: true,
    //                 text: (de[0].tipo == 2)? "Prueba de Bombeo Escalonada - Nombre Pozo: "+de[0].nombre : (de[0].tipo == 3)? "Prueba de Bombeo Continua - Nombre Pozo: "+de[0].nombre : "Prueba de Bombeo Desconocido - Nombre Pozo: "+de[0].nombre
    //             },
    //             scales: {
    //                 xAxes: [{
    //                     scaleLabel: {
    //                         display: true,
    //                         labelString: 'Tiempo (minutos)'
    //                     }
    //                 }],
    //                 yAxes: [{
    //                     stacked: true,
    //                     scaleLabel: {
    //                         display: true,
    //                         labelString: 'Abatimiento (m)'
    //                     }
    //                 }]
    //             }
    //         },
    //     }); 
    // }

    function GuardarGrafica(){
        if(de[0].tipo == 2){
            Canvas2Image.saveAsPNG(canvas, canvas.width, canvas.height, "PruebaBombeoEscalonada");
        }else if(de[0].tipo == 3){
            Canvas2Image.saveAsPNG(canvas, canvas.width, canvas.height, "PruebaBombeoContinua");
        } 
        
    }

    // function AbrirModal(){
    //     $('#modalgraficabombeo').modal('show');
    // }

    // function CerrarModal(){
    //     $('#modalgraficabombeo').modal('hide');
    // }

//----------------Permisos--------------------------------------------
    var obj_permiso;

    function permisos_usuario(){
        var idUsuarioResponsable = parseInt($('#idUsuarioResponsable').val());
        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=obtenerPermisos&perpozo=pozo', //&perpozo=pozo
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            //dataType: "json",
            success: function(data){
                obj_permiso = JSON.parse(data);

                // if (obj_permiso[0].crear == 1){                                
                //     $("#btn_nuevo_escalon_submit").show();
                // }else{
                //     $("#btn_nuevo_escalon_submit").hide();
                // }      
                
                switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#btn_nuevo_escalon_submit").show();
                        }else{
                            $("#btn_nuevo_escalon_submit").hide();
                        }
                        break;
                    case 3:
                        $("#btn_nuevo_escalon_submit").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                            $("#btn_nuevo_escalon_submit").show();
                        }else{
                            $("#btn_nuevo_escalon_submit").hide();
                        }
                        break;
                }
            },
        });
    }

    jQuery(document).ready(function() {
        permisos_usuario();
        snippet_datatable_list_escalon.init();
        //RecuperarDatosTipoBombeo();
        //RecuperarDatosEscalon();
    });

</script>
{/literal}