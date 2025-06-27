{literal}
<script>
    var snippet_general_form = function () {
        //var idficha = '{/literal}{$id}{literal}';
        var idficha = idMonitoreo;
        //var type = '{/literal}{$type}{literal}';
        var type = typeAction;
        var general_form = $('#general_form');
        var general_btn_submit = $('#general_submit');
        

        //== Private Functions
        var showRequest= function (formData, jqForm, op) {
            general_btn_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
            return true;
        };

        var showResponse = function (responseText, statusText) {
            general_btn_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
            if(responseText.res ==1) {
                if(responseText.accion == 'new') {
                    //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                    $("#ventana_form").modal("hide");
                    swal("Creado!", "Se guardó el registro con éxito!", "success");
                    $("#general_form")[0].reset();
                    table_list.draw();
                } else if(responseText.accion == 'update') {
                    $("#ventana_form").modal("hide");
                    swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                    $("#general_form")[0].reset();
                    table_list.draw();
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
                accion: '{/literal}{$subcontrol}_itemupdatesql{literal}'
                ,itemId: idficha
                ,type: type
            }
        };

        var handle_form_submit = function () {
            general_form.ajaxForm(options);
        };

        var handle_general_form_submit = function () {

            general_btn_submit.click(function (e) {
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

                options.data.itemId = idMonitoreo;
                options.data.type = typeAction;
                
                general_form.submit();
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
        snippet_general_form.init();
    });

</script>
{/literal}