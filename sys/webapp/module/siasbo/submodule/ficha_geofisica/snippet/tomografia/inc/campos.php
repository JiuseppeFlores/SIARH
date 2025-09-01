<?
/**
 * Configuramos todas los grupos de campos, para creación y verificación de formulaios
 */

/**
 * Arreglos que se utilizaran en esta configuración para guardar los grupos de campos
 */
$campos = array();

/***
 * Datos sev línea base
 */
$campos_item = array();

$campos_item["geofisicaId"]=array(
    "tipo"=>"text"
,   "label"=>"geofisicaId");

$campos_item["fuente"]=array(
    "tipo"=>"text"
,   "label"=>"fuente");

$campos_item["codigo"]=array(
    "tipo"=>"text"
,   "label"=>"codigo");

$campos_item["fecha"]=array(
    "tipo"=>"date_01"
,   "label"=>"fecha");

$campos_item["campania"]=array(
    "tipo"=>"text"
,   "label"=>"campania");

$campos_item["software_utilizado"]=array(
    "tipo"=>"text"
,   "label"=>"software_utilizado");

$campos_item["equipo"]=array(
    "tipo"=>"text"
,   "label"=>"equipo");

$campos_item["sev_lineabaseId"]=array(
    "tipo"=>"text"
,   "label"=>"sev_lineabaseId");

$campos_item["sev_azimut"]=array(
    "tipo"=>"text"
,   "label"=>"sev_azimut");

$campos_item["sev_error"]=array(
    "tipo"=>"text"
,   "label"=>"sev_error");

$campos_item["tomografia_configId"]=array(
    "tipo"=>"text"
,   "label"=>"tomografia_configId");

$campos_item["distancia"]=array(
    "tipo"=>"text"
,   "label"=>"distancia");

$campos_item["tomografia_electrodos"]=array(
    "tipo"=>"text"
,   "label"=>"tomografia_electrodos");

$campos_item["tomografia_abertura"]=array(
    "tipo"=>"text"
,   "label"=>"tomografia_abertura");

$campos_item["tomografia_abertura_remoto"]=array(
    "tipo"=>"text"
,   "label"=>"tomografia_abertura_remoto");

$campos_item["tomografia_electrodos"]=array(
    "tipo"=>"text"
,   "label"=>"tomografia_electrodos");

$campos_item["observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"observaciones");

$campos_item["latitudUtm"]=array(
    "tipo"=>"text"
,   "label"=>"latitudUtm");

$campos_item["longitudUtm"]=array(
    "tipo"=>"text"
,   "label"=>"longitudUtm");

$campos_item["utmZona"]=array(
    "tipo"=>"text"
,   "label"=>"utmZona");

$campos_item["tipo"]=array(
    "tipo"=>"text"
,   "label"=>"tipo");

$grupo = "campos_tomografia";
$campos[$grupo]= $campos_item;
unset($campos_item);

/**
 * Datos capa
 */
$campos_item["geofisicaId"]=array(
    "tipo"=>"text"
,   "label"=>"geofisicaId");

$campos_item["profundidad_desde"]=array(
    "tipo"=>"text"
,   "label"=>"profundidad_desde");

$campos_item["profundidad_hasta"]=array(
    "tipo"=>"text"
,   "label"=>"profundidad_hasta");

$campos_item["resistividad"]=array(
    "tipo"=>"text"
,   "label"=>"resistividad");

$campos_item["litologia"]=array(
    "tipo"=>"text"
,   "label"=>"litologia");

$grupo = "campos_capa";
$campos[$grupo]= $campos_item;
unset($campos_item);

/**
 * Datos vinculo pozo
 */
$campos_item["lineabaseId"]=array(
    "tipo"=>"text"
,   "label"=>"lineabaseId");

$campos_item["pozoId"]=array(
    "tipo"=>"text"
,   "label"=>"pozoId");

$campos_item["observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"observaciones");

$grupo = "campos_vinculo_pozo";
$campos[$grupo]= $campos_item;
unset($campos_item);
/**
 * Apartir de aca, puedes configurar otros campos
 */
