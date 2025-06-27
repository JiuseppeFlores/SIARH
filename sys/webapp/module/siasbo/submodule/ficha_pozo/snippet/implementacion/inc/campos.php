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

$campos_item["itemId"]=array(
    "tipo"=>"text"
,   "label"=>"itemId");

$campos_item["imple_profundidad"]=array(
    "tipo"=>"text"
,   "label"=>"Profundidad de la bomba");

$campos_item["imple_tipoId"]=array(
    "tipo"=>"text"
,   "label"=>"Tipo de Energia");

$campos_item["imple_caudal"]=array(
    "tipo"=>"text"
,   "label"=>"Caudal de bombeo");

$campos_item["imple_horario_bombeo"]=array(
    "tipo"=>"text"
,   "label"=>"Horario de bombeo");

$campos_item["imple_potencia"]=array(
    "tipo"=>"text"
,   "label"=>"Potencia de la bomba");

$campos_item["imple_observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"Observaciones");


$grupo = "campos_implementacion";
$campos[$grupo]= $campos_item;
unset($campos_item);
/**
 * Apartir de aca, puedes configurar otros campos
 */
