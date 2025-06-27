{literal}
<script>
	var snippet_consulta_epsa = function () {
		var select_epsa = $('#epsaId');
        var select_anio_perforacion = $('#anio_perforacion');
        var select_profundidad_perforacion = $('#profundidad_perforacion');
        var btn_uso_pozo = $('#btn_uso_pozo');
        var btn_proposito_pozo = $('#btn_proposito_pozo');

        var get_info_epsa = function(id) {
            var url = "{/literal}{$getModule}{literal}&accion=epsa_index&epsaId="+id;

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

        var get_info_epsa_anio_perforacion = function(id, anio) {
            var url = "{/literal}{$getModule}{literal}&accion=epsa_getConsultaAnioPerforacion&epsaId="+id+"&anio_perforacion="+anio;

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

        var get_info_epsa_profundidad = function(id, profundidad) {
            var url = "{/literal}{$getModule}{literal}&accion=epsa_getConsultaProfundidad&epsaId="+id+"&profundidad="+profundidad;

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

        var get_info_epsa_uso = function(id) {
            var url = "{/literal}{$getModule}{literal}&accion=epsa_getConsultaUso&epsaId="+id;

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

        var get_info_epsa_proposito = function(id) {
            var url = "{/literal}{$getModule}{literal}&accion=epsa_getConsultaProposito&epsaId="+id;

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
                $.post("{/literal}{$getModule}{literal}&accion=epsa_getAnioPerforacion"
                    , {epsaId: id}
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
            select_epsa.change(function() {
                var id = $('#epsaId').val();
                if (id != '') {
                    var urlPozo = urlBase+"&accion=epsa_getPuntosPozo&epsaId="+id;
                    var urlManantial = urlBase+"&accion=epsa_getPuntosManantial&epsaId="+id;
                    var urlGeofisica = urlBase+"&accion=epsa_getPuntosGeofisica&epsaId="+id
                    get_info_epsa(id);
                    get_puntos(urlPozo, sourcePozo, puntosPozo);
                    get_puntos(urlManantial, sourceManantial, puntosManantial);
                    get_puntos(urlGeofisica, sourceGeofisica, puntosGeofisica);
                    $('#modal_consultas').modal('hide');

                    $('#anio_perforacion').val('').trigger('change');
                    $('#profundidad_perforacion').val('').trigger('change');
                } else {
                    swal('Advertencia!','Seleccione una opción.','warning');
                }
            });

            select_anio_perforacion.change(function() {
                var id = $('#epsaId').val();
                var anioPerforacion = $('#anio_perforacion').val();
                if (id != '') {
                    if (anioPerforacion != '' && anioPerforacion != null) {
                        var urlPozo = urlBase + "&accion=epsa_getPuntosPozoAnioPerforacion&epsaId="+id+"&anio_perforacion="+anioPerforacion;
                        puntosGeofisica.setVisible(false);
                        puntosManantial.setVisible(false);
                        get_info_epsa_anio_perforacion(id, anioPerforacion);
                        get_puntos(urlPozo, sourcePozo, puntosPozo);
                        $('#modal_consultas').modal('hide');

                        $('#profundidad_perforacion').val('').trigger('change');
                    } else {
                        //swal('Advertencia!','Seleccione un año.','warning');
                    }
                } else {
                    swal('Advertencia!','Seleccione un acuífero.','warning');
                }
            });

            select_profundidad_perforacion.change(function() {
                var id = $('#epsaId').val();
                var profundidad = $('#profundidad_perforacion').val();
                if (id != '') {
                    if (profundidad != '' && profundidad != null) {
                        var urlPozo = urlBase + "&accion=epsa_getPuntosPozoProfundidad&epsaId="+id+"&profundidad="+profundidad;
                        puntosGeofisica.setVisible(false);
                        puntosManantial.setVisible(false);
                        get_info_epsa_profundidad(id, profundidad);
                        get_puntos(urlPozo, sourcePozo, puntosPozo);
                        $('#modal_consultas').modal('hide');

                        $('#anio_perforacion').val('').trigger('change');
                    } else {
                        //swal('Advertencia!','Seleccione una profundidad.','warning');
                    }
                } else {
                    swal('Advertencia!','Seleccione un acuífero.','warning');
                }
            });

            btn_uso_pozo.click(function() {
                var id = $('#epsaId').val();
                if (id != '') {
                    var urlPozo = urlBase + "&accion=epsa_getPuntosPozoUso&epsaId="+id;
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_epsa_uso(id);
                    get_puntos(urlPozo, sourcePozo, puntosPozo);
                    $('#modal_consultas').modal('hide');

                    $('#anio_perforacion').val('').trigger('change');
                    $('#profundidad_perforacion').val('').trigger('change');
                } else {
                    swal('Advertencia!','Seleccione un acuífero.','warning');
                }
            });

            btn_proposito_pozo.click(function() {
                var id = $('#epsaId').val();
                if (id != '') {
                    var urlPozo = urlBase + "&accion=epsa_getPuntosPozoProposito&epsaId="+id;
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_epsa_proposito(id);
                    get_puntos(urlPozo, sourcePozo, puntosPozo);
                    $('#modal_consultas').modal('hide');

                    $('#anio_perforacion').val('').trigger('change');
                    $('#profundidad_perforacion').val('').trigger('change');
                } else {
                    swal('Advertencia!','Seleccione un acuífero.','warning');
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
        snippet_consulta_epsa.init();

        if (poligonoSeleccionado) {
            poligonoSobrepuesto.getSource().removeFeature(poligonoSeleccionado);
            poligonoSeleccionado = null;
        }
    });
</script>
{/literal}