{literal}
<script>
	var snippet_acuifero = function () {
		//var btn_graficar_piper = $('#btn_graficar_piper');
        //var btn_generar_tabla_calidad = $('#btn_generar_tabla_calidad');
        var btn_descargar_pozos_excel = $('#btn_descargar_pozos_excel');
        var btn_graficar_isotopico = $('#btn_graficar_isotopico');
        var btn_guardar_grafica = $('#btn_guardar_grafica');

		/*var graficar_piper = function() {
			var url = "{/literal}{$getModule}{literal}&accion=acuifero_getGraficaPiper&acuiferoId={/literal}{$acuiferoId}{literal}&campaniaId={/literal}{$campaniaId}{literal}";

            $('#modal_content').html("Cargando...");
            swal({
                title: 'Cargando!',
                text: 'Procesando datos',
                imageUrl: 'images/loading/loading05.gif',
                showConfirmButton: false,
                allowEnterKey: false,
                allowOutsideClick: false,
                allowEscapeKey: false,
            });

            $.get(url, function(respuesta) {
                if (respuesta == 0) {
                    swal.close();
                    swal('Advertencia!','No existen datos.','warning');
                } else {
                    $('#modal_content').html(respuesta);
                    $('#modal_window').modal('show');
                    swal.close();
                }
            });
        };*/

        /*var generar_tabla_calidad = function() {
            var url = "{/literal}{$getModule}{literal}&accion=acuifero_getConsultaCalidad&acuiferoId={/literal}{$acuiferoId}{literal}&campaniaId={/literal}{$campaniaId}{literal}";
            
            window.open(url, '_blank');
        };*/

        /*var generar_tabla_calidad = function() {
            var url = "{/literal}{$getModule}{literal}&accion=reporte.calidad_getReporteCalidadAcuifero&acuiferoId={/literal}{$acuiferoId}{literal}&campaniaId={/literal}{$campaniaId}{literal}";
            window.open(url, '_blank');
        };*/

        var graficar_isotopicos = function() {
            var url = "{/literal}{$getModule}{literal}&accion=acuifero_getGraficaIsotopicos&acuiferoId={/literal}{$acuiferoId}{literal}";

            $('#modal_content').html("Cargando...");
            swal({
                title: 'Cargando!',
                text: 'Procesando datos',
                imageUrl: 'images/loading/loading05.gif',
                showConfirmButton: false,
                allowEnterKey: false,
                allowOutsideClick: false,
                allowEscapeKey: false,
            });

            $.get(url, function(respuesta){
                if (respuesta == 0) {
                    swal.close();
                    swal('Advertencia!','No existen datos.','warning');
                } else {
                    $('#modal_content').html(respuesta);
                    $('#modal_window').modal('show');
                    swal.close();
                }
            });
        };

        var get_descargar_excel = function() {
            var url = "{/literal}{$getModule}{literal}&accion=acuifero_getDescargarPozosExcel&acuiferoId={/literal}{$acuiferoId}{literal}";
            window.open(url, '_blank');
        };

        var handle_get_components = function() {
            /*btn_graficar_piper.click(function() {
                graficar_piper();
            });

            btn_generar_tabla_calidad.click(function() {
                generar_tabla_calidad();
            });*/

            btn_descargar_pozos_excel.click(function() {
                get_descargar_excel();
            });

            btn_graficar_isotopico.click(function() {
                graficar_isotopicos();
            });
        };

        return {
            //main function to initiate the module
            init: function() {
                handle_get_components();
            },
        };
	}();

    jQuery(document).ready(function() {
        snippet_acuifero.init();
    });

</script>
{/literal}