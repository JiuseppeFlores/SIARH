<?php
/**
 * Created by PhpStorm.
 * User: henrytaby
 * Date: 3/5/2018
 * Time: 15:27
 */

$campos = array();
$campos_item = array();

/*-------------------------------------------*/
$campos_item["nombre"]=array(
    "tipo"=>"text"
,   "label"=>"Nombres");

/*-------------------------------------------*/
$campos_item["estado"]=array(
    "tipo"=>"text"
,   "label"=>"Estado");

/*-------------------------------------------*/
$grupo = "tipo_uso_agua";
$campos[$grupo]= $campos_item;
unset($campos_item);
