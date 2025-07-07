{literal}
    <script>
        var snippet_form_litologico = function() {
            var idficha = '{/literal}{$id}{literal}';
            var type = '{/literal}{$type}{literal}';
            var form_litologico = $('#form_litologico');
            var btn_litologico_submit = $('#btn_litologico_submit');

            var campo_input_litologico = $('#form_litologico input');

            //== Private Functions
            var showRequest = function(formData, jqForm, op) {
                btn_litologico_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
                return true;
            };

            var showResponse = function(responseText, statusText) {
                btn_litologico_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled',
                    false);
                if (responseText.res == 1) {
                    if (responseText.accion == 'new') {
                        //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                        $("#modal_window_litologico").modal("hide");
                        swal("Creado!", "Se guardó el registro con éxito!", "success");
                        table_list_litologico.draw();
                    } else if (responseText.accion == 'update') {
                        $("#modal_window_litologico").modal("hide");
                        swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                        table_list_litologico.draw();
                        //swal({type: 'success',title: 'Actualizado! Se actualizó todo con éxito!',showConfirmButton: false, timer: 1000});
                    } else {
                        $("#modal_window_litologico").modal("hide");
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
                    accion: '{/literal}{$subcontrol}_itemupdatesql{literal}'
                    ,
                    itemId: idficha,
                    type: type
                }
            };

            var handle_form_submit = function() {
                form_litologico.ajaxForm(options);
            };

            var handle_general_form_submit = function() {

                btn_litologico_submit.click(function(e) {
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

                    if (calcular_porcentaje() == true) {
                        form_litologico.submit();
                    } else {
                        swal("Alerta!", "La suma de los porcentajes debe ser igual a 100", "warning");
                    }

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

                $('.select2').select2({
                    placeholder: "Seleccione una opción",
                    //dropdownParent: $("#modal_window_litologico")
                });

                $('.summernote').summernote({
                    height: 150
                });
            };

            function calcular_porcentaje() {
                var p1 = Number($('#porcentaje1').val());
                var p2 = Number($('#porcentaje2').val());
                var p3 = Number($('#porcentaje3').val());
                var p4 = Number($('#porcentaje4').val());
                var pt = 0;
                pt = p1 + p2 + p3 + p4;

                if (pt == 100) {
                    return true;
                } else {
                    return false;
                }
            };

            campo_input_litologico.focusout(function() {
                form_litologico.validate();
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

        $('#profundidad_desde').number(true, 2, '.');
        $('#profundidad_desde').mask('999.99');

        $('#profundidad_hasta').number(true, 2, '.');
        $('#profundidad_hasta').mask('999.99');

        $('#porcentaje1').number(true, 2, '.');
        $('#porcentaje1').mask('999.99');

        $('#porcentaje2').number(true, 2, '.');
        $('#porcentaje2').mask('999.99');

        $('#porcentaje3').number(true, 2, '.');
        $('#porcentaje3').mask('999.99');

        $('#porcentaje4').number(true, 2, '.');
        $('#porcentaje4').mask('999.99');

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
                        $("#btn_litologico_submit").show();
                    } else {
                        $("#btn_litologico_submit").hide();
                    }
                },
            });
        }

        //== Class Initialization
        jQuery(document).ready(function() {
            snippet_form_litologico.init();
            $('[data-toggle="m-tooltip"]').click().tooltip();
        });
    </script>
{/literal}