<?php
//servicios reportes APi REST 
$CFG->servicio_reporte["activo"] = true;
$CFG->servicio_reporte["token"] = "944234158:AAHJsciLmWeCDsfc90c-Hjlcn3bG5NfvJ2g";
$CFG->servicio_reporte["api_key"] = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImlzcyI6Iml1ZjlYZURibjloamRWUHlYVmtIQXBhYUJLbGpnSHIwIn0.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.0tP83tai3YKEocYHowjY5tGl_K60waaNt9YAmZNowxI";


//api mapbox
$CFG->servicio_reporte["token1"] = "pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw";
// https://www.jawg.io/
$CFG->servicio_reporte["token2"] = "LYknxLZEFlwdarWia6yM45Ss58NdajUb7SugxkWGHhFieCOm0E1vBYV1VHbJ31aX";
// https://cloud.maptiler.com/
$CFG->servicio_reporte["token3"] = "4OMvO29JVeqbMHZeL76b";
// https://manage.thunderforest.com/
$CFG->servicio_reporte["token4"] = "4c8d7dfe1bf44efeb809168cb0359b49";
// https://developer.tomtom.com/
$CFG->servicio_reporte["token5"] = "nHEjfjtGgkFeppmjqGtali7GUaiVBzWQ";
  // https://client.stadiamaps.com/
$CFG->servicio_reporte["token6"] = "0ba85ab6-34b1-490d-9ab9-fe31e0581148";
// https://developer.here.com/
$CFG->servicio_reporte["token7"] = "KgdHxxqNGueVhLbObpGm";


//* url para servicio api rest
// ruta para produccion
$CFG->servicio_reporte["url_api_prod"] = "https://konga.mmaya.gob.bo:8443/api";

$CFG->servicio_reporte["url_api"] = "https://konga.mmaya.gob.bo:8443/dev";
$CFG->servicio_reporte["url_api_test"] = "https://konga.mmaya.gob.bo:8443/test";
// ruta para desarrollo
// $CFG->servicio_reporte["url_api"] = "http://localhost:3000";

//* url para servicio geonode
$CFG->servicio_reporte["url_geoserver"] = "https://geo.siarh.gob.bo/geoserver/wms";
$CFG->servicio_reporte["parse_mode"] ='HTML';

//servicios reportes BIRT

//Para utilizar el servidor de Reportes en Produccion
//$CFG->servicio_reporte["url_reporte"] ='http://192.168.5.59/birt-viewer/frameset?__report=';

//Para utilizar el servidor de Reportes en Desarrollo (Pruebas)
//$CFG->servicio_reporte["url_reporte_dev"] ='http://birt.mmaya.gob.bo/birt-viewer/frameset?__report=';

//Para utilizar el servidor de Reportes en Produccion
$CFG->servicio_reporte["url_reporte"] ='http://birt.mmaya.gob.bo/birt-viewer/frameset?__report=';

//Para utilizar el servidor de Reportes en Desarrollo (Pruebas)
$CFG->servicio_reporte["url_reporte_dev"] ='http://birtdev.mmaya.gob.bo/birt-viewer/frameset?__report=';
