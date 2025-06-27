{literal}
<script>
	var snippet_consulta_cuenca_estrategica = function () {
		var select_cuenca_estrategica = $('#cuencaEstrategicaId');
        var select_anio_perforacion = $('#anio_perforacion');
        var select_profundidad_perforacion = $('#profundidad_perforacion');
        var btn_uso_pozo = $('#btn_uso_pozo');
        var btn_proposito_pozo = $('#btn_proposito_pozo');

        var get_info_cuenca_estrategica = function(id) {
            var url = "{/literal}{$getModule}{literal}&accion=cuenca.estrategica_index&cuencaEstrategicaId="+id;

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

        var get_info_cuenca_estrategica_anio_perforacion = function(id, anio) {
            var url = "{/literal}{$getModule}{literal}&accion=cuenca.estrategica_getConsultaAnioPerforacion&cuencaEstrategicaId="+id+"&anio_perforacion="+anio;

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

        var get_info_cuenca_estrategica_profundidad = function(id, profundidad) {
            var url = "{/literal}{$getModule}{literal}&accion=cuenca.estrategica_getConsultaProfundidad&cuencaEstrategicaId="+id+"&profundidad="+profundidad;

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

        var get_info_cuenca_estrategica_uso = function(id) {
            var url = "{/literal}{$getModule}{literal}&accion=cuenca.estrategica_getConsultaUso&cuencaEstrategicaId="+id;

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

        var get_info_cuenca_estrategica_proposito = function(id) {
            var url = "{/literal}{$getModule}{literal}&accion=cuenca.estrategica_getConsultaProposito&cuencaEstrategicaId="+id;

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

        var get_anio_perforacion = function (id) {
            var anioPerforacion = $('#anio_perforacion').empty();
            if(id!="") {
                $.post("{/literal}{$getModule}{literal}&accion=cuenca.estrategica_getAnioPerforacion"
                    , {cuencaEstrategicaId: id}
                    , function (respuesta, textStatus, jqXHR) {
                        selOption = $('<option></option>');
                        anioPerforacion.append(selOption.attr("value", "").text("--Seleccione una opción--"));
                        for (var clave in respuesta) {
                            anioPerforacion.append($('<option></option>').attr("value", respuesta[clave].anio).text(respuesta[clave].anio));
                        }
                    }
                    , 'json');
            } else {
                $("#anio_perforacion").append($('<option></option>').attr("value", "").text("--Seleccione una opción--"));
            }
        };

        var handle_general_components = function(){
            $('.select2').select2({
                placeholder: "Seleccione una opción",
                dropdownParent: $("#modal_consultas")
            });
        };

        var handle_get_components = function() {
            select_cuenca_estrategica.change(function() {
                var id = $('#cuencaEstrategicaId').val();
                var prefijo = 'cuenca_estra_25.';
                if (id != '') {
                    var urlPozo = urlBase+"&accion=cuenca.estrategica_getPuntosPozo&cuencaEstrategicaId="+id;
                    var urlManantial = urlBase+"&accion=cuenca.estrategica_getPuntosManantial&cuencaEstrategicaId="+id;
                    var urlGeofisica = urlBase+"&accion=cuenca.estrategica_getPuntosGeofisica&cuencaEstrategicaId="+id
                    selecciona_poligono(mapaCuencaEstra25, prefijo+id);
                    get_info_cuenca_estrategica(id);
                    get_puntos_poligono(urlPozo, sourcePozo, puntosPozo, mapaCuencaEstra25, prefijo+id);
                    get_puntos_poligono(urlManantial, sourceManantial, puntosManantial, mapaCuencaEstra25, prefijo+id);
                    get_puntos_poligono(urlGeofisica, sourceGeofisica, puntosGeofisica, mapaCuencaEstra25, prefijo+id);
                    get_anio_perforacion(id);
                    $('#modal_consultas').modal('hide');

                    $('#anio_perforacion').val('').trigger('change');
                    $('#profundidad_perforacion').val('').trigger('change');
                } else {
                    swal('Advertencia!','Seleccione una opción.','warning');
                }
            });

            select_anio_perforacion.change(function() {
                var id = $('#cuencaEstrategicaId').val();
                var anioPerforacion = $('#anio_perforacion').val();
                var prefijo = 'cuenca_estra_25.';
                if (id != '') {
                    if (anioPerforacion != ''  && anioPerforacion != null) {
                        var urlPozo = urlBase + "&accion=cuenca.estrategica_getPuntosPozoAnioPerforacion&cuencaEstrategicaId="+id+"&anio_perforacion="+anioPerforacion;
                        selecciona_poligono(mapaCuencaEstra25, prefijo+id);
                        puntosGeofisica.setVisible(false);
                        puntosManantial.setVisible(false);
                        get_info_cuenca_estrategica_anio_perforacion(id, anioPerforacion);
                        get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaCuencaEstra25, prefijo+id);
                        $('#modal_consultas').modal('hide');

                        $('#profundidad_perforacion').val('').trigger('change');
                    } else {
                        //swal('Advertencia!','Seleccione un año.','warning');
                    }
                } else {
                    swal('Advertencia!','Seleccione una cuenca estratégica.','warning');
                }
            });

            select_profundidad_perforacion.change(function() {
                var id = $('#cuencaEstrategicaId').val();
                var profundidad = $('#profundidad_perforacion').val();
                var prefijo = 'cuenca_estra_25.';
                if (id != '') {
                    if (profundidad != '' && profundidad != null) {
                        var urlPozo = urlBase + "&accion=cuenca.estrategica_getPuntosPozoProfundidad&cuencaEstrategicaId="+id+"&profundidad="+profundidad;
                        selecciona_poligono(mapaCuencaEstra25, prefijo+id);
                        puntosGeofisica.setVisible(false);
                        puntosManantial.setVisible(false);
                        get_info_cuenca_estrategica_profundidad(id, profundidad);
                        get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaCuencaEstra25, prefijo+id);
                        $('#modal_consultas').modal('hide');

                        $('#anio_perforacion').val('').trigger('change');
                    } else {
                        //swal('Advertencia!','Seleccione una profundidad.','warning');
                    }
                } else {
                    swal('Advertencia!','Seleccione una cuenca estratégica.','warning');
                }
            });

            btn_uso_pozo.click(function() {
                var id = $('#cuencaEstrategicaId').val();
                var prefijo = 'cuenca_estra_25.';
                if (id != '') {
                    var urlPozo = urlBase + "&accion=cuenca.estrategica_getPuntosPozoUso&cuencaEstrategicaId="+id;
                    selecciona_poligono(mapaCuencaEstra25, prefijo+id);
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_cuenca_estrategica_uso(id);
                    get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaCuencaEstra25, prefijo+id);
                    $('#modal_consultas').modal('hide');

                    $('#anio_perforacion').val('').trigger('change');
                    $('#profundidad_perforacion').val('').trigger('change');
                } else {
                    swal('Advertencia!','Seleccione una cuenca estratégica.','warning');
                }
            });

            btn_proposito_pozo.click(function() {
                var id = $('#cuencaEstrategicaId').val();
                var prefijo = 'cuenca_estra_25.';
                if (id != '') {
                    var urlPozo = urlBase + "&accion=cuenca.estrategica_getPuntosPozoProposito&cuencaEstrategicaId="+id;
                    selecciona_poligono(mapaCuencaEstra25, prefijo+id);
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_cuenca_estrategica_proposito(id);
                    get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaCuencaEstra25, prefijo+id);
                    $('#modal_consultas').modal('hide');

                    $('#anio_perforacion').val('').trigger('change');
                    $('#profundidad_perforacion').val('').trigger('change');
                } else {
                    swal('Advertencia!','Seleccione una cuenca estratégica.','warning');
                }
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
        snippet_consulta_cuenca_estrategica.init();
    });
</script>
{/literal}