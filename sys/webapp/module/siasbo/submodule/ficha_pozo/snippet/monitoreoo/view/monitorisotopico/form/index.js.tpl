{literal}
<script>
    var snippet_form_bombeo_pozo = function () {
        var idficha = '{/literal}{$id}{literal}';
        var type = '{/literal}{$type}{literal}';
        var form_bombeo_pozo = $('#form_bombeo_pozo');
        var btn_monitor_cantidad_submit = $('#btn_monitor_cantidad_submit');
        
        //== Private Functions
        var showRequest= function (formData, jqForm, op) {
            btn_monitor_cantidad_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
            return true;
        };

        var showResponse = function (responseText, statusText) {
            btn_monitor_cantidad_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
            if(responseText.res ==1) {
                if(responseText.accion == 'new') {
                    //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                    $("#modal_window_bombeo_pozo").modal("hide");
                    swal("Creado!", "Se guardó el registro con éxito!", "success");
                    $("#form_bombeo_pozo")[0].reset();
                    table_list_bombeo_pozo.draw();
                } else if(responseText.accion == 'update') {
                    $("#modal_window_bombeo_pozo").modal("hide");
                    swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                    $("#form_bombeo_pozo")[0].reset();
                    table_list_bombeo_pozo.draw();
                    //swal({type: 'success',title: 'Actualizado! Se actualizó todo con éxito!',showConfirmButton: false, timer: 1000});
                } else {
                    $("#modal_window_bombeo_pozo").modal("hide");
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
                accion: '{/literal}{$subcontrol}_itemupdatesqlMonitorCantidad{literal}'
                ,itemId: idficha
                ,type: type
            }
        };

        var handle_form_submit = function () {
            form_bombeo_pozo.ajaxForm(options);
        };

        var handle_general_form_submit = function () {

            btn_monitor_cantidad_submit.click(function (e) {
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
                
                form_bombeo_pozo.submit();
            });
        };

        var handle_general_components = function () {
            $('#bp_fecha').datepicker({
                todayHighlight: true,
                orientation: "bottom left",
                format: 'dd/mm/yyyy',
                templates: {
                    leftArrow: '<i class="la la-angle-left"></i>',
                    rightArrow: '<i class="la la-angle-right"></i>'
                }
            });

            $('.select2_general').select2({
                placeholder: "Seleccione una opción"
            });
            $('.summernote').summernote({
                height: 150
            });
        };

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

    //== Class Initialization
    jQuery(document).ready(function () {
        snippet_form_bombeo_pozo.init();
        $('[data-toggle="tooltip"]').click().tooltip();
    });

</script>
{/literal}