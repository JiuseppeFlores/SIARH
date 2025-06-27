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
$campos_item["itemId"]=array(
    "tipo"=>"text"
,   "label"=>"itemId");

$campos_item["fuente_informacion"]=array(
    "tipo"=>"text"
,   "label"=>"fuente_informacion");

$campos_item["codigo"]=array(
    "tipo"=>"text"
,   "label"=>"codigo");

$campos_item["usoaguaId"]=array(
    "tipo"=>"text"
,   "label"=>"usoaguaId");

$campos_item["propositoId"]=array(
    "tipo"=>"text"
,   "label"=>"propositoId");

$campos_item["propietario"]=array(
    "tipo"=>"text"
,   "label"=>"propietario");

$campos_item["observaciones"]=array(
    "tipo"=>"text"
,   "label"=>"observaciones");

$grupo = "campos_especifico"; //item //perforacion
$campos[$grupo]= $campos_item;
unset($campos_item);
/**
 * Apartir de aca, puedes configurar otros campos
 */