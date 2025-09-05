{literal}
<script>
    var snippet_form_diseno = function () {
        var idfichaCapa = '{/literal}{$id}{literal}';
        var typeCapa = '{/literal}{$type}{literal}';
        var form_diseno = $('#form_diseno');
        var btn_diseno_submit = $('#btn_diseno_submit');
        
        var campo_input = $('input');
        //== Private Functions
        var showRequest= function (formData, jqForm, op) {
            btn_diseno_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
            return true;
        };

        var showResponse = function (responseText, statusText) {
            btn_diseno_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
            if(responseText.res ==1) {
                if(responseText.accion == 'new') {
                    //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                    swal("Creado!", "Se guardó el registro con éxito!", "success");
                    $("#form_diseno")[0].reset();
                    table_list_diseno.draw();
                    show_modal_window_list_diseno();
                } else if(responseText.accion == 'update') {
                    swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                    $("#form_diseno")[0].reset();
                    table_list_diseno.draw();
                    show_modal_window_list_diseno();
                    //swal({type: 'success',title: 'Actualizado! Se actualizó todo con éxito!',showConfirmButton: false, timer: 1000});
                } else {
                    show_modal_window_list_diseno();
                }
            } else if(responseText.res == 2) {
                swal("Ocurrió un error!", responseText.msg, "error");
            } else if(responseText.res == 3) {
                swal("ocurrió un error!", "La <strong>profundidad desde</strong> y <strong>profundidad hasta</strong> ya existen en el sistema.", "error");
            } else if(responseText.res == 4) {
                swal("ocurrió un error!", "La <strong>profundidad hasta</strong> no debe sobrepasar los "+responseText.data+" metros (ver pestaña perforación).", "error");
            }
        };

        var options = {
            beforeSubmit: showRequest
            , dataType: 'json'
            , success: showResponse
            , data: {
                accion: '{/literal}{$subcontrol}_itemupdatesqlDiseno{literal}'
                ,itemId: idfichaCapa
                ,type: typeCapa
            }
        };

        var handle_form_submit = function () {
            form_diseno.ajaxForm(options);
        };

        var handle_general_form_submit = function () {

            btn_diseno_submit.click(function (e) {
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

                if (parseFloat($('#profundidad_desde').val()) >= parseFloat($('#profundidad_hasta').val())) {
                    swal("Advertencia", "La <strong>profundidad hasta</strong> debe ser mayor a la <strong>profundidad desde</strong>.", "error");
                    return;
                }

                if (!form.valid()) {
                    return;
                }

                form_diseno.submit();
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
                }
            });

            $('.select2').select2({
                placeholder: "Seleccione una opción",
                dropdownParent: $("#modal_window_diseno")
            });

            $('.summernote').summernote({
                height: 150
            });
        };

        campo_input.focusout(function () {
            //general_form.validate();
            form_diseno.validate();
        });

        //== Public Functions
        return {
            // public functions
            init: function () {
                handle_general_form_submit();
                handle_form_submit();
                handle_general_components();
            }
        };
    } ();

    //------------------------Permisos----------------------------------

    function permisos_usuario(){ //Hacemos una llamada al controlador del snippet index
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
                //alert(data);
                obj_permiso = JSON.parse(data);                           

                // if (obj_permiso[0].crear == 1){                                
                //     $("#btn_diseno_submit").show();
                // }else{
                //     $("#btn_diseno_submit").hide();
                // }     
                
                switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#btn_diseno_submit").show();
                        }else{
                            $("#btn_diseno_submit").hide();
                        }
                        break;
                    case 3:
                        $("#btn_diseno_submit").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                            $("#btn_diseno_submit").show();
                        }else{
                            $("#btn_diseno_submit").hide();
                        }
                        break;
                }
            },
        });
    }

    //== Class Initialization
    jQuery(document).ready(function () {
        permisos_usuario();
        snippet_form_diseno.init();
        $('[data-toggle="m-tooltip"]').click().tooltip();
    });
</script>
{/literal}