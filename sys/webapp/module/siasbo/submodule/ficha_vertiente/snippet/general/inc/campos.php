<?php
/**
 * Configuramos todas los grupos de campos, para creación y verificación de formulaios
 */

/**
 * Arreglos que se utilizaran en esta configuración para guardar los grupos de campos
 */
$campos = array();

/***
 * Configuraciòn de los grupos de campos a utilizar
 */
$campos_item = array();

$campos_item["codigo"]=array(
    "tipo"=>"text"
,   "label"=>"codigo");

$campos_item["nombre"]=array(
    "tipo"=>"text"
,   "label"=>"Nombre");

$campos_item["tipo"]=array(
    "tipo"=>"text"
,   "label"=>"tipo");

$campos_item["departamentoId"]=array(
    "tipo"=>"text"
,   "label"=>"departamentoId");

$campos_item["provinciaId"]=array(
    "tipo"=>"text"
,   "label"=>"provinciaId");

$campos_item["municipioId"]=array(
    "tipo"=>"text"
,   "label"=>"municipioId");

$campos_item["comunidadId"]=array(
    "tipo"=>"text"
,   "label"=>"comunidadId");

$campos_item["localidadId"]=array(
    "tipo"=>"text"
,   "label"=>"localidadId");

// $campos_item["epsasId"]=array(
//     "tipo"=>"text"
// ,   "label"=>"epsasId");

$campos_item["cuencaId"]=array(
    "tipo"=>"text"
,   "label"=>"cuencaId");

$campos_item["comunidad"]=array(
    "tipo"=>"text"
,   "label"=>"comunidad");

$campos_item["localidad"]=array(
    "tipo"=>"text"
,   "label"=>"localidad");

$campos_item["descripcion"]=array(
    "tipo"=>"text"
,   "label"=>"localidad");

$campos_item["latitud"]=array(
    "tipo"=>"text"
,   "label"=>"latitud");

$campos_item["latitudDec"]=array(
    "tipo"=>"text"
,   "label"=>"latitudDec");

$campos_item["latitudUtm"]=array(
    "tipo"=>"text"
,   "label"=>"latitudUtm");

$campos_item["longitud"]=array(
    "tipo"=>"text"
,   "label"=>"longitud");

$campos_item["longitudDec"]=array(
    "tipo"=>"text"
,   "label"=>"longitudDec");

$campos_item["longitudUtm"]=array(
    "tipo"=>"text"
,   "label"=>"longitudUtm");

$campos_item["utmZona"]=array(
    "tipo"=>"text"
,   "label"=>"utmZona");

$campos_item["altitud"]=array(
    "tipo"=>"text"
,   "label"=>"altitud");

$campos_item["estado"]=array(
    "tipo"=>"text"
,   "label"=>"estado");


$grupo = "item";
$campos[$grupo]= $campos_item;
unset($campos_item);
/**
 * Apartir de aca, puedes configurar otros campos
 */

$campos_item = array();

$campos_item["itemid"]=array(
    "tipo"=>"text"
,   "label"=>"itemid");

$campos_item["codigo"]=array(
    "tipo"=>"text"
,   "label"=>"codigo");

$campos_item["nombre"]=array(
    "tipo"=>"text"
,   "label"=>"nombre");

$campos_item["tipo"]=array(
    "tipo"=>"text"
,   "label"=>"tipo");

$campos_item["departamentoid"]=array(
    "tipo"=>"text"
,   "label"=>"departamentoid");

$campos_item["provinciaid"]=array(
    "tipo"=>"text"
,   "label"=>"provinciaid");

$campos_item["municipioid"]=array(
    "tipo"=>"text"
,   "label"=>"municipioid");

$campos_item["comunidadid"]=array(
    "tipo"=>"text"
,   "label"=>"comunidadid");

$campos_item["localidadid"]=array(
    "tipo"=>"text"
,   "label"=>"localidadid");

$campos_item["cuencaid"]=array(
    "tipo"=>"text"
,   "label"=>"cuencaid");

$campos_item["comunidad"]=array(
    "tipo"=>"text"
,   "label"=>"comunidad");

$campos_item["localidad"]=array(
    "tipo"=>"text"
,   "label"=>"localidad");

$campos_item["descripcion"]=array(
    "tipo"=>"text"
,   "label"=>"descripcion");

$campos_item["latitud"]=array(
    "tipo"=>"text"
,   "label"=>"latitud");

$campos_item["latituddec"]=array(
    "tipo"=>"text"
,   "label"=>"latituddec");

$campos_item["latitudutm"]=array(
    "tipo"=>"text"
,   "label"=>"latitudutm");

$campos_item["longitud"]=array(
    "tipo"=>"text"
,   "label"=>"longitud");

$campos_item["longituddec"]=array(
    "tipo"=>"text"
,   "label"=>"longituddec");

$campos_item["longitudutm"]=array(
    "tipo"=>"text"
,   "label"=>"longitudutm");

$campos_item["utmzona"]=array(
    "tipo"=>"text"
,   "label"=>"utmzona");

$campos_item["altitud"]=array(
    "tipo"=>"text"
,   "label"=>"altitud");

$campos_item["estado"]=array(
    "tipo"=>"text"
,   "label"=>"estado");

$grupo = "item_pg";
$campos[$grupo]= $campos_item;
unset($campos_item);