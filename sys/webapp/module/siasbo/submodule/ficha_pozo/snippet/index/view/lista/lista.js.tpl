{literal}
    <script>
        var table_list;
        var obj_permiso;
        var sw = false;

        function item_update(id) {
            var url = '{/literal}{$getModule}{literal}&accion=itemUpdate&id='+id+'&type=update';
            location = url;
        }

        function item_delete(id) {
            swal({
                title: 'Está seguro de borrar el registro?',
                text: "Recuerde que el registro se eliminará permanentemente. ID=" + id + ", ",
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
            alert("Imprime el dato:" + id)
        }

        function itemDeleteAction(id) {
            randomnumber = Math.floor(Math.random() * 11);
            $.get( "{/literal}{$getModule}{literal}",
            {accion:"itemDelete", random:randomnumber, id:id},
            function(res) {
                if (res.res == 1) {
                    swal('Eliminado!', 'El registro fue eliminado.', 'success');
                    //swal({position: 'top-center',type: 'success',title: 'El registro fue eliminado',showConfirmButton: false,timer: 1200});
                    table_list.draw();
                } else if (res.res == 2) {
                    swal("Ocurrió un error!", res.msg, "error");
                } else {
                    swal("ocurrió un error!", res.msg, "error");
                }
            }, "json");
        }

        function item_import(id) {
            $("#txtFichaId").val(id);
            $('#frmImportarDatosMonitoreo').trigger("reset");
            $("#divImportarPaso2").hide();
            $("#btnObtenerHojasArchivoDatosMonitoreo").attr("disabled", "disabled");
            $("#btnImportarArchivoDatosMonitoreo").attr("disabled", "disabled");
            $("#modalImportarDatosMonitoreo").modal("show");
        }

        function item_opcion_editar(id) {
            return '<a href="javascript:item_update(\'' + id +
                '\');" class="m-portlet__nav-link btn m-btn m-btn--hover-warning m-btn--icon m-btn--icon-only m-btn--pill" title="Editar"><i class="la flaticon-edit-1 m--font-brand"></i></a>';
        }

        function item_opcion_eliminar(id) {
            return '<a href="javascript:item_delete(\'' + id +
                '\');" class="m-portlet__nav-link btn m-btn m-btn--hover-danger m-btn--icon m-btn--icon-only m-btn--pill" title="Eliminar"><i class="la flaticon-delete-2 m--font-brand"></i></a>';
        }

        function item_opcion_sololeer(id) {
            return '<a href="javascript:item_delete(\'' + id +
                '\');" class="m-portlet__nav-link btn m-btn m-btn--hover-success m-btn--icon m-btn--icon-only m-btn--pill" title="Solo lectura"><i class="la flaticon-eye m--font-brand"></i></a>';
        }

        function item_opcion_importar(id) {
            return '<a href="javascript:item_import(\'' + id +
                '\');" class="m-portlet__nav-link btn m-btn m-btn--hover-success m-btn--icon m-btn--icon-only m-btn--pill" title="Importar datos de monitoreo"><i class="la flaticon-upload m--font-brand"></i></a>';
        }

        var snippet_datatable_list = function() {
        $.fn.dataTable.Api.register('column().title()', function() {
            return $(this.header()).text().trim();
        });

        // if (sw == true){
        //     urlespecifico = '{/literal}{$getModule}{literal}&accion=getItemList';
        // }else{
        //     urlespecifico = '{/literal}{$getModule}{literal}&accion=getItemListEspecifico';
        // }

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
                        dom: "<'row'<'col-sm-12 col-md-12 dataTables_pager'lp>>" +
                            `<'row'<'col-sm-5 text-left'f><'col-sm-7 text-right'B>>
                     <'row'<'col-sm-12'tr>>
                     <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'lp>>`,
                        // read more: https://datatables.net/examples/basic_init/dom.html
                        buttons: [
                            {extend:'colvis',text:'Ver'
                            , columnText: function(dt, idx, title) {
                                return (idx + 1) + ': ' + title;
                            }
                        },
                        {extend:'excelHtml5'
                        ,exportOptions: {columns: exporta_columnas}
                        ,
                        title: exporta_titulo
                    },
                    {extend:'pdfHtml5'
                    ,exportOptions: {columns: exporta_columnas}
                    , title: exporta_titulo, download: 'open'
                    //, orientation: 'landscape'
                    , pageSize: 'LETTER', customize: function(doc) {
                        doc.styles.tableHeader.fontSize = 7;
                        doc.defaultStyle.fontSize = 7;
                        doc.pageMargins = [20, 20];
                    }
                },

            ],
            // read more: https://datatables.net/examples/basic_init/dom.html
            language: {"url": "language/datatable.spanish.json"},
            lengthMenu: [10, 25, 50, 1000], //[[10, 25, 50, -1], [10, 25, 50, "Todo"]], //
            pageLength: 10,
            order: [
                [2, "asc"]
            ], // Por que campo ordenara al momento de desplegar
            searchDelay: 500,
            processing: true,
            serverSide: true,
            ajax: {
                url: '{/literal}{$getModule}{literal}&accion=getItemList', //&accion=getItemList',
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
        columnDefs: [{
                targets: 0,
                title: 'Acción',
                orderable: false,
                //visible: false,  
                render: function(data, type, full, meta) {
                    console.log(data);
                    // var boton = '{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar(data) + '{/literal}{/if}{literal}{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar(data) + '{/literal}{/if}{literal}';
                    // return boton;

                    // var permisoedit = 1;
                    // var permisodelete = 1;
                    // var permisoreadonly = 1;
                    var botonedit = "";
                    var botondelete = "";
                    //var botonreadonly = "";
                    var botonimport = "";

                    if (obj_permiso[0].editar == 1) { //permisoedit
                        botonedit = '{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar(data) + '{/literal}{/if}{literal}';
                        botonimport = '{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_importar(data) + '{/literal}{/if}{literal}';
                    }

                    if (obj_permiso[0].eliminar == 1) { //permisodelete
                        botondelete = '{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar(data) + '{/literal}{/if}{literal}';
                    }

                    //botonreadonly = '{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_sololeer(data) + '{/literal}{/if}{literal}';
                    //table_list.column(0).visible(false); //Solo funciona con false

                    return botonedit + botondelete + botonimport; //+botonreadonly;
                },
            },
            {
                targets: [1],
                searchable: true,
                orderable: true
            },
        ],
    });

    };

    return {

        //main function to initiate the module
        init: function() {
            initTable1();
            $("#th_busqueda_especifica").hide();
            // $("#divPaso2").hide();
            // $("#divPaso3").hide();
            // $("#btn_procesar").attr("disabled", "disabled");
            // $("#btn_guardar").attr("disabled", "disabled");
        },

    };

    }();


    //Seccion Importacion de Datos desde Excel

    var form_importar = $('#form_importar');

    $("#btn_importar_archivo").click(function() {
        MostrarModalImportar();
    })

    $("#btn_nueva_importacion").click(function() {
        $('#contenedor_lista_agregados').empty();

        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=resetearDatos',
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            dataType: "json",
            success: function(data) {
                //alert(data);
                //alert(data.res);
                //console.log(data);

                if (data.res == true) {
                    $("#input_importar").val("");
                    $("#divPaso2").hide();
                    $("#divPaso3").hide();
                    $("#btn_procesar").attr("disabled", "disabled");
                    $("#btn_guardar").attr("disabled", "disabled");
                    swal("OK", "Puede volver a importar datos", "success");
                } else {
                    swal("Advertencia", "Vuelva a recargar la pagina", "warning");
                }
            },
        });
    })

    $("#btn_modal_close").click(function() {
        $('#contenedor_lista_agregados').empty();

        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=resetearDatos',
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            dataType: "json",
            success: function(data) {
                //alert(data);
                //alert(data.res);
                //console.log(data);

                if (data.res == true) {
                    swal("OK", "Puede volver a importar datos", "success");
                } else {
                    swal("Advertencia", "Vuelva a recargar la pagina", "warning");
                }
            },
        });
    })

    $("#btn_icon_modal_close").click(function() {
        $('#contenedor_lista_agregados').empty();

        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=resetearDatos',
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            dataType: "json",
            success: function(data) {
                //alert(data);
                //alert(data.res);
                //console.log(data);

                if (data.res == true) {
                    swal("OK", "Puede volver a importar datos", "success");
                } else {
                    swal("Advertencia", "Vuelva a recargar la pagina", "warning");
                }
            },
        });
    })

    function MostrarModalImportar() {
        //$("#modal_importar").modal("show");
        $("#input_importar").val("");
        $("#divPaso2").hide();
        $("#divPaso3").hide();
        $("#btn_procesar").attr("disabled", "disabled");
        $("#btn_guardar").attr("disabled", "disabled");
    }

    function OcultarModalImportar() {
        //$("#modal_importar").modal("hide");
        $("#input_importar").val("");
        $("#divPaso2").hide();
        $("#divPaso3").hide();
        $("#btn_procesar").attr("disabled", "disabled");
        $("#btn_guardar").attr("disabled", "disabled");
    }

    $("#btn_enviar").click(function() {
        //alert("Procesar");
        //alert('{/literal}{$getModule}{literal}&accion=procesarArchivo');
        //alert("?module=siasbo&smodule=ficha_pozo");
        //alert('{/literal}{$subcontrol}_itemupdatesql{literal}');

        if ($("#input_importar").val() != "") {
            swal({
                title: 'Cargando tab!',
                text: 'Procesando datos',
                imageUrl: 'images/loading/loading05.gif',
                showConfirmButton: false,
                allowEnterKey: false,
                allowOutsideClick: false,
                allowEscapeKey: false,
            });

            $('#select_Hojas').empty().append('<option></option>');

            var data = new FormData();
            jQuery.each($('input[type=file]')[0].files, function(i, file) {
                data.append('file-' + i, file);
            });
            var other_data = $('#form_importar').serializeArray();
            $.each(other_data, function(key, input) {
                data.append(input.name, input.value);
            });
            jQuery.ajax({
                url: '{/literal}{$getModule}{literal}&accion=enviarArchivo',
                data: data,
                cache: false,
                contentType: false,
                processData: false,
                type: 'POST',
                //dataType: "json",
                success: function(data) {
                    swal.close();
                    var data = JSON.parse(data);
                    //alert(data.res);

                    if (data.res == false) {
                        $("#divPaso2").hide();
                        $("#btn_procesar").attr("disabled", "disabled");
                        swal("Advertencia",
                            "Verifique los nombres de las hojas de su archivo Excel", "warning");
                    } else {
                        $("#divPaso2").show();
                        $("#btn_procesar").removeAttr("disabled");
                        $.each(data, function(key, registro) {
                            $("#select_Hojas").append('<option>' + registro + '</option>');
                        });
                    }

                },
                //timeout: 20000,
            });
        } else {
            swal("Informacion!", "Haga click en examinar y seleccione un archivo", "warning");
        }
    })

    $("#btn_procesar").click(function() {
        //alert($("#select_Hojas").val());
        if ($("#input_importar").val() != "") {
            if ($("#select_Hojas").val() != "") {
                swal({
                    title: 'Cargando tab!',
                    text: 'Procesando datos',
                    imageUrl: 'images/loading/loading05.gif',
                    showConfirmButton: false,
                    allowEnterKey: false,
                    allowOutsideClick: false,
                    allowEscapeKey: false,
                });

                //$('#select_Hojas').empty().append('<option></option>');

                var data = new FormData();
                jQuery.each($('input[type=file]')[0].files, function(i, file) {
                    data.append('file-' + i, file);
                });

                var other_data = $('#form_importar').serializeArray();
                $.each(other_data, function(key, input) {
                    data.append(input.name, input.value);
                });

                jQuery.ajax({
                    url: '{/literal}{$getModule}{literal}&accion=procesarArchivo&hoja='+$("#select_Hojas").val(),
                    data: data,
                    cache: false,
                    contentType: false,
                    processData: false,
                    type: 'POST',
                    //dataType: "json",
                    success: function(data) {
                        swal.close();
                        var obj = JSON.parse(data);
                        //alert(obj.res);

                        if (obj.res == false) {
                            $("#divPaso3").hide();
                            $("#btn_guardar").attr("disabled", "disabled");
                            swal("Advertencia!",
                                "No tiene datos en la hoja excel que mando a procesar o el numero de columnas de su archivo excel es incorrecto, verifique",
                                "warning");
                        } else {
                            $("#divPaso3").show();
                            $("#btn_guardar").removeAttr("disabled");
                            swal("Informacion", obj.numfilas + " datos procesados correctamente",
                                "success");
                        }
                    },
                    timeout: 20000,
                });
            } else {
                swal("Informacion!", "PASO 2: Seleccione un item de la lista", "warning");
            }
        } else {
            swal("Informacion!", "PASO 1: Haga click en examinar y seleccione un archivo", "warning");
        }
    })

    $("#btn_guardar").click(function() {
        //alert("Guardar");
        if (!verificarGuardado($("#select_Hojas").val())) {
            if ($("#input_importar").val() != "") {
                if ($("#select_Hojas").val() != "") {
                    swal({
                        title: 'Cargando tab!',
                        text: 'Procesando datos',
                        imageUrl: 'images/loading/loading05.gif',
                        showConfirmButton: false,
                        allowEnterKey: false,
                        allowOutsideClick: false,
                        allowEscapeKey: false,
                    });

                    //$('#select_Hojas').empty().append('<option></option>');

                    var data = new FormData();
                    jQuery.each($('input[type=file]')[0].files, function(i, file) {
                        data.append('file-' + i, file);
                    });

                    var other_data = $('#form_importar').serializeArray();
                    $.each(other_data, function(key, input) {
                        data.append(input.name, input.value);
                    });

                    jQuery.ajax({
                        url: '{/literal}{$getModule}{literal}&accion=guardarArchivo&hoja='+$("#select_Hojas").val(),
                        data: data,
                        cache: false,
                        contentType: false,
                        processData: false,
                        type: 'POST',
                        //dataType: "json",
                        success: function(data) {
                            swal.close();
                            var obj = JSON.parse(data);
                            //alert(obj.res);

                            if (obj.res == true) {
                                swal("OK", "La información " + $("#select_Hojas").val() +
                                    " guardo <strong>" + obj.filasafectadas +
                                    "</strong> registros correctamente", "success");
                                $('#contenedor_lista_agregados').append(
                                    "<li class='dropdown-item'>" + $("#select_Hojas").val() +
                                    "</li>");
                                $('#select_Hojas option').each(function() {
                                    if ($(this).val() == $("#select_Hojas").val()) {
                                        $(this).remove();
                                    }
                                });
                                $("#select_Hojas").val("");
                            } else {
                                swal("ERROR",
                                    "La información no se guardo correctamente en PostgreSQL",
                                    "error");
                            }
                        },
                    });
                } else {
                    swal("Informacion!", "PASO 2: Seleccione un item de la lista", "warning");
                }
            } else {
                swal("Informacion!", "PASO 1: Haga click en examinar y seleccione un archivo", "warning");
            }
        } else {
            swal("Informacion!", "PASO 2: La informacion de la hoja " + $("#select_Hojas").val() +
                " ya fue guardado", "warning");
        }
    })

    $("#btn_busqueda_especifica").click(function() {
        if (sw == true) {
            $("#th_busqueda_especifica").hide();
            $("#sp_label").text("Mostrar busqueda especifica");
            sw = false;
        } else {
            $("#th_busqueda_especifica").show();
            $("#sp_label").text("Ocultar busqueda especifica");
            sw = true;
        }
    })

    function verificarGuardado(dato) {
        var contenedor = $('#contenedor_lista_agregados');
        var lista = contenedor.children('li');

        var isInList = false;
        for (var i = 0; i < lista.length; i++) {
            if (lista[i].innerHTML === dato) {
                isInList = true;
                break;
            }
        }

        if (isInList)
            return true;
        else
            return false;
    }

    //--------Importar datos archivo de datos de monitoreo------------
    function InicializarControlesImportacionArchivoDatosMonitoreo() {
        $("#divImportarPaso2").hide();
        $("#btnObtenerHojasArchivoDatosMonitoreo").attr("disabled", "disabled");
        $('#cboHojasArchivoDatosMonitoreo').empty().append('<option></option>');
        $("#btnImportarArchivoDatosMonitoreo").attr("disabled", "disabled");
    }

    $("#fileDatosMonitoreo").change(function() {
        if ($("#fileDatosMonitoreo").val() != "") {
            $("#btnObtenerHojasArchivoDatosMonitoreo").removeAttr("disabled");
        } else {
            InicializarControlesImportacionArchivoDatosMonitoreo();
        }
    });

    $("#btnObtenerHojasArchivoDatosMonitoreo").click(function() {
        if ($("#fileDatosMonitoreo").val() != "") {
            swal({
                title: 'Cargando tab!',
                text: 'Procesando datos',
                imageUrl: 'images/loading/loading05.gif',
                showConfirmButton: false,
                allowEnterKey: false,
                allowOutsideClick: false,
                allowEscapeKey: false,
            });

            $("#btnObtenerHojasArchivoDatosMonitoreo").attr("disabled", "disabled");
            $('#cboHojasArchivoDatosMonitoreo').empty().append('<option></option>');

            var form = $('#frmImportarDatosMonitoreo')[0];
            var formData = new FormData(form);

            jQuery.ajax({
                url: '{/literal}{$getModule}{literal}&accion=obtenerHojasArchivoDatosMonitoreo',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                type: 'POST',
                success: function(data) {
                    swal.close();
                    var data = JSON.parse(data);
                    if (data.estado == false) {
                        $("#divImportarPaso2").hide();
                        $("#btnImportarArchivoDatosMonitoreo").attr("disabled", "disabled");
                        swal("Advertencia", data.mensaje, "warning");
                    } else {
                        $("#divImportarPaso2").show();
                        $("#btnImportarArchivoDatosMonitoreo").removeAttr("disabled");
                        $.each(data.resultado, function(key, registro) {
                            $("#cboHojasArchivoDatosMonitoreo").append(new Option(registro,
                                registro));
                        });
                    }
                }
            });
        } else {
            swal("Informacion!", "Haga click en examinar y seleccione un archivo", "warning");
        }
    });

    $("#cboHojasArchivoDatosMonitoreo").change(function() {
        if ($("#cboHojasArchivoDatosMonitoreo").val() != "") {
            $("#btnImportarArchivoDatosMonitoreo").removeAttr("disabled");
        } else {
            $("#btnImportarArchivoDatosMonitoreo").attr("disabled", "disabled");
        }
    });

    $("#btnImportarArchivoDatosMonitoreo").click(function() {
        if ($("#cboHojasArchivoDatosMonitoreo").val() != "") {
            swal({
                title: 'Cargando tab!',
                text: 'Procesando datos',
                imageUrl: 'images/loading/loading05.gif',
                showConfirmButton: false,
                allowEnterKey: false,
                allowOutsideClick: false,
                allowEscapeKey: false,
            });

            var form = $('#frmImportarDatosMonitoreo')[0];
            var formData = new FormData(form);

            jQuery.ajax({
                url: '{/literal}{$getModule}{literal}&accion=procesarArchivoDatosMonitoreo',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                type: 'POST',
                success: function(data) {
                    swal.close();
                    var data = JSON.parse(data);
                    if (data.estado) {
                        var valorOpcion = $("#cboHojasArchivoDatosMonitoreo").val();
                        $('#cboHojasArchivoDatosMonitoreo').find('[value="' + valorOpcion + '"]')
                            .remove();
                        swal("OK", data.mensaje, "success");
                    } else {
                        swal("Advertencia", data.mensaje, "warning");
                    }
                }
            });
        } else {
            swal("Informacion!", "Seleccione una hoja", "warning");
        }
    });

    //----------------Permisos--------------------------------------------

    function permisos_usuario() {
        //alert("Permisos usuario pozo");
        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=obtenerPermisos&perpozo=pozo', //&perpozo=pozo ya no es necesario
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            //dataType: "json",
            success: function(data) {
                //alert(data);
                obj_permiso = JSON.parse(data);
                //alert(obj_permiso[0].crear+" - "+obj_permiso[0].editar+" - "+obj_permiso[0].eliminar);

                //alert('{/literal}{$dato1}{literal}');

                if (obj_permiso[0].crear == 1) {
                    $("#btn_importar_archivo").show();
                    $("#btn_update").show();
                } else {
                    $("#btn_importar_archivo").hide();
                    $("#btn_update").hide();
                }
            },
        });
    }

    jQuery(document).ready(function() {
        permisos_usuario();
        snippet_datatable_list.init();
        $('.search-input-text').on('keyup change', function() {
            var i = $(this).attr('data-column');
                var v = $(this).val();
                table_list.columns(i).search(v).draw();
            });
        });
    </script>
{/literal}