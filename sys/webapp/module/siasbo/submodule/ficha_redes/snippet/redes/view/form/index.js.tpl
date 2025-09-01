{literal}
    <script>
        var snippet_form_seguimiento = function() {
            var idficha = '{/literal}{$id}{literal}';
            var type = '{/literal}{$type}{literal}';
            var form_seguimiento = $('#form_seguimiento');
            var btn_seguimiento_submit = $('#btn_seguimiento_submit');

            var campo_input_seguimiento = $('#form_seguimiento input');

            //== Private Functions
            var showRequest = function(formData, jqForm, op) {
                btn_seguimiento_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
                return true;
            };

            var showResponse = function(responseText, statusText) {
                btn_seguimiento_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled',
                    false);
                if (responseText.res == 1) {
                    if (responseText.accion == 'new') {
                        //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                        $("#modal_window_seguimiento").modal("hide");
                        swal("Creado!", "Se guardó el registro con éxito!", "success");
                        table_list_seguimiento.draw();
                    } else if (responseText.accion == 'update') {
                        $("#modal_window_seguimiento").modal("hide");
                        swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                        table_list_seguimiento.draw();
                        //swal({type: 'success',title: 'Actualizado! Se actualizó todo con éxito!',showConfirmButton: false, timer: 1000});
                    } else {
                        $("#modal_window_seguimiento").modal("hide");
                    }
                } else if (responseText.res == 2) {
                    swal("Ocurrió un error!", responseText.msg, "error");
                } else {
                    swal("ocurrió un error!", responseText.msg, "danger");
                }
            };

            var options = {
                beforeSubmit: showRequest,
                dataType: 'json',
                success: showResponse,
                data: {
                    accion: '{/literal}{$subcontrol}_itemupdatesql{literal}',
                    itemId: idficha,
                    type: type
                }
            };

            var handle_form_submit = function() {
                form_seguimiento.ajaxForm(options);
            };

            var handle_general_form_submit = function() {

                btn_seguimiento_submit.click(function(e) {
                    // console.log("btn_seguimiento_submit clicked");
                    
                    e.preventDefault();
                    var btn = $(this);
                    var form = $(this).closest('form');
                    form.validate({
                        rules: {
                            "item[estadoOperativo]": {
                                required: true,
                                minlength: 3
                            },
                            "item[proveedorEnergia]": {
                                required: true,
                                minlength: 1
                            },
                            "item[fecha]": {
                                required: true,
                                minlength: 3
                            },
                            "item[hora]": {
                                required: true,
                                minlength: 5
                            },
                        }
                    });

                    if (!form.valid()) {
                        return;
                    }

                    // console.log("form is valid, submitting...",form_seguimiento);
                    form_seguimiento.submit();

                });
            };

            var handle_general_components = function() {
                $('#fecha').datepicker({
                    todayHighlight: true,
                    orientation: "bottom left",
                    format: 'dd/mm/yyyy',
                    templates: {
                        leftArrow: '<i class="la la-angle-left"></i>',
                        rightArrow: '<i class="la la-angle-right"></i>'
                    }
                });

                $("#hora").timepicker({
                    minuteStep: 1,
                    format: 'HH:mm',
                    //showSeconds:!0,
                    showMeridian: 0
                });

                $('.select2').select2({
                    placeholder: "Seleccione una opción",
                    //dropdownParent: $("#modal_window_seguimiento")
                });

                $('.summernote').summernote({
                    height: 150
                });
            };

            campo_input_seguimiento.focusout(function() {
                form_seguimiento.validate();
            });

            //== Public Functions
            return {
                // public functions
                init: function() {
                    handle_general_form_submit();
                    handle_form_submit();
                    handle_general_components();
                    //calcular_porcentaje();
                }
            };
        }();

        //----------------Permisos--------------------------------------------

        function permisos_usuario() {
            jQuery.ajax({
                url: '{/literal}{$getModule}{literal}&accion=obtenerPermisos&perpozo=pozo', //&perpozo=pozo
                //data: data,
                cache: false,
                contentType: false,
                processData: false,
                type: 'POST',
                //dataType: "json",
                success: function(data) {
                    obj_permiso = JSON.parse(data);

                    if (obj_permiso[0].crear == 1) {
                        $("#btn_seguimiento_submit").show();
                    } else {
                        $("#btn_seguimiento_submit").hide();
                    }
                },
            });
        }

        //== Class Initialization
        jQuery(document).ready(function() {
            snippet_form_seguimiento.init();
            $('[data-toggle="m-tooltip"]').click().tooltip();
        });
    </script>
{/literal}