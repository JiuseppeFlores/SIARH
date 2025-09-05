{literal}
<script>
    var pi = 3.14159265358979;

    /* Ellipsoid model constants (actual values here are for WGS84) */
    var sm_a = 6378137.0;
    var sm_b = 6356752.314;
    var sm_EccSquared = 6.69437999013e-03;

    var UTMScaleFactor = 0.9996;

    var Geo = {};

    Geo.parseDMS = function (dmsStr) {
        if (typeof deg == 'object') throw new TypeError('Geo.parseDMS - dmsStr is [DOM?] object');

        // check for signed decimal degrees without NSEW, if so return it directly
        if (typeof dmsStr === 'number' && isFinite(dmsStr)) return Number(dmsStr);

        // strip off any sign or compass dir'n & split out separate d/m/s
        var dms = String(dmsStr).trim().replace(/^-/, '').replace(/[NSEW]$/i, '').split(/[^0-9.,]+/);
        if (dms[dms.length - 1] == '') dms.splice(dms.length - 1);  // from trailing symbol

        if (dms == '') return NaN;

        // and convert to decimal degrees...
        switch (dms.length) {
            case 3:  // interpret 3-part result as d/m/s
                var deg = dms[0] / 1 + dms[1] / 60 + dms[2] / 3600;
                break;
            case 2:  // interpret 2-part result as d/m
                var deg = dms[0] / 1 + dms[1] / 60;
                break;
            case 1:  // just d (possibly decimal) or non-separated dddmmss
                var deg = dms[0];
                // check for fixed-width unseparated format eg 0033709W
                //if (/[NS]/i.test(dmsStr)) deg = '0' + deg;  // - normalise N/S to 3-digit degrees
                //if (/[0-9]{7}/.test(deg)) deg = deg.slice(0,3)/1 + deg.slice(3,5)/60 + deg.slice(5)/3600;
                break;
            default:
                return NaN;
        }
        if (/^-|[WS]$/i.test(dmsStr.trim())) deg = -deg; // take '-', west and south as -ve
        return Number(deg);
    }

    Geo.toDMS = function (deg, format, dp) {
        if (typeof deg == 'object') throw new TypeError('Geo.toDMS - deg is [DOM?] object');
        if (isNaN(deg)) return null;  // give up here if we can't make a number from deg

        // default values
        if (typeof format == 'undefined') format = 'dms';
        if (typeof dp == 'undefined') {
            switch (format) {
                case 'd': dp = 4; break;
                case 'dm': dp = 2; break;
                case 'dms': dp = 0; break;
                default: format = 'dms'; dp = 0;  // be forgiving on invalid format
            }
        }

        deg = Math.abs(deg);  // (unsigned result ready for appending compass dir'n)

        switch (format) {
            case 'd':
                d = deg.toFixed(dp);     // round degrees
                if (d < 100) d = '0' + d;  // pad with leading zeros
                if (d < 10) d = '0' + d;
                dms = d + '\u00B0';      // add º symbol
                break;
            case 'dm':
                var min = (deg * 60).toFixed(dp);  // convert degrees to minutes & round
                var d = Math.floor(min / 60);    // get component deg/min
                var m = (min % 60).toFixed(dp);  // pad with trailing zeros
                if (d < 100) d = '0' + d;          // pad with leading zeros
                if (d < 10) d = '0' + d;
                if (m < 10) m = '0' + m;
                dms = d + '\u00B0' + m + '\u2032';  // add º, ' symbols
                break;
            /*case 'dms':
                var sec = (deg * 3600).toFixed(dp);  // convert degrees to seconds & round
                var d = Math.floor(sec / 3600);    // get component deg/min/sec
                var m = Math.floor(sec / 60) % 60;
                var s = (sec % 60).toFixed(dp);    // pad with trailing zeros
                if (d < 100) d = '0' + d;            // pad with leading zeros
                if (d < 10) d = '0' + d;
                if (m < 10) m = '0' + m;
                if (s < 10) s = '0' + s;
                dms = d + '\u00B0' + m + '\u2032' + s + '\u2033';  // add º, ', " symbols
                break;*/
            case 'dms':
                var sec = (deg * 3600).toFixed(dp);  // convert degrees to seconds & round
                var d = Math.floor(sec / 3600);    // get component deg/min/sec
                var m = Math.floor(sec / 60) % 60;
                var s = (sec % 60).toFixed(dp);    // pad with trailing zeros
                /*if (d < 100) d = '0' + d;            // pad with leading zeros
                if (d < 10) d = '0' + d;
                if (m < 10) m = '0' + m;
                if (s < 10) s = '0' + s;
                dms = d + '\u00B0' + m + '\u2032' + s + '\u2033';  // add º, ', " symbols*/
                dms = [d, m, s];
                break;
        }

        return dms;
    }

    function DegToRad (deg)
    {
        return (deg / 180.0 * pi)
    }

    function RadToDeg (rad)
    {
        return (rad / pi * 180.0)
    }

    function ArcLengthOfMeridian (phi)
    {
        var alpha, beta, gamma, delta, epsilon, n;
        var result;

        /* Precalculate n */
        n = (sm_a - sm_b) / (sm_a + sm_b);

        /* Precalculate alpha */
        alpha = ((sm_a + sm_b) / 2.0)
           * (1.0 + (Math.pow (n, 2.0) / 4.0) + (Math.pow (n, 4.0) / 64.0));

        /* Precalculate beta */
        beta = (-3.0 * n / 2.0) + (9.0 * Math.pow (n, 3.0) / 16.0)
           + (-3.0 * Math.pow (n, 5.0) / 32.0);

        /* Precalculate gamma */
        gamma = (15.0 * Math.pow (n, 2.0) / 16.0)
            + (-15.0 * Math.pow (n, 4.0) / 32.0);

        /* Precalculate delta */
        delta = (-35.0 * Math.pow (n, 3.0) / 48.0)
            + (105.0 * Math.pow (n, 5.0) / 256.0);

        /* Precalculate epsilon */
        epsilon = (315.0 * Math.pow (n, 4.0) / 512.0);

        /* Now calculate the sum of the series and return */
        result = alpha
            * (phi + (beta * Math.sin (2.0 * phi))
                + (gamma * Math.sin (4.0 * phi))
                + (delta * Math.sin (6.0 * phi))
                + (epsilon * Math.sin (8.0 * phi)));

        return result;
    }

    function UTMCentralMeridian (zone)
    {
        var cmeridian;

        cmeridian = DegToRad (-183.0 + (zone * 6.0));

        return cmeridian;
    }

    function FootpointLatitude (y)
    {
        var y_, alpha_, beta_, gamma_, delta_, epsilon_, n;
        var result;

        /* Precalculate n (Eq. 10.18) */
        n = (sm_a - sm_b) / (sm_a + sm_b);

        /* Precalculate alpha_ (Eq. 10.22) */
        /* (Same as alpha in Eq. 10.17) */
        alpha_ = ((sm_a + sm_b) / 2.0)
            * (1 + (Math.pow (n, 2.0) / 4) + (Math.pow (n, 4.0) / 64));

        /* Precalculate y_ (Eq. 10.23) */
        y_ = y / alpha_;

        /* Precalculate beta_ (Eq. 10.22) */
        beta_ = (3.0 * n / 2.0) + (-27.0 * Math.pow (n, 3.0) / 32.0)
            + (269.0 * Math.pow (n, 5.0) / 512.0);

        /* Precalculate gamma_ (Eq. 10.22) */
        gamma_ = (21.0 * Math.pow (n, 2.0) / 16.0)
            + (-55.0 * Math.pow (n, 4.0) / 32.0);

        /* Precalculate delta_ (Eq. 10.22) */
        delta_ = (151.0 * Math.pow (n, 3.0) / 96.0)
            + (-417.0 * Math.pow (n, 5.0) / 128.0);

        /* Precalculate epsilon_ (Eq. 10.22) */
        epsilon_ = (1097.0 * Math.pow (n, 4.0) / 512.0);

        /* Now calculate the sum of the series (Eq. 10.21) */
        result = y_ + (beta_ * Math.sin (2.0 * y_))
            + (gamma_ * Math.sin (4.0 * y_))
            + (delta_ * Math.sin (6.0 * y_))
            + (epsilon_ * Math.sin (8.0 * y_));

        return result;
    }

    function MapLatLonToXY (phi, lambda, lambda0, xy)
    {
        var N, nu2, ep2, t, t2, l;
        var l3coef, l4coef, l5coef, l6coef, l7coef, l8coef;
        var tmp;

        /* Precalculate ep2 */
        ep2 = (Math.pow (sm_a, 2.0) - Math.pow (sm_b, 2.0)) / Math.pow (sm_b, 2.0);

        /* Precalculate nu2 */
        nu2 = ep2 * Math.pow (Math.cos (phi), 2.0);

        /* Precalculate N */
        N = Math.pow (sm_a, 2.0) / (sm_b * Math.sqrt (1 + nu2));

        /* Precalculate t */
        t = Math.tan (phi);
        t2 = t * t;
        tmp = (t2 * t2 * t2) - Math.pow (t, 6.0);

        /* Precalculate l */
        l = lambda - lambda0;

        /* Precalculate coefficients for l**n in the equations below
           so a normal human being can read the expressions for easting
           and northing
           -- l**1 and l**2 have coefficients of 1.0 */
        l3coef = 1.0 - t2 + nu2;

        l4coef = 5.0 - t2 + 9 * nu2 + 4.0 * (nu2 * nu2);

        l5coef = 5.0 - 18.0 * t2 + (t2 * t2) + 14.0 * nu2
            - 58.0 * t2 * nu2;

        l6coef = 61.0 - 58.0 * t2 + (t2 * t2) + 270.0 * nu2
            - 330.0 * t2 * nu2;

        l7coef = 61.0 - 479.0 * t2 + 179.0 * (t2 * t2) - (t2 * t2 * t2);

        l8coef = 1385.0 - 3111.0 * t2 + 543.0 * (t2 * t2) - (t2 * t2 * t2);

        /* Calculate easting (x) */
        xy[0] = N * Math.cos (phi) * l
            + (N / 6.0 * Math.pow (Math.cos (phi), 3.0) * l3coef * Math.pow (l, 3.0))
            + (N / 120.0 * Math.pow (Math.cos (phi), 5.0) * l5coef * Math.pow (l, 5.0))
            + (N / 5040.0 * Math.pow (Math.cos (phi), 7.0) * l7coef * Math.pow (l, 7.0));

        /* Calculate northing (y) */
        xy[1] = ArcLengthOfMeridian (phi)
            + (t / 2.0 * N * Math.pow (Math.cos (phi), 2.0) * Math.pow (l, 2.0))
            + (t / 24.0 * N * Math.pow (Math.cos (phi), 4.0) * l4coef * Math.pow (l, 4.0))
            + (t / 720.0 * N * Math.pow (Math.cos (phi), 6.0) * l6coef * Math.pow (l, 6.0))
            + (t / 40320.0 * N * Math.pow (Math.cos (phi), 8.0) * l8coef * Math.pow (l, 8.0));

        return;
    }

    function MapXYToLatLon (x, y, lambda0, philambda)
    {
        var phif, Nf, Nfpow, nuf2, ep2, tf, tf2, tf4, cf;
        var x1frac, x2frac, x3frac, x4frac, x5frac, x6frac, x7frac, x8frac;
        var x2poly, x3poly, x4poly, x5poly, x6poly, x7poly, x8poly;

        /* Get the value of phif, the footpoint latitude. */
        phif = FootpointLatitude (y);

        /* Precalculate ep2 */
        ep2 = (Math.pow (sm_a, 2.0) - Math.pow (sm_b, 2.0))
              / Math.pow (sm_b, 2.0);

        /* Precalculate cos (phif) */
        cf = Math.cos (phif);

        /* Precalculate nuf2 */
        nuf2 = ep2 * Math.pow (cf, 2.0);

        /* Precalculate Nf and initialize Nfpow */
        Nf = Math.pow (sm_a, 2.0) / (sm_b * Math.sqrt (1 + nuf2));
        Nfpow = Nf;

        /* Precalculate tf */
        tf = Math.tan (phif);
        tf2 = tf * tf;
        tf4 = tf2 * tf2;

        /* Precalculate fractional coefficients for x**n in the equations
           below to simplify the expressions for latitude and longitude. */
        x1frac = 1.0 / (Nfpow * cf);

        Nfpow *= Nf;   /* now equals Nf**2) */
        x2frac = tf / (2.0 * Nfpow);

        Nfpow *= Nf;   /* now equals Nf**3) */
        x3frac = 1.0 / (6.0 * Nfpow * cf);

        Nfpow *= Nf;   /* now equals Nf**4) */
        x4frac = tf / (24.0 * Nfpow);

        Nfpow *= Nf;   /* now equals Nf**5) */
        x5frac = 1.0 / (120.0 * Nfpow * cf);

        Nfpow *= Nf;   /* now equals Nf**6) */
        x6frac = tf / (720.0 * Nfpow);

        Nfpow *= Nf;   /* now equals Nf**7) */
        x7frac = 1.0 / (5040.0 * Nfpow * cf);

        Nfpow *= Nf;   /* now equals Nf**8) */
        x8frac = tf / (40320.0 * Nfpow);

        /* Precalculate polynomial coefficients for x**n.
           -- x**1 does not have a polynomial coefficient. */
        x2poly = -1.0 - nuf2;

        x3poly = -1.0 - 2 * tf2 - nuf2;

        x4poly = 5.0 + 3.0 * tf2 + 6.0 * nuf2 - 6.0 * tf2 * nuf2
            - 3.0 * (nuf2 *nuf2) - 9.0 * tf2 * (nuf2 * nuf2);

        x5poly = 5.0 + 28.0 * tf2 + 24.0 * tf4 + 6.0 * nuf2 + 8.0 * tf2 * nuf2;

        x6poly = -61.0 - 90.0 * tf2 - 45.0 * tf4 - 107.0 * nuf2
            + 162.0 * tf2 * nuf2;

        x7poly = -61.0 - 662.0 * tf2 - 1320.0 * tf4 - 720.0 * (tf4 * tf2);

        x8poly = 1385.0 + 3633.0 * tf2 + 4095.0 * tf4 + 1575 * (tf4 * tf2);

        /* Calculate latitude */
        philambda[0] = phif + x2frac * x2poly * (x * x)
            + x4frac * x4poly * Math.pow (x, 4.0)
            + x6frac * x6poly * Math.pow (x, 6.0)
            + x8frac * x8poly * Math.pow (x, 8.0);

        /* Calculate longitude */
        philambda[1] = lambda0 + x1frac * x
            + x3frac * x3poly * Math.pow (x, 3.0)
            + x5frac * x5poly * Math.pow (x, 5.0)
            + x7frac * x7poly * Math.pow (x, 7.0);

        return;
    }

    function LatLonToUTMXY (lat, lon, zone, xy)
    {
        MapLatLonToXY (lat, lon, UTMCentralMeridian (zone), xy);

        /* Adjust easting and northing for UTM system. */
        xy[0] = xy[0] * UTMScaleFactor + 500000.0;
        xy[1] = xy[1] * UTMScaleFactor;
        if (xy[1] < 0.0)
            xy[1] = xy[1] + 10000000.0;

        return zone;
    }

    function UTMXYToLatLon (x, y, zone, southhemi, latlon)
    {
        var cmeridian;

        x -= 500000.0;
        x /= UTMScaleFactor;

        /* If in southern hemisphere, adjust y accordingly. */
        if (southhemi)
        y -= 10000000.0;

        y /= UTMScaleFactor;

        cmeridian = UTMCentralMeridian (zone);
        MapXYToLatLon (x, y, cmeridian, latlon);

        return;
    }

    function convertir_decimal_utm()
    {
        var xy = new Array(2);

        if($('#lat_gra').val() == '' || $('#lat_min').val() == '' || $('#lat_seg').val() == '') {
            return;
        }

        if($('#lon_gra').val() == '' || $('#lon_min').val() == '' || $('#lon_seg').val() == '') {
            return;
        }

        var latString = $('#lat_gra').val()+' '+$('#lat_min').val()+' '+$('#lat_seg').val()+'S';
        var lonString = $('#lon_gra').val()+' '+$('#lon_min').val()+' '+$('#lon_seg').val()+'W';

        var lat = Geo.parseDMS(latString);
        var lon = Geo.parseDMS(lonString);

        // Compute the UTM zone.
        zone = Math.floor ((lon + 180.0) / 6) + 1;
        zone = LatLonToUTMXY (DegToRad (lat), DegToRad (lon), zone, xy);

        var latUtm = Math.round(1000 * (parseFloat(xy[0])))/1000;
        var lonUtm = Math.round(1000 * (parseFloat(xy[1])))/1000;

        // Asignar valores a decimal
        $('#latitudDec').val(lat);
        $('#longitudDec').val(lon);
        $('#latitudUtm').val(latUtm);
        $('#longitudUtm').val(lonUtm);
        $('#utmZona').val(zone+'K').trigger('change.select2');

        return true;
    }

    function convertir_utm_decimal()
    {
        latlon = new Array(2);
        var x, y, zone, southhemi;

        if($('#latitudUtm').val() == '' || $('#longitudUtm').val() == '' || $('#utmZona').val() == '') {
            return;
        }

        x = parseFloat($('#latitudUtm').val());
        y = parseFloat($('#longitudUtm').val());
        zoneAux = $('#utmZona').val();
        zone = parseInt(zoneAux.substring(0, 2));
        southhemi = true;

        UTMXYToLatLon (x, y, zone, southhemi, latlon);

        var lat = RadToDeg(latlon[0]);
        var lon = RadToDeg(latlon[1]);
        var latDMS = Geo.toDMS(lat, "dms", 4);
        var lonDMS = Geo.toDMS(lon, "dms", 4);

        $('#latitudDec').val(parseFloat(lat));
        $('#longitudDec').val(parseFloat(lon));
        $('#lat_gra').val(parseFloat(latDMS[0]));
        $('#lat_min').val(parseFloat(latDMS[1]));
        $('#lat_seg').val(parseFloat(Math.round(1000*(latDMS[2]))/1000));
        $('#lon_gra').val(parseFloat(lonDMS[0]));
        $('#lon_min').val(parseFloat(lonDMS[1]));
        $('#lon_seg').val(parseFloat(Math.round(1000*(lonDMS[2]))/1000));

        return true;
    }
//------------------------------------------------------
    var departamento_id = 0;
    var provincia_id = 0;
    var municipio_id = 0;
    var get_provincias;
    var get_municipios;
    var get_comunidades;
    var get_localidades;

    var snippet_general_form = function() {
        var idficha = '{/literal}{$id}{literal}';
        var type = '{/literal}{$type}{literal}';
        var general_form = $('#general_form');
        var general_btn_submit = $('#general_submit');
        var select_get_provincias = $('#departamentoId');
        var select_get_municipios = $('#provinciaId');
        var select_get_comunidades = $('#municipioId');
        var select_get_localidades = $('#comunidadId');
        var option_ubicacion = $('input[type=radio][name=ubicacion]');

        var campo_input_pozo = $('input');
        //var campo_select = $('select');

        // var campo_latitud_grado = $('#lat_gra');
        // var campo_latitud_minuto = $('#lat_min');
        // var campo_latitud_segundo = $('#lat_seg');
        // var campo_longitud_grado = $('#lon_gra');
        // var campo_longitud_minuto = $('#lon_min');
        // var campo_longitud_segundo = $('#lon_seg');

        // var campo_latitud_utm = $('#latitudUtm');
        // var campo_longitud_utm = $('#longitudUtm');
        // var campo_select_zona = $('#utmZona');
        //== Private Functions
        var showRequest= function(formData, jqForm, op) {
            general_btn_submit.addClass('m-loader m-loader--right m-loader--light').attr('disabled', true);
            return true;
        };

        var showResponse = function (responseText, statusText) {
            general_btn_submit.removeClass('m-loader m-loader--right m-loader--light').attr('disabled', false);
            if(responseText.res ==1){
                if(responseText.accion == 'new') {
                    //swal({type: 'success',title: 'Buen Trabajo! Se guardó todo con éxito!',showConfirmButton: false, timer: 1000});
                    //$("#general_form")[0].reset();
                    swal("Creado!", "Se guardó el registro con éxito!", "success");

                }else if(responseText.accion == 'update') {
                    swal("Actualizado!", "Se actualizó el registro con éxito!", "success");
                    //swal({type: 'success',title: 'Actualizado! Se actualizó todo con éxito!',showConfirmButton: false, timer: 1000});
                }else{
                    location = "{/literal}{$getModule}{literal}";
                }
            }else if(responseText.res ==2){
                swal("Ocurrió un error!", responseText.msg, "error")
            }else{
                swal("ocurrió un error!", responseText.msg, "danger")
            }
        };

        get_provincias = function (id) {
            var provinciaOpt = $('#provinciaId').empty();
            $("#municipioId").empty();
            $("#comunidadId").empty();
            $("#localidadId").empty();
            $("#municipioId").append($('<option></option>').attr("value", "").text("--Seleccione una opción--"));
            $("#comunidadId").append($('<option></option>').attr("value", "").text("--Seleccione una opción--"));
            $("#localidadId").append($('<option></option>').attr("value", "").text("--Seleccione una opción--"));
            if(id!="") {
                $.post("{/literal}{$getModule}{literal}&accion=general_getProvincia"
                    , {deptoId: id}
                    , function (respuesta, textStatus, jqXHR) {
                        selOption = $('<option></option>');
                        provinciaOpt.append(selOption.attr("value", "").text("-- Seleccione una opción --"));
                        for (var clave in respuesta) {
                            provinciaOpt.append($('<option></option>').attr("value", respuesta[clave].itemId).text(respuesta[clave].nombre));
                        }
                        //provinciaOpt.trigger('chosen:updated');

                        if (provincia_id != 0) {
                            provinciaOpt.val(provincia_id).trigger('change.select2');
                            provincia_id = 0;
                        }
                    }
                    , 'json');
            } else {
                $("#provinciaId").append($('<option></option>').attr("value", "").text("--Seleccione una opción--"));
            }
        };

        get_municipios = function (id) {
            var municipioOpt = $('#municipioId').empty();
            $("#comunidadId").empty();
            $("#localidadId").empty();
            $("#comunidadId").append($('<option></option>').attr("value", "").text("--Seleccione una opción--"));
            $("#localidadId").append($('<option></option>').attr("value", "").text("--Seleccione una opción--"));
            if(id!="") {
                $.post("{/literal}{$getModule}{literal}&accion=general_getMunicipio"
                    , {provinciaId: id}
                    , function (respuesta, textStatus, jqXHR) {
                        selOption = $('<option></option>');
                        municipioOpt.append(selOption.attr("value", "").text("-- Seleccione una opción --"));
                        for (var clave in respuesta) {
                            municipioOpt.append($('<option></option>').attr("value", respuesta[clave].itemId).text(respuesta[clave].nombre));
                        }
                        //municipioOpt.trigger('chosen:updated');
                        if (municipio_id != 0) {
                            $('#municipioId').val(municipio_id).trigger('change.select2');
                            municipio_id = 0;
                        }
                    }
                    , 'json');
            } else {
                $("#municipioId").append($('<option></option>').attr("value", "").text("--Seleccione una opción--"));
            }
        };

        get_comunidades = function (id) {
            var comunidadOpt = $('#comunidadId').empty();
            $("#localidadId").empty();
            $("#localidadId").append($('<option></option>').attr("value", "").text("--Seleccione una opción--"));
            if(id!="") {
                $.post("{/literal}{$getModule}{literal}&accion=general_getComunidad"
                    , {municipioId: id}
                    , function (respuesta, textStatus, jqXHR) {
                        selOption = $('<option></option>');
                        comunidadOpt.append(selOption.attr("value", "").text("-- Seleccione una opción --"));
                        for (var clave in respuesta) {
                            comunidadOpt.append($('<option></option>').attr("value", respuesta[clave].itemId).text(respuesta[clave].nombre));
                        }
                        //provinciaOpt.trigger('chosen:updated');
                    }
                    , 'json');
            } else {
                $("#comunidadId").append($('<option></option>').attr("value", "").text("--Seleccione una opción--"));
            }
        };

        get_localidades = function (id) {
            var localidadOpt = $('#localidadId').empty();
            if(id!="") {
                $.post("{/literal}{$getModule}{literal}&accion=general_getLocalidad"
                    , {comunidadId: id}
                    , function (respuesta, textStatus, jqXHR) {
                        selOption = $('<option></option>');
                        localidadOpt.append(selOption.attr("value", "").text("-- Seleccione una opción --"));
                        for (var clave in respuesta) {
                            localidadOpt.append($('<option></option>').attr("value", respuesta[clave].itemId).text(respuesta[clave].nombre));
                        }
                        //provinciaOpt.trigger('chosen:updated');
                    }
                    , 'json');
            } else {
                selOption = $('<option></option>');
                localidadOpt.append(selOption.attr("value", "").text("--Seleccione una opción--"));
            }
        };

        var deshabilitar_latitud_longitud = function () {
            $('#lat_gra').attr('readonly', true);
            $('#lat_min').attr('readonly', true);
            $('#lat_seg').attr('readonly', true);
            //$('#latitudDec').attr('readonly', true);
            $('#lon_gra').attr('readonly', true);
            $('#lon_min').attr('readonly', true);
            $('#lon_seg').attr('readonly', true);
            //$('#longitudDec').attr('readonly', true);
        };

        var habilitar_latitud_longitud = function () {
            $('#lat_gra').attr('readonly', false);
            $('#lat_min').attr('readonly', false);
            $('#lat_seg').attr('readonly', false);
            //$('#latitudDec').attr('readonly', false);
            $('#lon_gra').attr('readonly', false);
            $('#lon_min').attr('readonly', false);
            $('#lon_seg').attr('readonly', false);
            //$('#longitudDec').attr('readonly', false);
            $('#lat_gra').focus();
        };

        var deshabilitar_utm = function () {
            $('#latitudUtm').attr('readonly', true);
            $('#longitudUtm').attr('readonly', true);
        };

        var habilitar_utm = function () {
            $('#latitudUtm').attr('readonly', false);
            $('#longitudUtm').attr('readonly', false);
            $('#latitudUtm').focus();
        };

        var mostrar_campos_latitud_longitud = function() {
            $('#mapa_utm').hide();
            $('#mapa_lat_lon').show();
        };

        var mostrar_campos_utm = function() {
            $('#mapa_lat_lon').hide();
            $('#mapa_utm').show();
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
            general_form.ajaxForm(options);
        };

        var handle_general_form_submit = function() {
            general_btn_submit.click(function(e) {
                if(estado == "Observado"){
                    set_registrado();
                }else if(estado != "Revisado"){
                    e.preventDefault();
                    var btn = $(this);
                    var form = $(this).closest('form');

                    form.validate({
                        rules: {
                            // "item[nombre]": {
                            //     required: true,
                            //     minlength: 3
                            // },
                            // "item[codigo]": {
                            //     required: true,
                            //     minlength: 1
                            // },
                            // "item[fecha_inicio]": {
                            //     required: true,
                            //     minlength: 3
                            // },
                            // "item[fecha_fin]": {
                            //     required: true,
                            //     minlength: 3
                            // },
                        }
                    });

                    if (!form.valid()) {
                        return;
                    }

                    general_form.submit();
                }
            });
        };

        var handle_general_components = function(){
            $('.fecha_general').datepicker({
                todayHighlight: true,
                orientation: "bottom left",
                format: 'dd/mm/yyyy',
                templates: {
                    leftArrow: '<i class="la la-angle-left"></i>',
                    rightArrow: '<i class="la la-angle-right"></i>'
                }
            });

            $('.select2').select2({
                //placeholder: "Seleccione una opción"
            });

            $('.summernote').summernote({
                height: 150
            });
        };

        var handle_get_components = function() {
            select_get_provincias.change(function() {
                get_provincias($('#departamentoId').val());
            });

            select_get_municipios.change(function() {
                get_municipios($('#provinciaId').val());
            });

            select_get_comunidades.change(function() {
                get_comunidades($('#municipioId').val());
            });

            select_get_localidades.change(function() {
                get_localidades($('#comunidadId').val());
            });

            option_ubicacion.change(function() {
                if (this.value == 'lat_lon') {
                    habilitar_latitud_longitud();
                    deshabilitar_utm();
                    mostrar_campos_latitud_longitud();
                    this.checked = false;
                }else if (this.value == 'utm') {
                    habilitar_utm();
                    deshabilitar_latitud_longitud();
                    mostrar_campos_utm();
                    this.checked = false;
                }
                $('#modal_mapa').modal('show');
            });

            campo_input_pozo.keyup(function () {
                general_form.validate();
            });

            /*campo_latitud_grado.focusout(function () {
               convertir_decimal_utm();
            });

            campo_latitud_minuto.focusout(function () {
                convertir_decimal_utm();
            });

            campo_latitud_segundo.focusout(function () {
                convertir_decimal_utm();
            });

            campo_longitud_grado.focusout(function () {
                convertir_decimal_utm();
            });

            campo_longitud_minuto.focusout(function () {
                convertir_decimal_utm();
            });

            campo_longitud_segundo.focusout(function () {
                convertir_decimal_utm();
            });

            campo_latitud_utm.focusout(function () {
                convertir_utm_decimal();
            });

            campo_longitud_utm.focusout(function () {
                convertir_utm_decimal();
            });

            campo_select_zona.change(function () {
                convertir_utm_decimal();
            });*/

            deshabilitar_utm();
            deshabilitar_latitud_longitud();
        }

        //== Public Functions
        return {
            // public functions
            init: function() {
                handle_general_form_submit();
                handle_form_submit();
                handle_general_components();
                handle_get_components();
            }
        };
    } ();

    $("#general_observado").click(function(){
        var id = "{/literal}{$id}{literal}";
        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=general_setObservado&idpozo='+id,
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            //dataType: "json",
            success: function(data){
                // obj_permiso = JSON.parse(data);
                if(data != "false"){
                    swal("Información", "Se marco la información como <strong>observado</strong>", "success");
                }else{
                    swal("Información", "<strong>No</strong> se pudo marcar la información como observado", "success");
                }
            },
        });
    });

    $("#general_revisado").click(function(){
        var id = "{/literal}{$id}{literal}";
        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=general_setRevisado&idpozo='+id,
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            //dataType: "json",
            success: function(data){
                // obj_permiso = JSON.parse(data);
                if(data != "false"){
                    swal("Información", "Se marco la información como <strong>revisado</strong>", "success");
                }else{
                    swal("Información", "<strong>No</strong> se pudo marcar la información como observado", "success");
                }
            },
        });
    });

    function set_registrado(){
        var id = "{/literal}{$id}{literal}";
        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=general_setRegistrado&idpozo='+id,
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            //dataType: "json",
            success: function(data){
                // obj_permiso = JSON.parse(data);
                if(data != "false"){
                    swal("Información", "Se marco la información como <strong>registrado</strong>", "success");
                }else{
                    swal("Información", "<strong>No</strong> se pudo marcar la información como observado", "success");
                }
            },
        });
    }

    var estado;
    function obtener_estado(){
        var id = "{/literal}{$id}{literal}";
        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=general_obtenerEstado&idpozo='+id,
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            //dataType: "json",
            success: function(data){
                //alert(data);
                var obj_permiso = JSON.parse(data);
                //alert(obj_permiso[0]["estado"]);
                if (Array.isArray(obj_permiso) && obj_permiso.length > 0 && obj_permiso[0].estado !== undefined) {
                    estado = obj_permiso[0].estado;
                } else {
                    estado = null;
                }
            },
        });
    }

//------------------------Permisos----------------------------------

    function permisos_usuario(){ //Hacemos una llamada al controlador del snippet index
        var idUsuarioResponsable = parseInt($('#idUsuarioResponsable').val());
        var type = '{/literal}{$type}{literal}';
        var id = "{/literal}{$id}{literal}";
        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=obtenerPermisos&perpozo=pozo&type='+type+'&id='+id, //&perpozo=pozo
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            //dataType: "json",
            success: function(data){
                // console.log('recuperando datos:::',data,type);
                obj_permiso = JSON.parse(data);
                switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if (obj_permiso[0].crear == 1 && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#general_submit").show();
                        }else{
                            $("#general_submit").hide();
                        }
                        $("#general_observado").hide();
                        $("#general_revisado").hide();
                        break;
                    case 3:
                        $("#general_submit").hide();
                        $("#general_observado").hide();
                        $("#general_revisado").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1){                                
                            $("#general_submit").show();
                        }else{
                            $("#general_submit").hide();
                        }
                        if (obj_permiso[0].editar == 1 && type == 'update'){
                            $("#general_observado").show();
                            $("#general_revisado").show();
                        }else{
                            $("#general_observado").hide();
                            $("#general_revisado").hide();
                        }
                        break;
                }
            },
        });
    }

    //== Class Initialization
    jQuery(document).ready(function() {
        permisos_usuario();
        snippet_general_form.init();
        $('[data-toggle="m-tooltip"]').click().tooltip();
        $("#general_observado").hide();
        $("#general_revisado").hide();
        obtener_estado();
    });
</script>
{/literal}
