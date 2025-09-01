{literal}
<script>
    var snippet_form_tomografia = function () {
        var idficha = '{/literal}{$id}{literal}';
        var type = '{/literal}{$type}{literal}';
        var form_tomografia = $('#form_tomografia');
        var btn_tomografia_submit = $('#btn_tomografia_submit');

        var campo_input_tomografia = $('#form_tomografia input');
        
        //== Private Functions
        var showRequest= function (formData, jqForm, op) {
            btn_tomografia_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
            return true;
        };

        var showResponse = function (responseText, statusText) {
            btn_tomografia_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
            if(responseText.res ==1) {
                if(responseText.accion == 'new') {
                    //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                    $("#modal_window_tomografia").modal("hide");
                    swal("Creado!", "Se guardó el registro con éxito!", "success");
                    table_list_tomografia.draw();
                } else if(responseText.accion == 'update') {
                    $("#modal_window_tomografia").modal("hide");
                    swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                    table_list_tomografia.draw();
                    //swal({type: 'success',title: 'Actualizado! Se actualizó todo con éxito!',showConfirmButton: false, timer: 1000});
                } else {
                    $("#modal_window_tomografia").modal("hide");
                }
            } else if(responseText.res ==2) {
                swal("Ocurrio un error!", responseText.msg, "error");
            } else {
                swal("ocurrio un error!", responseText.msg, "danger");
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
            form_tomografia.ajaxForm(options);
        };

        var handle_general_form_submit = function () {

            btn_tomografia_submit.click(function (e) {
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
                
                form_tomografia.submit();
            });
        };

        var handle_general_components = function () {
            $('#fecha').datepicker({
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

        var handle_get_components = function () {
            campo_input_tomografia.keyup(function () {
                form_tomografia.validate();
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

    $('#latitudUtm').number(true, 3, '.');
    $('#latitudUtm').mask('999999.999');

    $('#longitudUtm').number(true, 3, '.');
    $('#longitudUtm').mask('9999999.999');

    $('#sev_azimut').number(true, 2, '.');
    $('#sev_azimut').mask('999.99');

    $('#distancia').number(true, 2, '.');
    $('#distancia').mask('9999.99');

    $('#tomografia_electrodos').number(true, 0, '.');
    $('#tomografia_electrodos').mask('999');

    $('#tomografia_abertura').number(true, 2, '.');
    $('#tomografia_abertura').mask('999.99');

    $('#tomografia_abertura_remoto').number(true, 2, '.');
    $('#tomografia_abertura_remoto').mask('999.99');

    $('#sev_error').number(true, 2, '.');
    $('#sev_error').mask('999.99');

//----------------Permisos--------------------------------------------

    function permisos_usuario(){
        var idUsuarioResponsable = parseInt($('#idUsuarioResponsable').val());
        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=obtenerPermisos&perpozo=geofisica', //&perpozo=pozo
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            //dataType: "json",
            success: function(data){
                obj_permiso = JSON.parse(data);

                // if (obj_permiso[0].crear == 1){                                
                //     $("#btn_tomografia_submit").show();
                // }else{
                //     $("#btn_tomografia_submit").hide();
                // }

                switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#btn_tomografia_submit").show();
                        }else{
                            $("#btn_tomografia_submit").hide();
                        }
                        break;
                    case 3:
                        $("#btn_tomografia_submit").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                            $("#btn_tomografia_submit").show();
                        }else{
                            $("#btn_tomografia_submit").hide();
                        }
                        break;
                }
            },
        });
    }

    //== Class Initialization
    jQuery(document).ready(function () {
        permisos_usuario();
        snippet_form_tomografia.init();
        $('[data-toggle="tooltip"]').click().tooltip();
    });

</script>
{/literal}