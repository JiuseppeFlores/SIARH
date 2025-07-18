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

// estadoOperativo
// proveedorEnergia
// numeroMedidor
// medidorOperativo
// indicadorGprs
// observaciones

$campos_item["pozoId"]=array(
    "tipo"=>"text"
,   "label"=>"pozoId");

$campos_item["fecha"]=array(
    "tipo"=>"date"
,   "label"=>"Fecha");

$campos_item["hora"]=array(
    "tipo"=>"text"
,   "label"=>"Hora");

$campos_item["estadoOperativo"]=array(
    "tipo"=>"text"
,   "label"=>"Estado Operativo");

$campos_item["proveedorEnergia"]=array(
    "tipo"=>"text"
,   "label"=>"Proveedor Energía");

$campos_item["numeroMedidor"]=array(
    "tipo"=>"text"
,   "label"=>"Numero Medidor");

$campos_item["medidorOperativo"]=array(
    "tipo"=>"text"
,   "label"=>"Medidor Operativo");

$campos_item["indicadorGprs"]=array(
    "tipo"=>"text"
,   "label"=>"Señal GPRS");

$campos_item["observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"Observaciones");

$grupo = "campos_seguimiento";
$campos[$grupo]= $campos_item;
unset($campos_item);
/**
 * Apartir de aca, puedes configurar otros campos
 */
