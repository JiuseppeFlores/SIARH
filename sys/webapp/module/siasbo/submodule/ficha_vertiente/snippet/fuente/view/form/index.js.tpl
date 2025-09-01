{literal}
    <script>
        var snippet_form_fuente = function() {
            var idficha = '{/literal}{$id}{literal}';
            var type = '{/literal}{$type}{literal}';
            var form_fuente = $('#form_fuente');
            var btn_fuente_submit = $('#btn_fuente_submit');

            var campo_input_fuente = $('#form_fuente input');

            //== Private Functions
            var showRequest = function(formData, jqForm, op) {
                btn_fuente_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
                return true;
            };

            var showResponse = function(responseText, statusText) {
                btn_fuente_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled',
                    false);
                if (responseText.res == 1) {
                    if (responseText.accion == 'new') {
                        //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                        $("#modal_window_fuente").modal("hide");
                        swal("Creado!", "Se guardó el registro con éxito!", "success");
                        table_list_fuente.draw();
                    } else if (responseText.accion == 'update') {
                        $("#modal_window_fuente").modal("hide");
                        swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                        table_list_fuente.draw();
                        //swal({type: 'success',title: 'Actualizado! Se actualizó todo con éxito!',showConfirmButton: false, timer: 1000});
                    } else {
                        $("#modal_window_fuente").modal("hide");
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
                form_fuente.ajaxForm(options);
            };

            var handle_general_form_submit = function() {

                btn_fuente_submit.click(function(e) {
                    // console.log("btn_fuente_submit clicked");
                    
                    e.preventDefault();
                    var btn = $(this);
                    var form = $(this).closest('form');
                    form.validate({
                        rules: {
                            "item[fecha]": {
                                required: true,
                                minlength: 3
                            },
                            "item[hora]": {
                                required: true,
                                minlength: 5
                            }
                        }
                    });
                        // console.log("form.validate() called",form);
                    if (!form.valid()) {
                        // console.log("form is not valid, aborting submit",form.valid());
                        return;
                    }

                    // console.log("form is valid, submitting...",form_fuente);
                    form_fuente.submit();

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

                $('#fechaInstalacion').datepicker({
                    todayHighlight: true,
                    orientation: "bottom left",
                    format: 'dd/mm/yyyy',
                    templates: {
                        leftArrow: '<i class="la la-angle-left"></i>',
                        rightArrow: '<i class="la la-angle-right"></i>'
                    }
                });

                // $("#hora").timepicker({
                //     minuteStep: 1,       // Intervalo de minutos (1 minuto)
                //     showSeconds: false,  // No mostrar segundos
                //     showMeridian: false, // Formato 24 horas (sin AM/PM)
                //     defaultTime: false,  // No establecer hora por defecto
                //     format: 'HH:mm',     // Formato de 24 horas
                //     maxHours: 23,        // Máximo 23 horas
                //     explicitMode: true,  // Permite borrar manualmente el valor
                //     snapToStep: true     // Ajusta minutos al step definido
                // });

                $("#hora").timepicker({
                    minuteStep: 1,
                    format: 'HH:mm',
                    showMeridian: 0
                }).on('change', function () {
                    let val = $(this).val().trim();
                    if (val) {
                        let partes = val.split(':');
                        if (partes.length === 2) {
                            let hora = partes[0].padStart(2, '0'); // agrega el 0 si es de 1 dígito
                            let minutos = partes[1].padStart(2, '0'); // asegura que los minutos también tengan 2 dígitos
                            $(this).val(`${hora}:${minutos}`);
                        }
                    }
                });

            };

            campo_input_fuente.focusout(function() {
                form_fuente.validate();
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

        // $('#conexionesagua').number(true, 2, '.');
        // $('#conexionesagua').mask('99.99');

        $('#coberturaagua').number(true, 2, '.');
        $('#coberturaagua').mask('99.99');

        $('#numero').number(true, 2, '.');
        $('#numero').mask('99.99');

        // $('#caudal').number(true, 2, '.');
        // $('#caudal').mask('99.99');

        // $('#caudal').mask('0000.00', {reverse: true});
        // $('#caudal').on('blur', function () {
        //     const value = $(this).val();
        //     const regex = /^\d{1,4}(\.\d{1,2})?$/; // 1-4 enteros y hasta 2 decimales
        //     if (!regex.test(value)) {
        //         alert("Ingrese un valor con hasta 4 enteros y 2 decimales");
        //         $(this).val('');
        //     }
        // });

        $('#alturaAgua').on('input', function() {
            let value = $(this).val();
            // Expresión regular: hasta 4 enteros y hasta 2 decimales
            const regex = /^\d{0,4}(\.\d{0,2})?$/;
            if (!regex.test(value)) {
                // si el valor no coincide, se elimina el último carácter ingresado
                $(this).val(value.slice(0, -1));
            }
        });

        $('#alturaBorde').on('input', function() {
            let value = $(this).val();
            // Expresión regular: hasta 4 enteros y hasta 2 decimales
            const regex = /^\d{0,4}(\.\d{0,2})?$/;
            if (!regex.test(value)) {
                // si el valor no coincide, se elimina el último carácter ingresado
                $(this).val(value.slice(0, -1));
            }
        });

        $('#altura').on('input', function() {
            let value = $(this).val();
            // Expresión regular: hasta 4 enteros y hasta 2 decimales
            const regex = /^\d{0,4}(\.\d{0,2})?$/;
            if (!regex.test(value)) {
                // si el valor no coincide, se elimina el último carácter ingresado
                $(this).val(value.slice(0, -1));
            }
        });

        $('#caudal').on('input', function() {
            let value = $(this).val();
            // Expresión regular: hasta 4 enteros y hasta 2 decimales
            const regex = /^\d{0,4}(\.\d{0,2})?$/;
            if (!regex.test(value)) {
                // si el valor no coincide, se elimina el último carácter ingresado
                $(this).val(value.slice(0, -1));
            }
        });

        $('#velocidad').on('input', function() {
            let value = $(this).val();
            // Expresión regular: hasta 4 enteros y hasta 2 decimales
            const regex = /^\d{0,3}(\.\d{0,2})?$/;
            if (!regex.test(value)) {
                // si el valor no coincide, se elimina el último carácter ingresado
                $(this).val(value.slice(0, -1));
            }
        });
        $('#tirante').on('input', function() {
            let value = $(this).val();
            // Expresión regular: hasta 4 enteros y hasta 2 decimales
            const regex = /^\d{0,2}(\.\d{0,2})?$/;
            if (!regex.test(value)) {
                // si el valor no coincide, se elimina el último carácter ingresado
                $(this).val(value.slice(0, -1));
            }
        });

        $('#capacidad').number(true, 2, '.');
        $('#capacidad').mask('99.99');

        $('#red').number(true, 2, '.');
        $('#red').mask('99.99');

        $('#area').number(true, 2, '.');
        $('#area').mask('99.99');


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
                    // console.log('recuperando permisos de usuarios, registros::',obj_permiso[0]);
                    // if (obj_permiso[0].crear == 1) {
                    //     $("#btn_fuente_submit").show();
                    // } else {
                    //     $("#btn_fuente_submit").hide();
                    // }

                    switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#btn_fuente_submit").show();
                        }else{
                            $("#btn_fuente_submit").hide();
                        }
                        break;
                    case 3:
                        $("#btn_fuente_submit").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                            $("#btn_fuente_submit").show();
                        }else{
                            $("#btn_fuente_submit").hide();
                        }
                        break;
                }
                },
            });
        }

        //== Class Initialization
        jQuery(document).ready(function() {
            permisos_usuario();
            snippet_form_fuente.init();
            $('[data-toggle="m-tooltip"]').click().tooltip();
        });
    </script>
{/literal}