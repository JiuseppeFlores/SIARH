{literal}
<script>
	var snippet_consulta_municipal = function () {
		var select_municipio = $('#municipioId');
        var select_anio_perforacion = $('#anio_perforacion');
        var select_profundidad_perforacion = $('#profundidad_perforacion');
        var btn_uso_pozo = $('#btn_uso_pozo');
        var btn_proposito_pozo = $('#btn_proposito_pozo');

        var get_info_municipal = function(id) {
            var url = "{/literal}{$getModule}{literal}&accion=municipal_index&municipioId="+id;
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

        var get_info_municipal_anio_perforacion = function (id, anio) {
            var url = "{/literal}{$getModule}{literal}&accion=municipal_getConsultaAnioPerforacion&municipioId="+id+"&anio_perforacion="+anio;
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

        var get_info_municipal_profundidad = function (id, profundidad) {
            var url = "{/literal}{$getModule}{literal}&accion=municipal_getConsultaProfundidad&municipioId="+id+"&profundidad="+profundidad;
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

        var get_info_municipal_uso = function (id) {
            var url = "{/literal}{$getModule}{literal}&accion=municipal_getConsultaUso&municipioId="+id;
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

        var get_info_municipal_proposito = function (id) {
            var url = "{/literal}{$getModule}{literal}&accion=municipal_getConsultaProposito&municipioId="+id;
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
                $.post("{/literal}{$getModule}{literal}&accion=municipal_getAnioPerforacion"
                    , {municipioId: id}
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
            select_municipio.change(function() {
                var id = $('#municipioId').val();
                var prefijo = 'municipios.';
                if (id != '') {
                    var urlPozo = urlBase+"&accion=municipal_getPuntosPozo&municipioId="+id;
                    var urlManantial = urlBase+"&accion=municipal_getPuntosManantial&municipioId="+id;
                    var urlGeofisica = urlBase+"&accion=municipal_getPuntosGeofisica&municipioId="+id;
                    selecciona_poligono(mapaMunicipios, prefijo+id);
                    get_info_municipal(id);
                    get_puntos_poligono(urlPozo, sourcePozo, puntosPozo, mapaMunicipios, prefijo+id);
                    get_puntos_poligono(urlManantial, sourceManantial, puntosManantial, mapaMunicipios, prefijo+id);
                    get_puntos_poligono(urlGeofisica, sourceGeofisica, puntosGeofisica, mapaMunicipios, prefijo+id);
                    get_anio_perforacion(id);
                    $('#modal_consultas').modal('hide');

                    $('#anio_perforacion').val('').trigger('change');
                    $('#profundidad_perforacion').val('').trigger('change');
                } else {
                    //swal('Advertencia!','Seleccione una opción.','warning');
                }
            });

            select_anio_perforacion.change(function() {
                var id = $('#municipioId').val();
                var anioPerforacion = $('#anio_perforacion').val();
                if (id != '') {
                    if (anioPerforacion != '' && anioPerforacion != null) {
                        var urlPozo = urlBase + "&accion=municipal_getPuntosPozoAnioPerforacion&municipioId="+id+"&anio_perforacion="+anioPerforacion;
                        puntosGeofisica.setVisible(false);
                        puntosManantial.setVisible(false);
                        get_info_municipal_anio_perforacion(id, anioPerforacion);
                        get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo);
                        $('#modal_consultas').modal('hide');

                        $('#profundidad_perforacion').val('').trigger('change');
                    } else {
                        //swal('Advertencia!','Seleccione un año.','warning');
                    }
                } else {
                    swal('Advertencia!','Seleccione un departamento.','warning');
                }
            });

            select_profundidad_perforacion.change(function() {
                var id = $('#municipioId').val();
                var profundidad = $('#profundidad_perforacion').val();
                if (id != '') {
                    if (profundidad != '' && profundidad != null) {
                        var urlPozo = urlBase + "&accion=municipal_getPuntosPozoProfundidad&municipioId="+id+"&profundidad="+profundidad;
                        puntosGeofisica.setVisible(false);
                        puntosManantial.setVisible(false);
                        get_info_municipal_profundidad(id, profundidad);
                        get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo);
                        $('#modal_consultas').modal('hide');

                        $('#anio_perforacion').val('').trigger('change');
                    } else {
                        //swal('Advertencia!','Seleccione una profundidad.','warning');
                    }
                } else {
                    swal('Advertencia!','Seleccione un departamento.','warning');
                }
            });

            btn_uso_pozo.click(function() {
                var id = $('#municipioId').val();
                if (id != '') {
                    var urlPozo = urlBase + "&accion=municipal_getPuntosPozoUso&municipioId="+id;
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_municipal_uso(id);
                    get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo);
                    $('#modal_consultas').modal('hide');

                    $('#anio_perforacion').val('').trigger('change');
                    $('#profundidad_perforacion').val('').trigger('change');
                } else {
                    swal('Advertencia!','Seleccione un municipio.','warning');
                }
            });

            btn_proposito_pozo.click(function() {
                var id = $('#municipioId').val();
                if (id != '') {
                    var urlPozo = urlBase + "&accion=municipal_getPuntosPozoProposito&municipioId="+id;
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_municipal_proposito(id);
                    get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo);
                    $('#modal_consultas').modal('hide');

                    $('#anio_perforacion').val('').trigger('change');
                    $('#profundidad_perforacion').val('').trigger('change');
                } else {
                    swal('Advertencia!','Seleccione un municipio.','warning');
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
        snippet_consulta_municipal.init();
    });
</script>
{/literal}