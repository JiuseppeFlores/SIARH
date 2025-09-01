{literal}
<script>
    var snippet_form_captacion = function() {
        var idficha = '{/literal}{$id}{literal}';
        var type = '{/literal}{$type}{literal}';
        var form_captacion = $('#form_captacion');
        var btn_captacion_submit = $('#btn_captacion_submit');

        var campo_input_captacion = $('#form_captacion input');

        //== Private Functions
        var showRequest= function(formData, jqForm, op) {
            btn_captacion_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
            return true;
        };

        var showResponse = function (responseText, statusText) {
            btn_captacion_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
            if(responseText.res ==1){
                if(responseText.accion == 'new') {
                    //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                    swal("Creado!", "Se guardó el registro con éxito!", "success");
                }else if(responseText.accion == 'update') {
                    swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                    //swal({type: 'success',title: 'Actualizado! Se actualizó todo con éxito!',showConfirmButton: false, timer: 1000});
                }else{
                    location = "{/literal}{$getModule}{literal}";
                }
            }else if(responseText.res ==2){
                swal("Ocurrió un error!", responseText.msg, "error")
            }else{
                swal("ocurrió un error!", responseText.msg, "danger")
            }
        };

        var options = {
            beforeSubmit:showRequest
            , dataType: 'json'
            , success:  showResponse
            , data: {
                accion:'{/literal}{$subcontrol}_itemupdatesql{literal}'
                ,itemId:idficha
                ,type:type
            }
        };

        var handle_form_submit=function(){
            form_captacion.ajaxForm(options);
        };

        var handle_general_form_submit = function() {
            btn_captacion_submit.click(function(e) {
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

                form_captacion.submit();
            });
        };

        var handle_general_components = function(){
            $('#cdc_fechainicio').datepicker({
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

        var handle_get_components = function () {
            campo_input_captacion.keyup(function () {
                form_captacion.validate();
            });
        };

        //== Public Functions
        return {
            // public functions
            init: function() {
                handle_general_form_submit();
                handle_form_submit();
                handle_general_components();
                handle_get_components();
            }
        };
    } ();

    $('#cdc_conexionesagua').number(true, 2, '.');
    $('#cdc_conexionesagua').mask('99.99');

    $('#cdc_coberturaagua').number(true, 2, '.');
    $('#cdc_coberturaagua').mask('99.99');

    $('#cdc_numero').number(true, 2, '.');
    $('#cdc_numero').mask('99.99');

    $('#cdc_caudal').number(true, 2, '.');
    $('#cdc_caudal').mask('99.99');

    $('#cdc_capacidad').number(true, 2, '.');
    $('#cdc_capacidad').mask('99.99');

    $('#cdc_red').number(true, 2, '.');
    $('#cdc_red').mask('99.99');

    $('#cdc_area').number(true, 2, '.');
    $('#cdc_area').mask('99.99');

//----------------Permisos--------------------------------------------

    function permisos_usuario(){
        var idUsuarioResponsable = parseInt($('#idUsuarioResponsable').val());
        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=obtenerPermisos&perpozo=captación superficial', //&perpozo=pozo
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            //dataType: "json",
            success: function(data){
                obj_permiso = JSON.parse(data);

                if (obj_permiso[0].crear == 1){                                
                    $("#btn_captacion_submit").show();
                }else{
                    $("#btn_captacion_submit").hide();
                }                 
            },
        });
    }

    //== Class Initialization
    jQuery(document).ready(function() {
        permisos_usuario();
        snippet_form_captacion.init();
        $('[data-toggle="m-tooltip"]').click().tooltip();
    });

</script>
{/literal}