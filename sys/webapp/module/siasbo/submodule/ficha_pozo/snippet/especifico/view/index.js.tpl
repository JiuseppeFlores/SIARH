{literal}
<script>
    var snippet_form_especifico = function() {
        var idficha = '{/literal}{$id}{literal}';
        var type = '{/literal}{$type}{literal}';
        var form_especifico = $('#form_especifico');
        var btn_especifico_submit = $('#btn_especifico_submit');

        var campo_input = $('input');

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
                    //$("#form_especifico")[0].reset();
                    swal("Creado!", "Se guardó el registro con éxito!", "success");
                }else if(responseText.accion == 'update') {
                    swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                    //swal({type: 'success',title: 'Actualizado! Se actualizó todo con éxito!',showConfirmButton: false, timer: 1000});
                }else{
                    location = "{/literal}{$getModule}{literal}";
                }
            }else if(responseText.res ==2){
                swal("Ocurrio un error!", responseText.msg, "error")
            }else{
                swal("ocurrio un error!", responseText.msg, "danger")
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
                        "item[categoria_id]": {
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
                $('#descripcion_input').val($('#descripcion').summernote('code'));
                form_especifico.submit();
            });
        };

        var handle_general_components = function(){
            $('#abc').datepicker({
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

        campo_input.focusout(function () {
            general_form.validate();
        });

        //== Public Functions
        return {
            // public functions
            init: function() {
                handle_general_form_submit();
                handle_form_submit();
                handle_general_components();
            }
        };
    }();

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
                //     $("#btn_especifico_submit").show();
                // }else{
                //     $("#btn_especifico_submit").hide();
                // }       
                
                switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#btn_especifico_submit").show();
                        }else{
                            $("#btn_especifico_submit").hide();
                        }
                        break;
                    case 3:
                        $("#btn_especifico_submit").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                            $("#btn_especifico_submit").show();
                        }else{
                            $("#btn_especifico_submit").hide();
                        }
                        break;
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