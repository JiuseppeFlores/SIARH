{literal}
<script>
    var snippet_form_archivo = function () {
        var idficha = '{/literal}{$id}{literal}';
        var type = '{/literal}{$type}{literal}';
        var form_archivo = $('#form_archivo');
        var btn_archivo_submit = $('#btn_archivo_submit');
        var campo_input_archivo = $('#form_archivo input');
        
        var btn_modal_close = $('#btn_modal_close');

        //== Private Functions
        var showRequest= function (formData, jqForm, op) {
            btn_archivo_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
            return true;
        };

        var showResponse = function (responseText, statusText) {
            btn_archivo_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
            if(responseText.res ==1) {
                if(responseText.accion == 'new') {
                    $("#modal_window").modal("hide");
                    swal("Creado!", "Se guardó el registro con éxito!", "success");
                    table_list_archivo.draw();
                } else if(responseText.accion == 'update') {
                    $("#modal_window").modal("hide");
                    swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                    table_list_archivo.draw();
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
                accion: '{/literal}{$subcontrol}_itemupdatesql{literal}'
                ,itemId: idficha
                ,type: type
            }
        };

        var handle_form_submit = function () {
            form_archivo.ajaxForm(options);
        };

        var handle_general_form_submit = function () {

            btn_archivo_submit.click(function (e) {
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
                
                form_archivo.submit();
            });
        };

        var handle_general_components = function () {
            $('#adj_fecha').datepicker({
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
                placeholder: "Seleccione una opción",
                dropdownParent: $("#modal_window")
            });
            
            $('.summernote').summernote({
                height: 150
            });
        };

        var handle_get_components = function() {
            campo_input_archivo.keyup(function () {
                form_archivo.validate();
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
                //     $("#btn_archivo_submit").show();
                // }else{
                //     $("#btn_archivo_submit").hide();
                // }       
                
                switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#btn_archivo_submit").show();
                        }else{
                            $("#btn_archivo_submit").hide();
                        }
                        break;
                    case 3:
                        $("#btn_archivo_submit").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                            $("#btn_archivo_submit").show();
                        }else{
                            $("#btn_archivo_submit").hide();
                        }
                        break;
                }
            },
        });
    }

    //== Class Initialization
    jQuery(document).ready(function () {
        permisos_usuario();
        snippet_form_archivo.init();
    });

</script>
{/literal}