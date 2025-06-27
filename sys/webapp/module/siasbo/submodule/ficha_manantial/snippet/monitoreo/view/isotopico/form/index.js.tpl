{literal}
<script>
    var snippet_form_isotopico = function () {
        var idficha = '{/literal}{$id}{literal}';
        var type = '{/literal}{$type}{literal}';
        var form_isotopico = $('#form_isotopico');
        var btn_isotopico_submit = $('#btn_isotopico_submit');
        var campo_input_isotopico = $('#form_isotopico input');
        
        var btn_modal_close = $('#btn_modal_close');
        //== Private Functions
        var showRequest= function (formData, jqForm, op) {
            btn_isotopico_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
            return true;
        };

        var showResponse = function (responseText, statusText) {
            btn_isotopico_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
            if(responseText.res ==1) {
                if(responseText.accion == 'new') {
                    //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                    swal("Creado!", "Se guardó el registro con éxito!", "success");
                    table_list_isotopico.draw();
                    $("#modal_window").modal("hide");
                } else if(responseText.accion == 'update') {
                    swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                    table_list_isotopico.draw();
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
                accion: '{/literal}{$subcontrol}_itemupdatesqlIsotopico{literal}'
                ,itemId: idficha
                ,type: type
            }
        };

        var handle_form_submit = function () {
            form_isotopico.ajaxForm(options);
        };

        var handle_general_form_submit = function () {
            btn_isotopico_submit.click(function (e) {
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
                
                form_isotopico.submit();
            });
        };

        var handle_general_components = function () {
            $('#iso_fecha_muestreo').datepicker({
                todayHighlight: true,
                orientation: "bottom left",
                format: 'dd/mm/yyyy',
                templates: {
                    leftArrow: '<i class="la la-angle-left"></i>',
                    rightArrow: '<i class="la la-angle-right"></i>'
                },
                language: 'es'
            });

            $('#iso_fecha_analisis').datepicker({
                todayHighlight: true,
                orientation: "bottom left",
                format: 'dd/mm/yyyy',
                templates: {
                    leftArrow: '<i class="la la-angle-left"></i>',
                    rightArrow: '<i class="la la-angle-right"></i>'
                },
                language: 'es'
            });

            $("#iso_hora_muestreo").timepicker({
                minuteStep: 1,
                format: 'HH:mm',
                //showSeconds:!0,
                showMeridian: 0
            });

            $("#iso_hora_analisis").timepicker({
                minuteStep: 1,
                format: 'HH:mm',
                //showSeconds:!0,
                showMeridian: 0
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
            campo_input_isotopico.keyup(function () {
                form_isotopico.validate();
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

    $('#iso_profundidad').number(true, 2, '.');
    $('#iso_profundidad').mask('999.99');

//----------------Permisos--------------------------------------------

    function permisos_usuario(){
        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=obtenerPermisos&perpozo=manantial', //&perpozo=pozo
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            //dataType: "json",
            success: function(data){
                obj_permiso = JSON.parse(data);

                if (obj_permiso[0].crear == 1){                                
                    $("#btn_isotopico_submit").show();
                }else{
                    $("#btn_isotopico_submit").hide();
                }                 
            },
        });
    }

    //== Class Initialization
    jQuery(document).ready(function () {
        permisos_usuario();
        snippet_form_isotopico.init();
        $('[data-toggle="m-tooltip"]').click().tooltip();
    });

</script>
{/literal}