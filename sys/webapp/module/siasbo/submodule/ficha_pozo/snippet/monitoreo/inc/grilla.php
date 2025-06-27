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

//-------------------------------------------------------------
//GRILLA MONITOREO CANTIDAD
$field_name = "pozoId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Codigo Pozo"
,   "activo"=> 1
);

$field_name = "fecha";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Fecha"
,   "activo"=> 1
);

$field_name = "hora";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Hora"
,   "activo"=> 1
);

// $field_name = "epocaId";
// $field_alias = "epoca";
// $field_activo = 1;
// $grilla_items[]=array(
//     "campo" => "nombre" // nombre del campo pero de la tabla que relaciona
// ,   "field"=> $field_name
// ,   "label"=>"Época"
// ,   "as" => $field_name
// ,   "tabla_alias"=> $field_alias
// ,   "activo"=> $field_activo
// );
//         $grilla_tablas[] = array(
//             "tabla" => $CFGm->tabla["c_epoca"]
//         ,    "alias"=> $field_alias
//         ,   "campo_id"=>"itemId"
//         ,   "relacion_id"=> $field_name
//         ,   "activo"=> $field_activo
//         );

$field_name = "puntoreferencia";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Punto de referencia"
,   "activo"=> 1
);

$field_name = "elevacion";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Elevacion"
,   "activo"=> 1
);

$field_name = "nivel_freatico";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Nivel freático"
,   "activo"=> 1
);

$field_name = "nivel_dinamico";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Nivel dinámico"
,   "activo"=> 1
);

$field_name = "nivel_estatico";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Nivel estático"
,   "activo"=> 1
);

$field_name = "caudal";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Caudal"
,   "activo"=> 1
);

$field_name = "caudalautorizado";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Caudal autorizado"
,   "activo"=> 1
);

$field_name = "observaciones";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Observaciones"
,   "activo"=> 1
);

$grupo = "grilla_cantidad";
$grilla[$grupo]= $grilla_items;
//$grilla_tablas_adicionales[$grupo]= $grilla_tablas;
unset($grilla_items); // siempre se borrar la variable para iniciar una nueva configuración

//-------------------------------------------------------------
//GRILLA MONITOREO CALIDAD
$field_name = "pozoId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Codigo pozo"
,   "activo"=> 1
);

$field_name = "fecha_muestreo";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Fecha de muestreo"
,   "activo"=> 1
);

$field_name = "hora_muestreo";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Hora de muestreo"
,   "activo"=> 1
);

/*$field_name = "epocaId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Época ID"
,   "activo"=> 1
);*/

$field_name = "epocaId";
$field_alias = "epoca";
$field_activo = 1;
$grilla_items[]=array(
    "campo" => "nombre" // nombre del campo pero de la tabla que relaciona
,   "field"=> $field_name
,   "label"=>"Época"
,   "as" => $field_name
,   "tabla_alias"=> $field_alias
,   "activo"=> $field_activo
);
        $grilla_tablas[] = array(
            "tabla" => $CFGm->tabla["c_epoca"]
        ,    "alias"=> $field_alias
        ,   "campo_id"=>"itemId"
        ,   "relacion_id"=> $field_name
        ,   "activo"=> $field_activo
        );

$field_name = "entidad";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Entidad que muestrea"
,   "activo"=> 1
);

$field_name = "codigo_muestra";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Código de muestra"
,   "activo"=> 1
);

$field_name = "fecha_analisis";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Fecha análisis"
,   "activo"=> 1
);

$field_name = "hora_analisis";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Hora análisis"
,   "activo"=> 1
);

$field_name = "nombre_laboratorio";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Nombre laboratorio"
,   "activo"=> 1
);

$field_name = "codigo_laboratorio";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Código análisis"
,   "activo"=> 1
);

$field_name = "profundidad";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Profundidad"
,   "activo"=> 1
);

$field_name = "observaciones";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Observaciones"
,   "activo"=> 1
);

$grupo = "grilla_calidad";
$grilla[$grupo]= $grilla_items;
$grilla_tablas_adicionales[$grupo]= $grilla_tablas;
unset($grilla_items); // siempre se borrar la variable para iniciar una nueva configuración
unset($grilla_tablas);

//-------------------------------------------------------------
//GRILLA MONITOREO CALIDAD COMPUESTO
$field_name = "calidadId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Código calidad"
,   "activo"=> 1
);

$field_name = "parametroId";
$field_alias = "param";
$field_activo = 1;
$grilla_items[]=array(
    "campo" => "nombre" // nombre del campo pero de la tabla que relaciona
,   "field"=> $field_name
,   "label"=>"Parámetro"
,   "as" => "nombre_parametro"
,   "tabla_alias"=> $field_alias
,   "activo"=> $field_activo
);
        $grilla_tablas[] = array(
            "tabla" => $CFGm->tabla["c_pozo_monitor_calidad_parametro"]
        ,    "alias"=> $field_alias
        ,   "campo_id"=>"itemId"
        ,   "relacion_id"=> $field_name
        ,   "activo"=> $field_activo
        );

$field_name = "parametroId";
$grilla_items[]=array(
    "campo" => $field_name 
,   "field" => "$field_name"
,   "label"=> "Código parámetro"
,   "activo"=> 1
);

$field_name = "compuestoId";
$field_alias = "compues";
$field_activo = 1;
$grilla_items[]=array(
    "campo" => "nombre" // nombre del campo pero de la tabla que relaciona
,   "field"=> $field_name
,   "label"=>"Compuesto"
,   "as" => "nombre_compuesto"
,   "tabla_alias"=> $field_alias
,   "activo"=> $field_activo
);
        $grilla_tablas[] = array(
            "tabla" => $CFGm->tabla["c_pozo_monitor_calidad_compuesto"]
        ,    "alias"=> $field_alias
        ,   "campo_id"=>"itemId"
        ,   "relacion_id"=> $field_name
        ,   "activo"=> $field_activo
        );

$field_name = "compuestoId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Código compuesto"
,   "activo"=> 1
);

$field_name = "valor";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Valor compuesto"
,   "activo"=> 1
);

$field_name = "observaciones";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Observaciones"
,   "activo"=> 1
);

$grupo = "grilla_calidad_compuesto";
$grilla[$grupo]= $grilla_items;
$grilla_tablas_adicionales[$grupo]= $grilla_tablas;
unset($grilla_items); // siempre se borrar la variable para iniciar una nueva configuración
unset($grilla_tablas);

//-------------------------------------------------------------
//GRILLA MONITOREO ISOTOPICO
$field_name = "pozoId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Código Pozo"
,   "activo"=> 1
);

$field_name = "fecha_muestreo";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Fecha de muestreo"
,   "activo"=> 1
);

$field_name = "hora_muestreo";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Hora de muestreo"
,   "activo"=> 1
);

/*$field_name = "epocaId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Época ID"
,   "activo"=> 1
);*/

$field_name = "epocaId";
$field_alias = "epoca";
$field_activo = 1;
$grilla_items[]=array(
    "campo" => "nombre" // nombre del campo pero de la tabla que relaciona
,   "field"=> $field_name
,   "label"=>"Época"
,   "as" => $field_name
,   "tabla_alias"=> $field_alias
,   "activo"=> $field_activo
);
        $grilla_tablas[] = array(
            "tabla" => $CFGm->tabla["c_epoca"]
        ,    "alias"=> $field_alias
        ,   "campo_id"=>"itemId"
        ,   "relacion_id"=> $field_name
        ,   "activo"=> $field_activo
        );

$field_name = "entidad";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Entidad que muestrea"
,   "activo"=> 1
);

$field_name = "codigo_muestra";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Código de muestra"
,   "activo"=> 1
);

$field_name = "fecha_analisis";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Fecha análisis"
,   "activo"=> 1
);

$field_name = "hora_analisis";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Hora análisis"
,   "activo"=> 1
);

$field_name = "nombre_laboratorio";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Nombre laboratorio"
,   "activo"=> 1
);

$field_name = "codigo_laboratorio";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Código análisis"
,   "activo"=> 1
);

$field_name = "profundidad";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Profundidad"
,   "activo"=> 1
);

$field_name = "observaciones";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Observaciones"
,   "activo"=> 1
);

$grupo = "grilla_isotopico";
$grilla[$grupo]= $grilla_items;
$grilla_tablas_adicionales[$grupo]= $grilla_tablas;
unset($grilla_items); // siempre se borrar la variable para iniciar una nueva configuración
unset($grilla_tablas);

//-------------------------------------------------------------
//GRILLA MONITOREO ISOTOPICO COMPUESTO
$field_name = "isotopicoId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Código isotópico"
,   "activo"=> 1
);

$field_name = "isotoparametroId";
$field_alias = "param";
$field_activo = 1;
$grilla_items[]=array(
    "campo" => "nombre" // nombre del campo pero de la tabla que relaciona
,   "field"=> $field_name
,   "label"=>"Parámetro"
,   "as" => "nombre_parametro"
,   "tabla_alias"=> $field_alias
,   "activo"=> $field_activo
);
        $grilla_tablas[] = array(
            "tabla" => $CFGm->tabla["c_pozo_monitor_isotopico_parametro"]
        ,    "alias"=> $field_alias
        ,   "campo_id"=>"itemId"
        ,   "relacion_id"=> $field_name
        ,   "activo"=> $field_activo
        );

$field_name = "isotoparametroId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Código parámetro"
,   "activo"=> 1
);

$field_name = "isotocompuestoId";
$field_alias = "compues";
$field_activo = 1;
$grilla_items[]=array(
    "campo" => "nombre" // nombre del campo pero de la tabla que relaciona
,   "field"=> $field_name
,   "label"=>"Compuesto"
,   "as" => "nombre_compuesto"
,   "tabla_alias"=> $field_alias
,   "activo"=> $field_activo
);
        $grilla_tablas[] = array(
            "tabla" => $CFGm->tabla["c_pozo_monitor_isotopico_compuesto"]
        ,    "alias"=> $field_alias
        ,   "campo_id"=>"itemId"
        ,   "relacion_id"=> $field_name
        ,   "activo"=> $field_activo
        );

$field_name = "isotocompuestoId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Código compuesto"
,   "activo"=> 1
);

$field_name = "valor";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Valor compuesto"
,   "activo"=> 1
);

$field_name = "observaciones";
$grilla_items[]=array(
    "campo" => $field_name
,   "field" => "$field_name"
,   "label"=> "Observaciones"
,   "activo"=> 1
);

$grupo = "grilla_isotopico_compuesto";
$grilla[$grupo]= $grilla_items;
$grilla_tablas_adicionales[$grupo]= $grilla_tablas;
unset($grilla_items); // siempre se borrar la variable para iniciar una nueva configuración