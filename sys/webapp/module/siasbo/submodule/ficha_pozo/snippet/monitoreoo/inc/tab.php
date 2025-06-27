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
    "label"=>"Monitoreo Cantidad"
,   "id_name"=>"monitorcantidad"
,   "sub_control"=>"monitorcantidad"
,   "active"=>"1"
,   "icon" => "flaticon-share"
,   "new" => 1
);
//-------------------------------------------------------------
$item_tab[]=array(
    "label"=>"Monitoreo Calidad"
,   "id_name"=>"monitorcalidad"
,   "sub_control"=>"monitorcalidad"
,   "active"=>"0"
,   "icon" => "fa fa-address-book"
,   "new" => 0
);
//-------------------------------------------------------------}
$item_tab[]=array(
    "label"=>"Monitoreo Isotopico"
,   "id_name"=>"monitorisotopico"
,   "sub_control"=>"monitorisotopico"
,   "active"=>"0"
,   "icon" => "fa fa-address-book"
,   "new" => 0
);
//-------------------------------------------------------------}
$grupo = "tab_monitor";
$tabs[$grupo]= $item_tab;
unset($item_tab); // siempre se borrar la variable para iniciar una nueva configuración
