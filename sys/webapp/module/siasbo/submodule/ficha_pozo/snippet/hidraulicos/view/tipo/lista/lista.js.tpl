{literal}
<script> 
    var table_list_tipo;

    function item_update_tipo(id) {
        //var url = '{/literal}{$getModule}{literal}&accion=sev_itemUpdate&id='+id+'&type=update';
        //location = url;
        get_form_tipo(id, "update");
    }

    function item_delete_tipo(id) {
        swal({
            title: 'Está seguro de borrar el registro?',
            text: "Recuerde que el registro se eliminará permanentemente. ID="+id+", ",
            type: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Si, eliminar!!!',
            cancelButtonText: "No, cancelar"
        }).then(function(result) {
            if (result.value) {
                itemDeleteActionTipo(id);
            }
        });
    }

    function item_print_tipo(id) {
        alert("Imprime el dato:"+id);
    }

    function itemDeleteActionTipo(id) {
        randomnumber=Math.floor(Math.random()*11);
        $.get( "{/literal}{$getModule}{literal}",
            {accion:"{/literal}{$subcontrol}_itemDeleteTipo{literal}", random:randomnumber, id:id},
            function(res){
                if(res.res == 1){
                    swal('Eliminado!','El registro fue eliminado con éxito.','success');
                    //swal({position: 'top-center',type: 'success',title: 'El registro fue eliminado.',showConfirmButton: false,timer: 1200});
                    table_list_tipo.draw();
                }else if(res.res == 2){
                    swal("Ocurrió un error!", res.msg, "error");
                }else{
                    swal("ocurrió un error!", res.msg, "error");
                }
            },"json");
    }

    function item_opcion_editar_tipo(id) {
        return '<a class="dropdown-item" href="javascript:item_update_tipo(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-warning m-btn--icon m-btn--icon-only m-btn--pill" title="Editar"><i class="la flaticon-edit-1 m--font-brand"></i>&nbsp;Editar</a>';
    }

    function item_opcion_eliminar_tipo(id) {
        return '<a class="dropdown-item" href="javascript:item_delete_tipo(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-danger m-btn--icon m-btn--icon-only m-btn--pill" title="Eliminar"><i class="la flaticon-delete-2 m--font-brand"></i>&nbsp;Eliminar</a>';
    }

    function item_opcion_tipo(id, tipo) {
       return '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-plus m--font-brand"></i></a><div class="dropdown-menu dropdown-menu-left"><a class="dropdown-item" href="javascript:get_dependencias(\''+ id +'\', \''+ tipo +'\', 1);"><i class="flaticon-squares-4 m--font-brand"></i>&nbsp;Agregar escalones</a><a class="dropdown-item" href="javascript:get_dependencias(\''+ id +'\', \''+ tipo +'\', 2);"><i class="flaticon-squares-4 m--font-brand"></i>&nbsp;Agregar prueba recuperación</a>{/literal}{if $tipoprueba == '2'}{literal}<a class="dropdown-item" href="javascript:get_dependencias(\''+ id +'\', \''+ tipo +'\', 3);"><i class="flaticon-squares-4 m--font-brand"></i>&nbsp;Agregar pozo observación</a>{/literal}{/if}{literal}</div></span>&nbsp;';
    }

    function get_form_tipo(id, type) {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemUpdateTipo{literal}&pruebaId={/literal}{$pruebaId}{literal}&id="+id+"&type="+type;

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

    /* FUNCIONES DEPENDIENTES DE TIPOD DE BOMBEO*/
    function get_dependencias(id, tipo, selector) {        
        get_escalon(id, tipo);
        get_recuperacion(id, tipo);
        {/literal}{if $tipoprueba == '2'}{literal}
        get_observacion(id, tipo);
        {/literal}{/if}{literal}
        switch(selector) {
            case 1:
                $('#nav_escalon').trigger('click');
                break;
            case 2:
                $('#nav_recuperacion').trigger('click');
                break;
            case 3:
                $('#nav_observacion').trigger('click');
        }
    }
 
    function get_escalon(id, tipo) {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemGrillaEscalon{literal}&pozoId={/literal}{$pozoId}{literal}&pruebaId={/literal}{$pruebaId}{literal}&tipoId="+id+"&tipobombeo="+tipo;

        $('#window_escalon').html(" Cargando Tab.. ");
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
            $('#window_escalon').html(respuesta);
            //$('#nav_recuperacion').hide();
            //$('#nav_observacion').hide();
            $('#nav_escalon').show();
            //$('#nav_escalon').trigger('click');
            swal.close();
        });
    }

    function get_recuperacion(id, tipo) {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemGrillaRecuperacion{literal}&pozoId={/literal}{$pozoId}{literal}&pruebaId={/literal}{$pruebaId}{literal}&tipoprueba={/literal}{$tipoprueba}{literal}&tipoId="+id+"&tipobombeo="+tipo;

        $('#window_recuperacion').html(" Cargando Tab.. ");
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
            $('#window_recuperacion').html(respuesta);
            //$('#nav_escalon').hide();
            //$('#nav_observacion').hide();
            $('#nav_recuperacion').show();
            //$('#nav_recuperacion').trigger('click');
            swal.close();
        });
    }

    function get_observacion(id, tipo) {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemGrillaObservacion{literal}&pozoId={/literal}{$pozoId}{literal}&pruebaId={/literal}{$pruebaId}{literal}&tipoId="+id+"&tipobombeo="+tipo;

        $('#window_observacion').html(" Cargando Tab.. ");
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
            $('#window_observacion').html(respuesta);
            //$('#nav_escalon').hide();
            $('#nav_observacion').show();
            //$('#nav_observacion').trigger('click');
            swal.close();
        });
    }
    
    var snippet_datatable_list_tipo = function () {
        $.fn.dataTable.Api.register('column().title()', function() {
            return $(this.header()).text().trim();
        });

        var exporta_titulo = "SIASBO - LISTA DE PRUEBAS CONTINUA/ESCALONADA";
        var exporta_columnas = [':visible :not(.noExport)'];

        var initTable = function() {
            // begin first table
            table_list_tipo = $('#lista_tipo').DataTable({

                initComplete: function(settings, json) {
                    $('#lista_tipo').removeClass('m--hide');
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
                    url: '{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemListTipo{literal}&pruebaId={/literal}{$pruebaId}{literal}',
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
                            // var boton = item_opcion_tipo(data, full.tipo) + '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-h m--font-brand"></i></a><div class="dropdown-menu dropdown-menu-left">{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar_tipo(data) + '{/literal}{/if}{literal}{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar_tipo(data) + '{/literal}{/if}{literal}</div></span>';
                            // return boton;

                            var boton = item_opcion_tipo(data, full.tipo) + '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-h m--font-brand"></i></a><div class="dropdown-menu dropdown-menu-left">';
                            
                            // var permisoedit = 1;
                            // var permisodelete = 1;
                            // var permisoreadonly = 1;
                            var botonedit = "";
                            var botondelete = ""; 
                            //var botonreadonly = "";               

                            if (obj_permiso[0].editar == 1){ //permisoedit
                                botonedit = '{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar_tipo(data) + '{/literal}{/if}{literal}';
                            }

                            if (obj_permiso[0].eliminar == 1){ //permisodelete
                                botondelete = '{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar_tipo(data) + '{/literal}{/if}{literal}';
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
                    {
                        targets: 2,
                        render: function(data, type, full, meta) {
                            return full.tipo_bombeo;
                        }
                    },
                    {
                        targets: 3,
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
                //     $("#btn_nuevo_tipo_submit").show();
                // }else{
                //     $("#btn_nuevo_tipo_submit").hide();
                // }       
                
                switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#btn_nuevo_tipo_submit").show();
                        }else{
                            $("#btn_nuevo_tipo_submit").hide();
                        }
                        break;
                    case 3:
                        $("#btn_nuevo_tipo_submit").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                            $("#btn_nuevo_tipo_submit").show();
                        }else{
                            $("#btn_nuevo_tipo_submit").hide();
                        }
                        break;
                }
            },
        });
    }

    jQuery(document).ready(function() {
        permisos_usuario();
        snippet_datatable_list_tipo.init(); 
    });

</script>
{/literal}