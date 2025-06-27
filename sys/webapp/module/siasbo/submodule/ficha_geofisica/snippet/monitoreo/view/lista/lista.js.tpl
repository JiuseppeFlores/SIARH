{literal}
<script>
    var table_list;
    var typeAction = "new";
    var idMonitoreo = null;

    function item_update(id) {
        //var url = '{/literal}{$getModule}{literal}&accion=monitoreo_itemUpdate&id='+id+'&type=update';
        //location = url;
        typeAction = "update";
        idMonitoreo = id;
    }

    function item_create() {
        $("#general_form")[0].reset();
        idMonitoreo = null;
        typeAction = "new";
    }

    function item_delete(id) {
        swal({
            title: 'Está seguro de borrar el registro?',
            text: "Recuerde que el registro se eliminará permanentemente. ID="+id+", ",
            type: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Si, eliminar!!!',
            cancelButtonText: "No, cancelar"
        }).then(function(respuesta) {
            if (respuesta.value) {
                itemDeleteAction(id);
            }
        });
    }

    function item_print(id) {
        alert("Imprime el dato:"+id)
    }

    function itemDeleteAction(id) {
        randomnumber=Math.floor(Math.random()*11);
        $.get( "{/literal}{$getModule}{literal}",
            {accion:"monitoreo_itemDelete", random:randomnumber, id:id},
            function(respuesta){
                if(respuesta.res == 1){
                    swal('Eliminado!','El registro fue eliminado.','success');
                    //swal({position: 'top-center',type: 'success',title: 'El registro fue eliminado',showConfirmButton: false,timer: 1200});
                    table_list.draw();
                }else if(respuesta.res == 2){
                    swal("Ocurrio un error!", respuesta.msg, "error");
                }else{
                    swal("ocurrio un error!", respuesta.msg, "error");
                }
            },"json");
    }

    function item_opcion_editar(id) {
        //return '<a href="javascript:item_update(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-primary m-btn--icon m-btn--icon-only m-btn--pill " title="Editar"><i class="fa fa-edit"></i></a>';

        return '<a href="#" onclick="javascript:item_update(\''+ id +'\');" id="lnkEditar" class="m-portlet__nav-link btn m-btn m-btn--hover-primary m-btn--icon m-btn--icon-only m-btn--pill " title="Editar"><i class="fa fa-edit"></i></a>';
    }

    function item_opcion_eliminar(id) {
        return '<a href="javascript:item_delete(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-danger m-btn--icon m-btn--icon-only m-btn--pill" title="Eliminar"><i class="fa fa-trash"></i></a>';
    }

    function item_recuperar_registro_tabla(registroSeleccionado) {
        typeAction = "update";
        dataRow = table_list.row($(registroSeleccionado).parents("tr")).data();
        dataRowIndex = table_list.row($(registroSeleccionado).parents("tr")).index();
        item_asignar_datos_form(dataRow);
        $("#ventana_form").modal("show");
    }

    function item_asignar_datos_form(dataRow) {
        $("#fecha").val(dataRow.fecha);
        $("#caudal").val(dataRow.caudal);
        $("#observaciones").val(dataRow.observaciones);
    }
    
    var snippet_datatable_list = function () {
        $.fn.dataTable.Api.register('column().title()', function() {
            return $(this.header()).text().trim();
        });

        var initTable1 = function() {
            // begin first table
            table_list = $('#index_lista').DataTable({
                responsive: true,
                //== Pagination settings
                dom:
                "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
                "<'row'<'col-sm-12 col-md-6'i><'col-sm-12 col-md-6'p>>" +
                "<'row'<'col-sm-12'tr>>" +
                "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
                "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
                // read more: https://datatables.net/examples/basic_init/dom.html
                language: {"url": "language/datatable.spanish.json"},
                lengthMenu: [5, 10, 25, 50],
                pageLength: 10,
                order: [[ 1, "asc" ]], // Por que campo ordenara al momento de desplegar
                searchDelay: 500,
                processing: true,
                serverSide: true,
                ajax: {
                    url: '{/literal}{$getModule}{literal}&accion=monitoreo_getItemList&manantialId={/literal}{$manantialId}{literal}',
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
                            var boton = '{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar(data) + '{/literal}{/if}{literal}{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar(data) + '{/literal}{/if}{literal}';
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
                initTable1();
            },

        };

    }();

    jQuery(document).ready(function() {
        snippet_datatable_list.init();

        $("body").on("click", "a#lnkEditar", function() {
            item_recuperar_registro_tabla(this);
            return false;
        });
    });

</script>
{/literal}