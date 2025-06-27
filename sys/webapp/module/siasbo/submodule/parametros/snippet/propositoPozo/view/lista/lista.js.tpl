{literal}
<script>
    var table_list;

    function item_update(id) {
        var url = '{/literal}{$getModule}{literal}&accion=propositoPozo_itemUpdate&id='+id+'&type=update';
        location = url;
    }

    function item_create() {
        var url = '{/literal}{$getModule}{literal}&accion=propositoPozo_itemUpdate&type=new';
        location = url;
    }

    function item_delete(id) {
        swal({
            title: 'Está seguro de borrar el registro?',
            text: "Recuerde que el registro se eliminará permanentemente. ID="+id+", ",
            type: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Si, eliminar!!!',
            cancelButtonText: "No, cancelar"
        }).then(function(result) {
            if (result.value) {
                itemDeleteAction(id);
            }
        });
    }

    function item_print(id) {
        alert("Imprime el dato:"+id);
    }

    function itemDeleteAction(id) {
        randomnumber=Math.floor(Math.random()*11);
        $.get( "{/literal}{$getModule}{literal}",
            {accion:"propositoPozo_itemDelete", random:randomnumber, id:id},
            function(res){
                if(res.res == 1){
                    swal('Eliminado!','El registro fue eliminado con éxito.','success');
                    //swal({position: 'top-center',type: 'success',title: 'El registro fue eliminado.',showConfirmButton: false,timer: 1200});
                    table_list.draw();
                }else if(res.res == 2){
                    swal("Ocurrió un error!", res.msg, "error");
                }else{
                    swal("ocurrió un error!", res.msg, "error");
                }
            },"json");
    }

    function item_opcion_editar(id) {
        return '<a href="javascript:item_update(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-warning m-btn--icon m-btn--icon-only m-btn--pill " title="Editar"><i class="la flaticon-edit-1 m--font-brand"></i></a>';
    }

    function item_opcion_eliminar(id) {
        return '<a href="javascript:item_delete(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-danger m-btn--icon m-btn--icon-only m-btn--pill" title="Eliminar"><i class="la flaticon-delete-2 m--font-brand"></i></a>';
    }

    function item_opcion_ruta(urlBase, ruta, objeto) {
        if (objeto.activo == "1") {
            return '<a href="'+ urlBase +'&accion='+ ruta +'" class="btn btn-brand btn-sm" title="Ingresar"><i class="fa fa-arrow-right"></i>&nbsp;Ingresar</a>';
        } else {
            return '<a href="'+ urlBase +'&accion='+ ruta +'" class="btn btn-brand btn-sm disabled" title="Ingresar" enabled="false"><i class="fa fa-arrow-right"></i>&nbsp;Ingresar</a>';
        }
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
                    url: '{/literal}{$getModule}{literal}&accion=propositoPozo_getItemList',
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
                        }
                    },
                    {
                        targets: [ 2 ],
                        searchable: false,
                        orderable: true,
                        render: function(data, type, full, meta) {
                            var status = {
                                0: {'title': 'INACTIVO', 'state': 'danger'},
                                1: {'title': 'ACTIVO', 'state': 'success'}
                            };

                            if (typeof status[data] === 'undefined') {
                                return data;
                            }
                            return '<span class="m-badge m-badge--' + status[data].state + ' info m-badge--wide"></span>&nbsp;' + '<span class="m--font-bold m--font-' + status[data].state + '">' + status[data].title + '</span>';
                        },
                    },
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
    });

</script>
{/literal}