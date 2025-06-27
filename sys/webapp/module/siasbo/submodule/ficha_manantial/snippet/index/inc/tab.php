<?php
/**
 * Configuración de los tabs a utilizarse en el snippet
 */
/**
 * Arreglos que se utilizaran en esta configuración
 */
$tabs = array();

/**
 * Realizamos la configuración de los taps para cada grupo que utilicemos
 */
//-------------------------------------------------------------
$item_tab[]=array(
    "label"=>"General"
,   "id_name"=>"general"
,   "sub_control"=>"general"
,   "active"=>"1"
,   "icon" => "fa fa-home"
,   "new" => 1
);

//-------------------------------------------------------------
$item_tab[]=array(
    "label"=>"Específico"
,   "id_name"=>"especifico"
,   "sub_control"=>"especifico"
,   "active"=>"0"
,   "icon" => "fa fa-tasks"
,   "new" => 0
);

//-------------------------------------------------------------
$item_tab[]=array(
    "label"=>"Monitoreo"
,   "id_name"=>"monitoreo"
,   "sub_control"=>"monitoreo"
,   "active"=>"0"
,   "icon" => "fa fa-chart-bar"
,   "new" => 0
);

//-------------------------------------------------------------
$item_tab[]=array(
    "label"=>"Archivos adjuntos"
,   "id_name"=>"archivos"
,   "sub_control"=>"archivos"
,   "active"=>"0"
,   "icon" => "fa fa-file-upload"
,   "new" => 0
);

//-------------------------------------------------------------
/**
 * Se añade el arreglo de tabs configurada a $tabs
 */
$grupo = "index";
$tabs[$grupo]= $item_tab;
unset($item_tab); // siempre se borrar la variable para iniciar una nueva configuración