<?php
/**
 * Configuración de referncias de las tablas de las base de datos que utilizaremos en este módulo
 *
 */
$CFGm->tabla = array();
/**
 * Tablas de información principal, configuración de los objetos principales
 */
$tname = "item_"; //sufijo que puedes o no usar
$db_datos = array();
$db_datos[] = "proposito_pozo";
/*
$db_datos[] = "item";
$db_datos[] = "item_escala_maestra_gestion";
$db_datos[] = "item_escala_salarial";
$db_datos[] = "puesto";
$db_datos[] = "puesto_estructura_personal";
$db_datos[] = "escala_maestra_2";
*/
$CFGm->tabla = array_merge($CFGm->tabla,$core->db_tableConvert($db_datos));
unset($db_datos);

/**
 * Tablas de catalogos, dentro la base de datos principal
 */
 /*
$db_datos = array();
$db_datos[] = "gestion_activa";
$db_datos[] = "escala_maestra_categoria";
$db_datos[] = "escala_maestra_area";
$CFGm->tabla = array_merge($CFGm->tabla,$core->db_tableConvert($db_datos,"c"));
unset($db_datos);
*/
/**
 * Otra base de datos
 */
/**
 * Tablas de información de catalogo territorio
 */
 /*
$dbname = "vrhr_territorio"; // otra base de datos que no es la principal
$db_datos = array();
$db_datos[] = "departamento";
$CFGm->tabla = array_merge($CFGm->tabla,$core->db_tableConvert($db_datos,"o",$dbname));
unset($db_datos);
*/
/**
 * Tablas de información de catalogo territorio
 */
 /*
$dbname = "vrhr_snir"; // otra base de datos que no es la principal
$db_datos = array();
$db_datos[] = "core_usuario";
$CFGm->tabla = array_merge($CFGm->tabla,$core->db_tableConvert($db_datos,"o",$dbname));
unset($db_datos);
*/
/*
print_struc($CFGm->tabla);
exit;
*/
