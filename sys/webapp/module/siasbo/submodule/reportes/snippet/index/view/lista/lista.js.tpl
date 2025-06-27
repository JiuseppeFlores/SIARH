{literal}
<script>
    var table_list

    function item_update(id){
        var url = '{/literal}{$getModule}{literal}&accion=itemUpdate&id='+id+'&type=update';
        location = url;
    }
    function item_delete(id){
        swal({
            title: 'Esta seguro de borrar el registro?',
            text: "Recuerde que el registro se eliminará permanentemente. ID="+id+", ",
            type: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Si, Elimnar!!!',
            cancelButtonText: "No, cancelar"
        }).then(function(result) {
            if (result.value) {
                itemDeleteAction(id);
            }
        });
    }
    function item_print(id){
        alert("Imprime el dato:"+id)
    }

    function itemDeleteAction(id){
        randomnumber=Math.floor(Math.random()*11);
        $.get( "{/literal}{$getModule}{literal}",
            {accion:"itemDelete", random:randomnumber, id:id},
            function(res){
                if(res.res == 1){
                    //swal('Eliminado!','El registro fue eliminado','success');
                    swal({position: 'top-center',type: 'success',title: 'El registro fue eliminado',showConfirmButton: false,timer: 1200});
                    table_list.draw();
                }else if(res.res == 2){
                    swal("Ocurrio un error!", res.msg, "error");
                }else{
                    swal("ocurrio un error!", res.msg, "error");
                }
            },"json");
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
                order: [[ 2, "asc" ]], // Por que campo ordenara al momento de desplegar
                searchDelay: 500,
                processing: true,
                serverSide: true,
                ajax: {
                    url: '{/literal}{$getModule}{literal}&accion=getItemList&accion=getItemList',
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
                        //title: 'Accion',
                        orderable: false,
                        render: function(data, type, full, meta) {

                            var boton = ''+
                                    {/literal}{if $privFace.editar == 1}{literal}
                                '<a href="javascript:item_update(\''+data+'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-warning m-btn--icon m-btn--icon-only m-btn--pill " title="View">'+
                                '<i class="la flaticon-edit-1"></i>'+
                                '</a>'+
                                    {/literal}{/if}{literal}

                                    {/literal}{if $privFace.eliminar == 1}{literal}
                                '<a href="javascript:item_delete(\''+data+'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-danger m-btn--icon m-btn--icon-only m-btn--pill" title="View">'+
                                '<i class="la flaticon-delete-2"></i>'+
                                '</a>'+
                                    {/literal}{/if}{literal}
                                '';
                            return boton;
                        },
                    },
                    {
                        targets: [ 1 ],
                        searchable: false,
                        orderable: false,
                        render: function(data, type, full, meta) {
                            var status = {
                                0: {'estado': 'off', 'class': 'm-badge--danger'},
                                1: {'estado': 'on', 'class': 'm-badge--success'},
                            };
                            if (typeof status[data] === 'undefined') {
                                return data;
                            }
                            return '<img src="./template/user/images/icon/activo-' + status[data].estado + '.png" width="30" height="30" border="0" alt="hol">';
                        },
                    },
                    {
                        targets: [ 2 ],
                        render: function(data,type,full,meta){
                            return '<span class="m--font-bold m--font-primary">' + data + '</span>';
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




</script>{/literal}