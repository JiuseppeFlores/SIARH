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

$campos_item["itemId"]=array(
    "tipo"=>"text"
,   "label"=>"itemId");

$campos_item["codigo"]=array(
    "tipo"=>"text"
,   "label"=>"codigo");

$campos_item["fuente"]=array(
    "tipo"=>"text"
,   "label"=>"fuente");

$campos_item["usoaguaId"]=array(
    "tipo"=>"text"
,   "label"=>"usoaguaId");

$campos_item["propositoId"]=array(
    "tipo"=>"text"
,   "label"=>"propositoId");

$campos_item["propietario"]=array(
    "tipo"=>"text"
,   "label"=>"propietario");

$campos_item["observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"observaciones");

$grupo = "campos_especifico";
$campos[$grupo]= $campos_item;
unset($campos_item);
/**
 * Apartir de aca, puedes configurar otros campos
 */
