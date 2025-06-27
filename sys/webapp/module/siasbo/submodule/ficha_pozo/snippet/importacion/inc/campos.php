<?
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

$campos_item["fichaId"]=array(
    "tipo"=>"text"
,   "label"=>"fichaId");

$campos_item["fecha"]=array(
    "tipo"=>"date_01"
,   "label"=>"fecha");

$campos_item["diagnostico"]=array(
    "tipo"=>"text"
,   "label"=>"diagnostico");

$campos_item["descripcion"]=array(
    "tipo"=>"text"
,   "label"=>"descripcion");

/*$campos_item["adjunto_nombre"]=array(
    "tipo"=>"text"
,   "label"=>"adjunto_nombre");

$campos_item["adjunto_extension"]=array(
    "tipo"=>"text"
,   "label"=>"adjunto_extension");

$campos_item["adjunto_tamano"]=array(
    "tipo"=>"text"
,   "label"=>"adjunto_tamano");

$campos_item["adjunto_tipo"]=array(
    "tipo"=>"text"
,   "label"=>"adjunto_tipo");*/

$grupo = "campos_archivo";
$campos[$grupo]= $campos_item;
unset($campos_item);

/**
 * Apartir de aca, puedes configurar otros campos
 */
