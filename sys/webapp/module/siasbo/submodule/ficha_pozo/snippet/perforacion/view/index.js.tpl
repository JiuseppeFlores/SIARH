{literal}
<script>
    var snippet_form_especifico = function() {
        var idficha = '{/literal}{$id}{literal}';
        var type = '{/literal}{$type}{literal}';
        var form_perforacion = $('#form_perforacion');
        var btn_perforacion_submit = $('#btn_perforacion_submit');

        var campo_input = $('input');

        var switchdiv = false;
        var nombrediv = "";


        //== Private Functions
        var showRequest= function(formData, jqForm, op) {
            btn_perforacion_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
            return true;
        };

        var showResponse = function (responseText, statusText) {
            btn_perforacion_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
            if(responseText.res ==1){
                if(responseText.accion == 'new') {
                    //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                    //$("#form_perforacion")[0].reset();
                    swal("Creado!", "Se guardó el registro con éxito!", "success");
                    //$("#perforacion_pozoId").prop("disabled",true);
                }else if(responseText.accion == 'update') {
                    swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                    //$("#perforacion_pozoId").prop("disabled",true);
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
            form_perforacion.ajaxForm(options);
        };

        var handle_general_form_submit = function() {

            btn_perforacion_submit.click(function(e) {
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

                if(verificarDatos()==true){
                    form_perforacion.submit();                    
                }else{
                    swal("Informacion", "No se puede agregar estos datos, porque este registro contiene informacion", "warning");
                }
                
            });
        };

        var handle_general_components = function(){
            $('#perforacion_fecha').datepicker({
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

        function cargar_defecto(){
            $("#divPerforacion").hide();
            $("#divExcavacion").hide();            
        }

        var cargar_valor_tipo_pozo = function(){
            //alert($("#perforacion_pozoId option:selected").val());
            if($("#perforacion_pozoId option:selected").val() == "1" || $("#perforacion_pozoId option:selected").val() == "3" || $("#perforacion_pozoId option:selected").val() == "0"){
                $("#divPerforacion").show();
                $("#divExcavacion").hide();
                //configurarExcavacion();
                //$("#perforacion_pozoId").prop("disabled",true);
                //$("#perforacion_pozoId").hide();
                //alert("Perforado");
            }else if($("#perforacion_pozoId option:selected").val() == "2"){
                $("#divPerforacion").hide();
                $("#divExcavacion").show();
                //configurarPerforacion();
                //$("#perforacion_pozoId").prop("disabled",true);
                //$("#perforacion_pozoId").hide();
                //alert("Excavado");
            }
        };

        var cambiar_valor_tipo_pozo = function(){
            $("#perforacion_pozoId").change(function(){
                if($("#perforacion_pozoId option:selected").val() == "1" || $("#perforacion_pozoId option:selected").val() == "3"){
                    $("#divPerforacion").show();
                    $("#divExcavacion").hide();
                    //configurarExcavacion();
                }else if($("#perforacion_pozoId option:selected").val() == "2"){
                    $("#divPerforacion").hide();
                    $("#divExcavacion").show();
                    //configurarPerforacion();
                }               
            });
        };        

        function configurarPerforacion(){
            //limpiarPerforacion();
            // $("input[name='item[perforacion_tipoId]']").removeAttr('required');
            // $("input[name='item[perforacion_metodoId]']").removeAttr('required');
            $("#perforacion_tipoId").removeAttr('required');
            $("#perforacion_metodoId").removeAttr('required');
            $("input[name='item[perforacion_profundidad]']").removeAttr('required');
            $("input[name='item[perforacion_diametro]']").removeAttr('required');
            $("input[name='item[perforacion_diametro_final]']").removeAttr('required');

            // $("input[name='item[perforacion_revestimientoId]']").attr('required', '');
            // $("input[name='item[perforacion_excavacionId]']").attr('required', '');
            $("#perforacion_revestimientoId").attr('required', '');
            $("#perforacion_excavacionId").attr('required', '');
            $("input[name='item[perforacion_profundidadexcavada]']").attr('required', '');
            $("input[name='item[perforacion_diametroexcavacion]']").attr('required', '');
            $("input[name='item[perforacion_nivelfreatico]']").attr('required', '');
            $("input[name='item[perforacion_caudal]']").attr('required', '');
        }

        function configurarExcavacion(){
            //limpiarExcavacion();
            // $("input[name='item[perforacion_revestimientoId]']").removeAttr('required');
            // $("input[name='item[perforacion_excavacionId]']").removeAttr('required');
            $("#perforacion_revestimientoId").removeAttr('required');
            $("#perforacion_excavacionId").removeAttr('required');
            $("input[name='item[perforacion_profundidadexcavada]']").removeAttr('required');
            $("input[name='item[perforacion_diametroexcavacion]']").removeAttr('required');
            $("input[name='item[perforacion_nivelfreatico]']").removeAttr('required'); 
            $("input[name='item[perforacion_caudal]']").removeAttr('required');      

            // $("input[name='item[perforacion_tipoId]']").attr('required', '');
            // $("input[name='item[perforacion_metodoId]']").attr('required', '');
            $("#perforacion_tipoId").attr('required', '');
            $("#perforacion_metodoId").attr('required', '');
            $("input[name='item[perforacion_profundidad]']").attr('required', '');
            $("input[name='item[perforacion_diametro]']").attr('required', '');
            $("input[name='item[perforacion_diametro_final]']").attr('required', '');         
        }

        function limpiarPerforacion(){
            $("#perforacion_tipoId").val("null"); //null
            $("#perforacion_metodoId").val("null"); //null
            // $("#perforacion_tipoId").val("");
            // $("#perforacion_metodoId").val("");
            $("#perforacion_profundidad").val("");
            $("#perforacion_diametro").val("");
            $("#perforacion_diametro_final").val("");
        }

        function limpiarExcavacion(){
            $("#perforacion_revestimientoId").val("null");
            $("#perforacion_excavacionId").val("null");
            // $("#perforacion_revestimientoId").val("");
            // $("#perforacion_excavacionId").val("");
            $("#perforacion_profundidadexcavada").val("");
            $("#perforacion_diametroexcavacion").val("");
            $("#perforacion_nivelfreatico").val("");   
            $("#perforacion_caudal").val(""); 
        }

        function verificarDatos(){
            // if($("#perforacion_pozoId option:selected").val() == "1" || $("#perforacion_pozoId option:selected").val() == "3"){
            //     if($("#perforacion_revestimientoId").val()=="" && $("#perforacion_excavacionId").val()=="" && $("#perforacion_profundidadexcavada").val()=="" && $("#perforacion_diametroexcavacion").val()=="" && $("#perforacion_nivelfreatico").val()=="" && $("#perforacion_caudal").val()==""){
            //         limpiarExcavacion();
            //         return true;
            //     }
            // }else if($("#perforacion_pozoId option:selected").val() == "2"){
            //     if($("#perforacion_tipoId").val()=="" && $("#perforacion_metodoId").val()=="" && $("#perforacion_profundidad").val()=="" && $("#perforacion_diametro").val()=="" && $("#perforacion_diametro_final").val()==""){
            //         limpiarPerforacion();
            //         return true;
            //     }
            // }
            // return false;

            if($("#perforacion_pozoId option:selected").val() == "1" || $("#perforacion_pozoId option:selected").val() == "3"){
                    //limpiarExcavacion();
                    return true;
                
            }else if($("#perforacion_pozoId option:selected").val() == "2"){
                    //limpiarPerforacion();
                    return true;
                
            }
            return false;
        }

        campo_input.focusout(function () {
            //general_form.validate();
            form_perforacion.validate();
        });       

        //== Public Functions
        return {
            // public functions
            init: function() {
                handle_general_form_submit();
                handle_form_submit();
                handle_general_components();
                cargar_defecto();
                cargar_valor_tipo_pozo(); 
                cambiar_valor_tipo_pozo();
                              
            }
        };

    }();

    $('#perforacion_profundidad').number(true, 2, '.');
    $('#perforacion_profundidad').mask('999.99');

    $('#perforacion_diametro').number(true, 2, '.');
    $('#perforacion_diametro').mask('99.99');

    $('#perforacion_diametro_final').number(true, 2, '.');
    $('#perforacion_diametro_final').mask('99.99');

    $('#perforacion_profundidadexcavada').number(true, 2, '.');
    $('#perforacion_profundidadexcavada').mask('99.99');

    $('#perforacion_diametroexcavacion').number(true, 2, '.');
    $('#perforacion_diametroexcavacion').mask('99.99');

    $('#perforacion_nivelfreatico').number(true, 2, '.');
    $('#perforacion_nivelfreatico').mask('99.99');

    $('#perforacion_caudal').number(true, 2, '.');
    $('#perforacion_caudal').mask('99.99');

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
                //     $("#btn_perforacion_submit").show();
                // }else{
                //     $("#btn_perforacion_submit").hide();
                // }
                switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#btn_perforacion_submit").show();
                        }else{
                            $("#btn_perforacion_submit").hide();
                        }
                        break;
                    case 3:
                        $("#btn_perforacion_submit").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                            $("#btn_perforacion_submit").show();
                        }else{
                            $("#btn_perforacion_submit").hide();
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

        //alert("Pruebassss");

        // var cambiar_valor_tipo_pozo = function(){
        //     $("#perforacion_pozoId").change(function(){
        //         //alert($("#perforacion_pozoId option:selected").text());
        //         // if($("#perforacion_pozoId").val() == "1"){
        //         //     $("#divPerforacion").show();
        //         // }else if($("#perforacion_pozoId").val() == "2"){
        //         //     $("#divExcavacion").show();
        //         // }
        //         if($("#perforacion_pozoId option:selected").text() == "Perforado"){
        //             $("#divPerforacion").show();
        //             $("#divExcavacion").hide();
        //         }else if($("#perforacion_pozoId option:selected").text() == "Excavado"){
        //             $("#divPerforacion").hide();
        //             $("#divExcavacion").show();
        //         }
        //     });
        // }();

        // cambiar_valor_tipo_pozo();

        $('[data-toggle="m-tooltip"]').click().tooltip();        
    });

</script>
{/literal}