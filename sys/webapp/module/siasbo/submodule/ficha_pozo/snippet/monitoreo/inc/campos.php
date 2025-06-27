<?php
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

//CAMPOS MONITOREO CANTIDAD
$campos_item["pozoId"]=array(
    "tipo"=>"text"
,   "label"=>"Codigo Pozo");

$campos_item["fecha"]=array(
    "tipo"=>"date_01"
,   "label"=>"Fecha");

$campos_item["hora"]=array(
    "tipo"=>"text"
,   "label"=>"Hora");

$campos_item["epocaId"]=array(
    "tipo"=>"text"
,   "label"=>"Epoca");

$campos_item["puntoreferencia"]=array(
    "tipo"=>"text"
,   "label"=>"Punto de Referencia");

$campos_item["elevacion"]=array(
    "tipo"=>"text"
,   "label"=>"Elevacion de Referencia");

$campos_item["nivel_freatico"]=array(
    "tipo"=>"text"
,   "label"=>"Nivel Freatico");

$campos_item["nivel_dinamico"]=array(
    "tipo"=>"text"
,   "label"=>"Nivel Dinamico");

$campos_item["nivel_estatico"]=array(
    "tipo"=>"text"
,   "label"=>"Nivel Estatico");

$campos_item["caudal"]=array(
    "tipo"=>"text"
,   "label"=>"Caudal");

$campos_item["caudalautorizado"]=array(
    "tipo"=>"text"
,   "label"=>"Caudal Autorizado");

$campos_item["observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"Observaciones");

$grupo = "campos_cantidad";
$campos[$grupo]= $campos_item;
unset($campos_item);
/**
 * Apartir de aca, puedes configurar otros campos
 */

//CAMPOS MONITOREO CALIDAD
$campos_item["pozoId"]=array(
    "tipo"=>"text"
,   "label"=>"Codigo Pozo");

$campos_item["fecha_muestreo"]=array(
    "tipo"=>"date_01"
,   "label"=>"Fecha de muestreo");

$campos_item["hora_muestreo"]=array(
    "tipo"=>"text"
,   "label"=>"Hora de muestreo");

$campos_item["epocaId"]=array(
    "tipo"=>"text"
,   "label"=>"Época");

$campos_item["entidad"]=array(
    "tipo"=>"text"
,   "label"=>"Entidad que muestrea");

$campos_item["codigo_muestra"]=array(
    "tipo"=>"text"
,   "label"=>"Codigo de la muestra");

$campos_item["fecha_analisis"]=array(
    "tipo"=>"date_01"
,   "label"=>"Fecha de analisis");

$campos_item["hora_analisis"]=array(
    "tipo"=>"text"
,   "label"=>"Hora de analisis");

$campos_item["nombre_laboratorio"]=array(
    "tipo"=>"text"
,   "label"=>"Nombre del laboratorio");

$campos_item["codigo_laboratorio"]=array(
    "tipo"=>"text"
,   "label"=>"Codigo del laboratorio");

$campos_item["profundidad"]=array(
    "tipo"=>"text"
,   "label"=>"Profundidad");

$campos_item["observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"Observaciones");

$grupo = "campos_calidad";
$campos[$grupo]= $campos_item;
unset($campos_item);

//CAMPOS MONITOREO CALIDAD COMPUESTOS
$campos_item["calidadId"]=array(
    "tipo"=>"text"
,   "label"=>"Monitor Calidad Id");

$campos_item["parametroId"]=array(
    "tipo"=>"text"
,   "label"=>"Parametro Id");

$campos_item["compuestoId"]=array(
    "tipo"=>"text"
,   "label"=>"Compuesto Id");

$campos_item["valor"]=array(
    "tipo"=>"text"
,   "label"=>"Valor");

$campos_item["observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"Observaciones");

$grupo = "campos_calidad_compuesto";
$campos[$grupo]= $campos_item;
unset($campos_item);


//CAMPOS MONITOREO ISOTOPICO
$campos_item["pozoId"]=array(
    "tipo"=>"text"
,   "label"=>"Codigo Pozo");

$campos_item["fecha_muestreo"]=array(
    "tipo"=>"date_01"
,   "label"=>"Fecha de muestreo");

$campos_item["hora_muestreo"]=array(
    "tipo"=>"text"
,   "label"=>"Hora de muestreo");

$campos_item["epocaId"]=array(
    "tipo"=>"text"
,   "label"=>"Época");

$campos_item["entidad"]=array(
    "tipo"=>"text"
,   "label"=>"Entidad que muestrea");

$campos_item["codigo_muestra"]=array(
    "tipo"=>"text"
,   "label"=>"Codigo de la muestra");

$campos_item["fecha_analisis"]=array(
    "tipo"=>"date_01"
,   "label"=>"Fecha de analisis");

$campos_item["hora_analisis"]=array(
    "tipo"=>"text"
,   "label"=>"Hora de analisis");

$campos_item["nombre_laboratorio"]=array(
    "tipo"=>"text"
,   "label"=>"Nombre del laboratorio");

$campos_item["codigo_laboratorio"]=array(
    "tipo"=>"text"
,   "label"=>"Codigo del laboratorio");

$campos_item["profundidad"]=array(
    "tipo"=>"text"
,   "label"=>"Profundidad");

$campos_item["observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"Observaciones");

$grupo = "campos_isotopico";
$campos[$grupo]= $campos_item;
unset($campos_item);


//CAMPOS MONITOREO ISOTOPICO COMPUESTOS
$campos_item["isotopicoId"]=array(
    "tipo"=>"text"
,   "label"=>"Monitor Calidad Id");

$campos_item["isotoparametroId"]=array(
    "tipo"=>"text"
,   "label"=>"Parametro Id");

$campos_item["isotocompuestoId"]=array(
    "tipo"=>"text"
,   "label"=>"Compuesto Id");

$campos_item["valor"]=array(
    "tipo"=>"text"
,   "label"=>"Valor");

$campos_item["observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"Observaciones");

$grupo = "campos_isotopico_compuesto";
$campos[$grupo]= $campos_item;
unset($campos_item);