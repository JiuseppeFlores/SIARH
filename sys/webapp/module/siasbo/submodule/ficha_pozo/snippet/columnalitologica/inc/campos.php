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
/*
$campos_item["activo"]=array(
    "tipo"=>"checkbox_01" //si es de este tipo, si o si guarda a la base de datos con 1 o 0
,   "label"=>"Activo");
*/

/**
 * Son de tipo fechas
 */
/*
$campos_item["fecha_inicio"]=array(
    "tipo"=>"date_01"
,   "label"=>"Fecha Inicio");

$campos_item["fecha_fin"]=array(
    "tipo"=>"date_01"
,   "label"=>"Fecha Fin");
*/
/**
 * Fin de tipo fechas
 */



$campos_item["pozoId"]=array(
    "tipo"=>"text"
,   "label"=>"pozoId");

$campos_item["profundidad_desde"]=array(
    "tipo"=>"text"
,   "label"=>"Profundidad Desde");

$campos_item["profundidad_hasta"]=array(
    "tipo"=>"text"
,   "label"=>"Profundidad Hasta");

$campos_item["litologia1"]=array(
    "tipo"=>"text"
,   "label"=>"Litologia 1");

$campos_item["porcentaje1"]=array(
    "tipo"=>"text"
,   "label"=>"Porcentaje 1");

$campos_item["litologia2"]=array(
    "tipo"=>"text"
,   "label"=>"Litologia 2");

$campos_item["porcentaje2"]=array(
    "tipo"=>"text"
,   "label"=>"Porcentaje 2");

$campos_item["litologia3"]=array(
    "tipo"=>"text"
,   "label"=>"Litologia 3");

$campos_item["porcentaje3"]=array(
    "tipo"=>"text"
,   "label"=>"Porcentaje 3");

$campos_item["litologia4"]=array(
    "tipo"=>"text"
,   "label"=>"Litologia 4");

$campos_item["porcentaje4"]=array(
    "tipo"=>"text"
,   "label"=>"Porcentaje 4");

$campos_item["permeabilidad"]=array(
    "tipo"=>"text"
,   "label"=>"Permeabilidad");

$campos_item["observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"Observaciones");

$grupo = "campos_litologico";
$campos[$grupo]= $campos_item;
unset($campos_item);
/**
 * Apartir de aca, puedes configurar otros campos
 */
