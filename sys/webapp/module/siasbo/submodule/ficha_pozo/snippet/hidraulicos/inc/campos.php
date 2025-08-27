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


/**
 * Campos item_pozo_hidra
 */
$campos_item["pozoId"]=array(
    "tipo"=>"text"
,   "label"=>"pozoId");

$campos_item["fecha"]=array(
    "tipo"=>"date_01"
,   "label"=>"fecha");

$campos_item["nivel_estatico"]=array(
    "tipo"=>"text"
,   "label"=>"nivel_estatico");

$campos_item["nivel_dinamico"]=array(
    "tipo"=>"text"
,   "label"=>"nivel_dinamico");

$campos_item["caudal"]=array(
    "tipo"=>"text"
,   "label"=>"caudal");

$campos_item["conductividad"]=array(
    "tipo"=>"text"
,   "label"=>"conductividad");

$campos_item["transmisividad"]=array(
    "tipo"=>"text"
,   "label"=>"transmisividad");

$campos_item["coeficiente"]=array(
    "tipo"=>"text"
,   "label"=>"coeficiente");

$campos_item["radio"]=array(
    "tipo"=>"text"
,   "label"=>"radio");

$campos_item["porosidad"]=array(
    "tipo"=>"text"
,   "label"=>"porosidad");

$campos_item["tipopruebaId"]=array(
    "tipo"=>"text"
,   "label"=>"tipopruebaId");

$campos_item["observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"observaciones");

$grupo = "campos_prueba";
$campos[$grupo]= $campos_item;
unset($campos_item);

/**
 * Campos item_pozo_hidra_bombeo
 */
$campos_item["pruebabombeoId"]=array(
    "tipo"=>"text"
,   "label"=>"pruebabombeoId");

$campos_item["tipo"]=array(
    "tipo"=>"text"
,   "label"=>"tipo");

$campos_item["fecha"]=array(
    "tipo"=>"date_01"
,   "label"=>"fecha");

$campos_item["nivel_estatico"]=array(
    "tipo"=>"text"
,   "label"=>"nivel_estatico");

$campos_item["nivel_dinamico"]=array(
    "tipo"=>"text"
,   "label"=>"nivel_dinamico");

$campos_item["duracion"]=array(
    "tipo"=>"text"
,   "label"=>"duracion");

$campos_item["profundidad"]=array(
    "tipo"=>"text"
,   "label"=>"profundidad");

$campos_item["potencia"]=array(
    "tipo"=>"text"
,   "label"=>"potencia");

$campos_item["caudal"]=array(
    "tipo"=>"text"
,   "label"=>"caudal");

$campos_item["observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"observaciones");

$grupo = "campos_tipo";
$campos[$grupo]= $campos_item;
unset($campos_item);

/**
 * Campos item_pozo_hidra_bombeo_dato
 */
$campos_item["tipobombeoId"]=array(
    "tipo"=>"text"
,   "label"=>"tipobombeoId");

$campos_item["tiempo"]=array(
    "tipo"=>"text"
,   "label"=>"tiempo");

$campos_item["nivel_dinamico"]=array(
    "tipo"=>"text"
,   "label"=>"nivel_dinamico");

$campos_item["caudal"]=array(
    "tipo"=>"text"
,   "label"=>"caudal");

$campos_item["etapa"]=array(
    "tipo"=>"text"
,   "label"=>"Etapa");

$grupo = "campos_escalon";
$campos[$grupo]= $campos_item;
unset($campos_item);

/**
 * Campos item_pozo_hidra_recuperacion
 */
$campos_item["tipobombeoId"]=array(
    "tipo"=>"text"
,   "label"=>"tipobombeoId");

$campos_item["fecha"]=array(
    "tipo"=>"date_01"
,   "label"=>"fecha");

$campos_item["nivel_estatico"]=array(
    "tipo"=>"text"
,   "label"=>"nivel_estatico");

$campos_item["nivel_dinamico_final"]=array(
    "tipo"=>"text"
,   "label"=>"nivel_dinamico_final");

$campos_item["duracion"]=array(
    "tipo"=>"text"
,   "label"=>"duracion");

$campos_item["observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"observaciones");

$grupo = "campos_recuperacion";
$campos[$grupo]= $campos_item;
unset($campos_item);

/**
 * Campos item_pozo_hidra_recuperacion_dato
 */
$campos_item["recuperacionId"]=array(
    "tipo"=>"text"
,   "label"=>"recuperacionId");

$campos_item["tiempo"]=array(
    "tipo"=>"text"
,   "label"=>"tiempo");

$campos_item["nivel_dinamico"]=array(
    "tipo"=>"text"
,   "label"=>"nivel_dinamico");

$grupo = "campos_recuperacion_escalon";
$campos[$grupo]= $campos_item;
unset($campos_item);

/**
 * Campos item_pozo_hidra_observacion
 */
$campos_item["tipobombeoId"]=array(
    "tipo"=>"text"
,   "label"=>"tipobombeoId");

$campos_item["fecha"]=array(
    "tipo"=>"date_01"
,   "label"=>"fecha");

$campos_item["pozoId"]=array(
    "tipo"=>"text"
,   "label"=>"pozoId");

$campos_item["utm_este"]=array(
    "tipo"=>"text"
,   "label"=>"utm_este");

$campos_item["utm_norte"]=array(
    "tipo"=>"text"
,   "label"=>"utm_norte");

$campos_item["zona"]=array(
    "tipo"=>"text"
,   "label"=>"zona");

$campos_item["nivel_estatico"]=array(
    "tipo"=>"text"
,   "label"=>"nivel_estatico");

$campos_item["nivel_dinamico"]=array(
    "tipo"=>"text"
,   "label"=>"nivel_dinamico");

$campos_item["duracion"]=array(
    "tipo"=>"text"
,   "label"=>"duracion");

$campos_item["observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"observaciones");

$grupo = "campos_observacion";
$campos[$grupo]= $campos_item;
unset($campos_item);

/**
 * Campos item_pozo_hidra_observacion_dato
 */
$campos_item["observacionId"]=array(
    "tipo"=>"text"
,   "label"=>"observacionId");

$campos_item["tiempo"]=array(
    "tipo"=>"text"
,   "label"=>"tiempo");

$campos_item["nivel_dinamico"]=array(
    "tipo"=>"text"
,   "label"=>"nivel_dinamico");

$grupo = "campos_observacion_escalon";
$campos[$grupo]= $campos_item;
unset($campos_item);

/**
 * Campos item_pozo_hidra_recupera_observa
 */
$campos_item["recuperacionId"]=array(
    "tipo"=>"text"
,   "label"=>"recuperacionId");

$campos_item["fecha"]=array(
    "tipo"=>"date_01"
,   "label"=>"fecha");

$campos_item["pozoId"]=array(
    "tipo"=>"text"
,   "label"=>"pozoId");

$campos_item["utm_este"]=array(
    "tipo"=>"text"
,   "label"=>"utm_este");

$campos_item["utm_norte"]=array(
    "tipo"=>"text"
,   "label"=>"utm_norte");

$campos_item["zona"]=array(
    "tipo"=>"text"
,   "label"=>"zona");

$campos_item["nivel_estatico"]=array(
    "tipo"=>"text"
,   "label"=>"nivel_estatico");

$campos_item["nivel_dinamico"]=array(
    "tipo"=>"text"
,   "label"=>"nivel_dinamico");

$campos_item["duracion"]=array(
    "tipo"=>"text"
,   "label"=>"duracion");

$campos_item["observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"observaciones");

$grupo = "campos_recupera_observa";
$campos[$grupo]= $campos_item;
unset($campos_item);

/**
 * Campos item_pozo_hidra_recupera_observa_dato
 */
$campos_item["recuperaobservaId"]=array(
    "tipo"=>"text"
,   "label"=>"recuperaobservaId");

$campos_item["tiempo"]=array(
    "tipo"=>"text"
,   "label"=>"tiempo");

$campos_item["nivel_dinamico"]=array(
    "tipo"=>"text"
,   "label"=>"nivel_dinamico");

$grupo = "campos_recupera_observa_escalon";
$campos[$grupo]= $campos_item;
unset($campos_item);
/**
 * Apartir de aca, puedes configurar otros campos
 */
