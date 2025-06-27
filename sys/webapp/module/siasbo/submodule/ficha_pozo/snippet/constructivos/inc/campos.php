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
 * Campos especifico
 */

$campos_item["itemId"]=array(
    "tipo"=>"text"
,   "label"=>"itemId");

$campos_item["constructivo_entubado"]=array(
    "tipo"=>"text"
,   "label"=>"constructivo_entubado");

$campos_item["constructivo_entubado_diametro"]=array(
    "tipo"=>"text"
,   "label"=>"constructivo_entubado_diametro");

$campos_item["constructivo_altura"]=array(
    "tipo"=>"text"
,   "label"=>"constructivo_altura");

$campos_item["constructivo_tuberiaId"]=array(
    "tipo"=>"text"
,   "label"=>"constructivo_tuberiaId");

$campos_item["constructivo_diametro"]=array(
    "tipo"=>"text"
,   "label"=>"constructivo_diametro");

$campos_item["constructivo_selloId"]=array(
    "tipo"=>"text"
,   "label"=>"constructivo_selloId");

$campos_item["constructivo_observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"constructivo_observaciones");

$grupo = "campos_constructivo";
$campos[$grupo]= $campos_item;
unset($campos_item);

/**
 * Campos diseño
 */
$campos_item["pozoId"]=array(
    "tipo"=>"text"
,   "label"=>"pozoId");

$campos_item["profundidad_desde"]=array(
    "tipo"=>"text"
,   "label"=>"profundidad_desde");

$campos_item["profundidad_hasta"]=array(
    "tipo"=>"text"
,   "label"=>"profundidad_hasta");

$campos_item["rejillafiltroId"]=array(
    "tipo"=>"text"
,   "label"=>"rejillafiltroId");

$campos_item["abertura"]=array(
    "tipo"=>"text"
,   "label"=>"abertura");

$campos_item["observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"observaciones");

$grupo = "campos_diseno";
$campos[$grupo]= $campos_item;
unset($campos_item);
/**
 * Apartir de aca, puedes configurar otros campos
 */
