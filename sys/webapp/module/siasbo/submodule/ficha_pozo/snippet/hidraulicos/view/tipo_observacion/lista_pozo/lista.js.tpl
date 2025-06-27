{literal}
<script>
    var table_list_pozo;

    function item_seleccionar_pozo(id) {
        $('#po_nombre').val(id);
        $('#modal_window_pozo').modal('hide');
        $('#modal_window').modal('show');
    }

    function item_opcion(id) {
        return '<a class="btn m-btn--pill m-btn--air btn-outline-primary btn-sm" href="javascript:item_seleccionar_pozo(\''+ id +'\');">&nbsp;Seleccionar</a>';
    }

    var snippet_datatable_list_pozo = function () {
        $.fn.dataTable.Api.register('column().title()', function() {
            return $(this.header()).text().trim();
        });

        var initTablePozo = function() {
            // begin first table
            table_list_pozo = $('#lista_pozo').DataTable({
                responsive: true,
                //== Pagination settings
                /*dom:
                "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
                "<'row'<'col-sm-12 col-md-6'i><'col-sm-12 col-md-6'p>>" +
                "<'row'<'col-sm-12'tr>>" +
                "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
                "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",*/
                // read more: https://datatables.net/examples/basic_init/dom.html
                language: {"url": "language/datatable.spanish.json"},
                lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "Todo"]], //[5, 10, 25, 50],
                pageLength: 5,
                order: [[ 1, "asc" ]], // Por que campo ordenara al momento de desplegar
                searchDelay: 500,
                processing: true,
                serverSide: true,
                ajax: {
                    url: '{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemListPozo{literal}',
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
                            var boton = item_opcion(data);
                            return boton;
                        }
                    },
                ],
            });

        };

        return {

            //main function to initiate the module
            init: function() {
                initTablePozo();
            },

        };

    }();

    jQuery(document).ready(function() {
        snippet_datatable_list_pozo.init();

        $('#btn_cerrar_pozo').on('click', function() {
            $('#modal_window_pozo').modal('hide');
            $('#modal_window').modal('show');
        });
    });

</script>
{/literal}