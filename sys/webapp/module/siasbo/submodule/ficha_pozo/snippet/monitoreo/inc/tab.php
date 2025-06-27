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
    "label"=>"Prueba de bombeo en pozo"
,   "id_name"=>"BombeoPozo"
,   "sub_control"=>"hidraulicos"
,   "active"=>"1"
,   "icon" => "flaticon-share"
,   "new" => 1
);

//-------------------------------------------------------------
$item_tab[]=array(
    "label"=>"Prueba de bombeo en acuífero"
,   "id_name"=>"BombeoAcuifero"
,   "sub_control"=>"hidraulicos"
,   "active"=>"0"
,   "icon" => "fa fa-address-book"
,   "new" => 0
);

//-------------------------------------------------------------
$grupo = "tab_hidraulicos";
$tabs[$grupo]= $item_tab;
unset($item_tab); // siempre se borrar la variable para iniciar una nueva configuración
