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
 * Grilla escalones tipos de prueba de bombeo (item_pozo_hidra_bombeo_dato)
 */
//-------------------------------------------------------------
$field_name = "tipobombeoId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Tipo bombeo ID"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "tiempo";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Tiempo (s)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "nivel_dinamico";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Nivel dinámico (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "caudal";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Caudal (l/s)"
,   "activo"=> 1
);

$field_name = "etapa";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Etapa (adm)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$grupo = "grilla_escalon";
$grilla[$grupo]= $grilla_items;
unset($grilla_items);

/**
 * Grilla escalones recuperacion (item_pozo_hidra_recuperacion_dato)
 */
//-------------------------------------------------------------
$field_name = "recuperacionId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Recuperación ID"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "tiempo";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Tiempo (s)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "nivel_dinamico";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Nivel dinámico (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$grupo = "grilla_recuperacion_escalon";
$grilla[$grupo]= $grilla_items;
unset($grilla_items);

/**
 * Grilla escalones observacion (item_pozo_hidra_recuperacion_dato)
 */
//-------------------------------------------------------------
$field_name = "observacionId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Observación ID"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "tiempo";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Tiempo (s)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "nivel_dinamico";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Nivel dinámico (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$grupo = "grilla_observacion_escalon";
$grilla[$grupo]= $grilla_items;
unset($grilla_items);

/**
 * Grilla escalones  recuperacion observacion (item_pozo_hidra_recupera_observa_dato)
 */
//-------------------------------------------------------------
$field_name = "recuperaobservaId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "ID"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "tiempo";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Tiempo (s)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "nivel_dinamico";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Nivel dinámico (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$grupo = "grilla_recupera_observa_escalon";
$grilla[$grupo]= $grilla_items;
unset($grilla_items);

/**
 * Grilla prueba de bombeo (item_pozo_hidra)
 */
//-------------------------------------------------------------
// $field_name = "pozoId";
// $grilla_items[]=array(
//     "campo" => $field_name // el campo de la base de datos que recupera
// ,   "field" => "$field_name" // se da formato o se configura el nombre del campo resultado
// ,   "label"=>"Pozo ID" //
// ,   "activo"=> 1
// );

//-------------------------------------------------------------
$field_name = "fecha";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Fecha"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "tipopruebaId";
$field_alias = "tipru";
$field_activo = 1;
$grilla_items[] = array(
    "campo" => "nombre" // nombre del campo pero de la tabla que relaciona
,   "field" => $field_name
,   "label" =>"Tipo prueba"
,   "as" => "tipo_prueba"
,   "tabla_alias" => $field_alias
,   "activo" => $field_activo
);

        $grilla_tablas[] = array(
            "tabla" => $CFGm->tabla["c_pozo_hidra_tipo_prueba"]
        ,   "alias" => $field_alias
        ,   "campo_id" => "itemId"
        ,   "relacion_id" => $field_name
        ,   "activo" => $field_activo
        );

//-------------------------------------------------------------
$field_name = "tipopruebaId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Tipo prueba ID"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "nivel_estatico";
$grilla_items[] = array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Nivel estático (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "nivel_dinamico";
$grilla_items[] = array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Nivel dinámico (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "caudal";
$grilla_items[] = array(
    "campo" => $field_name
,   "field" => $field_name
,   "label" => "Caudal (l/s)"
,   "activo" => 1
);

//-------------------------------------------------------------
// $field_name = "tipopruebaId";
// $grilla_items[]=array(
//     "campo" => $field_name
// ,   "field"=> $field_name
// ,   "label"=> "Tipo prueba ID"
// ,   "activo"=> 1
// );

//-------------------------------------------------------------
$field_name = "conductividad";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Conductividad hidráulica K (m/día)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "transmisividad";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Transmisividad T (m2/día)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "coeficiente";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Coeficiente almacenamiento S (adim)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "radio";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Radio cono abatimiento (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "porosidad";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Porosidad total (%)"
,   "activo"=> 1
);

//-------------------------------------------------------------
/*$field_name = "observaciones";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Observaciones"
,   "activo"=> 1
);*/

//-------------------------------------------------------------
$grupo = "grilla_prueba";
$grilla[$grupo]= $grilla_items;
$grilla_tablas_adicionales[$grupo] = $grilla_tablas;
unset($grilla_items);
unset($grilla_tablas);

/**
 * Grilla tipos de prueba de bombeo realizados (item_pozo_hidra_bombeo)
 */
//-------------------------------------------------------------
$field_name = "pruebabombeoId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Prueba bombeo ID"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "tipo";
$field_alias = "tipo";
$field_activo = 1;
$grilla_items[]=array(
    "campo" => "nombre" // nombre del campo pero de la tabla que relaciona
,   "field"=> $field_name
,   "label"=>"Tipo bombeo"
,   "as" => "tipo_bombeo"
,   "tabla_alias"=> $field_alias
,   "activo"=> $field_activo
);
        $grilla_tablas[] = array(
            "tabla" => $CFGm->tabla["c_pozo_hidra_tipo_bombeo"]
        ,    "alias"=> $field_alias
        ,   "campo_id"=>"itemId"
        ,   "relacion_id"=> $field_name
        ,   "activo"=> $field_activo
        );

//-------------------------------------------------------------
$field_name = "tipo";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Tipo bombeo ID"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "fecha";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Fecha"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "nivel_estatico";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Nivel estático (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "nivel_dinamico";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Nivel dinámico (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "duracion";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Duración (s)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "profundidad";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Profundidad bomba (m.b.b.p.)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "potencia";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Potencia bomba (HP)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "caudal";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Caudal (l/s)"
,   "activo"=> 1
);

//-------------------------------------------------------------
/*$field_name = "observaciones";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Observaciones"
,   "activo"=> 1
);*/

//-------------------------------------------------------------
$grupo = "grilla_tipo";
$grilla[$grupo]= $grilla_items;
$grilla_tablas_adicionales[$grupo] = $grilla_tablas;
unset($grilla_items);
unset($grilla_tablas);

/**
 * Grilla recuperacion (item_pozo_hidra_recuperacion)
 */
//-------------------------------------------------------------
$field_name = "tipobombeoId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Tipo bombeo ID"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "fecha";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Fecha"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "nivel_estatico";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Nivel estático (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "nivel_dinamico_final";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Nivel dinámico final (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "duracion";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Duración (s)"
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
$grupo = "grilla_recuperacion";
$grilla[$grupo]= $grilla_items;
unset($grilla_items);

/**
 * Grilla observacion (item_pozo_hidra_observacion)
 */
//-------------------------------------------------------------
$field_name = "tipobombeoId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Tipo bombeo ID"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "fecha";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Fecha"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "pozoId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Pozo ID"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "utm_este";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "UTM este (X)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "utm_norte";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "UTM norte (Y)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "zona";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Zona"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "nivel_estatico";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Nivel estático (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "nivel_dinamico";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Nivel dinámico final (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "duracion";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Duración total (s)"
,   "activo"=> 1
);

//-------------------------------------------------------------
/*$field_name = "observaciones";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Observaciones"
,   "activo"=> 1
);*/

//-------------------------------------------------------------
$grupo = "grilla_observacion";
$grilla[$grupo]= $grilla_items;
unset($grilla_items);

/**
 * Grilla recupera observa (item_pozo_hidra_recupera_observa)
 */
//-------------------------------------------------------------
$field_name = "recuperacionId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Recuperación ID"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "fecha";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Fecha"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "pozoId";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Pozo ID"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "utm_este";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "UTM este (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "utm_norte";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "UTM norte (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "zona";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Zona"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "nivel_estatico";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Nivel estático (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "nivel_dinamico";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Nivel dinámico final (m)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$field_name = "duracion";
$grilla_items[]=array(
    "campo" => $field_name
,   "field"=> $field_name
,   "label"=> "Duración total (s)"
,   "activo"=> 1
);

//-------------------------------------------------------------
$grupo = "grilla_recupera_observa";
$grilla[$grupo]= $grilla_items;
$grilla_tablas_adicionales[$grupo]= $grilla_tablas;
unset($grilla_items); // siempre se borrar la variable para iniciar una nueva configuración
unset($grilla_tablas); // siempre se borrar la variable para iniciar una nueva configuración