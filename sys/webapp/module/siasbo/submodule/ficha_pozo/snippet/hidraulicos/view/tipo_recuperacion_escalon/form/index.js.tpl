{literal}
<script>
    var snippet_form_recupera_escalon = function () {
        var idficha = '{/literal}{$id}{literal}';
        var type = '{/literal}{$type}{literal}';
        var form_recupera_escalon = $('#form_recupera_escalon');
        var btn_recupera_escalon_submit = $('#btn_recupera_escalon_submit');

        var campo_input_recupera_escalon = $('#form_recupera_escalon input');
        
        //== Private Functions
        var showRequest= function (formData, jqForm, op) {
            btn_recupera_escalon_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
            return true;
        };

        var showResponse = function (responseText, statusText) {
            btn_recupera_escalon_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
            if(responseText.res ==1) {
                if(responseText.accion == 'new') {
                    //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                    swal("Creado!", "Se guardó el registro con éxito!", "success");
                    table_list_recupera_escalon.draw();
                    $("#modal_window_escalon").modal("hide");
                } else if(responseText.accion == 'update') {
                    swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                    table_list_recupera_escalon.draw();
                    $("#modal_window_escalon").modal("hide");
                    //swal({type: 'success',title: 'Actualizado! Se actualizó todo con éxito!',showConfirmButton: false, timer: 1000});
                } else {
                    $("#modal_window_escalon").modal("hide");
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
                accion: '{/literal}{$subcontrol}_itemupdatesqlRecuperaEscalon{literal}'
                ,itemId: idficha
                ,type: type
            }
        };

        var handle_form_submit = function () {
            form_recupera_escalon.ajaxForm(options);
        };

        var handle_general_form_submit = function () {
            btn_recupera_escalon_submit.click(function (e) {
                e.preventDefault();
                var btn = $(this);
                var form = $(this).closest('form');

                form.validate({
                    rules: {
                        "item[horas]": {
                            required: true,
                            minlength: 0
                        },
                        "item[minutos]": {
                            required: true,
                            minlength: 0
                        },
                        "item[segundos]": {
                            required: true,
                            minlength: 0
                        },
                        "item[nivel_dinamico]": {
                            required: true,
                            minlength: 0
                        },
                    }
                });

                if (!form.valid()) {
                    return;
                }
                
                form_recupera_escalon.submit();
            });
        };

        var handle_general_components = function () {
            $('#tbp_fecha').datepicker({
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

        var handle_get_components = function() {
            campo_input_recupera_escalon.keyup(function () {
                form_recupera_escalon.validate();
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

    $('#tbp_hora').number(true, 0, '.');
    $('#tbp_hora').mask('99');

    $('#tbp_minuto').number(true, 0, '.');
    $('#tbp_minuto').mask('99');

    $('#tbp_segundo').number(true, 2, '.');
    $('#tbp_segundo').mask('99.99');

    $('#tbp_nivel_dinamico').number(true, 2, '.');
    $('#tbp_nivel_dinamico').mask('999.99');

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
                //     $("#btn_recupera_escalon_submit").show();
                // }else{
                //     $("#btn_recupera_escalon_submit").hide();
                // }   
                
                switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#btn_recupera_escalon_submit").show();
                        }else{
                            $("#btn_recupera_escalon_submit").hide();
                        }
                        break;
                    case 3:
                        $("#btn_recupera_escalon_submit").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                            $("#btn_recupera_escalon_submit").show();
                        }else{
                            $("#btn_recupera_escalon_submit").hide();
                        }
                        break;
                }
            },
        });
    }

    //== Class Initialization
    jQuery(document).ready(function () {
        permisos_usuario();
        snippet_form_recupera_escalon.init();
        $('[data-toggle="m-tooltip"]').click().tooltip();
    });

</script>
{/literal}