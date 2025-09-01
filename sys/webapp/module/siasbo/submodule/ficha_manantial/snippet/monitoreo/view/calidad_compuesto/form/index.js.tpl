{literal}
<script>
    var snippet_form_calidad_compuesto = function () {
        var idficha = '{/literal}{$id}{literal}';
        var type = '{/literal}{$type}{literal}';
        var form_calidad_compuesto = $('#form_calidad_compuesto');
        var btn_calidad_compuesto_submit = $('#btn_calidad_compuesto_submit');
        var select_get_parametro = $('#calcom_parametroId');
        var campo_input_calidad_compuesto = $('#form_calidad_compuesto input');
        
        var btn_modal_close = $('#btn_modal_close');
        //== Private Functions
        var showRequest= function (formData, jqForm, op) {
            btn_calidad_compuesto_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
            return true;
        };

        var showResponse = function (responseText, statusText) {
            btn_calidad_compuesto_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
            if(responseText.res ==1) {
                if(responseText.accion == 'new') {
                    //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                    swal("Creado!", "Se guardó el registro con éxito!", "success");
                    table_list_calidad_compuesto.draw();
                    $("#modal_window_compuesto").modal("hide");
                } else if(responseText.accion == 'update') {
                    swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                    table_list_calidad_compuesto.draw();
                    $("#modal_window_compuesto").modal("hide");
                    //swal({type: 'success',title: 'Actualizado! Se actualizó todo con éxito!',showConfirmButton: false, timer: 1000});
                } else {
                    $("#modal_window_compuesto").modal("hide");
                }
            } else if(responseText.res ==2) {
                swal("Ocurrió un error!", responseText.msg, "error");
            } else {
                swal("ocurrió un error!", responseText.msg, "danger");
            }
        };

        var get_compuesto = function (id) {
            var compuestoOpt = $('#calcom_compuestoId').empty();
            if(id!="") {
                $.post("{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getCalidadCompuesto{literal}"
                    , {parametroId: id}
                    , function (respuesta, textStatus, jqXHR) {
                        selOption = $('<option></option>');
                        compuestoOpt.append(selOption.attr("value", "").text("Seleccione compuesto"));
                        for (var clave in respuesta) {
                            compuestoOpt.append($('<option></option>').attr("value", respuesta[clave].itemId).text(respuesta[clave].nombre));
                        }
                        //municipioOpt.trigger('chosen:updated');
                    }
                    , 'json');
            }else{
                $('#calcom_parametroId').focus();
            }
        };

        var options = {
            beforeSubmit: showRequest
            , dataType: 'json'
            , success: showResponse
            , data: {
                accion: '{/literal}{$subcontrol}_itemupdatesqlCalidadCompuesto{literal}'
                ,itemId: idficha
                ,type: type
            }
        };

        var handle_form_submit = function () {
            form_calidad_compuesto.ajaxForm(options);
        };

        var handle_general_form_submit = function () {
            btn_calidad_compuesto_submit.click(function (e) {
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
                
                form_calidad_compuesto.submit();
            });
        };

        var handle_general_components = function () {
            $('#cal_fecha_muestreo').datepicker({
                todayHighlight: true,
                orientation: "bottom left",
                format: 'dd/mm/yyyy',
                templates: {
                    leftArrow: '<i class="la la-angle-left"></i>',
                    rightArrow: '<i class="la la-angle-right"></i>'
                }
            });

            $('.select2').select2({
                placeholder: "Seleccione una opción",
                dropdownParent: $("#modal_window_compuesto")
            });

            $('.summernote').summernote({
                height: 150
            });
        };

        var handle_get_components = function() {
            campo_input_calidad_compuesto.keyup(function () {
                form_calidad_compuesto.validate();
            });

            select_get_parametro.change(function() {
                get_compuesto($('#calcom_parametroId').val());
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
            }
        };
    } ();

    $('#calcom_valor').number(true, 6, '.');
    $('#calcom_valor').mask('999.999999');

//----------------Permisos--------------------------------------------

    function permisos_usuario(){
        var idUsuarioResponsable = parseInt($('#idUsuarioResponsable').val());
        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=obtenerPermisos&perpozo=manantial', //&perpozo=pozo
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            //dataType: "json",
            success: function(data){
                obj_permiso = JSON.parse(data);

                // if (obj_permiso[0].crear == 1){                                
                //     $("#btn_calidad_compuesto_submit").show();
                // }else{
                //     $("#btn_calidad_compuesto_submit").hide();
                // }

                switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#btn_calidad_compuesto_submit").show();
                        }else{
                            $("#btn_calidad_compuesto_submit").hide();
                        }
                        break;
                    case 3:
                        $("#btn_calidad_compuesto_submit").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                            $("#btn_calidad_compuesto_submit").show();
                        }else{
                            $("#btn_calidad_compuesto_submit").hide();
                        }
                        break;
                }
            },
        });
    }

    //== Class Initialization
    jQuery(document).ready(function () {
        permisos_usuario();
        snippet_form_calidad_compuesto.init();
        $('[data-toggle="m-tooltip"]').click().tooltip();
    });

</script>
{/literal}