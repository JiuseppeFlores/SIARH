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
    "tipo"=>"date_01"
,   "label"=>"Fecha");

$campos_item["fechaInstalacion"]=array(
    "tipo"=>"date_01"
,   "label"=>"Fecha de Instalación");


$campos_item["hora"]=array(
    "tipo"=>"text"
,   "label"=>"Hora");

$campos_item["caudal"]=array(
    "tipo"=>"text"
,   "label"=>"Caudal");

$campos_item["tirante"]=array(
    "tipo"=>"text"
,   "label"=>"Tirante");

$campos_item["flujo"]=array(
    "tipo"=>"text"
,   "label"=>"Flujo");

$campos_item["velocidad"]=array(
    "tipo"=>"text"
,   "label"=>"Velocidad");

$campos_item["tipoId"]=array(
    "tipo"=>"text"
,   "label"=>"Tipo");

$campos_item["conexionSubterranea"]=array(
    "tipo"=>"text"
,   "label"=>"Conexion de agua subterranea");

$campos_item["altura"]=array(
    "tipo"=>"text"
,   "label"=>"Altura");

$campos_item["tipo"]=array(
    "tipo"=>"text"
,   "label"=>"Tipo");

$campos_item["alturaAgua"]=array(
    "tipo"=>"text"
,   "label"=>"Altura del Agua");

$campos_item["alturaBorde"]=array(
    "tipo"=>"text"
,   "label"=>"Altura del Borde");

$campos_item["conexionesagua"]=array(
    "tipo"=>"text"
,   "label"=>"Conexiones de agua potable");

$campos_item["almacenamiento"]=array(
    "tipo"=>"text"
,   "label"=>"Tipo de almacenamiento");

$campos_item["coberturaagua"]=array(
    "tipo"=>"text"
,   "label"=>"Cobertura del servicio de agua");

$campos_item["numero"]=array(
    "tipo"=>"text"
,   "label"=>"Número de fuentes");

$campos_item["capacidad"]=array(
    "tipo"=>"text"
,   "label"=>"Capacidad de almacenamiento");

$campos_item["aduccion"]=array(
    "tipo"=>"text"
,   "label"=>"Aducción");

$campos_item["red"]=array(
    "tipo"=>"text"
,   "label"=>"Red de distribución");

$campos_item["area"]=array(
    "tipo"=>"text"
,   "label"=>"Área de servicio");

$campos_item["captaobservacion"]=array(
    "tipo"=>"text"
,   "label"=>"Observaciones");

$grupo = "campos_fuente";
$campos[$grupo]= $campos_item;
unset($campos_item);
/**
 * Apartir de aca, puedes configurar otros campos
 */
