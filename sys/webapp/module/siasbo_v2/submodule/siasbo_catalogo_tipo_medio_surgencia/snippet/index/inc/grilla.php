<?php
/**
 * Created by PhpStorm.
 * User: henrytaby
 * Date: 3/5/2018
 * Time: 15:27
 */

$grilla = array();
$grilla_tablas_adicionales = array();

/*-------------------------------------------*/
$field_name = "itemId";
$grilla_items[] = array(
    "campo" => $field_name
, 	"field" => $field_name
, 	"label" => "Código"
, 	"activo" => 1
);

/*-------------------------------------------*/
$field_name = "nombre";
$grilla_items[] = array(
    "campo" => $field_name
, 	"field" => $field_name
, 	"label" => "Nombre"
, 	"activo" => 1
);

/*-------------------------------------------*/
$field_name = "estado";
$grilla_items[] = array(
    "campo" => $field_name 
, 	"field" => $field_name
, 	"label" => "Estado" //
, 	"activo" => 1
);

/*-------------------------------------------*/
$grupo = "index";
$grilla[$grupo] = $grilla_items;
$grilla_tablas_adicionales[$grupo] = $grilla_tablas;
unset($grilla_items);
unset($grilla_tablas);