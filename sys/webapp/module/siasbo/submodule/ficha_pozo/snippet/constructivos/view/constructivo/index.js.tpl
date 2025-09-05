{literal}
    <script>
        function get_diseno(id) {
            var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemGrillaDiseno{literal}&pozoId="+id;

            $.get(url, function(respuesta) {
                $('#modal_content_list_diseno').html(respuesta);
                $('#modal_window_diseno').modal("show");
            });
        }

        var snippet_form_constructivo = function() {
            var idficha = '{/literal}{$pozoCod}{literal}';
            var type = '{/literal}{$type}{literal}';
            var form_constructivo = $('#form_constructivo');
            var btn_constructivo_submit = $('#btn_constructivo_submit');

            var campo_input = $('input');

            //== Private Functions
            var showRequest = function(formData, jqForm, op) {
                btn_constructivo_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
                return true;
            };

            var showResponse = function(responseText, statusText) {
                btn_constructivo_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled',
                    false);
                if (responseText.res == 1) {
                    if (responseText.accion == 'new') {
                        //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                        //$("#form_constructivo")[0].reset();
                        swal("Creado!", "Se guardó el registro con éxito!", "success");
                    } else if (responseText.accion == 'update') {
                        swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                        //swal({type: 'success',title: 'Actualizado! Se actualizó todo con éxito!',showConfirmButton: false, timer: 1000});
                    } else {
                        location = "{/literal}{$getModule}{literal}";
                    }
                } else if (responseText.res == 2) {
                    swal("Ocurrio un error!", responseText.msg, "error")
                } else {
                    swal("ocurrio un error!", responseText.msg, "danger")
                }
            };

            var options = {
                beforeSubmit: showRequest,
                dataType: 'json',
                success: showResponse,
                data: {
                    accion:'{/literal}{$subcontrol}_itemupdatesql{literal}'
                    ,
                    itemId: idficha,
                    type: type

                }
            };

            var handle_form_submit = function() {
                form_constructivo.ajaxForm(options);
            };

            var handle_general_form_submit = function() {

                btn_constructivo_submit.click(function(e) {
                    e.preventDefault();
                    var btn = $(this);
                    var form = $(this).closest('form');

                    form.validate({
                        rules: {
                            "item[nombre]": {
                                required: true,
                                minlength: 3
                            },
                            "item[categoria_id]": {
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
                    $('#descripcion_input').val($('#descripcion').summernote('code'));
                    form_constructivo.submit();
                });
            };

            var handle_general_components = function() {
                $('.fecha_general').datepicker({
                    todayHighlight: true,
                    orientation: "bottom left",
                    format: 'dd/mm/yyyy',
                    templates: {
                        leftArrow: '<i class="la la-angle-left"></i>',
                        rightArrow: '<i class="la la-angle-right"></i>'
                    }
                });

                $('.select2').select2({
                    placeholder: "Seleccione una opción"
                });

                $('.summernote').summernote({
                    height: 150
                });
            };

            campo_input.focusout(function() {
                //general_form.validate();
                form_constructivo.validate();
            });

            //== Public Functions
            return {
                // public functions
                init: function() {
                    handle_general_form_submit();
                    handle_form_submit();
                    handle_general_components();
                }
            };
        }();

        $('#constructivo_entubado').number(true, 2, '.');
        $('#constructivo_entubado').mask('999.99');

        $('#constructivo_entubado_diametro').number(true, 2, '.');
        $('#constructivo_entubado_diametro').mask('99.99');

        $('#constructivo_altura').on('input', function() {
            let val = $(this).val();

            // Permitir solo caracteres numéricos válidos
            if (!/^[-\d.]*$/.test(val)) {
                $(this).val(val.slice(0, -1));
                return;
            }

            // Separar parte entera y decimal
            let isNegative = val.startsWith('-');
            let parts = val.replace('-', '').split('.');
            let intPart = parts[0];
            let decPart = parts[1] || '';

            // Limitar parte entera a 3 dígitos
            if (intPart.length > 3) {
                intPart = intPart.substring(0, 3);
            }

            // Limitar parte decimal a 2 dígitos
            if (decPart.length > 2) {
                decPart = decPart.substring(0, 2);
            }

            // Reconstruir valor válido
            let newVal = (isNegative ? '-' : '') + intPart;
            if (val.includes('.')) {
                newVal += '.' + decPart;
            }

            // Validar rango
            let num = parseFloat(newVal);
            if (!isNaN(num) && (num < -999.99 || num > 999.99)) {
                return; // no actualizar si se pasa del rango
            }

            $(this).val(newVal);
        });

        // $('#constructivo_diametro').number(true, 2, '.');
        // $('#constructivo_diametro').mask('99.99');

        //------------------------Permisos----------------------------------

        function permisos_usuario() { //Hacemos una llamada al controlador del snippet index
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
                    //alert(data);
                    obj_permiso = JSON.parse(data);

                    // if (obj_permiso[0].crear == 1) {
                    //     $("#btn_constructivo_submit").show();
                    // } else {
                    //     $("#btn_constructivo_submit").hide();
                    // }

                    switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#btn_constructivo_submit").show();
                        }else{
                            $("#btn_constructivo_submit").hide();
                        }
                        break;
                    case 3:
                        $("#btn_constructivo_submit").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                            $("#btn_constructivo_submit").show();
                        }else{
                            $("#btn_constructivo_submit").hide();
                        }
                        break;
                }
                },
            });
        }

        //== Class Initialization
        jQuery(document).ready(function() {
            permisos_usuario();
            snippet_form_constructivo.init();
            $('[data-toggle="m-tooltip"]').click().tooltip();
        });
    </script>
{/literal}