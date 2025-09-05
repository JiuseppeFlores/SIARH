{literal}
    <script>
        var snippet_form_prueba = function() {
            var idficha = '{/literal}{$id}{literal}';
            var type = '{/literal}{$type}{literal}';
            var form_prueba = $('#form_prueba');
            var btn_prueba_submit = $('#btn_prueba_submit');

            var campo_input_prueba = $('#form_prueba input');
            var btn_modal_close = $('#btn_modal_close');
            //== Private Functions
            var showRequest = function(formData, jqForm, op) {
                btn_prueba_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
                return true;
            };

            var showResponse = function(responseText, statusText) {
                btn_prueba_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
                if (responseText.res == 1) {
                    if (responseText.accion == 'new') {
                        //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                        $("#modal_window").modal("hide");
                        swal("Creado!", "Se guardó el registro con éxito!", "success");
                        table_list_prueba.draw();
                    } else if (responseText.accion == 'update') {
                        $("#modal_window").modal("hide");
                        swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                        table_list_prueba.draw();
                        //swal({type: 'success',title: 'Actualizado! Se actualizó todo con éxito!',showConfirmButton: false, timer: 1000});
                    } else {
                        $("#modal_window").modal("hide");
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
                    accion: '{/literal}{$subcontrol}_itemupdatesqlPrueba{literal}'
                    ,
                    itemId: idficha,
                    type: type
                }
            };

            var handle_form_submit = function() {
                form_prueba.ajaxForm(options);
            };

            var handle_general_form_submit = function() {

                btn_prueba_submit.click(function(e) {
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

                    form_prueba.submit();
                });
            };

            var handle_general_components = function() {
                $('#bp_fecha').datepicker({
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
                    placeholder: "Seleccione una opción"
                });

                $('.summernote').summernote({
                    height: 150
                });
            };

            var handle_get_components = function() {
                campo_input_prueba.keyup(function() {
                    form_prueba.validate();
                });

                btn_modal_close.click(function() {
                    swal({type: 'success', title: 'Cerrando!', showConfirmButton: false, timer: 300});
                });
            };

            //== Public Functions
            return {
                // public functions
                init: function() {
                    handle_general_form_submit();
                    handle_form_submit();
                    handle_general_components();
                    handle_get_components();
                }
            };
        }();

        $('#bp_conductividad').number(true, 6, '.');
        $('#bp_conductividad').mask('999999.999999');

        $('#bp_transmisividad').number(true, 6, '.');
        $('#bp_transmisividad').mask('999999.999999');

        $('#bp_coeficiente').number(true, 6, '.');
        $('#bp_coeficiente').mask('99.999999');

        $('#bp_radio').number(true, 2, '.');
        $('#bp_radio').mask('99.99');

        // $('#bp_porosidad').number(true, 2, '.');
        // $('#bp_porosidad').mask('99.99');

        $('#bp_porosidad').on('input', function() {
            let val = $(this).val();

            // Permitir solo dígitos y un punto decimal
            if (!/^\d*\.?\d*$/.test(val)) {
                $(this).val(val.slice(0, -1));
                return;
            }

            // Convertir a número
            let num = parseFloat(val);

            // Validar que esté dentro del rango permitido
            if (!isNaN(num)) {
                if (num > 100) {
                    $(this).val('100');
                } else if (num !== 0 && num < 0.00001) {
                    $(this).val('0.00001');
                }
            }
        });

        //----------------Permisos--------------------------------------------

        function permisos_usuario() {
            var idUsuarioResponsable = parseInt($('#idUsuarioResponsable').val());
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

                    // if (obj_permiso[0].crear == 1) {
                    //     $("#btn_prueba_submit").show();
                    // } else {
                    //     $("#btn_prueba_submit").hide();
                    // }

                    switch (parseInt(obj_permiso[0].tipoUsuario)) {
                        case 2:
                            if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                                $("#btn_prueba_submit").show();
                            }else{
                                $("#btn_prueba_submit").hide();
                            }
                            break;
                        case 3:
                            $("#btn_prueba_submit").hide();
                            break;
                        default:
                            if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                                $("#btn_prueba_submit").show();
                            }else{
                                $("#btn_prueba_submit").hide();
                            }
                            break;
                    }
                },
            });
        }

        //== Class Initialization
        jQuery(document).ready(function() {
            permisos_usuario();
            snippet_form_prueba.init();
            $('[data-toggle="m-tooltip"]').click().tooltip();
        });
    </script>
{/literal}