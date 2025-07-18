{literal}
<script>
    var table_list_calidad;
    var canvasProfundidad = document.getElementById("lienzo_profundidad");

    function item_update_calidad(id) {
        //var url = '{/literal}{$getModule}{literal}&accion=sev_itemUpdate&id='+id+'&type=update';
        //location = url;
        get_form_calidad(id, "update");
    }

    function item_delete_calidad(id) {
        swal({
            title: 'Está seguro de borrar el registro?',
            text: "Recuerde que el registro se eliminará permanentemente. ID="+id+", ",
            type: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Si, eliminar!!!',
            cancelButtonText: "No, cancelar"
        }).then(function(result) {
            if (result.value) {
                itemDeleteActionCalidad(id);
            }
        });
    }

    function item_print_calidad(id) {
        alert("Imprime el dato:"+id);
    }

    function itemDeleteActionCalidad(id) {
        randomnumber=Math.floor(Math.random()*11);
        $.get( "{/literal}{$getModule}{literal}",
            {accion:"{/literal}{$subcontrol}_itemDeleteCalidad{literal}", random:randomnumber, id:id},
            function(res){
                if(res.res == 1){
                    swal('Eliminado!','El registro fue eliminado con éxito.','success');
                    //swal({position: 'top-center',type: 'success',title: 'El registro fue eliminado.',showConfirmButton: false,timer: 1200});
                    table_list_calidad.draw();
                }else if(res.res == 2){
                    swal("Ocurrió un error!", res.msg, "error");
                }else{
                    swal("ocurrió un error!", res.msg, "error");
                }
            },"json");
    }

    function RecuperarDatosCalidad() {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemCalidad{literal}&manantialId={/literal}{$manantialId}{literal}";
        console.log('url recuperado::',url);
        $('#modal_content').html(" Cargando Tab.. ");
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
            swal.close();
            var datos = JSON.parse(respuesta);
            console.log('datos recuperados caso calidad::',datos);
        //         //dth = datos;
            if (VerificarProfundidad(datos) == false){
                CargarGraficaCalidad(datos);
                AbrirModalCalidad();
            }else{
                swal("Advertencia","No existen datos para mostrar grafica","error");
            }
        //         //alert("Nivel estatico"+datos[0].nivel_estatico);
        });
    }

    function CargarGraficaCalidad(dtc){
        console.log('datos recuperados caso calidad::',dtc);
        var datosfechacalidad = [];
        var datoscalidad = [];
        var datoscalidadautorizado = [];
        var formatofecha;
        for (var i=0; i<=dtc.length-1; i++){
            formatofecha = dtc[i].fecha.split("-");
            datosfechacalidad[i] = dtc[i].epoca+" "+formatofecha[2]+"-"+formatofecha[1]+"-"+formatofecha[0]+" "+dtc[i].hora;
        }
        for (var i=0; i<=dtc.length-1; i++){
            datoscalidad[i] = dtc[i].profundidad;
        }
        for (var i=0; i<=dtc.length-1; i++){
            datoscalidadautorizado[i] = dtc[i].calidadautorizado;
        }
        //AbrirModal();
        var ctx = canvasProfundidad.getContext("2d");
        var barChart = new Chart(ctx, {
          type: 'line',
          data: {
            labels: datosfechacalidad,
            datasets: [{
              label: 'Variación del Profundidad vs Tiempo',
              data: datoscalidad,
              backgroundColor: [
                'rgba(27, 79, 114, 0.1)'
              ],
              //borderWidth: 5,
              radius: 1,
              borderColor: 'rgba(27, 79, 114, 0.5)'              
            },
            {
              label: 'Profundiad',
              data: datoscalidadautorizado,
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
                    text: 'Variacion del Profundidad - Nombre Manantial: '+dtc[0].nombre,
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
                            labelString: 'Profundidad (m)'
                        },
                        // ticks: {
                        //   beginAtZero: false,
                        // }
                    }]
                },
                elements: {
                    point: {
                        //radius: 0,
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

    function VerificarProfundidad(datos){
        var cont = 0;
        for (var i=0; i<=datos.length-1; i++){
            if (datos[i].profundidad == "" || datos[i].profundidad == null || datos[i].profundidad == 0  || datos[i].profundidad == "NULL"){
                cont++;
            }
        }
        
        if (cont == datos.length){
            return true;
        }else{
            return false;
        }
    }

    function GuardarGraficaCalidad(){
        Canvas2Image.saveAsPNG(canvasProfundidad, canvasProfundidad.width, canvasProfundidad.height, "MonitoreoCalidad");
    }

    function AbrirModalCalidad(){
        $('#modalgraficacalidad').modal('show');
    }
    
    function CerrarModalCalidad(){
        $('#modalgraficacalidad').modal('hide');
    }


    function item_opcion_editar_calidad(id) {
        return '<a class="dropdown-item" href="javascript:item_update_calidad(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-warning m-btn--icon m-btn--icon-only m-btn--pill" title="Editar"><i class="la flaticon-edit-1 m--font-brand"></i>&nbsp;Editar</a>';
    }

    function item_opcion_eliminar_calidad(id) {
        return '<a class="dropdown-item" href="javascript:item_delete_calidad(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-danger m-btn--icon m-btn--icon-only m-btn--pill" title="Eliminar"><i class="la flaticon-delete-2 m--font-brand"></i>&nbsp;Eliminar</a>';
    }

    function item_opcion_calidad(id) {
        return '<a class="btn m-btn--pill m-btn--air btn-outline-primary btn-sm" href="javascript:get_calidad_compuesto(\''+ id +'\');"><i class="fa fa-plus"></i>&nbsp;Agregar compuestos</a>&nbsp;';
    }

    function get_form_calidad(id, type) {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemUpdateCalidad{literal}&manantialId={/literal}{$manantialId}{literal}&id="+id+"&type="+type;

        $('#modal_content').html(" Cargando Tab.. ");
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
            $('#modal_content').html(respuesta);
            swal.close();
            $('#modal_window').modal("show");            
        });
    }

    // function get_calidad_compuesto(id) {
    //     var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemGrillaCalidadCompuesto{literal}&calidadId="+id;

    //     $('#subwindow_calidad').html(" Cargando Tab.. ");
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
    //         $('#subwindow_calidad').html(respuesta);
    //         swal.close();
    //     });
    // }


    function get_calidad_compuesto(id) {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemGrillaCalidadCompuesto{literal}&manantialId={/literal}{$manantialId}{literal}&calidadId="+id;
        // console.log('url calidad compuesto::',url);
        $('#subwindow_calidad').html(" Cargando Tab.. ");
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
            $('#subwindow_calidad').html(respuesta);
            swal.close();
        });
    }
    
    var snippet_datatable_list_calidad = function () {
        $.fn.dataTable.Api.register('column().title()', function() {
            return $(this.header()).text().trim();
        });

        var exporta_titulo = "SIASBO - LISTA DATOS DE CALIDAD";
        var exporta_columnas = [':visible :not(.noExport)'];

        var initTable = function() {
            // begin first table
            table_list_calidad = $('#lista_calidad').DataTable({

                initComplete: function(settings, json) {
                    $('#lista_calidad').removeClass('m--hide');
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
                lengthMenu: [5, 10, 25, 50],
                pageLength: 10,
                order: [[ 2, "asc" ]], // Por que campo ordenara al momento de desplegar
                searchDelay: 500,
                processing: true,
                serverSide: true,
                ajax: {
                    url: '{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemListCalidad{literal}&manantialId={/literal}{$manantialId}{literal}',
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
                            // var boton = item_opcion_calidad(data) + '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-h m--font-brand"></i></a><div class="dropdown-menu dropdown-menu-left">{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar_calidad(data) + '{/literal}{/if}{literal}{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar_calidad(data) + '{/literal}{/if}{literal}</div></span>';
                            // return boton;

                            var boton = item_opcion_calidad(data) + '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-h m--font-brand"></i></a><div class="dropdown-menu dropdown-menu-left">';
                            
                            // var permisoedit = 1;
                            // var permisodelete = 1;
                            // var permisoreadonly = 1;
                            var botonedit = "";
                            var botondelete = ""; 
                            //var botonreadonly = "";               

                            if (obj_permiso[0].editar == 1){ //permisoedit
                                botonedit = '{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar_calidad(data) + '{/literal}{/if}{literal}';
                            }

                            if (obj_permiso[0].eliminar == 1){ //permisodelete
                                botondelete = '{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar_calidad(data) + '{/literal}{/if}{literal}';
                            }
                            
                            //botonreadonly = '{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_sololeer(data) + '{/literal}{/if}{literal}';
                            //table_list.column(0).visible(false); //Solo funciona con false
                            
                            return boton+botonedit+botondelete+'</div></span>'; //+botonreadonly;
                        }
                    },
                    {
                        targets: [1, 9, 10, 11, 12],
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

//----------------Permisos--------------------------------------------
    var obj_permiso;

    function permisos_usuario(){
        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=obtenerPermisos&perpozo=manantial', //&perpozo=pozo
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            //dataType: "json",
            success: function(data){
                obj_permiso = JSON.parse(data);

                if (obj_permiso[0].crear == 1){                                
                    $("#btn_nuevo_calidad_submit").show();
                }else{
                    $("#btn_nuevo_calidad_submit").hide();
                }                 
            },
        });
    }

    jQuery(document).ready(function() {
        permisos_usuario();
        snippet_datatable_list_calidad.init();
    });

</script>
{/literal}