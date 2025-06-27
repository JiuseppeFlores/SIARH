{literal}
<script>
    var snippet_form_archivo = function () {
        var idficha = '{/literal}{$id}{literal}';
        var type = '{/literal}{$type}{literal}';
        var form_archivo = $('#form_archivo');
        var btn_archivo_submit = $('#btn_archivo_submit');
        var campo_input_archivo = $('#form_archivo input');
        
        var btn_modal_close = $('#btn_modal_close');

        //== Private Functions
        var showRequest= function (formData, jqForm, op) {
            btn_archivo_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
            return true;
        };

        var showResponse = function (responseText, statusText) {
            btn_archivo_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
            if(responseText.res ==1) {
                if(responseText.accion == 'new') {
                    $("#modal_window").modal("hide");
                    swal("Creado!", "Se guardó el registro con éxito!", "success");
                    table_list_archivo.draw();
                } else if(responseText.accion == 'update') {
                    $("#modal_window").modal("hide");
                    swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                    table_list_archivo.draw();
                } else {
                    $("#modal_window").modal("hide");
                }
            } else if(responseText.res ==2) {
                swal("Ocurrió un error!", responseText.msg, "error");
            } else {
                swal("ocurrió un error!", responseText.msg, "danger");
            }
        };

        var options = {
            beforeSubmit: showRequest
            , dataType: 'json'
            , success: showResponse
            , data: {
                accion: '{/literal}{$subcontrol}_itemupdatesql{literal}'
                ,itemId: idficha
                ,type: type
            }
        };

        var handle_form_submit = function () {
            form_archivo.ajaxForm(options);
        };

        var handle_general_form_submit = function () {

            btn_archivo_submit.click(function (e) {
                e.preventDefault();
                var btn = $(this);
                var form = $(this).closest('form');

                form.validate({
                    rules: {
                        "item[nombre]": {
                            required: true,
                            minlength: 3
                        },
                        "item[codigo]": {
                            required: true,
                            minlength: 1
                        },
                        "item[fecha_inicio]": {
                            required: true,
                            minlength: 3
                        },
                        "item[fecha_fin]": {
                            required: true,
                            minlength: 3
                        },
                    }
                });

                if (!form.valid()) {
                    return;
                }
                
                form_archivo.submit();
            });
        };

        var handle_general_components = function () {
            $('#adj_fecha').datepicker({
                todayHighlight: true,
                orientation: "bottom left",
                format: 'dd/mm/yyyy',
                templates: {
                    leftArrow: '<i class="la la-angle-left"></i>',
                    rightArrow: '<i class="la la-angle-right"></i>'
                },
                language: 'es'
            });

            $('.select2').select2({
                placeholder: "Seleccione una opción",
                dropdownParent: $("#modal_window")
            });
            
            $('.summernote').summernote({
                height: 150
            });
        };

        var handle_get_components = function() {
            campo_input_archivo.keyup(function () {
                form_archivo.validate();
            });

            btn_modal_close.click(function () {
                swal({type: 'success', title: 'Cerrando!', showConfirmButton: false, timer: 300});
            });
        };

        //== Public Functions
        return {
            // public functions
            init: function () {
                handle_general_form_submit();
                handle_form_submit();
                handle_general_components();
                handle_get_components();

                $("#divPaso2").hide();
                $("#divPaso3").hide();
                $("#btn_procesar").attr("disabled", "disabled");
                $("#btn_guardar").attr("disabled", "disabled");
            }
        };
    } ();


    //Seccion Importacion de Datos desde Excel

    var form_importar = $('#form_importar');

    // $("#btn_importar_archivo").click(function(){
    //     MostrarModalImportar();
    // })

    function MostrarModalImportar(){
        //$("#modal_importar").modal("show");
        $("#input_importar").val("");
        $("#divPaso2").hide();
        $("#divPaso3").hide();
        $("#btn_procesar").attr("disabled", "disabled");
        $("#btn_guardar").attr("disabled", "disabled");
    }

    function OcultarModalImportar(){
        //$("#modal_importar").modal("hide");
        $("#input_importar").val("");
        $("#divPaso2").hide();
        $("#divPaso3").hide();
        $("#btn_procesar").attr("disabled", "disabled");
        $("#btn_guardar").attr("disabled", "disabled");
    }

    $("#btn_enviar").click(function(){
        //alert("Procesar");
        //alert('{/literal}{$getModule}{literal}&accion=procesarArchivo');
        //alert("?module=siasbo&smodule=ficha_pozo");
        //alert('{/literal}{$subcontrol}_itemupdatesql{literal}');

        if($("#input_importar").val() != ""){
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
                data.append('file-'+i, file);
            });
            var other_data = $('#form_importar').serializeArray();
            $.each(other_data,function(key,input){
                data.append(input.name,input.value);
            });
            jQuery.ajax({
                url: '{/literal}{$getModule}{literal}&accion=importacion_enviarArchivo',
                data: data,
                cache: false,
                contentType: false,
                processData: false,
                type: 'POST',
                dataType: "json",
                success: function(data){
                    swal.close();
                    //alert(data);
                    //alert(data.res);
                    //console.log(data);
                    
                    if(data.res == false){
                        $("#divPaso2").hide();
                        $("#btn_procesar").attr("disabled", "disabled");
                        swal("Advertencia", "Verifique los nombres de las hojas de su archivo Excel", "warning");
                    }else{
                        $("#divPaso2").show();
                        $("#btn_procesar").removeAttr("disabled");
                        $.each(data,function(key, registro) {
                            $("#select_Hojas").append('<option>'+registro+'</option>');
                        });
                    }
                    
                },
                //timeout: 20000,
            });
        }else{
            swal("Informacion!", "Haga click en examinar y seleccione un archivo", "warning");
        }
    })

    $("#btn_procesar").click(function(){
        //alert($("#select_Hojas").val());
        if($("#input_importar").val() != ""){
            if($("#select_Hojas").val() != ""){
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
                    data.append('file-'+i, file);
                });

                var other_data = $('#form_importar').serializeArray();
                $.each(other_data,function(key,input){
                    data.append(input.name,input.value);
                });

                jQuery.ajax({
                    url: '{/literal}{$getModule}{literal}&accion=importacion_procesarArchivo&hoja='+$("#select_Hojas").val(),
                    data: data,
                    cache: false,
                    contentType: false,
                    processData: false,
                    type: 'POST',
                    //dataType: "json",
                    success: function(data){
                        swal.close();
                        alert(data);
                        //console.log(data);
                        
                        if(data.res == false){
                            $("#divPaso3").hide();
                            $("#btn_guardar").attr("disabled", "disabled");
                            swal("Advertencia!", "No tiene datos en la hoja excel que mando a procesar o el numero de columnas de su archivo excel es incorrecto, verifique", "warning");
                        }else{
                            $("#divPaso3").show();
                            $("#btn_guardar").removeAttr("disabled");
                            // $.each(data,function(key, registro) {
                            //     $("#select_Hojas").append('<option>'+registro+'</option>');
                            // });
                        }                    
                    },
                });
            }else{
                swal("Informacion!", "PASO 2: Seleccione un item de la lista", "warning");
            }       
        }else{
            swal("Informacion!", "PASO 1: Haga click en examinar y seleccione un archivo", "warning");
        }
    })

    $("#btn_guardar").click(function(){
        //alert("Guardar");
        if (!verificarGuardado($("#select_Hojas").val())){
            if($("#input_importar").val() != ""){
                if($("#select_Hojas").val() != ""){
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
                        data.append('file-'+i, file);
                    });

                    var other_data = $('#form_importar').serializeArray();
                    $.each(other_data,function(key,input){
                        data.append(input.name,input.value);
                    });

                    jQuery.ajax({
                        url: '{/literal}{$getModule}{literal}&accion=importacion_guardarArchivo&hoja='+$("#select_Hojas").val(),
                        data: data,
                        cache: false,
                        contentType: false,
                        processData: false,
                        type: 'POST',
                        //dataType: "json",
                        success: function(data){
                            swal.close();
                            alert(data);
                            //console.log(data);

                            if (data.res == true){
                                swal("OK", "La información "+$("#select_Hojas").val()+" guardo <strong>"+data.filasafectadas+"</strong> registros correctamente", "success");
                                $('#contenedor_lista_agregados').append("<li class='dropdown-item'>"+$("#select_Hojas").val()+"</li>");
                                $('#select_Hojas option').each(function(){
                                    if ($(this).val() == $("#select_Hojas").val()){
                                        $(this).remove();
                                    }
                                });
                                $("#select_Hojas").val("");                                
                            };               
                        },
                    });
                }else{
                    swal("Informacion!", "PASO 2: Seleccione un item de la lista", "warning");
                }       
            }else{
                swal("Informacion!", "PASO 1: Haga click en examinar y seleccione un archivo", "warning");
            }
        }else{
            swal("Informacion!", "PASO 2: La informacion de la hoja "+$("#select_Hojas").val()+" ya fue guardado", "warning");
        }        
    })

    function verificarGuardado(dato){
        var contenedor = $('#contenedor_lista_agregados');
        var lista = contenedor.children('li');

        var isInList = false;
        for(var i = 0; i < lista.length; i++){
            if(lista[i].innerHTML === dato){
                isInList = true;
                break;
            }
        }

        if(isInList)
            return true;
        else
            return false;
    }

    //== Class Initialization
    jQuery(document).ready(function () {
        snippet_form_archivo.init();
    });

</script>
{/literal}