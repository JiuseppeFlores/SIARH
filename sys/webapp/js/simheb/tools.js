/*
 * Codifica un objeto para ser enviado como un parámetro de una query string
 */
var b64EncodeUnicode = function(str) {
    return btoa(encodeURIComponent(str).replace(/%([0-9A-F]{2})/g, function(match, p1) {
        return String.fromCharCode(parseInt(p1, 16))
    }))
};
var b64DecodeUnicode = function(str) {
    return decodeURIComponent(Array.prototype.map.call(atob(str), function(c) {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2)
    }).join(''))
};
var encodeQueryStringObject = function(params) {
    // Codificar
    if (!params) params = {};
    console.log(JSON.stringify(params));
    //var string = b64EncodeUnicode(JSON.stringify( params )); AKIIIII: eliminado para DEBUG
    var string = JSON.stringify(params);
    return string;
};
var decodeQueryStringObject = function(string) {
    var tmp = b64DecodeUnicode(string);
    var params = JSON.parse(tmp);
    console.log(params);
    return params;
};

//--------------------------------------------------------
// Number formatting for legends and tooltips
//--------------------------------------------------------
function formatNumberByValue(value) {
    var ret = "";
    if ($.isNumeric(value)) {
        if (value == 0) return 0;
        ret = value.toFixed(1);
        if (Math.abs(ret) < 1.5) ret = value.toFixed(3);
        if (Math.abs(ret) < 0.5) ret = value.toFixed(4);
    }
    return ret;
};

function formatNumber(variable, value) {
    let ret = value;
    let decimals = 0;
    switch (variable) {
        case 'DEM':
        case 'VOL':
        case 'DV':
        case 'RS':
            decimals = 0;
            break;
        case 'HR':
        case 'PB':
        case 'PBD':
        case 'PBN':
        case 'PBM':
            decimals = 1;
            break;
        case 'TI':
        case 'PC':
        case 'TMD':
        case 'TMN':
        case 'TMM':
        case 'NIV':
        case 'VV':
            decimals = 2;
            break;
        case 'CS':
            decimals = 3;
            break;
        default:
            decimals = null;
    }
    if (decimals != null) {
        ret = value.toFixed(decimals);
    } else {
        ret = formatNumberByValue(value);
    }
    return ret;
}

//--------------------------------------------------------
// Obtiene un objeto Spinner de spin.js
//--------------------------------------------------------
var createSpinner = function() {
    var ret = new Spinner({
        lines: 13 // The number of lines to draw
            ,
        length: 28 // The length of each line
            ,
        width: 14 // The line thickness
            ,
        radius: 42 // The radius of the inner circle
            ,
        scale: 1 // Scales overall size of the spinner
            ,
        corners: 1 // Corner roundness (0..1)
            ,
        color: '#000' // #rgb or #rrggbb or array of colors
            ,
        opacity: 0.25 // Opacity of the lines
            ,
        rotate: 0 // The rotation offset
            ,
        direction: 1 // 1: clockwise, -1: counterclockwise
            ,
        speed: 1 // Rounds per second
            ,
        trail: 60 // Afterglow percentage
            ,
        fps: 20 // Frames per second when using setTimeout() as a fallback for CSS
            ,
        zIndex: 2e9 // The z-index (defaults to 2000000000)
            ,
        className: 'spinner' // The CSS class to assign to the spinner
            ,
        top: '50%' // Top position relative to parent
            ,
        left: '50%' // Left position relative to parent
            ,
        shadow: false // Whether to render a shadow
            ,
        hwaccel: false // Whether to use hardware acceleration
            ,
        position: 'absolute' // Element positioning
    });
    return ret;
};

var createSmallSpinner = function() {
    var ret = new Spinner({
        lines: 10,
        length: 12,
        width: 8,
        radius: 12,
        scale: 0.5,
        corners: 1,
        speed: 0.8,
        rotate: 0,
        animation: 'spinner-line-fade-more',
        direction: 1,
        color: 'ffffff',
        fadeColor: 'transparent',
        shadow: '0 0 1px transparent',
        top: '90%',
        left: '2rem',
        position: 'absolute'
    });
    return ret;
};
//--------------------------------------------------------
// Obtiene un dialog de BootstrapDialog.js con un mensaje de espera
//--------------------------------------------------------
var createWaitDialog = function(title) {

    $msg = $("<div/>");
    let $row = $("<div class='row' />");
    $row.append($("<div class='col-md-1'> <i class='fa fa-circle-o-notch fa-spin fa-fw'></i> </div>"));
    $row.append($("<div class='col-md-11'> Este proceso puede durar varios minutos.<br/>Esta ventana se cerrará automáticamente al finalizar. </div>"));
    $msg.append($row);
    var dialog = BootstrapDialog.show({
        type: BootstrapDialog.TYPE_PRIMARY,
        title: title,
        message: $msg,
        closable: false,
        draggable: false
    });
    return dialog;
};


//--------------------------------------------------------
// Obtiene un dialog de BootstrapDialog.js con un mensaje de error
//--------------------------------------------------------
var createWarningDialog = function(title, message) {

    $msg = $("<div/>");
    let $row = $("<div class='row' />");
    $row.append($("<div class='col-md-1'> <i class='fa fa-exclamation-circle'></i> </div>"));
    $row.append($("<div class='col-md-11'> " + message + "</div>"));
    $msg.append($row);
    var dialog = BootstrapDialog.show({
        type: BootstrapDialog.TYPE_WARNING,
        title: title,
        message: $msg,
        closable: true,
        draggable: false
    });
    return dialog;
};

var getColorByVariable = function(variable) {
    let color = '#000000';
    switch (variable) {
        case 'PC':        color = '#68CFE8'; break;
        case 'TI':
        case 'TMD':
        case 'TMM':
        case 'TMN':       color = '#F45B5F'; break;
        case 'HR':        color = '#8085E9'; break;
        case 'RS':        color = '#FB931D'; break;
        case 'CS':        color = '#993366'; break;
        case 'DEM':       color = '#BC1C3C'; break;
        case 'VOL':       color = '#91B3DF'; break;
        case 'NIV':       color = '#FFD800'; break;
        case 'DV':        color = '#000000'; break;
        case 'VV':        color = '#000000'; break;
        case 'PB':        color = '#000000'; break;
        case 'VA':        color = '#3366FF'; break;
        case 'VD':        color = '#993366'; break;
        case 'ETP':       color = '#2592C8'; break;
        case 'curva':     
        case 'elev_vol':  color = '#0000ff'; break;
        case 'elev_area': color = '#000000'; break;
    }
    return color;
}

var getYAxisByVariable = function(variable, tipoGrafica) {
    let yAxis = 0;
    switch (variable) {
        case 'curva':
        case 'elev_vol':
        case 'PC':
            yAxis = 0;
            break;
        case 'elev_area':
        case 'TI':
        case 'TMD':
        case 'TMM':
        case 'TMN':
            yAxis = 1;
            break;
        case 'HR':
            yAxis = 2;
            break;
        case 'RS':
            yAxis = 3;
            break;
        case 'CS':
            yAxis = 0;
            break;
        case 'DEM':
            yAxis = 1;
            break;
        case 'VOL':
            yAxis = 1;
            break;
        case 'NIV':
            yAxis = tipoGrafica === 'polar' ? 0 : 2;
            break;
        case 'PB':
        case 'PBN':
        case 'PBD':
        case 'PBM':
            yAxis = 4;
            break;
    }
    return yAxis;
}

var getChartTypeByVariable = function(variable, periodicidad, tipoGrafica) {
    let chartType = null;
    switch (variable) {
        case 'PC':
            chartType = 'bar';
            break;
        case 'DV':
            chartType = 'windbarb';
            break;
        case 'VV':
            chartType = 'windbarb';
            break;
        case 'CS':
            if (periodicidad === 'MES') {
                chartType = 'line';
            }
            break;
        case 'NIV':
            if (periodicidad === 'MES') {
                chartType = 'line';
            }
            break;
        case 'TMM':
            chartType = 'line';
            break;
        case 'TMN':
            chartType = 'line';
            break;
        case 'TMD':
            chartType = 'line';
            break;
        case 'HR':
            chartType = 'line';
            break;
    }
    return chartType;
}

var getDashStyleByVariable = function(variable) {
    let dashStyle = 0;
    switch (variable) {
        case 'PC':
        case 'TI':
        case 'TMD':
        case 'HR':
        case 'RS':
        case 'CS':
        case 'DEM':
        case 'VOL':
        case 'NIV':
        case 'PB':
        case 'PBD':
            dashStyle = 'solid';
            break;
        case 'TMN':
        case 'PBN':
            dashStyle = 'dot';
            break;
        case 'PBM':
        case 'TMM':
            dashStyle = 'dash';
            break;
    }
    return dashStyle;
}

function autocomplete(inp, arr) {
    var currentFocus;
    inp.addEventListener("input", function(e) {
        var a, b, i, val = this.value;
        closeAllLists();
        if (!val) { return false; }
        currentFocus = -1;
        a = document.createElement("DIV");
        a.setAttribute("id", this.id + "autocomplete-list");
        a.setAttribute("class", "autocomplete-items");
        this.parentNode.appendChild(a);
        for (i = 0; i < arr.length; i++) {
            if (arr[i] !== null && arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
                b = document.createElement("DIV");
                b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
                b.innerHTML += arr[i].substr(val.length);
                b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
                b.addEventListener("click", function(e) {
                    inp.value = this.getElementsByTagName("input")[0].value;
                    closeAllLists();
                });
                a.appendChild(b);
            }
        }
    });
    inp.addEventListener("keydown", function(e) {
        var x = document.getElementById(this.id + "autocomplete-list");
        if (x) x = x.getElementsByTagName("div");
        if (e.keyCode == 40) {
            currentFocus++;
            addActive(x);
        } else if (e.keyCode == 38) { //up
            currentFocus--;
            addActive(x);
        } else if (e.keyCode == 13) {
            e.preventDefault();
            if (currentFocus > -1) {
                if (x) x[currentFocus].click();
            }
        }
    });

    function addActive(x) {
        if (!x) return false;
        removeActive(x);
        if (currentFocus >= x.length) currentFocus = 0;
        if (currentFocus < 0) currentFocus = (x.length - 1);
        x[currentFocus].classList.add("autocomplete-active");
    }

    function removeActive(x) {
        for (var i = 0; i < x.length; i++) {
            x[i].classList.remove("autocomplete-active");
        }
    }

    function closeAllLists(elmnt) {
        var x = document.getElementsByClassName("autocomplete-items");
        for (var i = 0; i < x.length; i++) {
            if (elmnt != x[i] && elmnt != inp) {
                x[i].parentNode.removeChild(x[i]);
            }
        }
    }
    document.addEventListener("click", function(e) {
        closeAllLists(e.target);
    });
}

function formatExportedheader(item, key, keyLength) {
    if (item.userOptions.unit) {

        let unit = item.userOptions.unit;
        if (item.userOptions.unit.includes('<sup>')) {
            unit = item.userOptions.unit.replace('<sup>', '').replace('</sup>', '').replace('2', '²').replace('3', '³');
        }

        return item.name + ' (' + unit + ')';
    }
    return false;
}

function corregirTexto(key) {
    const correcciones = [
        ['descripcion', 'descripción'],
        ['minimo', 'mínimo'],
        ['minima', 'mínima'],
        ['maximo', 'máximo'],
        ['maxima', 'máxima'],
        ['util', 'útil'],
        ['ecologico', 'ecológico'],
        ['regulacion', 'regulación'],
        ['inundacion', 'inundación'],
        ['sedimentacion', 'sedimentación'],
        ['precipitacion', 'precipitación'],
        ['lamina', 'lámina'],
        ['codigo', 'código'],
        ['poblacion', 'población'],
        ['posicion', 'posición'],
        ['instrumentacion', 'instrumentación'],
        ['fundacion', 'fundación'],
        ['via', 'vía'],
        ['metodo', 'método'],
        ['transmision', 'transmisión'],
        ['area', 'área'],
        ['usonombre', 'uso'],
        ['estadonombre', 'estado']
    ];

    const m1 = key.replace(/\./g, " ");
    let m2 = m1.replace(/_/g, " ");
    for (value in correcciones) {
        if (m2.includes(correcciones[value][0])) {
            m2 = m2.replace(new RegExp(correcciones[value][0], "g"), correcciones[value][1]);
        }
    }

    return m2.charAt(0).toUpperCase() + m2.substring(1);
}