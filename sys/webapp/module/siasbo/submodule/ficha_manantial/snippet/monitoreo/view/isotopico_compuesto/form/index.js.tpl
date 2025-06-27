{literal}
<script>
    var snippet_form_isotopico_compuesto = function () {
        var idficha = '{/literal}{$id}{literal}';
        var type = '{/literal}{$type}{literal}';
        var form_isotopico_compuesto = $('#form_isotopico_compuesto');
        var btn_isotopico_compuesto_submit = $('#btn_isotopico_compuesto_submit');
        var select_get_parametro_iso = $('#isocom_isotoparametroId');
        var campo_input_isotopico_compuesto = $('#form_isotopico_compuesto input');

        var btn_modal_close = $('#btn_modal_close');
        //== Private Functions
        var showRequest= function (formData, jqForm, op) {
            btn_isotopico_compuesto_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
            return true;
        };

        var showResponse = function (responseText, statusText) {
            btn_isotopico_compuesto_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
            if(responseText.res ==1) {
                if(responseText.accion == 'new') {
                    //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                    swal("Creado!", "Se guardó el registro con éxito!", "success");
                    table_list_isotopico_compuesto.draw();
                    $("#modal_window_compuesto").modal("hide");
                } else if(responseText.accion == 'update') {
                    swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                    table_list_isotopico_compuesto.draw();
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
            var compuestoOpt = $('#isocom_isotocompuestoId').empty();
            if(id!="") {
                $.post("{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getIsotopicoCompuesto{literal}"
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
                $('#isocom_isotoparametroId').focus();
            }
        };

        var options = {
            beforeSubmit: showRequest
            , dataType: 'json'
            , success: showResponse
            , data: {
                accion: '{/literal}{$subcontrol}_itemupdatesqlIsotopicoCompuesto{literal}'
                ,itemId: idficha
                ,type: type
            }
        };

        var handle_form_submit = function () {
            form_isotopico_compuesto.ajaxForm(options);
        };

        var handle_general_form_submit = function () {
            btn_isotopico_compuesto_submit.click(function (e) {
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
                
                form_isotopico_compuesto.submit();
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
            campo_input_isotopico_compuesto.keyup(function () {
                form_isotopico_compuesto.validate();
            });

            select_get_parametro_iso.change(function() {
                get_compuesto($('#isocom_isotoparametroId').val());
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

    $('#isocom_valor').number(true, 6, '.');
    $('#isocom_valor').mask('999.999999');

//----------------Permisos--------------------------------------------

    function permisos_usuario(){
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

                if (obj_permiso[0].crear == 1){                                
                    $("#btn_isotopico_compuesto_submit").show();
                }else{
                    $("#btn_isotopico_compuesto_submit").hide();
                }                 
            },
        });
    }

    //== Class Initialization
    jQuery(document).ready(function () {
        permisos_usuario();
        snippet_form_isotopico_compuesto.init();
        $('[data-toggle="m-tooltip"]').click().tooltip();
    });

</script>
{/literal}