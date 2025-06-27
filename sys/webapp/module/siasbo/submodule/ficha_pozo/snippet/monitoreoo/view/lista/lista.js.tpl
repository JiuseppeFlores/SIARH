{literal}
<script>
    var table_list_litologico;

    function item_update_sev(id) {
        //var url = '{/literal}{$getModule}{literal}&accion=sev_itemUpdate&id='+id+'&type=update';
        //location = url;
        get_form_litologico(id, "update");
    }

    function item_delete_sev(id) {
        swal({
            title: 'Está seguro de borrar el registro?',
            text: "Recuerde que el registro se eliminará permanentemente. ID="+id+", ",
            type: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Si, eliminar!!!',
            cancelButtonText: "No, cancelar"
        }).then(function(result) {
            if (result.value) {
                itemDeleteActionSev(id);
            }
        });
    }

    function item_print_sev(id) {
        alert("Imprime el dato:"+id);
    }

    function itemDeleteActionSev(id) {
        randomnumber=Math.floor(Math.random()*11);
        //alert(id + " " + "{/literal}{$getModule}{literal}");
        $.get( "{/literal}{$getModule}{literal}",
            {accion:"columnalitologica_itemDelete", random:randomnumber, id:id},
            function(res){
                if(res.res == 1){
                    swal('Eliminado!','El registro fue eliminado con éxito.','success');
                    //swal({position: 'top-center',type: 'success',title: 'El registro fue eliminado.',showConfirmButton: false,timer: 1200});
                    table_list_litologico.draw();
                }else if(res.res == 2){
                    swal("Ocurrió un error!", res.msg, "error");
                }else{
                    swal("ocurrió un error!", res.msg, "error");
                }
            },"json");
    }

    function item_opcion_editar_sev(id) {
        return '<a class="dropdown-item" href="javascript:item_update_sev(\''+ id +'\');"><i class="fa fa-edit"></i>&nbsp;Editar</a>';
    }

    function item_opcion_eliminar_sev(id) {        
        return '<a class="dropdown-item" href="javascript:item_delete_sev(\''+ id +'\');"><i class="fa fa-trash"></i>&nbsp;Eliminar</a>';
    }

    // function item_opcion_sev(id) {
    //     return '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-plus"></i></a><div class="dropdown-menu dropdown-menu-left"><a class="dropdown-item" href="javascript:get_sev_capa(\''+ id +'\');"><i class="fa fa-tasks"></i>&nbsp;Agregar capa</a><a class="dropdown-item" href="javascript:get_sev_vinculo_pozo(\''+ id +'\');"><i class="fa fa-link"></i>&nbsp;Vincular pozo</a></div></span>&nbsp;';
    // }

    function get_form_monitorcantidad(id, type) {
        //alert("{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemUpdate{literal}&pozoId={/literal}{$id}{literal}&id="+id+"&type="+type);
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemUpdate{literal}&pozoId={/literal}{$id}{literal}&id="+id+"&type="+type; 
        $.get(url, function(respuesta) {
            //alert(respuesta);
            $('#modal_content_litologico').html(respuesta);
            $('#modal_window_litologico').modal("show");
        });
    }

    // function get_sev_capa(id) {
    //     var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemGrillaCapa{literal}&geofisicaId="+id;

    //     $.get(url, function(respuesta) {
    //         $('#modal_content_capa_list').html(respuesta);
    //         $('#modal_window_capa').modal("show");
    //     });
    // }

    // function get_sev_vinculo_pozo(id) {
    //     var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemGrillaVinculoPozo{literal}&lineabaseId="+id;

    //     $.get(url, function(respuesta) {
    //         $('#modal_content_vinculo_pozo_list').html(respuesta);
    //         $('#modal_window_vinculo_pozo').modal("show");
    //     });
    // }
    
    var snippet_datatable_list_sev = function () {
        $.fn.dataTable.Api.register('column().title()', function() {
            return $(this.header()).text().trim();
        });

        var initTable = function() {
            // begin first table
            //alert("{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemList{literal}&id={/literal}{$id}{literal}");
            table_list_litologico = $('#lista_litologica').DataTable({
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
                    url: '{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemList{literal}&id={/literal}{$id}{literal}',
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
                            var boton = '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-h"></i></a><div class="dropdown-menu dropdown-menu-left">{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar_sev(data) + '{/literal}{/if}{literal}{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar_sev(data) + '{/literal}{/if}{literal}</div></span>';
                            return boton;
                        }
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

    jQuery(document).ready(function() {
        snippet_datatable_list_sev.init();
    });

</script>
{/literal}