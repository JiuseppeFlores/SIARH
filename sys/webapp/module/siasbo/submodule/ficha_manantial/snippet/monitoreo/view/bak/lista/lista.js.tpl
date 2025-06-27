{literal}
<script>
    var table_list_monitoreo;

    function item_update_monitoreo(id) {
        //var url = '{/literal}{$getModule}{literal}&accion=monitoreo_itemUpdate&id='+id+'&type=update';
        //location = url;
        get_form_monitoreo(id, "update");
    }

    function item_delete_monitoreo(id) {
        swal({
            title: 'Está seguro de borrar el registro?',
            text: "Recuerde que el registro se eliminará permanentemente. ID="+id+", ",
            type: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Si, eliminar!!!',
            cancelButtonText: "No, cancelar"
        }).then(function(respuesta) {
            if (respuesta.value) {
                itemDeleteActionMonitoreo(id);
            }
        });
    }

    function item_print_monitoreo(id) {
        alert("Imprime el dato:"+id)
    }

    function itemDeleteActionMonitoreo(id) {
        randomnumber=Math.floor(Math.random()*11);
        $.get( "{/literal}{$getModule}{literal}",
            {accion:"{/literal}{$subcontrol}_itemDelete{literal}", random:randomnumber, id:id},
            function(respuesta){
                if(respuesta.res == 1){
                    swal('Eliminado!','El registro fue eliminado.','success');
                    //swal({position: 'top-center',type: 'success',title: 'El registro fue eliminado',showConfirmButton: false,timer: 1200});
                    table_list_monitoreo.draw();
                }else if(respuesta.res == 2){
                    swal("Ocurrió un error!", respuesta.msg, "error");
                }else{
                    swal("ocurrió un error!", respuesta.msg, "error");
                }
            },"json");
    }

    function item_opcion_editar_monitoreo(id) {
        return '<a href="#" onclick="javascript:item_update_monitoreo(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-warning m-btn--icon m-btn--icon-only m-btn--pill" title="Editar"><i class="la flaticon-edit-1 m--font-brand"></i></a>';
    }

    function item_opcion_eliminar_monitoreo(id) {
        return '<a href="javascript:item_delete_monitoreo(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-danger m-btn--icon m-btn--icon-only m-btn--pill" title="Eliminar"><i class="la flaticon-delete-2 m--font-brand"></i></a>';
    }

    function get_form_monitoreo(id, type) {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemUpdate{literal}&manantialId={/literal}{$id}{literal}&id="+id+"&type="+type;
        $.get(url, function(respuesta) {
            $('#modal_content_monitoreo').html(respuesta);
            $('#modal_window_monitoreo').modal("show");
        });
    }
    
    var snippet_datatable_list_monitoreo = function () {
        $.fn.dataTable.Api.register('column().title()', function() {
            return $(this.header()).text().trim();
        });

        var exporta_titulo = "SIASBO - POZO - DATOS DE MONITOREO";
        var exporta_columnas = [':visible :not(.noExport)'];

        var initTable = function() {
            // begin first table
            table_list_monitoreo = $('#lista_monitoreo').DataTable({
                initComplete: function(settings, json) {
                    $('#index_lista').removeClass('m--hide');
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
                order: [[ 1, "asc" ]], // Por que campo ordenara al momento de desplegar
                searchDelay: 500,
                processing: true,
                serverSide: true,
                ajax: {
                    url: '{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemList{literal}&manantialId={/literal}{$manantialId}{literal}',
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
                            var boton = '{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar_monitoreo(data) + '{/literal}{/if}{literal}{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar_monitoreo(data) + '{/literal}{/if}{literal}';
                            return boton;
                        },
                    },
                    /*{
                        targets: [ 1 ],
                        searchable: true,
                        orderable: true,
                        render: function(data, type, full, meta) {
                            return '{/literal}{'+ data +'|date_format:"%d/%m/%Y"}{literal}';
                        },
                    },*/
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

    jQuery(document).ready(function() {
        snippet_datatable_list_monitoreo.init();
    });

</script>
{/literal}