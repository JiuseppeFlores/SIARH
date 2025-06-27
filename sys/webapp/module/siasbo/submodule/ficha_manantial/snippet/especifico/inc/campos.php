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

$campos_item["tipoId"]=array(
    "tipo"=>"text"
,   "label"=>"tipoId");

$campos_item["cantidad"]=array(
    "tipo"=>"text"
,   "label"=>"cantidad");

$campos_item["propiedad_agua"]=array(
    "tipo"=>"text"
,   "label"=>"propiedad_agua");

$campos_item["propiedad_terreno"]=array(
    "tipo"=>"text"
,   "label"=>"propiedad_terreno");

$campos_item["administrador"]=array(
    "tipo"=>"text"
,   "label"=>"administrador");

$campos_item["medioId"]=array(
    "tipo"=>"text"
,   "label"=>"medioId");

$campos_item["permanenciaId"]=array(
    "tipo"=>"text"
,   "label"=>"permanenciaId");

$campos_item["observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"observaciones");

$campos_item["edad"]=array(
    "tipo"=>"text"
,   "label"=>"edad");

$campos_item["litologia"]=array(
    "tipo"=>"text"
,   "label"=>"litologia");

$campos_item["estructura"]=array(
    "tipo"=>"text"
,   "label"=>"estructura");

$campos_item["usoaguaId"]=array(
    "tipo"=>"text"
,   "label"=>"usoaguaId");

$grupo = "manantial";
$campos[$grupo]= $campos_item;
unset($campos_item);
/**
 * Apartir de aca, puedes configurar otros campos
 */
