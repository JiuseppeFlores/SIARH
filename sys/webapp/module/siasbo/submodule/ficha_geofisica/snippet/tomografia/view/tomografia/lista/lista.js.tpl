{literal}
<script>
    var table_list_tomografia;

    function item_update_tomografia(id) {
        //var url = '{/literal}{$getModule}{literal}&accion=sev_itemUpdate&id='+id+'&type=update';
        //location = url;
        get_form_tomografia(id, "update");
    }

    function item_delete_tomografia(id) {
        swal({
            title: 'Está seguro de borrar el registro?',
            text: "Recuerde que el registro se eliminará permanentemente. ID="+id+", ",
            type: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Si, eliminar!!!',
            cancelButtonText: "No, cancelar"
        }).then(function(result) {
            if (result.value) {
                itemDeleteActionTomografia(id);
            }
        });
    }

    function item_print_tomografia(id) {
        alert("Imprime el dato:"+id);
    }

    function itemDeleteActionTomografia(id) {
        randomnumber=Math.floor(Math.random()*11);
        $.get( "{/literal}{$getModule}{literal}",
            {accion:"sev_itemDelete", random:randomnumber, id:id},
            function(res){
                if(res.res == 1){
                    swal('Eliminado!','El registro fue eliminado con éxito.','success');
                    //swal({position: 'top-center',type: 'success',title: 'El registro fue eliminado.',showConfirmButton: false,timer: 1200});
                    table_list_tomografia.draw();
                }else if(res.res == 2){
                    swal("Ocurrió un error!", res.msg, "error");
                }else{
                    swal("ocurrió un error!", res.msg, "error");
                }
            },"json");
    }

    function item_opcion_editar_tomografia(id) {
        return '<a class="dropdown-item" href="javascript:item_update_tomografia(\''+ id +'\');"><i class="la flaticon-edit-1 m--font-brand"></i>&nbsp;Editar</a>';
    }

    function item_opcion_eliminar_tomografia(id) {
        return '<a class="dropdown-item" href="javascript:item_delete_tomografia(\''+ id +'\');"><i class="la flaticon-delete-2 m--font-brand"></i>&nbsp;Eliminar</a>';
    }

    function item_opcion_tomografia(id) {
        return '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-plus m--font-brand"></i></a><div class="dropdown-menu dropdown-menu-left"><a class="dropdown-item" href="javascript:get_tomografia_capa(\''+ id +'\');"><i class="fa fa-tasks m--font-brand"></i>&nbsp;Agregar capa</a><a class="dropdown-item" href="javascript:get_tomografia_vinculo_pozo(\''+ id +'\');"><i class="fa fa-link m--font-brand"></i>&nbsp;Vincular pozo</a></div></span>&nbsp;';
    }

    function get_form_tomografia(id, type) {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemUpdate{literal}&geofisicaId={/literal}{$id}{literal}&id="+id+"&type="+type; 
        $.get(url, function(respuesta) {
            $('#modal_content_tomografia').html(respuesta);
            $('#modal_window_tomografia').modal("show");
        });
    }

    function get_tomografia_capa(id) {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemGrillaCapa{literal}&geofisicaId="+id;

        $.get(url, function(respuesta) {
            $('#modal_content_list_tomografia_capa').html(respuesta);
            $('#modal_window_tomografia_capa').modal("show");
        });
    }

    function get_tomografia_vinculo_pozo(id) {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemGrillaVinculoPozo{literal}&lineabaseId="+id;

        $.get(url, function(respuesta) {
            $('#modal_content_list_tomografia_vinculo_pozo').html(respuesta);
            $('#modal_window_tomografia_vinculo_pozo').modal("show");
        });
    }
    
    var snippet_datatable_list_tomografia = function () {
        $.fn.dataTable.Api.register('column().title()', function() {
            return $(this.header()).text().trim();
        });

        var initTable = function() {
            // begin first table
            table_list_tomografia = $('#lista_tomografia').DataTable({
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
                            // var boton = item_opcion_tomografia(data) + '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-h m--font-brand"></i></a><div class="dropdown-menu dropdown-menu-left">{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar_tomografia(data) + '{/literal}{/if}{literal}{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar_tomografia(data) + '{/literal}{/if}{literal}</div></span>';
                            // return boton;

                            var boton = item_opcion_tomografia(data) + '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-h m--font-brand"></i></a><div class="dropdown-menu dropdown-menu-left">';
                            
                            // var permisoedit = 1;
                            // var permisodelete = 1;
                            // var permisoreadonly = 1;
                            var botonedit = "";
                            var botondelete = ""; 
                            //var botonreadonly = "";               

                            if (obj_permiso[0].editar == 1){ //permisoedit
                                botonedit = '{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar_tomografia(data) + '{/literal}{/if}{literal}';
                            }

                            if (obj_permiso[0].eliminar == 1){ //permisodelete
                                botondelete = '{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar_tomografia(data) + '{/literal}{/if}{literal}';
                            }
                            
                            //botonreadonly = '{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_sololeer(data) + '{/literal}{/if}{literal}';
                            //table_list.column(0).visible(false); //Solo funciona con false
                            
                            return boton+botonedit+botondelete+'</div></span>'; //+botonreadonly;
                        }
                    },
                    {
                        targets: 1,
                        visible: false
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
        var idUsuarioResponsable = parseInt($('#idUsuarioResponsable').val());
        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=obtenerPermisos&perpozo=geofisica', //&perpozo=pozo
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            //dataType: "json",
            success: function(data){
                obj_permiso = JSON.parse(data);

                // if (obj_permiso[0].crear == 1){                                
                //     $("#btn_nuevo_tomografia_submit").show();
                // }else{
                //     $("#btn_nuevo_tomografia_submit").hide();
                // }

                switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#btn_nuevo_tomografia_submit").show();
                        }else{
                            $("#btn_nuevo_tomografia_submit").hide();
                        }
                        break;
                    case 3:
                        $("#btn_nuevo_tomografia_submit").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                            $("#btn_nuevo_tomografia_submit").show();
                        }else{
                            $("#btn_nuevo_tomografia_submit").hide();
                        }
                        break;
                }
            },
        });
    }

    jQuery(document).ready(function() {
        permisos_usuario();
        snippet_datatable_list_tomografia.init();
    });

</script>
{/literal}