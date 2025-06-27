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
    "label"=>"SEV"
,   "id_name"=>"sev"
,   "sub_control"=>"sev"
,   "active"=>"0"
,   "icon" => "fa fa-stream"
,   "new" => 0
);

//-------------------------------------------------------------
$item_tab[]=array(
    "label"=>"Tomografía"
,   "id_name"=>"tomografia"
,   "sub_control"=>"tomografia"
,   "active"=>"0"
,   "icon" => "fab fa-500px"
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