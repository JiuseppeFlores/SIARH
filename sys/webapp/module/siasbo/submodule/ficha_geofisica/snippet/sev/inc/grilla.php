<?php
/**
 * Configuramos todas las grillas que utilizaremos en este snippet
 */

/**
 * Arreglos que se utilizaran en esta configuración
 */
$grilla = array();
$grilla_tablas_adicionales = array();

/**
 * Configuramos las tablas adicionales para realizar un join con la tabla principal
 * estas tablas estan configuradas en el archivo db.referencia.php del submodulo
 * puede hacer un :
 *
 * print_struc($CFGm->tabla);exit;
 *
 * para ver el contenido de las tablas configuradas
 *
 * es una tabla de configuración para cada grilla
 */

/**
 * Items lista pozos
 */
//-------------------------------------------------------------
$field_name = "itemId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "ID"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "codigo";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Código"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "nombre";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=>"Nombre" //
,   "activo"=> 1
);

//-------------------------------------------------------------
$grupo = "grilla_pozo";
$grilla[$grupo]= $grilla_items;
unset($grilla_items);

/**
 * Items lista dev linea base
 */
//-------------------------------------------------------------
$field_name = "geofisicaId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Código geofísica"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "fecha";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=>"Fecha" //
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "campania";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Campaña"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "fuente";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Fuente de información"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "codigo";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Código de documento"
,   "activo"=> 1
);

//-------------------------------------------------------------
$grupo = "grilla_sev";
$grilla[$grupo]= $grilla_items;
unset($grilla_items);

/**
 * Items lista capa
 */
//-------------------------------------------------------------
$field_name = "geofisicaId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Código línea base"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "profundidad_desde";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Profundidad desde (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "profundidad_hasta";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Profundidad hasta (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "resistividad";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Resistividad"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "litologia";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Litología"
,   "activo"=> 1
);

//-------------------------------------------------------------
$grupo = "grilla_capa";
$grilla[$grupo]= $grilla_items;
unset($grilla_items);

/**
 * Items lista vinculo pozo
 */
//-------------------------------------------------------------
$field_name = "lineabaseId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Código línea base"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "pozoId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Código pozo"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "observaciones";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Observaciones"
,   "activo"=> 1
);

//-------------------------------------------------------------
$grupo = "grilla_vinculo_pozo";
$grilla[$grupo]= $grilla_items;
$grilla_tablas_adicionales[$grupo]= $grilla_tablas;
unset($grilla_items); // siempre se borrar la variable para iniciar una nueva configuración
unset($grilla_tablas); // siempre se borrar la variable para iniciar una nueva configuración
