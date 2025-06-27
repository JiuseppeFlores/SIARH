/**
 * file to define open layers settings
 */
//alert("hola mundo 2");
function Construye2() {
    /*
    Añadimos control de capas, para visualizar
    ------------------------------------------------------------------------------------------
    */
    /*
    layerControlOpt = [
        bing_road,bing_aerial,bing_hyb,
        gmap,gphy,ghyb,gsat,
    ];
    
    layer_switcher = new OpenLayers.Control.LayerSwitcher({
        
    }
    );
    map.addControl(layer_switcher);
    */
    /*
    Añadimos la barra de herramientas
    ------------------------------------------------------------------------------------------
    */
    /*
    var vector_layer = new OpenLayers.layer.vector("Editable");
    var edit_panel = new OpenLayers.control.EditingToolbar(vector_layer);
    map.addControl(edit_panel);
    */
}
/*************************************************************************************************************************/

/**
 * Funciones 
 */
function handleMeasurements(event) {
    var geometry = event.geometry;
    var units = event.units;
    var order = event.order;
    var measure = event.measure;
    var element = document.getElementById('output_measurement');
    var out = "";
    
    console.log("El valor de unidades "+units);
    if(order == 1) {
        if( units == 'm' ) {
            out += "<table border=\"0\" cellpading=\"0\" cellspacing=\"0\">\n\
                        <tr><td>Distancia: </td><td align=\"right\"><b>" + measure.toFixed(3) + "</b></td><td><b>" + units + "</b></td></tr>\n\
                        <tr><td></td><td align=\"right\"><b>" + roundNumber((measure.toFixed(3)) / 1000, 2 ) + "</b></td><td><b>km</b></td></tr>\n\
                        <tr><td></td><td align=\"right\"><b>" + roundNumber((( measure.toFixed(3)) * 0.6214 )/ 1000, 2 ) + "</b></td><td><b>mi</b></td></tr>\n\
                    </table>";
        }
        else {
            out += "<table border=\"0\" cellpading=\"0\" cellspacing=\"0\">\n\
                        <tr><td>Distancia: </td><td align=\"right\"><b>" + roundNumber((measure.toFixed(3)) * 1000, 2 ) + "</b></td><td><b>m</b></td></tr>\n\
                        <tr><td></td><td align=\"right\"><b>" + measure.toFixed(3) + " </b></td><td><b>" + units + "</b></td></tr>\n\
                        <tr><td></td><td align=\"right\"><b>" + roundNumber(( ( measure.toFixed(3) ) * 0.6214 ) / 1, 2 ) + "</b></td><td><b>mi</b></td></tr>\n\
                    </table>";
        }
    } else {
        if( units == 'm' ) {
            out += "<table border=\"0\" cellpading=\"0\" cellspacing=\"0\">\n\
                        <tr><td>Área: </td><td align=\"right\"><b>" + measure.toFixed(3) + "</b></td><td><b>" + units + "<sup>2</" + "sup></b></td></tr>\n\
                    </table>";
        }
    }
    
    element.innerHTML = out;
}

function handleMeasurementsPerimeter(event) {
    var geometry = event.geometry;
    var units = event.units;
    var order = event.order;
    var measure = event.measure;
    var element = document.getElementById('output_measurement');
    var out = "";
    if(order == 1) {
        out += "measure: " + measure.toFixed(3) + " " + units;
    } else {
        out += "measure: " + measure.toFixed(3) + " " + units + "<sup>2</" + "sup>";
    }
    //console.log(geometry);
    var totalPerimeter = getPerimeterPoints(geometry);
    
    //--console.log("perimetro sin conv "+totalPerimeter);
    if( totalPerimeter > 10000 ) 
        element.innerHTML = "Perímetro: <b>" + roundNumber( totalPerimeter / 1000, 2 ) + " km</b>";
    else
        element.innerHTML = "Perímetro: <b>" + roundNumber( totalPerimeter, 2 ) + " m</b>";
}

/**
 * Function to get perimeter points
 */
function getPerimeterPoints(data) {
    var com = data.components[0];
    //console.log(com.components[0].x);
    //console.log(com.components[0].y);
    
    var lastX = 0;
    var lastY = 0;
    
    var currentX = 0;
    var currentY = 0;
    
    var currentPerimeter = 0;
    
    for (var point in com.components) {
        currentX = com.components[point].x;
        currentY = com.components[point].y;
        
        if( ( lastX != 0 && lastY != 0 ) ) {
            if(lastX != currentX && lastY != currentY) {
                //console.log("distancia: "+ distance2Points( lastX, lastY, currentX, currentY ) );
                currentPerimeter += distance2Points( lastX, lastY, currentX, currentY );
            }
            else
                break;
        }
            
        // assign new values
        lastX = currentX;
        lastY = currentY;
    }

    //console.log(currentPerimeter);
    return currentPerimeter;
}

/**
 * Function to calculate the distance between two points
 */
function distance2Points(pointX1, pointY1, pointX2, pointY2) {
    return Math.sqrt( Math.pow( ( pointX2 - pointX1 ), 2 ) + Math.pow( ( pointY2 - pointY1 ), 2 ) );
}

function toggleControl(element) {
    //alert(measureControls);
    for(key in measureControls) {
        var control = measureControls[key];
        //alert(element.value+"=="+element.checked);
        
        if(element.value == key && element.checked) {
            control.activate();
        } else {
            control.deactivate();
        }
    }
}

function toggleGeodesic(element) {
    for(key in measureControls) {
        var control = measureControls[key];
        control.geodesic = element.checked;
    }
}

function toggleImmediate(element) {
    for(key in measureControls) {
        var control = measureControls[key];
        control.setImmediate(element.checked);
    }
}

function toggleLoadingPanel() {    
    map.getControlsByClass('OpenLayers.Control.LoadingPanel')[0].toggle();
}
/*
--------------------------------------------------------------------------------
*/
/**
 * Function to show and return the WMS data
 */
function showInfo(evt) {
    
    
    //Contenido en HTML devuelto por el servidor GIS
    var content = evt.text;
    var content_json = Base64.encode(content);
    
    //--$('#mapa_search').update(wait_information);
    //--$('#mapa_search').html(wait_information);
    document.body.style.cursor="wait"; 
    //--sendAjaxRequestProt('/ajax/processGeoInformation.php','mapa_datos','process=1','geoinfo='+content_json,evt);
    // change response to JSON format
    var jsonVar = {"geoinfo":content_json};
    //sendAjaxRequestJQueryLocal(getInfoWms,'mapa_datos','process=1',jsonVar,evt);
    sendAjaxRequestJQueryLocal(getInfoWms,'mapa_datos','process=1',jsonVar,evt);
    
    return wait_information;
}

/**
 * Funcion para mostrar los datos devueltos por WMS
 */
function mostrarInformacion(evt){
    //Guardamos el contenido devuelto por WMS
    var contenido = evt.text;
    //alert("entro: "+contenido);
    var contenidoBase64 = Base64.encode(contenido);
    //Cambiamos el icono del cursor a espera
    document.body.style.cursor="wait";
    //Variable en formato JSon
    var jsonVar = {"geoinfo":contenidoBase64,"gestion":$("#gestion").val()};
    //envioamos la información para procesar al servidor nuevamente.
    procesarInformacion(jsonVar,evt,'');
}
function mostrarInformacion2(evt){
    //Guardamos el contenido devuelto por WMS
    var contenido = evt.text;
    alert("entro: "+contenido);
    var contenidoBase64 = Base64.encode(contenido);
    //Cambiamos el icono del cursor a espera
    document.body.style.cursor="wait";
    //Variable en formato JSon
    var jsonVar = {"geoinfo":contenidoBase64};
    //envioamos la información para procesar al servidor nuevamente.
    
    procesarInformacion(jsonVar,evt,'');
}
/**
 * Funcion para procesar la información enviada del WMS
 */
function procesarInformacion(valuesPost,event,extraUrl){
    /**
     * Primero removemos todas las ventanas
     */
    for(var i=0; i<map.popups.length; ++i) {
        map.removePopup(map.popups[i]);
    }
    // Preparamos el arrego de respuesta
    var response = new Array();
    // Preparamos el ajax
    $.ajax({
        type: 'POST',
        url: getInfoWms+'?'+extraUrl,
        data: valuesPost,
        //cuando se completa la acción
        complete: function(data) {
            //alert(data.responseText);
            if(data.responseText != "/////////empty") {
                response = data.responseText;
                // Creamos un Popup, para mostrar el resultado del servidor
                var popup = new OpenLayers.Popup.FramedCloud(
                    'InformacionGeo',
                    map.getLonLatFromPixel(event.xy),
                    new OpenLayers.Size( 400, 350 ),
                    response,
                    null,
                    false
                );
                popup.autoSize = false;
                map.addPopup(popup);
                //Cambiamos el cursor a por defecto
                document.body.style.cursor="default";
            }
        },
        // cuando nos da un error
        error: function() {
            //alert("Error de Ajax para procesar información");
        }
    });
}

function CambiarEstilo(id,id1) {  
    var elemento = document.getElementById(id);  
    var elemento1 = document.getElementById(id1);  
    if (elemento.className == "tacordion selector") {  
    elemento1.className = "tacordion selector";     
    elemento.className = "tacordion selected";
       var obj = document.getElementById('dtab1');
    var obj1 = document.getElementById('dtab0');
	obj.style.display=='none' ? obj.style.display='block' : obj.style.display='none';
        obj1.style.display=='none' ? obj1.style.display='block' : obj1.style.display='none';
    } 
}