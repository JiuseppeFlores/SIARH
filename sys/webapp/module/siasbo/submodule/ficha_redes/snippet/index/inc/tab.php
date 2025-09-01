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
// $item_tab[]=array(
//     "label"=>"Especifico"
// ,   "id_name"=>"especifico"
// ,   "sub_control"=>"especifico"
// ,   "active"=>"0"
// ,   "icon" => "fa fa-tasks"
// ,   "new" => 0
// );

//-------------------------------------------------------------
// $item_tab[]=array(
//     "label"=>"Perforación"
// ,   "id_name"=>"perforacion"
// ,   "sub_control"=>"perforacion"
// ,   "active"=>"0"
// ,   "icon" => "fa fa-bullseye"
// ,   "new" => 0
// );

//-------------------------------------------------------------
// $item_tab[]=array(
//     "label"=>"Datos Constructivos"
// ,   "id_name"=>"constructivos"
// ,   "sub_control"=>"constructivos"
// ,   "active"=>"0"
// ,   "icon" => "fa fa-wrench"
// ,   "new" => 0
// );

//-------------------------------------------------------------
// $item_tab[]=array(
//     "label"=>"Columna Litológica"
// ,   "id_name"=>"columnalitologica"
// ,   "sub_control"=>"columnalitologica"
// ,   "active"=>"0"
// ,   "icon" => "fa fa-layer-group"
// ,   "new" => 0
// );

//-------------------------------------------------------------
// $item_tab[]=array(
//     "label"=>"Perfilaje Eléctrico"
// ,   "id_name"=>"perfilelectrico"
// ,   "sub_control"=>"perfilelectrico"
// ,   "active"=>"0"
// ,   "icon" => "fa fa-bolt"
// ,   "new" => 0
// );

//-------------------------------------------------------------
// $item_tab[]=array(
//     "label"=>"Datos Hidráulicos"
// ,   "id_name"=>"hidraulicos"
// ,   "sub_control"=>"hidraulicos"
// ,   "active"=>"0"
// ,   "icon" => "fa fa-cogs"
// ,   "new" => 0
// );

//-------------------------------------------------------------
// $item_tab[]=array(
//     "label"=>"Datos de Implementación"
// ,   "id_name"=>"implementacion"
// ,   "sub_control"=>"implementacion"
// ,   "active"=>"0"
// ,   "icon" => "fa fa-expand"
// ,   "new" => 0
// );

//-------------------------------------------------------------
$item_tab[]=array(
    "label"=>"Listado de Items"
,   "id_name"=>"redes"
,   "sub_control"=>"redes"
,   "active"=>"0"
,   "icon" => "fa fa-tasks"
,   "new" => 0
);

//-------------------------------------------------------------
// $item_tab[]=array(
//     "label"=>"Monitoreo"
// ,   "id_name"=>"monitoreo"
// ,   "sub_control"=>"monitoreo"
// ,   "active"=>"0"
// ,   "icon" => "fa fa-chart-line"
// ,   "new" => 0
// );

//-------------------------------------------------------------
// $item_tab[]=array(
//     "label"=>"Archivos adjuntos"
// ,   "id_name"=>"archivos"
// ,   "sub_control"=>"archivos"
// ,   "active"=>"0"
// ,   "icon" => "fa fa-file-upload"
// ,   "new" => 0
// );

// $item_tab[]=array(
//     "label"=>"Importacion de archivos"
// ,   "id_name"=>"importacion"
// ,   "sub_control"=>"importacion"
// ,   "active"=>"0"
// ,   "icon" => "fa fa-file"
// ,   "new" => 0
// );

//-------------------------------------------------------------
/**
 * Se añade el arreglo de tabs configurada a $tabs
 */
$grupo = "index";
$tabs[$grupo]= $item_tab;
unset($item_tab); // siempre se borrar la variable para iniciar una nueva configuración

/**
 * A partir de aca puede añadir todos los grupos de tabs que sean necesarias para esta vista
 */
/*
$item_tab = array();
$item_tab[]=array(
    "label"=>"General"
,   "id_name"=>"general"
,   "sub_control"=>"general"
,   "active"=>"1"
,   "icon" => "flaticon-share"
,   "new" => 1
);
//-------------------------------------------------------------
$item_tab[]=array(
    "label"=>"Codice"
,   "id_name"=>"codice"
,   "sub_control"=>"codice"
,   "active"=>"0"
,   "icon" => "fa fa-address-book"
,   "new" => 0
);
$grupo = "otro_grupo";
$tabs[$grupo]= $item_tab;
unset($item_tab);
*/