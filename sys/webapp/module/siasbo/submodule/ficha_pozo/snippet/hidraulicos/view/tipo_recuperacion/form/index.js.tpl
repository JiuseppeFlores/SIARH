{literal}
<script>
    var snippet_form_recuperacion = function () {
        var idficha = '{/literal}{$id}{literal}';
        var type = '{/literal}{$type}{literal}';
        var form_recuperacion = $('#form_recuperacion');
        var btn_recuperacion_submit = $('#btn_recuperacion_submit');

        var campo_input_recuperacion = $('#form_recuperacion input');
        
        //== Private Functions
        var showRequest= function (formData, jqForm, op) {
            btn_recuperacion_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
            return true;
        };

        var showResponse = function (responseText, statusText) {
            btn_recuperacion_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
            if(responseText.res ==1) {
                if(responseText.accion == 'new') {
                    //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                    swal("Creado!", "Se guardó el registro con éxito!", "success");
                    table_list_recuperacion.draw();
                    $("#modal_window").modal("hide");
                } else if(responseText.accion == 'update') {
                    swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                    table_list_recuperacion.draw();
                    $("#modal_window").modal("hide");
                    //swal({type: 'success',title: 'Actualizado! Se actualizó todo con éxito!',showConfirmButton: false, timer: 1000});
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
                accion: '{/literal}{$subcontrol}_itemupdatesqlRecuperacion{literal}'
                ,itemId: idficha
                ,type: type
            }
        };

        var handle_form_submit = function () {
            form_recuperacion.ajaxForm(options);
        };

        var handle_general_form_submit = function () {
            btn_recuperacion_submit.click(function (e) {
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
                
                form_recuperacion.submit();
            });
        };

        var handle_general_components = function () {
            $('#pr_fecha').datepicker({
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
            campo_input_recuperacion.keyup(function () {
                form_recuperacion.validate();
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

    $('#pr_nivel_estatico').number(true, 2, '.');
    $('#pr_nivel_estatico').mask('99.99');

    $('#pr_nivel_dinamico_final').number(true, 2, '.');
    $('#pr_nivel_dinamico_final').mask('99.99');

    $('#pr_horas').number(true, 0, '.');
    $('#pr_horas').mask('99');

    $('#pr_minutos').number(true, 0, '.');
    $('#pr_minutos').mask('99');

    $('#pr_segundos').number(true, 2, '.');
    $('#pr_segundos').mask('99.99');

//----------------Permisos--------------------------------------------

    function permisos_usuario(){
        var idUsuarioResponsable = parseInt($('#idUsuarioResponsable').val());
        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=obtenerPermisos&perpozo=pozo', //&perpozo=pozo
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            //dataType: "json",
            success: function(data){
                obj_permiso = JSON.parse(data);

                // if (obj_permiso[0].crear == 1){                                
                //     $("#btn_recuperacion_submit").show();
                // }else{
                //     $("#btn_recuperacion_submit").hide();
                // }    
                
                switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#btn_recuperacion_submit").show();
                        }else{
                            $("#btn_recuperacion_submit").hide();
                        }
                        break;
                    case 3:
                        $("#btn_recuperacion_submit").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                            $("#btn_recuperacion_submit").show();
                        }else{
                            $("#btn_recuperacion_submit").hide();
                        }
                        break;
                }
            },
        });
    }

    //== Class Initialization
    jQuery(document).ready(function () {
        permisos_usuario();
        snippet_form_recuperacion.init();
        $('#campo_caudal').hide();
        $('[data-toggle="m-tooltip"]').click().tooltip();
    });

</script>
{/literal}