{literal}
<script>
    var snippet_form_especifico = function() {
        var idficha = '{/literal}{$id}{literal}';
        var type = '{/literal}{$type}{literal}';
        var form_especifico = $('#form_especifico');
        var btn_especifico_submit = $('#btn_especifico_submit');

        var campo_input_especifico = $('#form_especifico input');

        //== Private Functions
        var showRequest= function(formData, jqForm, op) {
            btn_especifico_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
            return true;
        };

        var showResponse = function (responseText, statusText) {
            btn_especifico_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
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
            form_especifico.ajaxForm(options);
        };

        var handle_general_form_submit = function() {
            btn_especifico_submit.click(function(e) {
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

                form_especifico.submit();
            });
        };

        var handle_general_components = function(){
            $('.fecha_general').datepicker({
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
            campo_input_especifico.keyup(function () {
                form_especifico.validate();
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

//----------------Permisos--------------------------------------------

    function permisos_usuario(){
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
                    $("#btn_especifico_submit").show();
                }else{
                    $("#btn_especifico_submit").hide();
                }                 
            },
        });
    }

    //== Class Initialization
    jQuery(document).ready(function() {
        permisos_usuario();
        snippet_form_especifico.init();
        $('[data-toggle="m-tooltip"]').click().tooltip();
    });

</script>
{/literal}