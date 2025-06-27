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

$campos_item["itemId"]=array(
    "tipo"=>"text"
,   "label"=>"itemId");

$campos_item["fechainicio"]=array(
    "tipo"=>"text"
,   "label"=>"fechainicio");

$campos_item["conexionesagua"]=array(
    "tipo"=>"text"
,   "label"=>"conexionesagua");

$campos_item["coberturaagua"]=array(
    "tipo"=>"text"
,   "label"=>"coberturaagua");

$campos_item["numero"]=array(
    "tipo"=>"text"
,   "label"=>"numero");

$campos_item["caudal"]=array(
    "tipo"=>"text"
,   "label"=>"caudal");

$campos_item["almacenamiento"]=array(
    "tipo"=>"text"
,   "label"=>"almacenamiento");

$campos_item["capacidad"]=array(
    "tipo"=>"text"
,   "label"=>"capacidad");

$campos_item["aduccion"]=array(
    "tipo"=>"text"
,   "label"=>"aduccion");

$campos_item["red"]=array(
    "tipo"=>"text"
,   "label"=>"red");

$campos_item["area"]=array(
    "tipo"=>"text"
,   "label"=>"area");

$campos_item["captaobservacion"]=array(
    "tipo"=>"text"
,   "label"=>"captaobservacion");

$grupo = "campos_captacion";
$campos[$grupo]= $campos_item;
unset($campos_item);
/**
 * Apartir de aca, puedes configurar otros campos
 */
