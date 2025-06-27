{literal}
<script>
	var snippet_consulta_nacional = function () {
		var btn_datos_nacional = $('#btn_datos_nacional');
        var select_anio_perforacion = $('#anio_perforacion');
        var select_profundidad_perforacion = $('#profundidad_perforacion');
        var btn_uso_pozo = $('#btn_uso_pozo');
        var btn_proposito_pozo = $('#btn_proposito_pozo');

        var get_info_nacional = function() {
            var url = "{/literal}{$getModule}{literal}&accion=nacional_index";
            $('#window_content_info').html("Cargando...");
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
                    $('#window_content_info').html(respuesta);
                    swal.close();
                }
            });
        };

        var get_info_nacional_anio_perforacion = function (anio) {
            var url = "{/literal}{$getModule}{literal}&accion=nacional_getConsultaAnioPerforacion&anio_perforacion="+anio;
            $('#window_content_info').html("Cargando...");
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
                    $('#window_content_info').html(respuesta);
                    swal.close();
                }
            });
        };

        var get_info_nacional_profundidad = function (profundidad) {
            var url = "{/literal}{$getModule}{literal}&accion=nacional_getConsultaProfundidad&profundidad="+profundidad;
            $('#window_content_info').html("Cargando...");
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
                    $('#window_content_info').html(respuesta);
                    swal.close();
                }
            });
        };

        var get_info_nacional_uso = function () {
            var url = "{/literal}{$getModule}{literal}&accion=nacional_getConsultaUso";
            $('#window_content_info').html("Cargando...");
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
                    $('#window_content_info').html(respuesta);
                    swal.close();
                }
            });
        };

        var get_info_nacional_proposito = function () {
            var url = "{/literal}{$getModule}{literal}&accion=nacional_getConsultaProposito";
            $('#window_content_info').html("Cargando...");
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
                    $('#window_content_info').html(respuesta);
                    swal.close();
                }
            });
        };

        var posicion_inicial = function() {
            var location = ol.proj.transform([-64.655, -16.708], 'EPSG:4326', 'EPSG:3857');
            var pan = ol.animation.pan({
                source: mapa.getView().getCenter()
            });
            var zoom = ol.animation.zoom({
                resolution: mapa.getView().getResolution(),
                duration: 1500,
                easing: ol.easing.easeIn
            });
            mapa.beforeRender(pan, zoom);
            mapa.getView().setCenter(location);
            mapa.getView().setZoom(5.2);
            if (poligonoSeleccionado) {
                poligonoSobrepuesto.getSource().removeFeature(poligonoSeleccionado);
                poligonoSeleccionado = null;
            }
        };

        var handle_general_components = function(){
            $('.select2-form').select2({
                placeholder: "Seleccione una opción",
                dropdownParent: $("#modal_consultas")
            });
        };

        var handle_get_components = function() {
            btn_datos_nacional.click(function() {
                puntosPozo.setVisible(true);
                puntosGeofisica.setVisible(true);
                puntosManantial.setVisible(true);
                get_info_nacional();
                puntosPozo.setSource(clusterPozo);
                puntosManantial.setSource(clusterManantial);
                puntosGeofisica.setSource(clusterGeofisica);
                posicion_inicial();
                $('#modal_consultas').modal('hide');

                $('#anio_perforacion').val('').trigger('change');
                $('#profundidad_perforacion').val('').trigger('change');
            });

            select_anio_perforacion.change(function() {
                var anioPerforacion = $('#anio_perforacion').val();
                if (anioPerforacion != '' && anioPerforacion != null) {
                    var urlPozo = urlBase + "&accion=nacional_getPuntosPozoAnioPerforacion&anio_perforacion="+anioPerforacion;
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_nacional_anio_perforacion(anioPerforacion);
                    get_puntos_pozo(urlPozo, sourcePozo, puntosPozo);
                    posicion_inicial();
                    $('#modal_consultas').modal('hide');

                    $('#profundidad_perforacion').val('').trigger('change');
                } else {
                    //swal('Advertencia!','Seleccione un año.','warning');
                }
            });

            select_profundidad_perforacion.change(function() {
                var profundidad = $('#profundidad_perforacion').val();
                if (profundidad != '' && profundidad != null) {
                    var urlPozo = urlBase + "&accion=nacional_getPuntosPozoProfundidad&profundidad="+profundidad;
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_nacional_profundidad(profundidad);
                    get_puntos_pozo(urlPozo, sourcePozo, puntosPozo);
                    posicion_inicial();
                    $('#modal_consultas').modal('hide');

                    $('#anio_perforacion').val('').trigger('change');
                } else {
                    //swal('Advertencia!','Seleccione una profundidad.','warning');
                }
            });

            btn_uso_pozo.click(function() {
                var urlPozo = urlBase + "&accion=nacional_getPuntosPozoUso";
                puntosGeofisica.setVisible(false);
                puntosManantial.setVisible(false);
                get_info_nacional_uso();
                get_puntos_pozo(urlPozo, sourcePozo, puntosPozo);
                posicion_inicial();
                $('#modal_consultas').modal('hide');

                $('#anio_perforacion').val('').trigger('change');
                $('#profundidad_perforacion').val('').trigger('change');
            });

            btn_proposito_pozo.click(function() {
                var urlPozo = urlBase + "&accion=nacional_getPuntosPozoProposito";
                puntosGeofisica.setVisible(false);
                puntosManantial.setVisible(false);
                get_info_nacional_proposito();
                get_puntos_pozo(urlPozo, sourcePozo, puntosPozo);
                posicion_inicial();
                $('#modal_consultas').modal('hide');

                $('#anio_perforacion').val('').trigger('change');
                $('#profundidad_perforacion').val('').trigger('change');
            });
        };

        return {
            //main function to initiate the module
            init: function() {
                handle_general_components();
                handle_get_components();
            },
        };
	}();

    jQuery(document).ready(function() {
        snippet_consulta_nacional.init();
    });
</script>
{/literal}