{literal}
<script>
	var snippet_consulta_pozo = function () {
		var btn_pozo_diseno = $('#btn_pozo_diseno');
        var btn_pozo_litologia = $('#btn_pozo_litologia');
        var btn_pozo_electrico = $('#btn_pozo_electrico');
        var btn_pozo_hidraulico_escalon = $('#btn_pozo_hidraulico_escalon');
        var btn_pozo_hidraulico_recuperacion = $('#btn_pozo_hidraulico_recuperacion');
        var btn_pozo_hidraulico_observacion = $('#btn_pozo_hidraulico_observacion');
        var btn_pozo_implementacion = $('#btn_pozo_implementacion');
        var btn_pozo_monitor_cantidad = $('#btn_pozo_monitor_cantidad');
        var btn_pozo_monitor_calidad = $('#btn_pozo_monitor_calidad');
        var btn_pozo_monitor_isotopico = $('#btn_pozo_monitor_isotopico');
        var rdb_tipo = $('input[type=radio][name=rdb_tipo]');
        var select_departamento = $('#deptoId');
        var select_municipio = $('#municipioId');

        var get_info_diseno = function(depto_id, municipio_id, tipo) {
            var url = "{/literal}{$getModule}{literal}&accion=pozo_getConsultaDiseno&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;

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

        var get_info_litologia = function(depto_id, municipio_id, tipo) {
            var url = "{/literal}{$getModule}{literal}&accion=pozo_getConsultaLitologia&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;

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

        var get_info_electrico = function(depto_id, municipio_id, tipo) {
            var url = "{/literal}{$getModule}{literal}&accion=pozo_getConsultaElectrico&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;

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

        var get_info_hidraulico_escalon = function(depto_id, municipio_id, tipo) {
            var url = "{/literal}{$getModule}{literal}&accion=pozo_getConsultaHidraulicoEscalon&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;

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

        var get_info_hidraulico_recuperacion = function(depto_id, municipio_id, tipo) {
            var url = "{/literal}{$getModule}{literal}&accion=pozo_getConsultaHidraulicoRecuperacion&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;

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

        var get_info_hidraulico_observacion = function(depto_id, municipio_id, tipo) {
            var url = "{/literal}{$getModule}{literal}&accion=pozo_getConsultaHidraulicoObservacion&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;

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

        var get_info_implementacion = function(depto_id, municipio_id, tipo) {
            var url = "{/literal}{$getModule}{literal}&accion=pozo_getConsultaImplementacion&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;

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

        var get_info_monitor_cantidad = function(depto_id, municipio_id, tipo) {
            var url = "{/literal}{$getModule}{literal}&accion=pozo_getConsultaMonitorCantidad&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;

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

        var get_info_monitor_calidad = function(depto_id, municipio_id, tipo) {
            var url = "{/literal}{$getModule}{literal}&accion=pozo_getConsultaMonitorCalidad&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;

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

        var get_info_monitor_isotopico = function(depto_id, municipio_id, tipo) {
            var url = "{/literal}{$getModule}{literal}&accion=pozo_getConsultaMonitorIsotopico&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;

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

        var inicializar_tipo_nacional = function() {
            $('#deptoId').val('').trigger('change');
            $('#municipioId').val('').trigger('change');
            $('#deptoId').attr('disabled', 'disabled');
            $('#municipioId').attr('disabled', 'disabled');
        };

        var inicializar_tipo_departamental = function() {
            $('#deptoId').val('').trigger('change');
            $('#municipioId').val('').trigger('change');
            $('#deptoId').removeAttr('disabled');
            $('#municipioId').attr('disabled', 'disabled');
        };

        var inicializar_tipo_municipal = function() {
            $('#deptoId').val('').trigger('change');
            $('#municipioId').val('').trigger('change');
            $('#deptoId').attr('disabled', 'disabled');
            $('#municipioId').removeAttr('disabled');
        };

        var handle_general_components = function(){
            $('.select2').select2({
                //placeholder: "Seleccione una opción",
                dropdownParent: $("#modal_consultas")
            });
        };

        var handle_get_components = function() {
            rdb_tipo.change(function() {
                switch(this.value) {
                    case 'c1':
                        mapaDepartamental.setVisible(true);
                        mapaMunicipios.setVisible(false);
                        inicializar_tipo_nacional();

                        break;
                    case 'c2':
                        mapaDepartamental.setVisible(true);
                        mapaMunicipios.setVisible(false);
                        inicializar_tipo_departamental();
                        break;
                    case 'c3':
                        mapaDepartamental.setVisible(false);
                        mapaMunicipios.setVisible(true);
                        inicializar_tipo_municipal();
                        break;
                }
            });

            select_departamento.change(function() {
                ubicacionPoligono = null;
            });

            select_municipio.change(function() {
                ubicacionPoligono = null;
            });

            btn_pozo_diseno.click(function() {
                var tipo = $('input[type=radio][name=rdb_tipo]:checked').val();
                var depto_id = select_departamento.val();
                var municipio_id = select_municipio.val();
                var urlPozo = urlBase+"&accion=pozo_getPuntosPozoDiseno&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;
                var prefijo_depto = 'departamento.'+depto_id;
                var prefijo_municipio = 'municipios.'+municipio_id;

                if (tipo == 'c2' && depto_id == '') {
                    swal('Advertencia!','Seleccione un departamento.','warning');
                } else if (tipo == 'c3' && municipio_id == '') {
                    swal('Advertencia!','Seleccione un municipio.','warning');
                } else {
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_diseno(depto_id, municipio_id, tipo);
                    switch(tipo) {
                        case 'c1':
                            get_puntos(urlPozo, sourcePozo, puntosPozo);
                            posicion_inicial();
                            break;
                        case 'c2':
                            selecciona_poligono(mapaDepartamental, prefijo_depto);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaDepartamental, prefijo_depto);
                            break;
                        case 'c3':
                            selecciona_poligono(mapaMunicipios, prefijo_municipio);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaMunicipios, prefijo_municipio);
                            break;
                    }
                    $('#modal_consultas').modal('hide');
                }
            });

            btn_pozo_litologia.click(function() {
                var tipo = $('input[type=radio][name=rdb_tipo]:checked').val();
                var depto_id = select_departamento.val();
                var municipio_id = select_municipio.val();
                var urlPozo = urlBase+"&accion=pozo_getPuntosPozoLitologia&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;
                var prefijo_depto = 'departamento.'+depto_id;
                var prefijo_municipio = 'municipios.'+municipio_id;

                if (tipo == 'c2' && depto_id == '') {
                    swal('Advertencia!','Seleccione un departamento.','warning');
                } else if (tipo == 'c3' && municipio_id == '') {
                    swal('Advertencia!','Seleccione un municipio.','warning');
                } else {
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_litologia(depto_id, municipio_id, tipo);
                    switch(tipo) {
                        case 'c1':
                            get_puntos(urlPozo, sourcePozo, puntosPozo);
                            posicion_inicial();
                            break;
                        case 'c2':
                            selecciona_poligono(mapaDepartamental, prefijo_depto);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaDepartamental, prefijo_depto);
                            break;
                        case 'c3':
                            selecciona_poligono(mapaMunicipios, prefijo_municipio);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaMunicipios, prefijo_municipio);
                            break;
                    }
                    $('#modal_consultas').modal('hide');
                }
            });

            btn_pozo_electrico.click(function() {
                var tipo = $('input[type=radio][name=rdb_tipo]:checked').val();
                var depto_id = select_departamento.val();
                var municipio_id = select_municipio.val();
                var urlPozo = urlBase+"&accion=pozo_getPuntosPozoElectrico&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;
                var prefijo_depto = 'departamento.'+depto_id;
                var prefijo_municipio = 'municipios.'+municipio_id;

                if (tipo == 'c2' && depto_id == '') {
                    swal('Advertencia!','Seleccione un departamento.','warning');
                } else if (tipo == 'c3' && municipio_id == '') {
                    swal('Advertencia!','Seleccione un municipio.','warning');
                } else {
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_electrico(depto_id, municipio_id, tipo);
                    switch(tipo) {
                        case 'c1':
                            get_puntos(urlPozo, sourcePozo, puntosPozo);
                            posicion_inicial();
                            break;
                        case 'c2':
                            selecciona_poligono(mapaDepartamental, prefijo_depto);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaDepartamental, prefijo_depto);
                            break;
                        case 'c3':
                            selecciona_poligono(mapaMunicipios, prefijo_municipio);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaMunicipios, prefijo_municipio);
                            break;
                    }
                    $('#modal_consultas').modal('hide');
                }
            });

            btn_pozo_hidraulico_escalon.click(function() {
                var tipo = $('input[type=radio][name=rdb_tipo]:checked').val();
                var depto_id = select_departamento.val();
                var municipio_id = select_municipio.val();
                var urlPozo = urlBase+"&accion=pozo_getPuntosPozoHidraulicoEscalon&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;
                var prefijo_depto = 'departamento.'+depto_id;
                var prefijo_municipio = 'municipios.'+municipio_id;

                if (tipo == 'c2' && depto_id == '') {
                    swal('Advertencia!','Seleccione un departamento.','warning');
                } else if (tipo == 'c3' && municipio_id == '') {
                    swal('Advertencia!','Seleccione un municipio.','warning');
                } else {
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_hidraulico_escalon(depto_id, municipio_id, tipo);
                    switch(tipo) {
                        case 'c1':
                            get_puntos(urlPozo, sourcePozo, puntosPozo);
                            posicion_inicial();
                            break;
                        case 'c2':
                            selecciona_poligono(mapaDepartamental, prefijo_depto);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaDepartamental, prefijo_depto);
                            break;
                        case 'c3':
                            selecciona_poligono(mapaMunicipios, prefijo_municipio);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaMunicipios, prefijo_municipio);
                            break;
                    }
                    $('#modal_consultas').modal('hide');
                }
            });

            btn_pozo_hidraulico_recuperacion.click(function() {
                var tipo = $('input[type=radio][name=rdb_tipo]:checked').val();
                var depto_id = select_departamento.val();
                var municipio_id = select_municipio.val();
                var urlPozo = urlBase+"&accion=pozo_getPuntosPozoHidraulicoRecuperacion&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;
                var prefijo_depto = 'departamento.'+depto_id;
                var prefijo_municipio = 'municipios.'+municipio_id;

                if (tipo == 'c2' && depto_id == '') {
                    swal('Advertencia!','Seleccione un departamento.','warning');
                } else if (tipo == 'c3' && municipio_id == '') {
                    swal('Advertencia!','Seleccione un municipio.','warning');
                } else {
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_hidraulico_recuperacion(depto_id, municipio_id, tipo);
                    switch(tipo) {
                        case 'c1':
                            get_puntos(urlPozo, sourcePozo, puntosPozo);
                            posicion_inicial();
                            break;
                        case 'c2':
                            selecciona_poligono(mapaDepartamental, prefijo_depto);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaDepartamental, prefijo_depto);
                            break;
                        case 'c3':
                            selecciona_poligono(mapaMunicipios, prefijo_municipio);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaMunicipios, prefijo_municipio);
                            break;
                    }
                    $('#modal_consultas').modal('hide');
                }
            });

            btn_pozo_hidraulico_observacion.click(function() {
                var tipo = $('input[type=radio][name=rdb_tipo]:checked').val();
                var depto_id = select_departamento.val();
                var municipio_id = select_municipio.val();
                var urlPozo = urlBase+"&accion=pozo_getPuntosPozoHidraulicoObservacion&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;
                var prefijo_depto = 'departamento.'+depto_id;
                var prefijo_municipio = 'municipios.'+municipio_id;

                if (tipo == 'c2' && depto_id == '') {
                    swal('Advertencia!','Seleccione un departamento.','warning');
                } else if (tipo == 'c3' && municipio_id == '') {
                    swal('Advertencia!','Seleccione un municipio.','warning');
                } else {
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_hidraulico_observacion(depto_id, municipio_id, tipo);
                    switch(tipo) {
                        case 'c1':
                            get_puntos(urlPozo, sourcePozo, puntosPozo);
                            posicion_inicial();
                            break;
                        case 'c2':
                            selecciona_poligono(mapaDepartamental, prefijo_depto);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaDepartamental, prefijo_depto);
                            break;
                        case 'c3':
                            selecciona_poligono(mapaMunicipios, prefijo_municipio);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaMunicipios, prefijo_municipio);
                            break;
                    }
                    $('#modal_consultas').modal('hide');
                }
            });

            btn_pozo_implementacion.click(function() {
                var tipo = $('input[type=radio][name=rdb_tipo]:checked').val();
                var depto_id = select_departamento.val();
                var municipio_id = select_municipio.val();
                var urlPozo = urlBase+"&accion=pozo_getPuntosPozoImplementacion&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;
                var prefijo_depto = 'departamento.'+depto_id;
                var prefijo_municipio = 'municipios.'+municipio_id;

                if (tipo == 'c2' && depto_id == '') {
                    swal('Advertencia!','Seleccione un departamento.','warning');
                } else if (tipo == 'c3' && municipio_id == '') {
                    swal('Advertencia!','Seleccione un municipio.','warning');
                } else {
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_implementacion(depto_id, municipio_id, tipo);
                    switch(tipo) {
                        case 'c1':
                            get_puntos(urlPozo, sourcePozo, puntosPozo);
                            posicion_inicial();
                            break;
                        case 'c2':
                            selecciona_poligono(mapaDepartamental, prefijo_depto);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaDepartamental, prefijo_depto);
                            break;
                        case 'c3':
                            selecciona_poligono(mapaMunicipios, prefijo_municipio);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaMunicipios, prefijo_municipio);
                            break;
                    }
                    $('#modal_consultas').modal('hide');
                }
            });

            btn_pozo_monitor_cantidad.click(function() {
                var tipo = $('input[type=radio][name=rdb_tipo]:checked').val();
                var depto_id = select_departamento.val();
                var municipio_id = select_municipio.val();
                var urlPozo = urlBase+"&accion=pozo_getPuntosPozoMonitorCantidad&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;
                var prefijo_depto = 'departamento.'+depto_id;
                var prefijo_municipio = 'municipios.'+municipio_id;

                if (tipo == 'c2' && depto_id == '') {
                    swal('Advertencia!','Seleccione un departamento.','warning');
                } else if (tipo == 'c3' && municipio_id == '') {
                    swal('Advertencia!','Seleccione un municipio.','warning');
                } else {
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_monitor_cantidad(depto_id, municipio_id, tipo);
                    switch(tipo) {
                        case 'c1':
                            get_puntos(urlPozo, sourcePozo, puntosPozo);
                            posicion_inicial();
                            break;
                        case 'c2':
                            selecciona_poligono(mapaDepartamental, prefijo_depto);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaDepartamental, prefijo_depto);
                            break;
                        case 'c3':
                            selecciona_poligono(mapaMunicipios, prefijo_municipio);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaMunicipios, prefijo_municipio);
                            break;
                    }
                    $('#modal_consultas').modal('hide');
                }
            });

            btn_pozo_monitor_calidad.click(function() {
                var tipo = $('input[type=radio][name=rdb_tipo]:checked').val();
                var depto_id = select_departamento.val();
                var municipio_id = select_municipio.val();
                var urlPozo = urlBase+"&accion=pozo_getPuntosPozoMonitorCalidad&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;
                var prefijo_depto = 'departamento.'+depto_id;
                var prefijo_municipio = 'municipios.'+municipio_id;

                if (tipo == 'c2' && depto_id == '') {
                    swal('Advertencia!','Seleccione un departamento.','warning');
                } else if (tipo == 'c3' && municipio_id == '') {
                    swal('Advertencia!','Seleccione un municipio.','warning');
                } else {
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_monitor_calidad(depto_id, municipio_id, tipo);
                    switch(tipo) {
                        case 'c1':
                            get_puntos(urlPozo, sourcePozo, puntosPozo);
                            posicion_inicial();
                            break;
                        case 'c2':
                            selecciona_poligono(mapaDepartamental, prefijo_depto);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaDepartamental, prefijo_depto);
                            break;
                        case 'c3':
                            selecciona_poligono(mapaMunicipios, prefijo_municipio);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaMunicipios, prefijo_municipio);
                            break;
                    }
                    $('#modal_consultas').modal('hide');
                }
            });

            btn_pozo_monitor_isotopico.click(function() {
                var tipo = $('input[type=radio][name=rdb_tipo]:checked').val();
                var depto_id = select_departamento.val();
                var municipio_id = select_municipio.val();
                var urlPozo = urlBase+"&accion=pozo_getPuntosPozoMonitorIsotopico&deptoId="+depto_id+"&municipioId="+municipio_id+"&tipo="+tipo;
                var prefijo_depto = 'departamento.'+depto_id;
                var prefijo_municipio = 'municipios.'+municipio_id;

                if (tipo == 'c2' && depto_id == '') {
                    swal('Advertencia!','Seleccione un departamento.','warning');
                } else if (tipo == 'c3' && municipio_id == '') {
                    swal('Advertencia!','Seleccione un municipio.','warning');
                } else {
                    puntosGeofisica.setVisible(false);
                    puntosManantial.setVisible(false);
                    get_info_monitor_isotopico(depto_id, municipio_id, tipo);
                    switch(tipo) {
                        case 'c1':
                            get_puntos(urlPozo, sourcePozo, puntosPozo);
                            posicion_inicial();
                            break;
                        case 'c2':
                            selecciona_poligono(mapaDepartamental, prefijo_depto);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaDepartamental, prefijo_depto);
                            break;
                        case 'c3':
                            selecciona_poligono(mapaMunicipios, prefijo_municipio);
                            get_puntos_poligono_pozo(urlPozo, sourcePozo, puntosPozo, mapaMunicipios, prefijo_municipio);
                            break;
                    }
                    $('#modal_consultas').modal('hide');
                }
            });
        };

        return {
            //main function to initiate the module
            init: function() {
                handle_general_components();
                handle_get_components();
                inicializar_tipo_nacional();
            },
        };
	}();

    jQuery(document).ready(function() {
        snippet_consulta_pozo.init();
    });
</script>
{/literal}