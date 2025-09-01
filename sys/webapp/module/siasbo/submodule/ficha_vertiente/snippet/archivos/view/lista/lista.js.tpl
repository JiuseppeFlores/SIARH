{literal}
<script>
    var table_list_archivo

    function item_update_archivo(id) {
        //var url = '{/literal}{$getModule}{literal}&accion=itemUpdate&id='+id+'&type=update';
        //location = url;
        get_form_archivo(id, "update");
    }

    function item_delete_archivo(id) {
        swal({
            title: 'Está seguro de borrar el registro?',
            text: "Recuerde que el registro se eliminará permanentemente. ID="+id+", ",
            type: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Si, eliminar!!!',
            cancelButtonText: "No, cancelar"
        }).then(function(result) {
            if (result.value) {
                itemDeleteActionArchivo(id);
            }
        });
    }
    function item_print_archivo(id) {
        alert("Imprime el dato:"+id)
    }

    function itemDeleteActionArchivo(id) {
        randomnumber=Math.floor(Math.random()*11);
        $.get( "{/literal}{$getModule}{literal}",
            {accion:"{/literal}{$subcontrol}_itemDelete{literal}", random:randomnumber, id:id, captacionId:"{/literal}{$captacionId}{literal}"},
            function(res) {
                if(res.res == 1){
                    swal('Eliminado!','El registro fue eliminado.','success');
                    //swal({position: 'top-center',type: 'success',title: 'El registro fue eliminado',showConfirmButton: false,timer: 1200});
                    table_list_archivo.draw();
                } else if(res.res == 2) {
                    swal("Ocurrió un error!", res.msg, "error");
                } else {
                    swal("ocurrió un error!", res.msg, "error");
                }
            },"json");
    }

    function item_opcion_editar_archivo(id) {
        return '<a href="javascript:item_update_archivo(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-warning m-btn--icon m-btn--icon-only m-btn--pill" title="Editar"><i class="la flaticon-edit-1 m--font-brand"></i></a>';
    }

    function item_opcion_eliminar_archivo(id) {
        return '<a href="javascript:item_delete_archivo(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-danger m-btn--icon m-btn--icon-only m-btn--pill" title="Eliminar"><i class="la flaticon-delete-2 m--font-brand"></i></a>';
    }

    function item_opcion_descargar_archivo(id) {
        return '<a href="javascript:item_descargar_archivo(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-success m-btn--icon m-btn--icon-only m-btn--pill" title="Descargar"><i class="la flaticon-download m--font-brand"></i></a>';
    }

    function get_form_archivo(id, type) {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemUpdate{literal}&captacionId={/literal}{$captacionId}{literal}&id="+id+"&type="+type;

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

    function item_descargar_archivo(id) {
        url= "{/literal}{$getModule}&accion={$subcontrol}_itemDescarga{literal}&captacionId={/literal}{$captacionId}{literal}&id="+id;
        window.open(url, '_blank');
    }
    
    var snippet_datatable_list_archivo = function () {
        $.fn.dataTable.Api.register('column().title()', function() {
            return $(this.header()).text().trim();
        });

        var exporta_titulo = "SIASBO - LISTA DE ARCHIVOS ADJUNTOS";
        var exporta_columnas = [':visible :not(.noExport)'];

        var initTableArchivo = function() {
            // begin first table
            table_list_archivo = $('#lista_archivo').DataTable({
                initComplete: function(settings, json) {
                    $('#lista_archivo').removeClass('m--hide');
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
                lengthMenu: [5, 10, 25, 50, 100],
                pageLength: 10,
                order: [[ 1, "asc" ]], // Por que campo ordenara al momento de desplegar
                searchDelay: 500,
                processing: true,
                serverSide: true,
                ajax: {
                    url: '{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemList{literal}&captacionId={/literal}{$captacionId}{literal}',
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
                            // var boton = '{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar_archivo(data) + '{/literal}{/if}{literal}{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar_archivo(data) + '{/literal}{/if}{literal}' + item_opcion_descargar_archivo(data);
                            // return boton;

                            var boton = item_opcion_descargar_archivo(data);
                            
                            // var permisoedit = 1;
                            // var permisodelete = 1;
                            // var permisoreadonly = 1;
                            var botonedit = "";
                            var botondelete = ""; 
                            //var botonreadonly = "";               

                            if (obj_permiso[0].editar == 1){ //permisoedit
                                botonedit = '{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar_archivo(data) + '{/literal}{/if}{literal}';
                            }

                            if (obj_permiso[0].eliminar == 1){ //permisodelete
                                botondelete = '{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar_archivo(data) + '{/literal}{/if}{literal}';
                            }
                            
                            //botonreadonly = '{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_sololeer(data) + '{/literal}{/if}{literal}';
                            //table_list.column(0).visible(false); //Solo funciona con false
                            
                            return botonedit+botondelete+boton; //+botonreadonly;
                        },
                    },
                    {
                        targets: [5, 6, 7],
                        visible: false,
                    },
                ],
            });

        };

        return {

            //main function to initiate the module
            init: function() {
                initTableArchivo();
            },

        };

    }();

//----------------Permisos--------------------------------------------
    var obj_permiso;

    function permisos_usuario(){
        var idUsuarioResponsable = parseInt($('#idUsuarioResponsable').val());
        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=obtenerPermisos&perpozo=captación superficial', //&perpozo=pozo
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            //dataType: "json",
            success: function(data){
                obj_permiso = JSON.parse(data);

                // if (obj_permiso[0].crear == 1){                                
                //     $("#btn_archivo_adjunto").show();
                // }else{
                //     $("#btn_archivo_adjunto").hide();
                // }           
                
                switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#btn_archivo_adjunto").show();
                        }else{
                            $("#btn_archivo_adjunto").hide();
                        }
                        break;
                    case 3:
                        $("#btn_archivo_adjunto").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                            $("#btn_archivo_adjunto").show();
                        }else{
                            $("#btn_archivo_adjunto").hide();
                        }
                        break;
                }
            },
        });
    }

    jQuery(document).ready(function() {
        permisos_usuario();
        snippet_datatable_list_archivo.init();
    });

</script>
{/literal}