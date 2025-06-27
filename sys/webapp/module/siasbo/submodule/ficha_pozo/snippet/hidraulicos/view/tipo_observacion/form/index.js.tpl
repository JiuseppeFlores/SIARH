{literal}
<script>
    var snippet_form_observacion = function () {
        var idficha = '{/literal}{$id}{literal}';
        var type = '{/literal}{$type}{literal}';
        var form_observacion = $('#form_observacion');
        var btn_observacion_submit = $('#btn_observacion_submit');
        var btn_buscar_pozo = $('#btn_buscar_pozo');

        var campo_input_observacion = $('#form_observacion input');
        
        //== Private Functions
        var showRequest= function (formData, jqForm, op) {
            btn_observacion_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
            return true;
        };

        var showResponse = function (responseText, statusText) {
            btn_observacion_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
            if(responseText.res ==1) {
                if(responseText.accion == 'new') {
                    //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                    swal("Creado!", "Se guardó el registro con éxito!", "success");
                    table_list_observacion.draw();
                    $("#modal_window").modal("hide");
                } else if(responseText.accion == 'update') {
                    swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                    table_list_observacion.draw();
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
                accion: '{/literal}{$subcontrol}_itemupdatesqlObservacion{literal}'
                ,itemId: idficha
                ,type: type
            }
        };

        var handle_form_submit = function () {
            form_observacion.ajaxForm(options);
        };

        var handle_general_form_submit = function () {
            btn_observacion_submit.click(function (e) {
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
                
                form_observacion.submit();
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
                $('#modal_window').modal("hide");
                $('#modal_window_pozo').modal("show");
            });
        };

        var handle_general_components = function () {
            $('#po_fecha').datepicker({
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
            campo_input_observacion.keyup(function () {
                form_observacion.validate();
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

    $('#po_utm_este').number(true, 3, '.');
    $('#po_utm_este').mask('999999.999');

    $('#po_utm_norte').number(true, 3, '.');
    $('#po_utm_norte').mask('9999999.999');

    $('#po_nivel_estatico').number(true, 2, '.');
    $('#po_nivel_estatico').mask('99.99');

    $('#po_nivel_dinamico').number(true, 2, '.');
    $('#po_nivel_dinamico').mask('99.99');

    $('#po_horas').number(true, 0, '.');
    $('#po_horas').mask('99');

    $('#po_minutos').number(true, 0, '.');
    $('#po_minutos').mask('99');

    $('#po_segundos').number(true, 2, '.');
    $('#po_segundos').mask('99.99');

//----------------Permisos--------------------------------------------

    function permisos_usuario(){
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

                if (obj_permiso[0].crear == 1){                                
                    $("#btn_observacion_submit").show();
                }else{
                    $("#btn_observacion_submit").hide();
                }                 
            },
        });
    }

    //== Class Initialization
    jQuery(document).ready(function () {
        permisos_usuario();
        snippet_form_observacion.init();
        $('[data-toggle="m-tooltip"]').click().tooltip();
    });

</script>
{/literal}