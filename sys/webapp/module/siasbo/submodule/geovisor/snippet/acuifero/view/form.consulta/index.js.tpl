{literal}
<script>
	var snippet_consulta_acuifero = function () {
        var select_acuifero = $('#acuiferoId');
        var select_campania = $('#campaniaId');
        var select_anio_perforacion = $('#anio_perforacion');
        var select_profundidad_perforacion = $('#profundidad_perforacion');
        var btn_uso_pozo = $('#btn_uso_pozo');
        var btn_proposito_pozo = $('#btn_proposito_pozo');
		var btn_consulta_acuifero = $('#btn_consulta_acuifero');

        var get_info_acuifero = function(id) {
            var url = "{/literal}{$getModule}{literal}&accion=acuifero_index&acuiferoId="+id;

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

        var get_info_campania = function(id, campaniaId) {
            var url = "{/literal}{$getModule}{literal}&accion=acuifero_getConsultaAcuiferoCampania&acuiferoId="+id+"&campaniaId="+campaniaId;

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

        var get_info_acuifero_anio_perforacion = function(id, anio) {
            var url = "{/literal}{$getModule}{literal}&accion=acuifero_getConsultaAnioPerforacion&acuiferoId="+id+"&anio_perforacion="+anio;

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

        var get_info_acuifero_profundidad = function(id, profundidad) {
            var url = "{/literal}{$getModule}{literal}&accion=acuifero_getConsultaProfundidad&acuiferoId="+id+"&profundidad="+profundidad;

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

        var get_info_acuifero_uso = function(id) {
            var url = "{/literal}{$getModule}{literal}&accion=acuifero_getConsultaUso&acuiferoId="+id;

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

        var get_info_acuifero_proposito = function(id) {
            var url = "{/literal}{$getModule}{literal}&accion=acuifero_getConsultaProposito&acuiferoId="+id;

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

        var get_campanias = function (id, campaniaId) {
            var campaniaOpt = $('#campaniaId').empty();
            if(id!="") {
                $.post("{/literal}{$getModule}{literal}&accion=acuifero_getCampanias"
                    , {acuiferoId: id, campaniaId: campaniaId}
                    , function (respuesta, textStatus, jqXHR) {
                        selOption = $('<option></option>');
                        campaniaOpt.append(selOption.attr("value", "").text("Seleccione campaña"));
                        for (var clave in respuesta) {
                            campaniaOpt.append($('<option></option>').attr("value", respuesta[clave].mes+'-'+respuesta[clave].anio).text(respuesta[clave].mes+'/'+respuesta[clave].anio));
                        }
                        campaniaOpt.trigger('chosen:updated');
                    }
                    , 'json');
            } else {
                $("#campaniaId").append($('<option></option>').attr("value", "").text("--Seleccione una opción--"));
                //swal('Advertencia!','Seleccione un acuífero.','warning');
            }
        };

        var get_anio_perforacion = function (id) {
            var anioPerforacion = $('#anio_perforacion').empty();
            if(id!="") {
                $.post("{/literal}{$getModule}{literal}&accion=acuifero_getAnioPerforacion"
                    , {acuiferoId: id}
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
            btn_consulta_acuifero.click(function() {
                //graficar_piper();
            });

            select_acuifero.change(function() {
                var id = $('#acuiferoId').val();
                if (id != '') {
                    var urlPozo = urlBase + "&accion=acuifero_getPuntosPozoAcuifero&acuiferoId=" + id;
                    var urlManantial = urlBase + "&accion=acuifero_getPuntosManantialAcuifero&acuiferoId=" + id;
                    var urlGeofisica = urlBase + "&accion=acuifero_getPuntosGeofisicaAcuifero&acuiferoId=" + id;
                    get_info_acuifero(id);
                    get_puntos(urlPozo, sourcePozo, puntosPozo);
                    get_puntos(urlManantial, sourceManantial, puntosManantial);
                    get_puntos(urlGeofisica, sourceGeofisica, puntosGeofisica);
                    get_campanias($('#acuiferoId').val());
                    get_anio_perforacion(id);
                    $('#modal_consultas').modal('hide');

                    $('#anio_perforacion').val('').trigger('change');
                    $('#profundidad_perforacion').val('').trigger('change');
                } else {
                    swal('Advertencia!','Seleccione una opción.','warning');
                }
            });

            select_campania.change(function() {
                var id = $('#acuiferoId').val();
                var campaniaId = $('#campaniaId').val();
                if (id != '') {
                    if (campaniaId != '' && campaniaId != null) {
                        var urlPozo = urlBase + "&accion=acuifero_getPuntosPozoCampania&acuiferoId=" + id+"&campaniaId="+campaniaId;
                        var urlManantial = urlBase + "&accion=acuifero_getPuntosManantialCampania&acuiferoId=" + id+"&campaniaId="+campaniaId;
                        var urlGeofisica = urlBase + "&accion=acuifero_getPuntosGeofisicaCampania&acuiferoId=" + id+"&campaniaId="+campaniaId;
                        get_info_campania(id, campaniaId);
                        get_puntos(urlPozo, sourcePozo, puntosPozo);
                        get_puntos(urlManantial, sourceManantial, puntosManantial);
                        get_puntos(urlGeofisica, sourceGeofisica, puntosGeofisica);
                        $('#modal_consultas').modal('hide');

                        $('#anio_perforacion').val('').trigger('change');
                        $('#profundidad_perforacion').val('').trigger('change');
                    }
                } else {
                    //swal('Advertencia!','Seleccione una opción en acuífero y campaña.','warning');
                }
            });

            select_anio_perforacion.change(function() {
                var id = $('#acuiferoId').val();
                var anioPerforacion = $('#anio_perforacion').val();
                if (id != '') {
                    if (anioPerforacion != '' && anioPerforacion != null) {
                        var urlPozo = urlBase + "&accion=acuifero_getPuntosPozoAnioPerforacion&acuiferoId="+id+"&anio_perforacion="+anioPerforacion;
                        puntosGeofisica.setVisible(false);
                        puntosManantial.setVisible(false);
                        get_info_acuifero_anio_perforacion(id, anioPerforacion);
                        get_puntos(urlPozo, sourcePozo, puntosPozo);
                        $('#modal_consultas').modal('hide');

                        $('#campaniaId').val('').trigger('change');
                        $('#profundidad_perforacion').val('').trigger('change');
                    } else {
                        //swal('Advertencia!','Seleccione un año.','warning');
                    }
                } else {
                    swal('Advertencia!','Seleccione un acuífero.','warning');
                }
            });

            select_profundidad_perforacion.change(function() {
                var id = $('#acuiferoId').val();
                var profundidad = $('#profundidad_perforacion').val();
                if (id != '') {
                    if (profundidad != '' && profundidad != null) {
                        var urlPozo = urlBase + "&accion=acuifero_getPuntosPozoProfundidad&acuiferoId="+id+"&profundidad="+profundidad;
                        puntosGeofisica.setVisible(false);
                        puntosManantial.setVisible(false);
                        get_info_acuifero_profundidad(id, profundidad);
                        get_puntos(urlPozo, sourcePozo, puntosPozo);
                        $('#modal_consultas').modal('hide');

                        $('#campaniaId').val('').trigger('change');
                        $('#anio_perforacion').val('').trigger('change');
                    } else {
                        //swal('Advertencia!','Seleccione una profundidad.','warning');
                    }
                } else {
                    swal('Advertencia!','Seleccione un acuífero.','warning');
                }
            });

            btn_uso_pozo.click(function() {
                var id = $('#acuiferoId').val();
                if (id != '') {
                    var urlPozo = urlBase + "&accion=acuifero_getPuntosPozoUso&acuiferoId="+id;
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_acuifero_uso(id);
                    get_puntos(urlPozo, sourcePozo, puntosPozo);
                    $('#modal_consultas').modal('hide');

                    $('#campaniaId').val('').trigger('change');
                    $('#anio_perforacion').val('').trigger('change');
                    $('#profundidad_perforacion').val('').trigger('change');
                } else {
                    swal('Advertencia!','Seleccione un acuífero.','warning');
                }
            });

            btn_proposito_pozo.click(function() {
                var id = $('#acuiferoId').val();
                if (id != '') {
                    var urlPozo = urlBase + "&accion=acuifero_getPuntosPozoProposito&acuiferoId="+id;
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_acuifero_proposito(id);
                    get_puntos(urlPozo, sourcePozo, puntosPozo);
                    $('#modal_consultas').modal('hide');

                    $('#campaniaId').val('').trigger('change');
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
        snippet_consulta_acuifero.init();

        if (poligonoSeleccionado) {
            poligonoSobrepuesto.getSource().removeFeature(poligonoSeleccionado);
            poligonoSeleccionado = null;
        }
    });
</script>
{/literal}