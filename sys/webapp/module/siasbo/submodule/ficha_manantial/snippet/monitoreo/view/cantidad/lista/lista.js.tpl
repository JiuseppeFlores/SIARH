{literal}
    <script>
        var table_list_cantidad;

        function item_update_cantidad(id) {
            //var url = '{/literal}{$getModule}{literal}&accion=sev_itemUpdate&id='+id+'&type=update';
            //location = url;
            get_form_cantidad(id, "update");
        }

        function item_delete_cantidad(id) {
            swal({
                title: 'Está seguro de borrar el registro?',
                text: "Recuerde que el registro se eliminará permanentemente. ID=" + id + ", ",
                type: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Si, eliminar!!!',
                cancelButtonText: "No, cancelar"
            }).then(function(result) {
                if (result.value) {
                    itemDeleteActionCantidad(id);
                }
            });
        }

        function item_print_cantidad(id) {
            alert("Imprime el dato:" + id);
        }

        function itemDeleteActionCantidad(id) {
            randomnumber = Math.floor(Math.random() * 11);
            $.get( "{/literal}{$getModule}{literal}",
            {accion:"{/literal}{$subcontrol}_itemDeleteCantidad{literal}", random:randomnumber, id:id},
                function(res) {
                    if (res.res == 1) {
                        swal('Eliminado!', 'El registro fue eliminado con éxito.', 'success');
                        //swal({position: 'top-center',type: 'success',title: 'El registro fue eliminado.',showConfirmButton: false,timer: 1200});
                        table_list_cantidad.draw();
                    } else if (res.res == 2) {
                        swal("Ocurrió un error!", res.msg, "error");
                    } else {
                        swal("ocurrió un error!", res.msg, "error");
                    }
                }, "json");
            }

            function item_opcion_editar_cantidad(id) {
                return '<a class="dropdown-item" href="javascript:item_update_cantidad(\'' + id +
                    '\');" class="m-portlet__nav-link btn m-btn m-btn--hover-warning m-btn--icon m-btn--icon-only m-btn--pill" title="Editar"><i class="la flaticon-edit-1 m--font-brand"></i>&nbsp;Editar</a>';
            }

            function item_opcion_eliminar_cantidad(id) {
                return '<a class="dropdown-item" href="javascript:item_delete_cantidad(\'' + id +
                    '\');" class="m-portlet__nav-link btn m-btn m-btn--hover-danger m-btn--icon m-btn--icon-only m-btn--pill" title="Eliminar"><i class="la flaticon-delete-2 m--font-brand"></i>&nbsp;Eliminar</a>';
            }

            function item_opcion_cantidad(id) {
                return '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-plus m--font-brand"></i></a><div class="dropdown-menu dropdown-menu-left"><a class="dropdown-item" href="javascript:get_tipo(\'' +
                    id +
                    '\');"><i class="fa fa-tasks m--font-brand"></i>&nbsp;Agregar cantidad continua/escalonada</a></div></span>&nbsp;';
            }

            function get_form_cantidad(id, type) {
                var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemUpdateCantidad{literal}&manantialId={/literal}{$manantialId}{literal}&id="+id+"&type="+type;

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

            function get_tipo(id) {
                var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemGrillaTipo{literal}&manantialId={/literal}{$id}{literal}&cantidadId="+id;

                $('#window_cantidad').html(" Cargando Tab.. ");
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
                    $('#window_cantidad').html(respuesta);
                    /*$('#nav_cantidad').removeClass('active show');
            $('#window_cantidad').removeClass('active show');
            $('#nav_tipo').addClass('active show');
            $('#window_tipo').addClass('active show');*/

                    // $('#nav_escalon').hide();
                    // $('#nav_recuperacion').hide();
                    // $('#nav_observacion').hide();
                    // $('#nav_tipo').show();
                    // $('#nav_tipo').trigger('click');
                    swal.close();
                });
            }

            var snippet_datatable_list_cantidad = function() {
            $.fn.dataTable.Api.register('column().title()', function() {
                return $(this.header()).text().trim();
            });

            var exporta_titulo = "SIASBO - LISTA MONITOREO DE CANTIDAD";
            var exporta_columnas = [':visible :not(.noExport)'];

            var initTable = function() {
                    // begin first table
                    table_list_cantidad = $('#lista_cantidad').DataTable({

                            initComplete: function(settings, json) {
                                $('#lista_cantidad').removeClass('m--hide');
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
                            dom: "<'row'<'col-sm-12 col-md-12 dataTables_pager'lp>>" +
                                `<'row'<'col-sm-5 text-left'f><'col-sm-7 text-right'B>>
                     <'row'<'col-sm-12'tr>>
                     <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'lp>>`,
                            // read more: https://datatables.net/examples/basic_init/dom.html
                            buttons: [
                                {extend:'colvis',text:'Ver '
                                , columnText: function(dt, idx, title) {
                                    return (idx + 1) + ': ' + title;
                                }
                            },
                            {extend:'excelHtml5'
                            ,exportOptions: {columns: exporta_columnas}
                            ,
                            title: exporta_titulo
                        },
                        {extend:'pdfHtml5'
                        ,exportOptions: {columns: exporta_columnas}
                        , title: exporta_titulo, download: 'open'
                        //, orientation: 'landscape'
                        , pageSize: 'LETTER', customize: function(doc) {
                            doc.styles.tableHeader.fontSize = 7;
                            doc.defaultStyle.fontSize = 7;
                            doc.pageMargins = [20, 20];
                        }
                    },

                ],

                // read more: https://datatables.net/examples/basic_init/dom.html
                language: {"url": "language/datatable.spanish.json"},
                lengthMenu: [5, 10, 25, 50],
                pageLength: 10,
                order: [
                    [2, "asc"]
                ], // Por que campo ordenara al momento de desplegar
                searchDelay: 500,
                processing: true,
                serverSide: true,
                ajax: {
                    url: '{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemListCantidad{literal}&manantialId={/literal}{$manantialId}{literal}',
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
                columnDefs: [{
                        targets: 0,
                        title: 'Acción',
                        orderable: false,
                        render: function(data, type, full, meta) {
                            // var boton = '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-h m--font-brand"></i></a><div class="dropdown-menu dropdown-menu-left">{/literal}
                                
                                {if $privFace.editar == 1}
                                    
                                    {literal}' + item_opcion_editar_cantidad(data) + '
                                        
                                    {/literal}
                                    
                                {/if}
                                
                                {literal}
                                    
                                {/literal}
                                
                                {if $privFace.eliminar == 1}
                                    
                                    {literal}' + item_opcion_eliminar_cantidad(data) + '
                                        
                                    {/literal}
                                    
                                {/if}
                                
                                {literal}</div></span>';
                                    // return boton;

                                    var boton =
                                        '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-h m--font-brand"></i></a><div class="dropdown-menu dropdown-menu-left">';

                                    // var permisoedit = 1;
                                    // var permisodelete = 1;
                                    // var permisoreadonly = 1;
                                    var botonedit = "";
                                    var botondelete = "";
                                    //var botonreadonly = "";               

                                    if (obj_permiso[0].editar == 1) { //permisoedit
                                        botonedit = '{/literal}
                                            
                                            {if $privFace.editar == 1}
                                                
                                                {literal}' + item_opcion_editar_cantidad(data) + '
                                                    
                                                {/literal}
                                                
                                            {/if}
                                            
                                            {literal}';
                                            }

                                            if (obj_permiso[0].eliminar == 1) { //permisodelete
                                                botondelete = '{/literal}
                                                    
                                                    {if $privFace.eliminar == 1}
                                                        
                                                        {literal}' + item_opcion_eliminar_cantidad(data) + '
                                                            
                                                        {/literal}
                                                        
                                                    {/if}
                                                    
                                                    {literal}';
                                                    }

                                                    //botonreadonly = '{/literal}
                                                        
                                                        {if $privFace.eliminar == 1}
                                                            
                                                            {literal}' + item_opcion_sololeer(data) + '
                                                                
                                                            {/literal}
                                                            
                                                        {/if}
                                                        
                                                        {literal}';
                                                            //table_list.column(0).visible(false); //Solo funciona con false

                                                            return boton + botonedit + botondelete + '</div></span>'; //+botonreadonly;
                                                        }
                                                    },
                                                    {
                                                        targets: [3],
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

                                            function permisos_usuario() {
                                                jQuery.ajax({
                                                    url: '{/literal}{$getModule}{literal}&accion=obtenerPermisos&perpozo=manantial', //&perpozo=pozo
                                                    //data: data,
                                                    cache: false,
                                                    contentType: false,
                                                    processData: false,
                                                    type: 'POST',
                                                    //dataType: "json",
                                                    success: function(data) {
                                                        obj_permiso = JSON.parse(data);

                                                        if (obj_permiso[0].crear == 1) {
                                                            $("#btn_nuevo_cantidad_submit").show();
                                                        } else {
                                                            $("#btn_nuevo_cantidad_submit").hide();
                                                        }
                                                    },
                                                });
                                            }

                                            jQuery(document).ready(function() {
                                                permisos_usuario();
                                                snippet_datatable_list_cantidad.init();
                                            });
                                        </script>
                                    {/literal}