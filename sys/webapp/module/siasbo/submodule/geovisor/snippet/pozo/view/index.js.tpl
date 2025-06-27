{literal}
<script>
	var snippet_epsa = function () {
		var btn_graficar_piper = $('#btn_graficar_piper');
        var btn_graficar_caudal = $('#btn_graficar_caudal');
        var btn_graficar_isotopico = $('#btn_graficar_isotopico');

		var graficar_piper = function() {
			var url = "{/literal}{$getModule}{literal}&accion=epsa_getGraficaPiper&epsaId={/literal}{$epsaId}{literal}";

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
        };

        var graficar_caudal = function() {
            var url = "{/literal}{$getModule}{literal}&accion=epsa_getGraficaCaudales&epsaId={/literal}{$epsaId}{literal}";

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
        };

        var graficar_isotopicos = function() {
            var url = "{/literal}{$getModule}{literal}&accion=epsa_getGraficaIsotopicos&epsaId={/literal}{$epsaId}{literal}";

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
        };

        var handle_get_components = function() {
            btn_graficar_piper.click(function() {
                graficar_piper();
            });

            btn_graficar_caudal.click(function() {
                graficar_caudal();
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
        snippet_epsa.init();
    });

</script>
{/literal}