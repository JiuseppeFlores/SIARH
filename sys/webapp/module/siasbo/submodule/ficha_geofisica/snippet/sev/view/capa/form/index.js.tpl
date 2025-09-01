{literal}
<script>
    var snippet_form_capa = function () {
        var idfichaCapa = '{/literal}{$id}{literal}';
        var typeCapa = '{/literal}{$type}{literal}';
        var form_capa = $('#form_capa');
        var btn_capa_submit = $('#btn_capa_submit');

        var campo_input_sev_capa = $('#form_capa input');
        
        //== Private Functions
        var showRequest= function (formData, jqForm, op) {
            btn_capa_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
            return true;
        };

        var showResponse = function (responseText, statusText) {
            btn_capa_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
            if(responseText.res ==1) {
                if(responseText.accion == 'new') {
                    //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                    swal("Creado!", "Se guardó el registro con éxito!", "success");
                    $("#form_capa")[0].reset();
                    table_list_capa.draw();
                    show_modal_window_list_capa();
                } else if(responseText.accion == 'update') {
                    swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                    table_list_capa.draw();
                    show_modal_window_list_capa();
                    //swal({type: 'success',title: 'Actualizado! Se actualizó todo con éxito!',showConfirmButton: false, timer: 1000});
                } else {
                    location = "{/literal}{$getModule}{literal}";
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
                accion: '{/literal}{$subcontrol}_itemupdatesqlCapa{literal}'
                ,itemId: idfichaCapa
                ,type: typeCapa
            }
        };

        var handle_form_submit = function () {
            form_capa.ajaxForm(options);
        };

        var handle_general_form_submit = function () {

            btn_capa_submit.click(function (e) {
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

                form_capa.submit();
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
                placeholder: "Seleccione una opción"
            });

            $('.summernote').summernote({
                height: 150
            });
        };

        var handle_get_components = function () {
            campo_input_sev_capa.keyup(function () {
                form_capa.validate();
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

    $('#capa_profundidad_desde').number(true, 2, '.');
    $('#capa_profundidad_desde').mask('999.99');

    $('#capa_profundidad_hasta').number(true, 2, '.');
    $('#capa_profundidad_hasta').mask('999.99');

    $('#capa_resistividad').number(true, 2, '.');
    $('#capa_resistividad').mask('99999.99');

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
                //     $("#btn_capa_submit").show();
                // }else{
                //     $("#btn_capa_submit").hide();
                // }

                switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#btn_capa_submit").show();
                        }else{
                            $("#btn_capa_submit").hide();
                        }
                        break;
                    case 3:
                        $("#btn_capa_submit").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                            $("#btn_capa_submit").show();
                        }else{
                            $("#btn_capa_submit").hide();
                        }
                        break;
                }
            },
        });
    }

    //== Class Initialization
    jQuery(document).ready(function () {
        permisos_usuario();
        snippet_form_capa.init();
        $('[data-toggle="m-tooltip"]').click().tooltip();
    });

</script>
{/literal}