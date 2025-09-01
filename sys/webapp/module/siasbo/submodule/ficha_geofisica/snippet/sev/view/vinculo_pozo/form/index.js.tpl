{literal}
<script>
    var snippet_form_vinculo_pozo = function () {
        var idfichaVinculoPozo = '{/literal}{$id}{literal}';
        var typeVinculoPozo = '{/literal}{$type}{literal}';
        var form_vinculo_pozo = $('#form_vinculo_pozo');
        var btn_vinculo_pozo_submit = $('#btn_vinculo_pozo_submit');
        var btn_buscar_pozo = $('#btn_buscar_pozo');

        var campo_input_vinculo_pozo = $('#form_vinculo_pozo input');
        
        //== Private Functions
        var showRequest= function (formData, jqForm, op) {
            btn_vinculo_pozo_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
            return true;
        };

        var showResponse = function (responseText, statusText) {
            btn_vinculo_pozo_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
            if(responseText.res ==1) {
                if(responseText.accion == 'new') {
                    //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                    swal("Creado!", "Se guardó el registro con éxito!", "success");
                    $("#form_vinculo_pozo")[0].reset();
                    table_list_vinculo_pozo.draw();
                    show_modal_window_list_vinculo_pozo();
                } else if(responseText.accion == 'update') {
                    swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                    $("#form_vinculo_pozo")[0].reset();
                    table_list_vinculo_pozo.draw();
                    show_modal_window_list_vinculo_pozo();
                    //swal({type: 'success',title: 'Actualizado! Se actualizó todo con éxito!',showConfirmButton: false, timer: 1000});
                } else {
                    show_modal_window_list_vinculo_pozo();
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
                accion: '{/literal}{$subcontrol}_itemupdatesqlVinculoPozo{literal}'
                ,itemId: idfichaVinculoPozo
                ,type: typeVinculoPozo
            }
        };

        var handle_form_submit = function () {
            form_vinculo_pozo.ajaxForm(options);
        };

        var handle_general_form_submit = function () {

            btn_vinculo_pozo_submit.click(function (e) {
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

                form_vinculo_pozo.submit();
            });
        };

        var listarPozos = function () {
            var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemGrillaPozo{literal}";

            swal({
                title: 'Cargando tab!',
                text: 'Procesando datos',
                imageUrl: 'images/loading/loading05.gif',
                showConfirmButton: false,
                allowEnterKey: false,
                allowOutsideClick: false,
                allowEscapeKey: false,
            });

            $.get(url, function(respuesta) {
                $('#modal_content_pozo').html(respuesta);
                swal.close();
                $('#modal_window_vinculo_pozo').modal("hide");
                $('#modal_window_pozo').modal("show");
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
                dropdownParent: $("#modal_window_vinculo_pozo")
            });

            $('.summernote').summernote({
                height: 150
            });
        };

        var handle_get_components = function () {
            campo_input_vinculo_pozo.keyup(function () {
                form_vinculo_pozo.validate();
            });

            btn_buscar_pozo.click(function () {
                listarPozos();
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
                //     $("#btn_vinculo_pozo_submit").show();
                // }else{
                //     $("#btn_vinculo_pozo_submit").hide();
                // }

                switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#btn_vinculo_pozo_submit").show();
                        }else{
                            $("#btn_vinculo_pozo_submit").hide();
                        }
                        break;
                    case 3:
                        $("#btn_vinculo_pozo_submit").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                            $("#btn_vinculo_pozo_submit").show();
                        }else{
                            $("#btn_vinculo_pozo_submit").hide();
                        }
                        break;
                }
            },
        });
    }

    //== Class Initialization
    jQuery(document).ready(function () {
        permisos_usuario();
        snippet_form_vinculo_pozo.init();
    });

</script>
{/literal}