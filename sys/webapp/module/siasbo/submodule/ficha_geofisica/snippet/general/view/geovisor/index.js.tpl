{literal}
<script>
    var inicializarMapa = 0;
    var puntosMapa;
    var puntoSeleccionado;
    var mapa;
    var btn_asignar_coordenada;

    var initMapa = function() {
        // Mapas Base
        var sourceBing = new ol.source.BingMaps({ 
            key: 'AkEKaa5IN_fxt4qvZAN5_aAaZ8xtxnh_UvYZUmZdXYJvohBUfR6oTGrGWgOldrv8',
            imagerySet: 'AerialWithLabels',
        });

        var mapaBing = new ol.layer.Tile({
            id: 'bing',
            title: 'Bing Map Road',
            source: sourceBing,
            visible: true,
            name: 'bing'
        });

        var mapaGoogle = new ol.layer.Tile({
            id: 'google',
            title: 'Google Map',
            source: new ol.source.OSM({
                url: 'http://mt{0-3}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                attributions: [
                    new ol.Attribution({ html: '© Google' }),
                    new ol.Attribution({ html: '<a href="https://developers.google.com/maps/terms">Terms of Use.</a>' })
                ]
            }),
            visible: false,
            name: 'google'
        });

        var mapaOSM = new ol.layer.Tile({
            id: 'osm',
            title: 'Open Street Map',
            source: new ol.source.OSM(),
            visible: false,
            name: 'osm'
        });

        var mapasBase = new ol.layer.Group({
            title: 'Mapas Base',
            layers: [
                mapaBing,
                mapaGoogle,
                mapaOSM
            ]
        });

        // Mapas Siasbo
        var estilosDepartamento = new ol.style.Style({
            fill: new ol.style.Fill({
                color: [255, 255, 255, 0]
            }),
            stroke: new ol.style.Stroke({
                color: '#319FD3',
                width: 2
            })
        });

        var mapaDepartamental = new ol.layer.Vector({
            id: 'departamento',
            title: 'Departamentos',
            source: new ol.source.Vector({
                crossOrigin: 'anonymous',
                url: 'http://sig01.mmaya.gob.bo/geoserver/siasbo/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=siasbo:departamento&outputFormat=application%2Fjson',
                format: new ol.format.GeoJSON()
            }),
            style: estilosDepartamento
        });

        var mapaMunicipios = new ol.layer.Vector({
                id: 'municipio',
                title: 'Municipios',
                source: new ol.source.Vector({
                    format: new ol.format.GeoJSON(),
                    crossOrigin: 'anonymous',
                    url: 'http://sig01.mmaya.gob.bo/geoserver/siasbo/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=siasbo:municipios&outputFormat=application%2Fjson'
                }),
                visible: false,
                style: estilosDepartamento
            });

        var mapasSiasbo = new ol.layer.Group({
            title: 'Mapas Siasbo',
            layers: [
                mapaMunicipios,
                mapaDepartamental
            ]
        });

        // Crea vista de mapa
        var vista = new ol.View({
            center: ol.proj.fromLonLat([-64.655, -16.708]),
            zoom: 5
        });

        // Crea mapa y asigana capa de mapas
        mapa = new ol.Map({
            layers: [
                mapasBase,
                mapasSiasbo
            ],
            controls: ol.control.defaults({zoom: true, rotate: false}),
            target: 'mapa',
            view: vista
        });

        var conmutadorCapas = new ol.control.LayerSwitcher({
            tipLabel: 'Leyenda'
        });

        mapa.addControl(conmutadorCapas);

        var escala = new ol.control.ScaleLine({
            target: document.getElementById('mapa_tool_escala')
        });

        mapa.addControl(escala);

        mapa.on('click', function(browserEvent) {
            var coordinate = browserEvent.coordinate;
            //var dms = ol.coordinate.toStringHDMS(coordinate, 3);
            var decimal = ol.proj.transform(coordinate, 'EPSG:3857', 'EPSG:4326');
            convertirDecToDmsUtm(decimal);
        });

        
        inicializarMapa++;

        // Punto localizado
        puntosMapa = new ol.layer.Vector({
            source: new ol.source.Vector(),
            map: mapa,
            style: new ol.style.Style({
                image: new ol.style.Circle({
                    radius: 9,
                    fill: new ol.style.Fill({color: '#34bfa3'}), 
                    stroke: new ol.style.Stroke({color: '#03715b'})
                })
            })
        });

        var convertirDecToDmsUtm = function (coordenada) {
            swal({
                title: 'Cargando tab!',
                text: 'Procesando datos',
                imageUrl: 'images/loading/loading05.gif',
                showConfirmButton: false,
                allowEnterKey: false,
                allowOutsideClick: false,
                allowEscapeKey: false,
            });
            $.post("{/literal}{$getModule}{literal}&accion=general_convertirDecToDmsUtm"
                , {
                    coordenada: coordenada
                }
                , function (respuesta, textStatus, jqXHR) {
                    $('#mapa_lat_gra').val(respuesta.lat_gra);
                    $('#mapa_lat_min').val(respuesta.lat_min);
                    $('#mapa_lat_seg').val(respuesta.lat_seg);
                    $('#mapa_lon_gra').val(respuesta.lon_gra);
                    $('#mapa_lon_min').val(respuesta.lon_min);
                    $('#mapa_lon_seg').val(respuesta.lon_seg);
                    $('#mapa_latitudDec').val(respuesta.lat_decimal);
                    $('#mapa_longitudDec').val(respuesta.lon_decimal);
                    $('#mapa_latitudUtm').val(respuesta.lat_utm);
                    $('#mapa_longitudUtm').val(respuesta.lon_utm);
                    $('#mapa_utmZona').val(respuesta.zona_utm).trigger('change');

                    var latAux = respuesta.lat_gra+'° '+respuesta.lat_min+'\' '+respuesta.lat_seg+'"';
                    var lonAux = respuesta.lon_gra+'° '+respuesta.lon_min+'\' '+respuesta.lon_seg+'"';
                    $('#texto_latitud').html(latAux);
                    $('#texto_longitud').html(lonAux);
                    $('#texto_latitudDec').html(respuesta.lat_decimal);
                    $('#texto_longitudDec').html(respuesta.lon_decimal);
                    $('#texto_latitudUtm').html(respuesta.lat_utm);
                    $('#texto_longitudUtm').html(respuesta.lon_utm);
                    $('#texto_utmZona').html(respuesta.zona_utm);

                    swal.close();
                    fijarPunto(parseFloat(respuesta.lon_decimal), parseFloat(respuesta.lat_decimal));
                    centrarMapa(parseFloat(respuesta.lon_decimal), parseFloat(respuesta.lat_decimal));
                    btn_asignar_coordenada.prop('disabled', false);
                }
                , 'json');
        };

        generarEscala();
    };

    var initCampos = function() {
        $('#mapa_lat_gra').val($('#lat_gra').val());
        $('#mapa_lat_min').val($('#lat_min').val());
        $('#mapa_lat_seg').val($('#lat_seg').val());
        $('#mapa_lon_gra').val($('#lon_gra').val());
        $('#mapa_lon_min').val($('#lon_min').val());
        $('#mapa_lon_seg').val($('#lon_seg').val());
        $('#mapa_latitudDec').val($('#latitudDec').val());
        $('#mapa_longitudDec').val($('#longitudDec').val());
        $('#mapa_latitudUtm').val($('#latitudUtm').val());
        $('#mapa_longitudUtm').val($('#longitudUtm').val());

        if ($('#utmZona').val() != '') {
            $('#mapa_utmZona').val($('#utmZona').val()).trigger('change');
        }

        var latAux = $('#lat_gra').val()+'° '+$('#lat_min').val()+'\' '+$('#lat_seg').val()+'"';
        var lonAux = $('#lon_gra').val()+'° '+$('#lon_min').val()+'\' '+$('#lon_seg').val()+'"';
        $('#texto_latitud').html(latAux);
        $('#texto_longitud').html(lonAux);
        $('#texto_latitudDec').html($('#latitudDec').val());
        $('#texto_longitudDec').html($('#longitudDec').val());
        $('#texto_latitudUtm').html($('#latitudUtm').val());
        $('#texto_longitudUtm').html($('#longitudUtm').val());
        $('#texto_utmZona').html($('#utmZona').val());
    };

    var generarEscala = function() {
        // Variables de escala
        var canvas = $('canvas').get(0); 
        //get the Scaleline div container the style-width property
        var olscale = $('.ol-scale-line-inner');
        //Scaleline thicknes
        var line1 = 6;
        //Offset from the left
        var x_offset = 10;
        //offset from the bottom
        var y_offset = 40;
        var fontsize1 = 15;
        var font1 = 'bold ' + fontsize1 + 'px Arial';
        // how big should the scale be (original css-width multiplied)
        var multiplier = 2;

        var dibujarEscala = function(e) {
            var ctx = e.context;
            //var scalewidth = parseInt(olscale.css('width'),10)*multiplier;
            var scalewidth = parseInt(55,10)*multiplier;
            var scale = olscale.text();
            var scalenumber = (parseInt(scale,10)*multiplier)/2;
            var scaleunit = scale.match(/[Aa-zZ]{1,}/g);

            //Scale Text
            ctx.beginPath();
            ctx.textAlign = "left";
            ctx.strokeStyle = "#ffffff";
            ctx.fillStyle = "#000000";
            ctx.lineWidth = 2;
            ctx.font = font1;
            ctx.strokeText([scalenumber + ' ' + scaleunit], x_offset + fontsize1 / 2, canvas.height - y_offset - fontsize1 / 2);
            ctx.fillText([scalenumber + ' ' + scaleunit], x_offset + fontsize1 / 2, canvas.height - y_offset - fontsize1 / 2);

            //Scale Dimensions
            var xzero = scalewidth + x_offset;
            var yzero = canvas.height - y_offset;
            var xfirst = x_offset + scalewidth * 1 / 4;
            var xsecond = xfirst + scalewidth * 1 / 4;
            var xthird = xsecond + scalewidth * 1 / 4;
            var xfourth = xthird + scalewidth * 1 / 4;

            // Stroke
            ctx.beginPath();
            ctx.lineWidth = line1 + 2;
            ctx.strokeStyle = "#000000";
            ctx.fillStyle = "#ffffff";
            ctx.moveTo(x_offset, yzero);
            ctx.lineTo(xzero + 1, yzero);
            ctx.stroke();

            //sections black/white
            ctx.beginPath();
            ctx.lineWidth = line1;
            ctx.strokeStyle = "#000000";
            ctx.moveTo(x_offset, yzero);
            ctx.lineTo(xfirst, yzero);
            ctx.stroke();

            ctx.beginPath();
            ctx.lineWidth = line1;
            ctx.strokeStyle = "#FFFFFF";
            ctx.moveTo(xfirst, yzero);
            ctx.lineTo(xsecond, yzero);
            ctx.stroke();

            ctx.beginPath();
            ctx.lineWidth = line1;
            ctx.strokeStyle = "#000000";
            ctx.moveTo(xsecond, yzero);
            ctx.lineTo(xthird, yzero);
            ctx.stroke();

            ctx.beginPath();
            ctx.lineWidth = line1;
            ctx.strokeStyle = "#FFFFFF";
            ctx.moveTo(xthird, yzero);
            ctx.lineTo(xfourth, yzero);
            ctx.stroke();
        };

        mapa.on('postcompose', function (evt) {
            dibujarEscala(evt);
        });
    };

    var centrarMapa = function(longitud, latitud) {
        var punto = ol.proj.transform([longitud, latitud], 'EPSG:4326', 'EPSG:3857');
        var pan = ol.animation.pan({
            source: mapa.getView().getCenter()
        });
        mapa.beforeRender(pan);
        mapa.getView().setCenter(punto);
    };

    var fijarPunto = function(longitud, latitud) {
        var featurePunto = new ol.Feature({
            geometry: new ol.geom.Point(ol.proj.transform([longitud, latitud], 'EPSG:4326', 'EPSG:3857')),
            name: 'punto',
            population: 4000,
            rainfall: 500
        });

        if (featurePunto !== puntoSeleccionado) {
            if (puntoSeleccionado) {
                puntosMapa.getSource().removeFeature(puntoSeleccionado);
            }
            if (featurePunto) {
                puntosMapa.getSource().addFeature(featurePunto);
            }
            puntoSeleccionado = featurePunto;
        }
    };

	var snippet_mapa_form = function() {
        var campo_latitud_grado = $('#mapa_lat_gra');
        var campo_latitud_minuto = $('#mapa_lat_min');
        var campo_latitud_segundo = $('#mapa_lat_seg');
        var campo_longitud_grado = $('#mapa_lon_gra');
        var campo_longitud_minuto = $('#mapa_lon_min');
        var campo_longitud_segundo = $('#mapa_lon_seg');
        var campo_latitud_utm = $('#mapa_latitudUtm');
        var campo_longitud_utm = $('#mapa_longitudUtm');
        var campo_select_zona = $('#mapa_utmZona');

        var btn_convertir_lat_lon = $('#btn_convertir_lat_lon');
        var btn_convertir_utm = $('#btn_convertir_utm');
        var btn_mapa_inicio = $('#btn_mapa_inicio');
        btn_asignar_coordenada = $('#btn_asignar_coordenada');
        btn_asignar_coordenada.prop('disabled', true);

        var convertirDmsToDecUtm = function () {
            swal({
                title: 'Cargando tab!',
                text: 'Procesando datos',
                imageUrl: 'images/loading/loading05.gif',
                showConfirmButton: false,
                allowEnterKey: false,
                allowOutsideClick: false,
                allowEscapeKey: false,
            });
            $.post("{/literal}{$getModule}{literal}&accion=general_convertirDmsToDecUtm"
                , {
                    lat_gra: parseInt($('#mapa_lat_gra').val()),
                    lat_min: parseInt($('#mapa_lat_min').val()),
                    lat_seg: parseFloat($('#mapa_lat_seg').val()),
                    lon_gra: parseInt($('#mapa_lon_gra').val()),
                    lon_min: parseInt($('#mapa_lon_min').val()),
                    lon_seg: parseFloat($('#mapa_lon_seg').val())
                }
                , function (respuesta, textStatus, jqXHR) {
                    $('#mapa_latitudDec').val(respuesta.lat_decimal);
                    $('#mapa_longitudDec').val(respuesta.lon_decimal);
                    $('#mapa_latitudUtm').val(respuesta.lat_utm);
                    $('#mapa_longitudUtm').val(respuesta.lon_utm);
                    $('#mapa_utmZona').val(respuesta.zona_utm).trigger('change');

                    var latAux = $('#mapa_lat_gra').val()+'° '+$('#mapa_lat_min').val()+'\' '+$('#mapa_lat_seg').val()+'"';
                    var lonAux = $('#mapa_lon_gra').val()+'° '+$('#mapa_lon_min').val()+'\' '+$('#mapa_lon_seg').val()+'"';
                    $('#texto_latitud').html(latAux);
                    $('#texto_longitud').html(lonAux);
                    $('#texto_latitudDec').html(respuesta.lat_decimal);
                    $('#texto_longitudDec').html(respuesta.lon_decimal);
                    $('#texto_latitudUtm').html(respuesta.lat_utm);
                    $('#texto_longitudUtm').html(respuesta.lon_utm);
                    $('#texto_utmZona').html(respuesta.zona_utm);

                    swal.close();
                    fijarPunto(parseFloat(respuesta.lon_decimal), parseFloat(respuesta.lat_decimal));
                    centrarMapa(parseFloat(respuesta.lon_decimal), parseFloat(respuesta.lat_decimal));
                    btn_asignar_coordenada.prop('disabled', false);
                }
                , 'json');
        };

        var convertirUtmToDecDms = function () {
            swal({
                title: 'Cargando tab!',
                text: 'Procesando datos',
                imageUrl: 'images/loading/loading05.gif',
                showConfirmButton: false,
                allowEnterKey: false,
                allowOutsideClick: false,
                allowEscapeKey: false,
            });
            $.post("{/literal}{$getModule}{literal}&accion=general_convertirUtmToDecDms"
                , {
                    lat_utm: parseFloat($('#mapa_latitudUtm').val()),
                    lon_utm: parseFloat($('#mapa_longitudUtm').val()),
                    zona_utm: $('#mapa_utmZona').val()
                }
                , function (respuesta, textStatus, jqXHR) {
                    $('#mapa_lat_gra').val(respuesta.lat_gra);
                    $('#mapa_lat_min').val(respuesta.lat_min);
                    $('#mapa_lat_seg').val(respuesta.lat_seg);
                    $('#mapa_lon_gra').val(respuesta.lon_gra);
                    $('#mapa_lon_min').val(respuesta.lon_min);
                    $('#mapa_lon_seg').val(respuesta.lon_seg);
                    $('#mapa_latitudDec').val(respuesta.lat_decimal);
                    $('#mapa_longitudDec').val(respuesta.lon_decimal);

                    var latAux = respuesta.lat_gra+'° '+respuesta.lat_min+'\' '+respuesta.lat_seg+'"';
                    var lonAux = respuesta.lon_gra+'° '+respuesta.lon_min+'\' '+respuesta.lon_seg+'"';
                    $('#texto_latitud').html(latAux);
                    $('#texto_longitud').html(lonAux);
                    $('#texto_latitudDec').html(respuesta.lat_decimal);
                    $('#texto_longitudDec').html(respuesta.lon_decimal);
                    $('#texto_latitudUtm').html($('#mapa_latitudUtm').val());
                    $('#texto_longitudUtm').html($('#mapa_longitudUtm').val());
                    $('#texto_utmZona').html($('#mapa_utmZona').val());

                    swal.close();
                    fijarPunto(parseFloat(respuesta.lon_decimal), parseFloat(respuesta.lat_decimal));
                    centrarMapa(parseFloat(respuesta.lon_decimal), parseFloat(respuesta.lat_decimal));
                    btn_asignar_coordenada.prop('disabled', false);
                }
                , 'json');
        };

        var obtenerUbicacionGeografica = function () {
            swal({
                title: 'Cargando tab!',
                text: 'Procesando datos',
                imageUrl: 'images/loading/loading05.gif',
                showConfirmButton: false,
                allowEnterKey: false,
                allowOutsideClick: false,
                allowEscapeKey: false,
            });
            $.post("{/literal}{$getModule}{literal}&accion=general_obtenerUbicacionGeografica"
                , {
                    lat_decimal: $('#mapa_latitudDec').val(),
                    lon_decimal: $('#mapa_longitudDec').val()
                }
                , function (respuesta, textStatus, jqXHR) {
                    if (respuesta.res == 1) {
                        swal.close();
                        departamento_id = respuesta.deptoId;
                        provincia_id = respuesta.provinciaId;
                        municipio_id = respuesta.municipioId;
                        get_provincias(departamento_id);
                        get_municipios(provincia_id);
                        get_comunidades(municipio_id);
                        $('#departamentoId').val(departamento_id).trigger('change.select2');
                        $('#cuencaId').val(respuesta.macroId).trigger('change.select2');
                    } else {
                        swal("Ocurrió un error!", "No se pudo conectar con ls BD PostgreSQL.", "error");
                    }
                }
                , 'json');
        };

        var handle_general_components = function(){
            $('.select2').select2({
                placeholder: "Seleccione una opción"
            });
        };

        var validar_latitud_grado = function() {
            var grado = parseInt($('#mapa_lat_gra').val());
            if ($('#mapa_lat_gra').val() == '') {
                return false;
            }
            if (grado >= 8 && grado <= 24) {
                return true;
            } else {
                return false;
            }
        };

        var validar_latitud_minuto = function() {
            var minuto = parseInt($('#mapa_lat_min').val());
            if ($('#mapa_lat_min').val() == '') {
                return false;
            }
            if (minuto >= 0 && minuto <= 59) {
                return true;
            } else {
                return false;
            }
        };

        var validar_latitud_segundo = function() {
            var segundo = parseFloat($('#mapa_lat_seg').val());
            if ($('#mapa_lat_seg').val() == '') {
                return false;
            }
            if (segundo >= 0 && segundo <= 59.999) {
                return true;
            } else {
                return false;
            }
        };

        var validar_longitud_grado = function() {
            var grado = parseInt($('#mapa_lon_gra').val());
            if ($('#mapa_lon_gra').val() == '') {
                return false;
            }
            if (grado >= 55 && grado <= 70) {
                return true;
            } else {
                return false;
            }
        };

        var validar_longitud_minuto = function() {
            var minuto = parseInt($('#mapa_lon_min').val());
            if ($('#mapa_lon_min').val() == '') {
                return false;
            }
            if (minuto >= 0 && minuto <= 59) {
                return true;
            } else {
                return false;
            }
        };

        var validar_longitud_segundo = function() {
            var segundo = parseFloat($('#mapa_lon_seg').val());
            if ($('#mapa_lon_seg').val() == '') {
                return false;
            }
            if (segundo >= 0 && segundo <= 59.999) {
                return true;
            } else {
                return false;
            }
        };

        var validar_utm_este = function() {
            var latitudUtm = parseFloat($('#mapa_latitudUtm').val());
            if ($('#mapa_latitudUtm').val() == '') {
                return false;
            }
            if (latitudUtm >= 0 && latitudUtm <= 999999.999) {
                return true;
            } else {
                return false;
            }
        };

        var validar_utm_norte = function() {
            var longitudUtm = parseFloat($('#mapa_longitudUtm').val());
            if ($('#mapa_longitudUtm').val() == '') {
                return false;
            }
            if (longitudUtm >= 0 && longitudUtm <= 9999999.999) {
                return true;
            } else {
                return false;
            }
        };

        var validar_utm_zona = function() {
            if ($('#mapa_utmZona').val() == '') {
                return false;
            } else {
                return true;
            }
        };

        var handle_get_components = function() {
            campo_latitud_grado.focusout(function () {
                if (!validar_latitud_grado()) {
                    swal('Advertencia!','Campo Grados (Latitud sud), debe contener valores numéricos entre 8 y 24.','warning');
                    $('#mapa_lat_gra').val('');
                }
            });

            campo_latitud_minuto.focusout(function () {
                if (!validar_latitud_minuto()) {
                    swal('Advertencia!','Campo Minutos (Latitud sud), debe contener valores numéricos entre 0 y 59.','warning');
                    $('#mapa_lat_min').val('');
                }
            });

            campo_latitud_segundo.focusout(function () {
                if (!validar_latitud_segundo()) {
                    swal('Advertencia!','Campo Segundos (Latitud sud), debe contener valores numéricos entre 0 y 59.999 (2 enteros y 3 decimales como máximo).','warning');
                    $('#mapa_lat_seg').val('');
                }
            });

            campo_longitud_grado.focusout(function () {
                if (!validar_longitud_grado()) {
                    swal('Advertencia!','Campo Grados (Longitud oeste), debe contener valores numéricos entre 55 y 70.','warning');
                    $('#mapa_lon_gra').val('');
                }
            });

            campo_longitud_minuto.focusout(function () {
                if (!validar_longitud_minuto()) {
                    swal('Advertencia!','Campo Minutos (Longitud oeste), debe contener valores numéricos entre 0 y 59.','warning');
                    $('#mapa_lon_min').val('');
                }
            });

            campo_longitud_segundo.focusout(function () {
                if (!validar_longitud_segundo()) {
                    swal('Advertencia!','Campo Segundos (Longitud oeste), debe contener valores numéricos entre 0 y 59.999 (2 enteros y 3 decimales como máximo).','warning');
                    $('#mapa_lon_seg').val('');
                }
            });

            campo_latitud_utm.focusout(function () {
                if (!validar_utm_este()) {
                    swal('Advertencia!','Campo UTM este, debe contener valores numéricos entre 0 y 999999.999 (6 enteros y 3 decimales como máximo).','warning');
                    $('#mapa_latitudUtm').val('');
                }
            });

            campo_longitud_utm.focusout(function () {
                if (!validar_utm_norte()) {
                    swal('Advertencia!','Campo UTM norte, debe contener valores numéricos entre 0 y 9999999.999 (7 enteros y 3 decimales como máximo).','warning');
                    $('#mapa_longitudUtm').val('');
                }
            });

            campo_select_zona.change(function () {
                if (!validar_utm_zona()) {
                    swal('Advertencia!','Campo Zona, seleccione una opción.','warning');
                    $('#mapa_utmZona').val('');
                }
            });

            btn_convertir_lat_lon.click(function() {
                if (validar_latitud_grado() && validar_latitud_minuto() && validar_latitud_segundo() && validar_longitud_grado() && validar_longitud_minuto() && validar_longitud_segundo()) {
                    convertirDmsToDecUtm();
                } else {
                    swal('Advertencia!','Ingrese datos válidos en los campos de latitud y longitud.','warning');
                }
            });

            btn_convertir_utm.click(function() {
                if (validar_utm_este() && validar_utm_norte() && validar_utm_zona()) {
                    convertirUtmToDecDms();
                } else {
                    swal('Advertencia!','Ingrese datos válidos en los campos UTM este, UTM norte y Zona.','warning');
                }
            });

            btn_asignar_coordenada.click(function() {
                $('#lat_gra').val($('#mapa_lat_gra').val());
                $('#lat_min').val($('#mapa_lat_min').val());
                $('#lat_seg').val($('#mapa_lat_seg').val());
                $('#lon_gra').val($('#mapa_lon_gra').val());
                $('#lon_min').val($('#mapa_lon_min').val());
                $('#lon_seg').val($('#mapa_lon_seg').val());

                $('#latitudDec').val($('#mapa_latitudDec').val());
                $('#longitudDec').val($('#mapa_longitudDec').val());

                $('#latitudUtm').val($('#mapa_latitudUtm').val());
                $('#longitudUtm').val($('#mapa_longitudUtm').val());
                $('#utmZona').val($('#mapa_utmZona').val()).trigger('change');
                btn_asignar_coordenada.prop('disabled', true);
                $('#modal_mapa').modal('hide');

                obtenerUbicacionGeografica();
            });

            btn_mapa_inicio.click(function() {
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
                mapa.getView().setZoom(5);
            });
        }

        //== Public Functions
        return {
            // public functions
            init: function() {
                handle_general_components();
                handle_get_components();
            }
        };
    } ();

    //== Class Initialization
    jQuery(document).ready(function() {
        snippet_mapa_form.init();
        $('#mapa_lat_lon').hide();
        $('#mapa_utm').hide();
        $('#modal_mapa').on('shown.bs.modal', function() {
           if (inicializarMapa === 0) {
                initMapa();
           }
           initCampos();
        });
    });
</script>
{/literal}