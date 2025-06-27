var pageLayoutOptions = {
		name:					'pageLayout' // only for debugging
	//,	resizeWithWindowDelay:	250		// delay calling resizeAll when window is *still* resizing
	//,	resizeWithWindowMaxDelay: 2000	// force resize every XX ms while window is being resized
	//,	resizable:				false
	//,	slidable:				false
	//,	closable:				false
    //,   scrollToBookmarkOnLoad:         false
    ,   defaults: {
        }
    ,	north: {
				size:					80
			,	spacing_open:			0
			,	closable:				false
			,	resizable:				false
			}
    ,	south: {
				size:					28
			,	spacing_open:			0
			,	closable:				false
			,	resizable:				false
			}
    ,	east: {
				size:					240
            ,   paneSelector:           "#east_pane"
			,	spacing_closed:			22
			,	togglerLength_closed:	140
			,	togglerAlign_closed:	"top"
            ,	togglerContent_closed:	"p<br>a<br>n<br>e<br>l"
			,	togglerTip_closed:		"Abrir Panel de Herramientas"
			,	sliderTip:				"Mostrar Panel"
			,	slideTrigger_open:		"mouseover"
            ,	resizable:				false
			}
	,	center__paneSelector:	"#center"
	,	west__resizable:        false
	,	west__closed:           true
	,	initClosed:             false
	,	onclose_end: function(panName) {
            // update map size when a panel is closed
            map.updateSize();
            if(panName == 'south') {
                east.resizeAll();
            }
        }
	,	onopen_end: function(panName) {
            // update map size when a panel is opened
            map.updateSize();
            if(panName == 'south') {
                east.resizeAll();
            }
        }


};

$(window).resize(function(e) {
    //alert("hola");
    // Código de respuesta
    //center.resizeAll();
    //setTimeout( function() { map.updateSize();}, 200);
    
});

$(document).ready(function () {

    maximoWindow();
    /**
    Construimos los frames
    **/
    var pageLayout = $("body").layout( pageLayoutOptions ); 

    east = $('#east_pane').layout({
            center__paneSelector:   "#layerGroup"
        ,   south__paneSelector:    "#over_measurement"
        ,   south__resizable:       false
        ,   south__size:            120
        //,	south__onresize:		$.layout.callbacks.resizePaneAccordions
        ,	center__onresize:		$.layout.callbacks.resizePaneAccordions
    });
    /**
    Ponemos el footer encima de todo
    **/
    $('#footer').css( 'z-index', 10000);
    /**
    creamos el acordion del menu derecho
    **/
    $("#accordion2").accordion({
			fillSpace:	true
		,	active:		1
		});
    setRightBarButtom();
    Construye();
});
/**
funcion para cambiar el tamaño de la ventana
**/
function maximoWindow() {
    //window.moveTo(0, 0);
    //window.resizeTo(screen.availWidth, screen.availHeight);
    //console.log("width Scream: "+screen.availWidth);
    //console.log("width Scream: "+screen.availHeight);
}
function setRightBarButtom(){
    /**
    Creamos el boton 
    **/
    $("#base_opt_google").buttonset();
    $("#base_opt_bing").buttonset();
    $(".baseopt_google").button({
            icons: {primary: "button_google"},
            text: false
        });
    $(".baseopt_google02").button({
            icons: {primary: "button_google02"},
            text: false
        });
    $(".baseopt_google03").button({
            icons: {primary: "button_google03"},
            text: false
        });
    $(".baseopt_bing").button({
            icons: {primary: "button_bing"},
            text: false
        });
    $(".baseopt_osm").button({
            icons: {primary: "button_osm"},
            text: false
        });
    /**
    Menu para escojer los mapas
    **/
    /*
    $("#mapas_cocha").buttonset(
         {
            icons: {primary: "button_osm"}
         }
    );
    */
    //$("#map-controls").buttonset();
    setClickButtom();
}