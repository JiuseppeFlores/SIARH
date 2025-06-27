var lon = -66.16670;
var lat = -17.38414;
var zoom = 7;
    
var map;

var measureControls;
var measureControlsArray = new Array(
                            'measure-line-button'
                            ,'measure-polygon-button'
                            ,'per-button'
                            ,'print-button');
var pan_zoom_bar;
//var scaleBar;
//var myPopUp;
var myMarkers;
OpenLayers.ProxyHost = "/wms/sethmap.html/geoproxy?url=";
var getInfoWms = "/wms/sethmap.html/getInfo";
//var array_cuencas = new Array();
var array_base_layers = new Array();

var wmsSrv_1 = 'http://saig.gobernaciondecochabamba.bo:8080/geoserver/wms';
var wmsSrv_1_arrayLayers = new Array();
var wms_1_1;
var wms_1_1_info_controls;
var wms_1_6;
var wms_1_6_info_controls;
var wmsSrv_3 = 'http://geo.gob.bo/geoserver/wms';
var wmsSrv_3_arrayLayers = new Array();
var wms_3_7;
var wms_3_7_info_controls;


function Construye(){



    /**
    Creación de controles
    **/
    /*
    Poder controlar con el mouse
    ------------------------------------------------------------------------------------------
    */
    var navigation_control = new OpenLayers.Control.Navigation({
        'zoomWheelEnabled':true
    });
    /*
    Panel para hacer zoom, con el mundo
    ------------------------------------------------------------------------------------------
    */
    pan_zoom_bar = new OpenLayers.Control.PanZoomBar({
        zoomWorldIcon:true,zoomStart:zoom
    });
    /*
    Muestra la latitud y longitud en decimales
    ------------------------------------------------------------------------------------------
    */
    var mouse_position = new OpenLayers.Control.MousePosition({
        div: document.getElementById("mouse_position"),numDigits: 5
        });
    /*
    Muestra el icono de cargar, cada vez que hace una solicitud
    ------------------------------------------------------------------------------------------
    */
    var loading_panel = new OpenLayers.Control.LoadingPanel();
    /*
    Muestra las rejas de coordenadas
    ------------------------------------------------------------------------------------------
    */
    var graticule = new OpenLayers.Control.Graticule({
        numPoints: 10,
        labelled: true,
        displayInLayerSwitcher: false
    });
    /*
    Muestra las rejas de coordenadas
    ------------------------------------------------------------------------------------------
    */
    var scaleLine = new OpenLayers.Control.ScaleLine({
        //div: document.getElementById("scalebar"),
        minWidth: 175,
        maxWidth: 215
    });
    /*
    Para la vista del mapa pequeño
    ------------------------------------------------------------------------------------------
    */
    var ol = new OpenLayers.Layer.WMS(
            "OpenLayers WMS", 
            "http://vmap0.tiles.osgeo.org/wms/vmap0",
            {layers: 'basic'}
        );
    var contenedor = document.getElementById("overview_map");
    var controlOptions = {
            div: contenedor,
            //autoPan: true,
            size: new OpenLayers.Size(217,100),
            mapOptions: {tileSize: new OpenLayers.Size(200,100)},
            layers: [ol]
        };
    var overview = new OpenLayers.Control.OverviewMap(controlOptions);
    /*
    Opciones de controles para crear el mapa
    ------------------------------------------------------------------------------------------
    */
    var controls_array = [
        graticule,
        navigation_control,
        pan_zoom_bar,
        mouse_position,
        overview,
        scaleLine,
        loading_panel
    ];
    /*
    Creamos el mapa con todas las configuraciones previas
    */
    map = new OpenLayers.Map('map', {
                    controls: controls_array,
                    allOverlays: true,
                    projection: "EPSG:900913",
                    displayProjection: "EPSG:4326",
                    numZoomLevels: 18,
                    units: "m"
                });

    /*
    Mapas de Bing maps
    ------------------------------------------------------------------------------------------
    */
    var gmap = new OpenLayers.Layer.Google(
        "Google Streets",
        {
            numZoomLevels: 20, 
            visibility: false,
            isBaseLayer: true
        }
    );
    array_base_layers[0] = gmap;
    var gphy = new OpenLayers.Layer.Google(
        "Google Physical", { 
            type: google.maps.MapTypeId.TERRAIN,
            visibility: false,
            isBaseLayer: true
        }
    );
    array_base_layers[1] = gphy;
    var ghyb = new OpenLayers.Layer.Google(
        "Google Hybrid", {
            type: google.maps.MapTypeId.HYBRID, 
            numZoomLevels: 20,
            visibility: false,
            isBaseLayer: true
        }
    );
    array_base_layers[2] = ghyb;
    var gsat = new OpenLayers.Layer.Google(
        "Google Satellite", {
            type: google.maps.MapTypeId.SATELLITE, 
            numZoomLevels: 22,
            visibility: false,
            isBaseLayer: true
        }
    );
    array_base_layers[3] = gsat;
    /*
    Mapas de Bing maps
    ------------------------------------------------------------------------------------------
    */
    var bingKey = 'AlGbcz8v32z-wS-X_6gT2YaZNhgnzgJd2j3z_WUzOPgRlHtajvfNLTiGX63GEJo5';
    
    var bing_road = new OpenLayers.Layer.Bing({
        key: bingKey,
        type: "Road",
        wrapDateLine: true,
        visibility: false,
        isBaseLayer: true
    });
    array_base_layers[4] = bing_road;
    var bing_aerial = new OpenLayers.Layer.Bing({
        key: bingKey,
        type: "Aerial",
        wrapDateLine: true,
        visibility: false,
        isBaseLayer: true
    });
    array_base_layers[5] = bing_aerial;
    var bing_hyb = new OpenLayers.Layer.Bing({
        key: bingKey,
        type: "AerialWithLabels",
        wrapDateLine: true,
        visibility: false,
        isBaseLayer: true
    });
    array_base_layers[6] = bing_hyb;
    /* 
    Mapas de OpenStreetMap
    ------------------------------------------------------------------------------------------
    */    
    var osm_mapnik = new OpenLayers.Layer.OSM('Simple OSM map', null, 
        {
            visibility: true,
            displayInLayerSwitcher: true,
            isBaseLayer: true}
    );
    array_base_layers[7] = osm_mapnik;

    
    /* Layer para deplegar algunas opciones
    ------------------------------------------------------------------------------------------
    */
    var highlightLayer = new OpenLayers.Layer.Vector(
        "Highlighted Features", 
        {
            displayInLayerSwitcher: false,
            isBaseLayer: false
	}
    );
    /* add markers to map
    ------------------------------------------------------------------------------------------
    */    
    myMarkers = new OpenLayers.Layer.Markers( "Markers",{displayInLayerSwitcher: false} );       
    /* añadimos las capas al mapa
    ------------------------------------------------------------------------------------------
    */
    map.addLayers([
        /*
        Adicionales Bing
        */
        bing_road,bing_aerial,bing_hyb,
        /*
        OpenStreetMap
        */
        osm_mapnik,
        /*
        Google Map
        */
        gmap,gphy,ghyb,gsat,
        /*
        Otros
        */
        myMarkers,
        highlightLayer
    ]);

    wms_1_1 = wms_MunicipioCocha = new OpenLayers.Layer.WMS(
        'Municipios Cochabamba',wmsSrv_1,
        {
            layers: 'giscocha:municipioCocha',
            format: 'image/png',
            transparent: true
        },
        {
            opacity: 0.5,
            visibility: true,
            isBaseLayer: false,
            displayInLayerSwitcher: true
        }
    );
    map.addLayer(wms_1_1);
    
    wms_1_1_info_controls = 
    {
        click: new OpenLayers.Control.WMSGetFeatureInfo({
            url: wmsSrv_1,
            title: 'Información de Municipios Cochabamba',
            layers: [wms_1_1],
            queryVisible: true,
            infoFormat: 'text/html'
        })
    };
    
    for(var i in wms_1_1_info_controls) {
        wms_1_1_info_controls[i].events.register('getfeatureinfo',this,mostrarInformacion);
        map.addControl(wms_1_1_info_controls[i]);
    }
    wms_1_1_info_controls.click.activate();
    
    wms_1_6 = wms_MunicipioCocha = new OpenLayers.Layer.WMS(
        'REGIONES',wmsSrv_1,
        {
            layers: 'egobierno:regiones',
            format: 'image/png',
            transparent: false
        },
        {
            opacity: 0.4,
            visibility: false,
            isBaseLayer: false,
            displayInLayerSwitcher: true
        }
    );
    map.addLayer(wms_1_6);
    
    wms_1_6_info_controls = 
    {
        click: new OpenLayers.Control.WMSGetFeatureInfo({
            url: wmsSrv_1,
            title: 'Información de REGIONES',
            layers: [wms_1_6],
            queryVisible: true,
            infoFormat: 'text/html'
        })
    };
    
    for(var i in wms_1_6_info_controls) {
        wms_1_6_info_controls[i].events.register('getfeatureinfo',this,mostrarInformacion);
        map.addControl(wms_1_6_info_controls[i]);
    }
    wms_1_6_info_controls.click.activate();
    
    wms_3_7 = wms_MunicipioCocha = new OpenLayers.Layer.WMS(
        'LUCES',wmsSrv_3,
        {
            layers: 'nasa:map_luz',
            format: 'image/png',
            transparent: false
        },
        {
            opacity: 0.4,
            visibility: false,
            isBaseLayer: false,
            displayInLayerSwitcher: true
        }
    );
    map.addLayer(wms_3_7);
    
    wms_3_7_info_controls = 
    {
        click: new OpenLayers.Control.WMSGetFeatureInfo({
            url: wmsSrv_3,
            title: 'Información de LUCES',
            layers: [wms_3_7],
            queryVisible: true,
            infoFormat: 'text/html'
        })
    };
    
    for(var i in wms_3_7_info_controls) {
        wms_3_7_info_controls[i].events.register('getfeatureinfo',this,mostrarInformacion);
        map.addControl(wms_3_7_info_controls[i]);
    }
    wms_3_7_info_controls.click.activate();
    


    /*
    Información sobre la capa principal
    ------------------------------------------------------------------------------------------
    */
    /*
    info_controls = {
        click: new OpenLayers.Control.WMSGetFeatureInfo({
            url: info_url,
            title: 'Información del mapa',
            layers: [wms_MunicipioCocha],
            queryVisible: true,
            infoFormat: 'text/html'
        })
    };
    
    for(var i in info_controls) {
        alert(i);
        info_controls[i].events.register('getfeatureinfo',this,mostrarInformacion);
        map.addControl(info_controls[i]);
    }
    */
    /**
     * Añadimos el control a los mapas para recoger información
     */
     /*
    
    */
    
    // by default information control is deactivate
    //info_controls.click.activate();
    //wms_1_1_info_controls.click.activate();

    // style the sketch fancy
    var sketchSymbolizers = {
           "Point": {
               pointRadius: 4,
               graphicName: "square",
               fillColor: "white",
               fillOpacity: 1,
               strokeWidth: 1,
               strokeOpacity: 1,
               strokeColor: "#333333"
           },
           "Line": {
               strokeWidth: 1,
               strokeOpacity: 1,
               strokeColor: "#DE1935",
               strokeDashstyle: "solid"
           },
           "Polygon": {
               strokeWidth: 2,
               strokeOpacity: 1,
               strokeColor: "#DE1935",
               fillColor: "#E598A3",
               fillOpacity: 0.3
           }
    };
    
    var style = new OpenLayers.Style();
    style.addRules([
        new OpenLayers.Rule({symbolizer: sketchSymbolizers})
    ]);
    var styleMap = new OpenLayers.StyleMap({"default": style});
    
    // allow testing of specific renderers via "?renderer=Canvas", etc
    var renderer = OpenLayers.Util.getParameters(window.location.href).renderer;
    renderer = (renderer) ? [renderer] : OpenLayers.Layer.Vector.prototype.renderers;
    
    measureControls = {
        line: new OpenLayers.Control.Measure(
            OpenLayers.Handler.Path, {
                persist: true,
                handlerOptions: {
                    layerOptions: {
                        renderers: renderer,
                        styleMap: styleMap
                    }
                }
            }
        ),
        polygon: new OpenLayers.Control.Measure(
            OpenLayers.Handler.Polygon, {
                persist: true,
                handlerOptions: {
                    layerOptions: {
                        renderers: renderer,
                        styleMap: styleMap
                    }
                }
            }
        ),
        perimeter: new OpenLayers.Control.Measure(
            OpenLayers.Handler.Polygon, {
                persist: true,
                handlerOptions: {
                    layerOptions: {
                        renderers: renderer,
                        styleMap: styleMap
                    }
                }
            }
        )
    };
    
    var control;
    
    for(var key in measureControls) {
        control = measureControls[key];
        
        if(key == 'perimeter') {
            control.events.on({
                "measure": handleMeasurementsPerimeter,
                "measurepartial": handleMeasurementsPerimeter
            });
        }
        else {
            control.events.on({
                "measure": handleMeasurements,
                "measurepartial": handleMeasurements
            });
        }
        map.addControl(control);
    }
    
    // set visibility true to one base layer
    //gmap.setVisibility(true);
    
    //set map to bolivia country
    map.setCenter(new OpenLayers.LonLat(lon, lat).transform(
        new OpenLayers.Projection("EPSG:4326"),
        map.getProjectionObject()
    ), zoom);

}

function setClickButtom()
{

    $("#wms_1_1").click(
        function(){
            checkControlJQuery('wms_1_1');
            $(this).parent().toggleClass('opt_mapasSelect');
        }
    );
    
    $("#wms_1_6").click(
        function(){
            checkControlJQuery('wms_1_6');
            $(this).parent().toggleClass('opt_mapasSelect');
        }
    );
    
    $("#wms_3_7").click(
        function(){
            checkControlJQuery('wms_3_7');
            $(this).parent().toggleClass('opt_mapasSelect');
        }
    );
    


    $(".opt_mapas01&gt;input,.opt_mapas01&gt;label").hover(function(){
        $(this).parent().toggleClass('opt_mapasHover');
    })
}


function getListProject(id,gestion,ine){
    
    var w = 700;
    var h = 350;
    var scroll = 0;
    var url = 'wms/sethmap/listTable?id='+id+'&amp;gestion='+gestion+'&amp;codine='+ine;
    var f = iframeBox(url,w,h);    
    html = "<div id="\&quot;formContent\&quot;" style="\&quot;width:&quot;+w+&quot;px;height:&quot;+h+&quot;px;\&quot;">"+f+"</div>";
    titlebox='Listado';
    
    boxyWindows = new Boxy(html,{ title:titlebox, modal: true,fixed:true,
    					          draggable:true, show:false, afterShow: function() {},
                                  closeable:false,unloadOnHide:true});
   	boxyWindows.show();    
    
    /*
    var url = 'module/wms/sethmap/listTable';
    
    $.post( url,
            {id:id, gestion:gestion,codine:ine},
            function (data, textStatus){
                alert(data);
            });
      */      
}