/**
 * Funcion que envia los datos via POST
 * action, action del formulario, pagina de destino
 * values, elementos que seran enviados via POST, cada elemento separado por '#', en cala elemento el nombre del campo y valor estan separados por el caracter '$'
 */ 
/*$j(document).ready(function (){
    
        $j('#rmcpio_585').click(function(){
            if ($j('#rmcpio_585').attr("checked")=="checked")
                $j('#sequia').css('display','block');
            else
                $j('#sequia').css('display','none');
            
            //--$j('#municipio').attr("checked","1");
            //--checkControl('municipio');
        });
        
        $j('#rmcpio_583').click(function(){
            if ($j('#rmcpio_583').attr("checked")=="checked")
                $j('#inundacion').css('display','block');
            else
                $j('#inundacion').css('display','none');
            
            //--$j('#municipio').attr("checked","1");
            //--checkControl('municipio');    
        });
        
        $j('#rmcpio_582').click(function(){
            if ($j('#rmcpio_582').attr("checked")=="checked")
                $j('#helada').css('display','block');
            else
                $j('#helada').css('display','none');
            
            //--$j('#municipio').attr("checked","1");
            //--checkControl('municipio');
        });
});*/


/**
 * Funcion para enviar valores de combobox por el metodo post
 * 
 * @param string action, destino del formulario
 * @param string combo, nombre del elemento combo
 */
function sendComboByPost(action, combo) {
    //var localCbo = $F(combo);
    
    var comboQuery = "#" + combo + " option:selected";
    console.log("consulta al combo "+comboQuery);
    var localCboTxt = $(comboQuery).text();
    console.log("valor del combo "+localCboTxt);
    //--sendbypost( action, combo + '=' + localCboTxt );
    sendbypostJQuery( action, combo + '=' + localCboTxt );
}


function sendbypost(action,values)
{
    var elements = values.split('#');
    var input;
    var data_elements;

    var form = new Element('form',{
        'name':'javascriptForm',
        'method':'post',
        'action':action
    })

    for(var i=0; i<elements.length; i++)
    {
        data_elements = elements[i].split('=');
        input = new Element('input',{
            'name':data_elements[0],
            'value':data_elements[1],
            'type':'hidden'
        });
        form.appendChild(input);
    }
   
    document.body.appendChild(form);
    form.submit();
    document.body.removeChild(form);
}


function sendbypostJQuery(action, values, valuesByClass)
{
    var elements = values.split('#');
    var input;
    var data_elements;

    //--console.log("el valor de values: "+values);
    var form = $('<form name="javascriptForm" id="javascriptForm" method="post" action="' + action + '"></form>');
    var input;
    var cElementId;

    for(var i=0; i<elements.length; i++)
    {
        //--console.log("el valor del primer elemento "+elements[i]);
        data_elements = elements[i].split('=');
        
        cElementId = "#"+elements[i]+" option:selected";
        input = $('<input type="hidden" name="' + data_elements[0] + '" value="' + $(cElementId).text() + '" />');
        input.appendTo(form);
    }
    
    // check if valuesByClass has content
    if( valuesByClass.length > 0 ) {
        cElementId = "."+valuesByClass;
        input = $(cElementId);
        //console.log(input);
        var cElementChecked = "."+valuesByClass+":checked";
        //--console.log("atributos: "+$(cElementChecked).attr("id"));
        
        input = $('<input type="hidden" name="' + valuesByClass + '" value="' + $(cElementChecked).attr("id") + '" />');
        input.appendTo(form);
    }
   
    form.appendTo($('body')); // required for submission to work in Firefox
    
    form.submit();
    form.remove();
}

function sendbypost_search(action,values)
{
    var elements = values.split('#');
    var input;
    var data_elements;
    
    var form = $('<form name="javascriptForm" id="javascriptForm" method="post" action="' + action + '"></form>');
    var cElementId;

    for(var i=0; i<elements.length; i++)
    {
        data_elements = elements[i].split('=');
        input = new Element('input',{
            'name':data_elements[0],
            'value':data_elements[1],
            'type':'hidden'
        });
        form.appendChild(input);
    }
   
    document.body.appendChild(form);
    form.submit();
    document.body.removeChild(form);
}

function sendbypost_searchJQuery(action,values)
{
    var elements = values.split('#');
    var input;
    var data_elements;

    var form = $('<form name="javascriptForm" id="javascriptForm" method="post" action="' + action + '"></form>');

    for(var i=0; i<elements.length; i++)
    {
        data_elements = elements[i].split('=');
        
        input = $('<input type="hidden" name="' + data_elements[0] + '" value="' + data_elements[1] + '" />');
        input.appendTo(form);
    }
   
    // required for submission to work in Firefox
    form.appendTo($('body')); 
    
    form.submit();
    form.remove();
}

/**
 * Funcion que envia los datos por GET
 */
function sendbyget(action,values,type)
{   
    var localVal = '';
    var completeUrl = '';

    switch(type) {
        case 1:  /*cuando values es un campo de un formulario*/
            localVal = $F(values);

            /*si la direccion URL no tiene el caracter '/' al final, lo agregamos*/
            if(localVal.charAt(localVal.length-1) != '/')
                completeUrl = action+localVal+'/';

            break;
            
        case 2:
            completeUrl = action+values;
            break;
			
	default:
    }
	/*alert(completeUrl);*/
    window.location=completeUrl;
}

 function send(Valor)
	 {if(Valor==0)
                    var texto=$j("#search_text1").val(); 
		else
                    var texto=$j("#search_text").val(); 
		if(texto.length>2)
		{if(texto=='Texto a buscar')	
                    {alert ("El criterio de b\u00FAsqueda no es v\u00E1lido.");  
                        return false;                       
                    }
                    else
                    {return true;
                    }
                } 
		else	
		{alert ("El criterio de b\u00FAsqueda no es v\u00E1lido.\nPor favor introduzca m\u00E1s de 2 caracteres.");
                    return false;
		}
	 }   
	     function fechaaaa(date)
        {return false;
        }
        

/**
 * Function to get information via AJAX
 */
function sendAjaxRequestProt(filePath,divName,extraUrl,valuesPost) {
    var opciones = {
            method: 'post',		
            parameters: valuesPost,
            // funci�n a llamar cuando reciba la respuesta
            onSuccess: function(t) {
                    datos = t.responseText.evalJSON();

                    /*if(divName != 'NONAME')
                            procesar(datos,divName);
                    else*/
                    procesarByPart(datos,divName);
            }
    }

    new Ajax.Request(filePath+'?'+extraUrl, opciones);

}

function val_foro(){
    var oForm = document.forms['foro_form2'];
    var oText = oForm.elements["res_titulo"];    
    var valor_text = oText.value;
    var titulo= oForm["res_titulo"].value;    
    var respuesta = oForm.elements["res_contenido"].value;
    if (titulo!='' && respuesta!=''){
        //document.foro_form2.submit()
        return true;
    }else{
    alert('Debe llenar los campos de:\n\n\- Título \n\- Contenido') ;
    return false;
    }
}

/**
 * Function to handle cuencas radio options
 * 
 * @param selectedOption (int), index of radio array
 */
function cuencasOptions(selectedOption) {
    /*select current option*/
    radioControl(array_cuencas,selectedOption);
    
    /*deselect another options*/
    //---changeCheckControls('helada_municipio,inundaciones_municipio,sequia_municipio',false);
}

/**
 * Function to handle riesgos checkbox options
 * 
 * @param selectedOption (string), name of selected option
 * @param force (int), if 1 force 'municipio' layer to check or uncheck
 */
function riesgosOptions(selectedOption, force, enableLayer) {
    var tempObject;
    var currentObject = $(selectedOption);
    
    checkControl(selectedOption);
    //--tempObject = $('municipio');
    tempObject = $(enableLayer);
    
    if(force == 1){
        if(currentObject.checked == true)
            tempObject.checked = 'true';
        else
            tempObject.checked = '';
    }
    else
        tempObject.checked = '';
    
    //--checkControl('municipio');
    checkControl(enableLayer);
    
    cuencasRadioButtons = new Array('nivel1','nivel2','nivel3');
    
    for(var i = 0; i < cuencasRadioButtons.length; i++) {
        tempObject = $(cuencasRadioButtons[i]);
        //--tempObject.checked = '';
    }
        
    radioControl(array_cuencas,-1);
}

/**
 * Function to handle riesgos checkbox options
 * 
 * @param selectedOption (string), name of selected option
 * @param force (int), if 1 force 'municipio' layer to check or uncheck
 * @param enableLayer, layer to be put visible
 */
function riesgosOptionsJQuery(selectedOption, force, enableLayer) {
    var tempObject;
    var optionId = "#"+selectedOption;
    var currentObject = $(optionId);
    //--console.log("Current Object: "+currentObject);
    
    checkControlJQuery(selectedOption);
    //--tempObject = $('municipio');
    
    var enableLayerId = "#"+enableLayer;
    tempObject = $(enableLayerId);
    //console.log("Enable layer: "+tempObject);
    
    if(force == 1){
        if(currentObject.is(":checked") == true)
            tempObject.checked = 'true';
        else
            tempObject.checked = '';
    }
    else
        tempObject.checked = '';
    
    //--checkControl('municipio');
    checkControlJQuery(enableLayer);
    
    cuencasRadioButtons = new Array('nivel1','nivel2','nivel3');
    
    for(var i = 0; i < cuencasRadioButtons.length; i++) {
        tempObject = $(cuencasRadioButtons[i]);
        //--tempObject.checked = '';
    }
        
    radioControl(array_cuencas,-1);
}


/**
 * Function to control radio buttons
 * 
 * @param radioArray (mixed|array), control's array, to contain options
 * @param currentOption (int), identifier of control's array that was selected
 */
function radioControl(radioArray, currentOption) {
    for(var i in radioArray) {
        var item = radioArray[i];
        //--alert(typeof(item)+'====='+currentOption);
        
        if(typeof(item) == 'object') {
            if(i == currentOption) {
                radioArray[i].setVisibility(true);
            }
            else {
                //--alert(radioArray[i]);
                radioArray[i].setVisibility(false);
            }
        }
    }
}

/**
 * Function to control checkbox to show or hide layer
 * 
 * @param control (string), name of checkbox control
 */
function checkControl(control) {
    var currentObject;
    var tempObject;
    var layer;
    
    currentObject = $(control);
    
    /*get layer variable from the name property*/
    //alert(currentObject.name);
    layer = eval(currentObject.name);
    
    //--alert(currentObject.checked);
    
    if(currentObject.checked == true) {
        layer.setVisibility(true);
        
        /*if(control == 'helada_municipio') {
            tempObject = $('departamento');            
            tempObject.checked = "1";
            
            checkControl('departamento');
        }*/ 
    }
    else
        layer.setVisibility(false);
}

/**
 * Function to control checkbox to show or hide layer
 * 
 * @param control (string), name of checkbox control
 */
function checkControlJQuery(control) {
    var currentObject;
    var controlId = "#"+control;
    var layer;
    var tempObject;
    
    //console.log("id: "+controlId);
    currentObject = $(controlId);
    
    //console.log("Got object: "+currentObject);
    /*get layer variable from the name property*/
    //console.log(currentObject.attr("name"));
    layer = eval(currentObject.attr("name"));
    
    //console.log(layer);
    
    //--if(currentObject.checked == true) {
    if(currentObject.is(":checked") == true) {
        //console.log("the opion is marked");
        layer.setVisibility(true);
        
        /*if(control == 'helada_municipio') {
            tempObject = $('departamento');            
            tempObject.checked = "1";
            
            checkControl('departamento');
        }*/ 
    }
    else
        layer.setVisibility(false);
}

/**
 * Function to disable or enable check controls
 * 
 * @param controlNames (mixed|array), array of checkbox's names
 * @param status (bool), indicate the status of the contols, should be true or false
 */
function changeCheckControls(controlNames,status) {
    var names = controlNames.split(',');
    var currentObject;
    
    for(var i = 0; i < names.length; i++) {
        currentObject = $(names[i]);
        if(status == true) {
            currentObject.checked = "checked";
            checkControl(names[i]);
        }
        else {
            currentObject.checked = "";
            checkControl(names[i]);
        }
    }
}
var ngrid;
function addfilaGrid(datosGrid,idGrid,numerogrid)
{  ngrid=numerogrid;
	$j.ajax({
        type: "POST",
        url: "/ajax/getGrid.php",
        data: "cd="+datosGrid+"&idgrid="+idGrid+"&ng="+ngrid,
        success: function(datos){
       $j('#filasGrid').val(ngrid)	;	
        
		 $j('#filafooter').remove();
		 $j('#'+idGrid).append(datos);
		// $j('#filacon').removeClass('newfilaGrid');
		
		}
		});	
}
function delfilaGrid(idGrid)
{	 if (confirm('¿Desea eliminar este item?')==true)
	{	
		
    $j('#'+idGrid).remove();
	}
    
}

/**
 * Function to open window
 */
function openPrintWindow(typeCombo) {
    var cElementId = "#" + typeCombo + " option:selected";
    var dimensions = 'height=100px,width=100px';
    
    var input = $(cElementId).val();
    
    dimensions = 'height=500px,width=500px';
    
    var layerName;
    var arrayLayerName = new Array();
    var count = 0;
    
    for(var layer in map.layers) {
        layerName = map.layers[layer].name;
        
        if(map.layers[layer].visibility == true && map.layers[layer].CLASS_NAME == "OpenLayers.Layer.WMS") {
            arrayLayerName[count] = map.layers[layer].params.LAYERS;
            count++;
        }
    }
    
    /* check departament filter */
    cElementId = "#combo_departamento option:selected";
    
    var departamentSelected = $(cElementId).val();
    
    var cqlFilter = new Array();
    var count = 0;
    
    if( departamentSelected.length > 0 ) {
        for( var layer in  arrayLayerName) {
            console.log("selected layer: "+arrayLayerName[layer]);
            
            if( arrayLayerName[layer] == 'BoliviaPolitico:deptos_' ) {
                cqlFilter[count] = '(FIRST_NOM_=\'' + departamentSelected + '\')';
            }
            else if( arrayLayerName[layer] == 'BoliviaPolitico:muni_proyec2010' ) {
                cqlFilter[count] = '(NOM_DEP=\'' + departamentSelected + '\')';
            }
            else if( arrayLayerName[layer] == 'Cuencas:puntos' ) {
                cqlFilter[count] = '(Departamen=\'' + departamentSelected + '\')';
            }
            else if( arrayLayerName[layer] == 'RiesgosCuencas:riesgo_de_helada_completo' || 
                    arrayLayerName[layer] == 'RiesgosCuencas:riesgo_inund_completo' ||
                    arrayLayerName[layer] == 'RiesgosCuencas:riesgo_de_sequia_completo' ) {
                cqlFilter[count] = '(NOM_DEP=\'' + departamentSelected + '\')';
            }
            else
                cqlFilter[count] = 'INCLUDE';
            
            count++;
        }
    }
    
    //--console.log(arrayLayerName);
    var content_json = Base64.encode(arrayLayerName.join(","));
    var content_json_cql = Base64.encode(cqlFilter.join(";"));
        
    window.open('/exportMap.php?outputFormat=' + input + '&layers=' + content_json + '&cql_filter=' + content_json_cql,'export',dimensions);
}

/**
 * Function to convert and locate map coords
 */
function setMap2Position( posX, posY, LatLongUTM, zone ) {
    var wgs84Proj = new OpenLayers.Projection("EPSG:4326");
    var latLonProj = new OpenLayers.Projection("EPSG:900913");
    
    var temMessage = 'Debe ingresar valores para:';
    var realPosition;
    
    if( LatLongUTM == 1 ) { // to convert from LonLat to UTM
        if( posX.length > 0 && posY.length > 0 ) {
            realPosition = new OpenLayers.LonLat(posX, posY).transform(wgs84Proj, latLonProj);

            var utmcoords=[];
            
            LLtoUTM( posY, posX, utmcoords, 0);
            
            var utmx    = utmcoords[0];
            var utmy    = utmcoords[1];
            zone        = utmcoords[2];

            if( utmy < 0 ) 
                utmy+=10000000; 
                        
            //--console.log(utmcoords);
            utmx.toFixed(0)
            $( '#posX' ).val( roundNumber( utmx, 0) );
            $( '#posY' ).val( roundNumber( utmy, 0) );
            $( '#zone' ).val( zone );
        }
        else {
            var msg = new Array();
            
            if( posX.length == 0 )
                msg[msg.length] = "<br />- Longitud";
            
            if( posY.length == 0 )
                msg[msg.length] = "<br />- Latitud";
            
            $( '#conversionMsg' ).html( temMessage + msg.join('') );
            $( '#conversionMsg' ).dialog( {modal: true, resizable: false} );
        }
    }
    else { // to convert from UTM to LonLat
        if( posX.length > 0 && posY.length > 0 && zone.length > 0 ) {
            //realPosition = new OpenLayers.LonLat(, );
            var latlong = new Array();
            latlong = UTMXYToLatLon(posX, posY, zone, true);
            
            realPosition = new OpenLayers.LonLat( latlong[1], latlong[0] ).transform( wgs84Proj, latLonProj );
            //--console.log(latlong);
            //--console.log(realPosition);

            $('#lon').val( roundNumber( latlong[1], 3) );
            $('#lat').val( roundNumber( latlong[0], 3) );
        }
        else {
            var msg = new Array();
            
            if( posX.length == 0 )
                msg[ msg.length ] = '<br />- Coordenada X';
            
            if( posY.length == 0 )
                msg[ msg.length ] = '<br />- Coordenada Y';
            
            if( zone.length == 0 )
                msg[ msg.length ] = '<br />- Zona';
            
            $( '#conversionMsg' ).html( temMessage + msg.join('') );
            $( '#conversionMsg' ).dialog( {modal: true, resizable: false} );
        }
    }
    
    if( typeof realPosition != 'undefined' ) {
        // add marker to position
        var size    = new OpenLayers.Size( 32, 32 );
        var offset  = new OpenLayers.Pixel(-(size.w/2), -size.h);
        var icon    = new OpenLayers.Icon('http://www.cuencasbolivia.org/images/pin-red.png', size, offset);

        myMarkers.addMarker(new OpenLayers.Marker( realPosition, icon ));

        map.setCenter(realPosition, 10);
    }
}

/**
 * Function to round a decimal number
 */
function roundNumber(num, dec) {
    var result = Math.round(num*Math.pow(10,dec))/Math.pow(10,dec);
    return result;
}