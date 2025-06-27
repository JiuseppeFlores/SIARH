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

$campos_item["perforacion_fecha"]=array(
    "tipo"=>"date_01"
,   "label"=>"Fecha de Perforacion");

$campos_item["perforacion_pozoId"]=array(
    "tipo"=>"text"
,   "label"=>"Tipo de Pozo");

$campos_item["perforacion_tipoId"]=array(
    "tipo"=>"text"
,   "label"=>"Tipo de Perforacion");

$campos_item["perforacion_metodoId"]=array(
    "tipo"=>"text"
,   "label"=>"Metodo de Perforacion");

$campos_item["perforacion_profundidad"]=array(
    "tipo"=>"text"
,   "label"=>"Profundidad Perforada");

$campos_item["perforacion_diametro"]=array(
    "tipo"=>"text"
,   "label"=>"Diametro de Perforacion Inicial");

$campos_item["perforacion_diametro_final"]=array(
    "tipo"=>"text"
,   "label"=>"Diametro de Perforacion Final");

$campos_item["perforacion_revestimientoId"]=array(
    "tipo"=>"text"
,   "label"=>"Tipo de Revestimiento");

$campos_item["perforacion_excavacionId"]=array(
    "tipo"=>"text"
,   "label"=>"Tipo de Excavacion");

$campos_item["perforacion_profundidadexcavada"]=array(
    "tipo"=>"text"
,   "label"=>"Profundidad Excavada");

$campos_item["perforacion_diametroexcavacion"]=array(
    "tipo"=>"text"
,   "label"=>"Diametro de Excavacion");

$campos_item["perforacion_nivelfreatico"]=array(
    "tipo"=>"text"
,   "label"=>"Nivel Freático");

$campos_item["perforacion_caudal"]=array(
    "tipo"=>"text"
,   "label"=>"Caudal");

$campos_item["perforacion_observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"Observaciones");

$grupo = "campos_perforacion"; //item
$campos[$grupo]= $campos_item;
unset($campos_item);

/**
 * Apartir de aca, puedes configurar otros campos
 */
// $campos_item["itemId"]=array(
//     "tipo"=>"text"
// ,   "label"=>"itemId");

// $campos_item["perforacion_fecha"]=array(
//     "tipo"=>"date_01"
// ,   "label"=>"Fecha de Perforacion");

// $campos_item["perforacion_pozoId"]=array(
//     "tipo"=>"text"
// ,   "label"=>"Tipo de Pozo");

// $campos_item["perforacion_revestimientoId"]=array(
//     "tipo"=>"text"
// ,   "label"=>"Tipo de Revestimiento");

// $campos_item["perforacion_excavacionId"]=array(
//     "tipo"=>"text"
// ,   "label"=>"Tipo de Excavacion");

// $campos_item["perforacion_profundidadexcavada"]=array(
//     "tipo"=>"text"
// ,   "label"=>"Profundidad Excavada");

// $campos_item["perforacion_diametroexcavacion"]=array(
//     "tipo"=>"text"
// ,   "label"=>"Diametro de Excavacion");

// $campos_item["perforacion_nivelfreatico"]=array(
//     "tipo"=>"text"
// ,   "label"=>"Nivel Freático");

// $campos_item["perforacion_caudal"]=array(
//     "tipo"=>"text"
// ,   "label"=>"Caudal");

// $campos_item["perforacion_observaciones"]=array(
//     "tipo"=>"text"
// ,   "label"=>"Observaciones");

// $grupo = "campos_perforacion_excavado"; //item
// $campos[$grupo]= $campos_item;
// unset($campos_item);