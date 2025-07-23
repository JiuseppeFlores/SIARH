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
 * Item de las lista que se tiene desplegar
 */

/*

//-------------------------------------------------------------
$field_name = "nombres";
$grilla_items[]=array(
    "campo" => $field_name // el campo de la base de datos que recupera
,   "field" => "$field_name" // se da formato o se configura el nombre del campo resultado
,   "label"=>"Nombres" //
,   "activo"=> 1
);
//-------------------------------------------------------------
$field_name = "apellido_paterno";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Apellido Paterno"
,   "activo"=> 1
);
//-------------------------------------------------------------
$field_name = "ci_exp";
$field_alias = "depa";
$field_activo = 1;
$grilla_items[]=array(
    "campo" => "nombre" // nombre del campo pero de la tabla que relaciona
,   "field"=> $field_name
,   "label"=>"Expedido"
,   "as" => $field_name
,   "tabla_alias"=> $field_alias
,   "activo"=> $field_activo
);
        $grilla_tablas[] = array(
            "tabla" => $CFGm->tabla["o_departamento"]
        ,    "alias"=> $field_alias
        ,   "campo_id"=>"itemId"
        ,   "relacion_id"=> $field_name
        ,   "activo"=> $field_activo
        );
//-------------------------------------------------------------
$grupo = "nombre_funcionalidad";
$grilla[$grupo]= $grilla_items;
$grilla_tablas_adicionales[$grupo]= $grilla_tablas;
unset($grilla_items); // siempre se borrar la variable para iniciar una nueva configuración
unset($grilla_tablas); // siempre se borrar la variable para iniciar una nueva configuración
*/

$field_name = "pozoId";
$grilla_items[]=array(
    "campo" => $field_name // el campo de la base de datos que recupera
,   "field" => "$field_name" // se da formato o se configura el nombre del campo resultado
,   "label"=> "**Pozo ID" //
,   "activo"=> 1
);

$field_name = "fecha";
$grilla_items[]=array(
    "campo" => $field_name // el campo de la base de datos que recupera
,   "field" => "$field_name" // se da formato o se configura el nombre del campo resultado
,   "label"=> "Fecha" //
,   "activo"=> 1
);
$field_name = "hora";
$grilla_items[]=array(
    "campo" => $field_name // el campo de la base de datos que recupera
,   "field" => "$field_name" // se da formato o se configura el nombre del campo resultado
,   "label"=> "Hora" //
,   "activo"=> 1
);

$field_name = "estadoOperativo";
$field_alias = "std";
$field_activo = 1;
$grilla_items[]=array(
    "campo" => "nombre" // el campo de la base de datos que recupera
,   "field" => "$field_name" // se da formato o se configura el nombre del campo resultado
,   "label"=> "Estado Operativo" //
,   "as" => "estadoOperativo"
,   "tabla_alias"=> $field_alias
,   "activo"=> $field_activo
);

        $grilla_tablas[] = array(
            "tabla" => $CFGm->tabla["c_pozo_estado_operativo"]
        ,   "alias"=> $field_alias
        ,   "campo_id"=>"itemId"
        ,   "relacion_id"=> $field_name
        ,   "activo"=> $field_activo
        );

$field_name = "proveedorEnergia";
$field_alias = "nrg";
$field_activo = 1;
$grilla_items[]=array(
    "campo" => "nombre" // el campo de la base de datos que recupera
,   "field" => "$field_name" // se da formato o se configura el nombre del campo resultado
,   "label"=> "Proveedor de Energia" //
,   "as" => "proveedorEnergia"
,   "tabla_alias"=> $field_alias
,   "activo"=> $field_activo
);

        $grilla_tablas[] = array(
            "tabla" => $CFGm->tabla["c_pozo_proveedor_energia"]
        ,    "alias"=> $field_alias
        ,   "campo_id"=>"itemId"
        ,   "relacion_id"=> $field_name
        ,   "activo"=> $field_activo
        );

$field_name = "medidorOperativo";
$grilla_items[]=array(
    "campo" => $field_name // el campo de la base de datos que recupera
,   "field" => "$field_name" // se da formato o se configura el nombre del campo resultado
,   "label"=> "Medidor" //
,   "activo"=> 1
);

$field_name = "numeroMedidor";
$grilla_items[]=array(
    "campo" => $field_name // el campo de la base de datos que recupera
,   "field" => "$field_name" // se da formato o se configura el nombre del campo resultado
,   "label"=> "Numero de Medidor" //
,   "activo"=> 1
);

$field_name = "indicadorGprs";
$grilla_items[]=array(
    "campo" => $field_name // el campo de la base de datos que recupera
,   "field" => "$field_name" // se da formato o se configura el nombre del campo resultado
,   "label"=> "Señal GPRS" //
,   "activo"=> 1
);

// $field_name = "permeabilidad";
// $field_alias = "permea";
// $field_activo = 1;
// $grilla_items[]=array(
//     "campo" => "nombre" // nombre del campo pero de la tabla que relaciona
// ,   "field"=> $field_name
// ,   "label"=>"Permeabilidad estimada"
// ,   "as" => $field_name
// ,   "tabla_alias"=> $field_alias
// ,   "activo"=> $field_activo
// );

$field_name = "observaciones";
$grilla_items[]=array(
    "campo" => $field_name // el campo de la base de datos que recupera
,   "field" => "$field_name" // se da formato o se configura el nombre del campo resultado
,   "label"=> "Observaciones" //
,   "activo"=> 1
);

//-------------------------------------------------------------
$grupo = "grilla_seguimiento";
$grilla[$grupo]= $grilla_items;
$grilla_tablas_adicionales[$grupo]= $grilla_tablas;
unset($grilla_items); // siempre se borrar la variable para iniciar una nueva configuración
unset($grilla_tablas); // siempre se borrar la variable para iniciar una nueva configuración