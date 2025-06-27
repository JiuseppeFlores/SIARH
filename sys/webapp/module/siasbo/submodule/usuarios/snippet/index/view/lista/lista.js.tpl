{literal}
<script>
    // var table_list

    // function item_update(id){
    //     var url = '{/literal}{$getModule}{literal}&accion=itemUpdate&id='+id+'&type=update';
    //     location = url;
    // }
    // function item_delete(id){
    //     swal({
    //         title: 'Esta seguro de borrar el registro?',
    //         text: "Recuerde que el registro se eliminará permanentemente. ID="+id+", ",
    //         type: 'warning',
    //         showCancelButton: true,
    //         confirmButtonText: 'Si, Elimnar!!!',
    //         cancelButtonText: "No, cancelar"
    //     }).then(function(result) {
    //         if (result.value) {
    //             itemDeleteAction(id);
    //         }
    //     });
    // }
    // function item_print(id){
    //     alert("Imprime el dato:"+id)
    // }

    // function itemDeleteAction(id){
    //     randomnumber=Math.floor(Math.random()*11);
    //     $.get( "{/literal}{$getModule}{literal}",
    //         {accion:"itemDelete", random:randomnumber, id:id},
    //         function(res){
    //             if(res.res == 1){
    //                 //swal('Eliminado!','El registro fue eliminado','success');
    //                 swal({position: 'top-center',type: 'success',title: 'El registro fue eliminado',showConfirmButton: false,timer: 1200});
    //                 table_list.draw();
    //             }else if(res.res == 2){
    //                 swal("Ocurrio un error!", res.msg, "error");
    //             }else{
    //                 swal("ocurrio un error!", res.msg, "error");
    //             }
    //         },"json");
    // }

    // var snippet_datatable_list = function () {
    //     $.fn.dataTable.Api.register('column().title()', function() {
    //         return $(this.header()).text().trim();
    //     });

    //     var initTable1 = function() {
    //         // begin first table
    //         table_list = $('#index_lista').DataTable({
    //             responsive: true,
    //             //== Pagination settings
    //             dom:
    //             "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
    //             "<'row'<'col-sm-12 col-md-6'i><'col-sm-12 col-md-6'p>>" +
    //             "<'row'<'col-sm-12'tr>>" +
    //             "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
    //             "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
    //             // read more: https://datatables.net/examples/basic_init/dom.html
    //             language: {"url": "language/datatable.spanish.json"},
    //             lengthMenu: [5, 10, 25, 50],
    //             pageLength: 10,
    //             order: [[ 2, "asc" ]], // Por que campo ordenara al momento de desplegar
    //             searchDelay: 500,
    //             processing: true,
    //             serverSide: true,
    //             ajax: {
    //                 url: '{/literal}{$getModule}{literal}&accion=getItemList&accion=getItemList',
    //                 type: 'POST',
    //                 data: {},
    //             },
    //             columns: [
    //                 {/literal}
    //                 {foreach from=$grill_list item=row key=idx}
    //                     {literal}{data: '{/literal}{$row.field}{literal}'} ,{/literal}
    //                 {/foreach}
    //                 {literal}
    //             ],
    //             columnDefs: [
    //                 {
    //                     targets: 0,
    //                     //title: 'Accion',
    //                     orderable: false,
    //                     render: function(data, type, full, meta) {

    //                         var boton = ''+
    //                                 {/literal}{if $privFace.editar == 1}{literal}
    //                             '<a href="javascript:item_update(\''+data+'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-warning m-btn--icon m-btn--icon-only m-btn--pill " title="View">'+
    //                             '<i class="la flaticon-edit-1"></i>'+
    //                             '</a>'+
    //                                 {/literal}{/if}{literal}

    //                                 {/literal}{if $privFace.eliminar == 1}{literal}
    //                             '<a href="javascript:item_delete(\''+data+'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-danger m-btn--icon m-btn--icon-only m-btn--pill" title="View">'+
    //                             '<i class="la flaticon-delete-2"></i>'+
    //                             '</a>'+
    //                                 {/literal}{/if}{literal}
    //                             '';
    //                         return boton;
    //                     },
    //                 },
    //                 {
    //                     targets: [ 1 ],
    //                     searchable: false,
    //                     orderable: false,
    //                     render: function(data, type, full, meta) {
    //                         var status = {
    //                             0: {'estado': 'off', 'class': 'm-badge--danger'},
    //                             1: {'estado': 'on', 'class': 'm-badge--success'},
    //                         };
    //                         if (typeof status[data] === 'undefined') {
    //                             return data;
    //                         }
    //                         return '<img src="./template/user/images/icon/activo-' + status[data].estado + '.png" width="30" height="30" border="0" alt="hol">';
    //                     },
    //                 },
    //                 {
    //                     targets: [ 2 ],
    //                     render: function(data,type,full,meta){
    //                         return '<span class="m--font-bold m--font-primary">' + data + '</span>';
    //                     },

    //                 },

    //             ],

    //         });
    //     };

    //     return {

    //         //main function to initiate the module
    //         init: function() {
    //             initTable1();
    //         },

    //     };

    // }();

    // jQuery(document).ready(function() {
    //     snippet_datatable_list.init();
    // });

    //NUEVOS PROCEDIMIENTOS
    var table_list;
    var numero_usuario;

    function item_update(id) {
        var url = '{/literal}{$getModule}{literal}&accion=itemUpdate&id='+id+'&type=update';
        location = url;
    }

    function item_delete(id) {
        swal({
            title: 'Está seguro de borrar el registro?',
            text: "Recuerde que el registro se eliminará permanentemente. ID="+id+", ",
            type: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Si, Eliminar!!!',
            cancelButtonText: "No, cancelar"
        }).then(function(result) {
            if (result.value) {
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
            {accion:"itemDelete", random:randomnumber, id:id},
            function(res){
                if(res.res == 1){
                    swal('Eliminado!','El registro fue eliminado.','success');
                    //swal({position: 'top-center',type: 'success',title: 'El registro fue eliminado',showConfirmButton: false,timer: 1200});
                    table_list.draw();
                }else if(res.res == 2){
                    swal("Ocurrió un error!", res.msg, "error");
                }else{
                    swal("ocurrió un error!", res.msg, "error");
                }
            },"json");
    }

    function item_opcion_editar(id) {
        return '<a href="javascript:item_update(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-warning m-btn--icon m-btn--icon-only m-btn--pill" title="Editar"><i class="la flaticon-edit-1 m--font-brand"></i></a>';
    }

    function item_opcion_eliminar(id) {
        return '<a href="javascript:item_delete(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-danger m-btn--icon m-btn--icon-only m-btn--pill" title="Eliminar"><i class="la flaticon-delete-2 m--font-brand"></i></a>';
    }

    function item_opcion_permisos(id) {
        return '<a href="javascript:DarConfiguracion(\''+ id +'\');" class="btn m-btn--pill m-btn--air btn-outline-primary btn-sm" title="Solo lectura">Dar Permisos</a>'; //<i class="la flaticon-eye m--font-brand"></i>
    }

    function DarConfiguracion(dato){
        //alert('Configuraciones: '+dato);
        numero_usuario = dato;
        //$('#lbl_usuario').text('SIASBO');
        $('#modal_configuracion').modal('show');
    }
    
    var snippet_datatable_list = function () {
        $.fn.dataTable.Api.register('column().title()', function() {
            return $(this.header()).text().trim();
        });

        var exporta_titulo = "SIASBO - LISTA DE POZOS";
        var exporta_columnas = [':visible :not(.noExport)'];

        var initTable1 = function() {
            // begin first table            
            table_list = $('#index_lista').DataTable({
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
                    {extend:'colvis',text:'Ver'
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
                lengthMenu: [10, 25, 50, 1000], //[[10, 25, 50, -1], [10, 25, 50, "Todo"]], //
                pageLength: 10,
                order: [[ 2, "asc" ]], // Por que campo ordenara al momento de desplegar
                searchDelay: 500,
                processing: true,
                serverSide: true,
                ajax: {
                    url: '{/literal}{$getModule}{literal}&accion=getItemList', //&accion=getItemList
                    type: 'POST',
                    data: {},
                    datatype: 'json',
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
                        //visible: false,  
                        render: function(data, type, full, meta) {
                            // var boton = '{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar(data) + '{/literal}{/if}{literal}{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar(data) + '{/literal}{/if}{literal}';
                            // return boton;
                             
                            var botonpermisos = "";

                            if (obj_permiso[0].eliminar == 1){
                                botonpermisos = '{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_permisos(data) + '{/literal}{/if}{literal}';
                            }
                            
                            return botonpermisos;
                        },
                    },
                    {
                        targets: [ 1 ],
                        searchable: true,
                        orderable: true
                    },
                ],
            });

        };

        $('#btn_basico').click(function(){
            //alert("Configuracion basica: "+numero_usuario);
            jQuery.ajax({
                url: '{/literal}{$getModule}{literal}&accion=setPermisoBasico&id='+numero_usuario,
                //data: data,
                cache: false,
                contentType: false,
                processData: false,
                type: 'POST',
                //dataType: "json",
                success: function(data){
                    //alert(data);                    
                    var obj = JSON.parse(data);
                    
                    if(obj.res == true){
                        swal("Ok", "Se asigno el permiso <strong>basico</strong> para este usuario", "success");
                    }else{
                        swal("Error", "No se pudo asignar los permisos", "error");
                    }                    
                },
            });
        });

        $('#btn_medio').click(function(){
            //alert("Configuracion media: "+numero_usuario);
            jQuery.ajax({
                url: '{/literal}{$getModule}{literal}&accion=setPermisoMedio&id='+numero_usuario,
                //data: data,
                cache: false,
                contentType: false,
                processData: false,
                type: 'POST',
                //dataType: "json",
                success: function(data){
                    //alert(data);
                    var obj = JSON.parse(data);
                    
                    if(obj.res == true){
                        swal("Ok", "Se asigno el permiso <strong>medio</strong> para este usuario", "success");
                    }else{
                        swal("Error", "No se pudo asignar los permisos", "error");
                    }                    
                },
            });
        })

        $('#btn_avanzado').click(function(){
            //alert("Configuracion avanzada: "+numero_usuario);
            jQuery.ajax({
                url: '{/literal}{$getModule}{literal}&accion=setPermisoAvanzado&id='+numero_usuario,
                //data: data,
                cache: false,
                contentType: false,
                processData: false,
                type: 'POST',
                //dataType: "json",
                success: function(data){
                    //alert(data);
                    var obj = JSON.parse(data);
                    
                    if(obj.res == true){
                        swal("Ok", "Se asigno el permiso <strong>avanzado</strong> para este usuario", "success");
                    }else{
                        swal("Error", "No se pudo asignar los permisos", "error");
                    }                    
                },
            });
        })

        return {
            //main function to initiate the module
            init: function() {
                initTable1();
            },
        };

    }();

//----------------Permisos--------------------------------------------
    var obj_permiso;

    function permisos_usuario(){
        //alert("Permisos usuario pozo");
        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=obtenerPermisos', //&perpozo=Acciones de Usuario',
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            //dataType: "json",
            success: function(data){
                //alert(data);
                obj_permiso = JSON.parse(data);                
            },
        });
    }

    jQuery(document).ready(function(){
        permisos_usuario();
        snippet_datatable_list.init();
    });

</script>
{/literal}