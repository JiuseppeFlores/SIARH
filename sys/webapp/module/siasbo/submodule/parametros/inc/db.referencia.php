<?php
/**
 * Configuración de referncias de las tablas de las base de datos que utilizaremos en este módulo
 *
 */
$CFGm->tabla = array();
/**
 * Tablas de información principal, configuración de los objetos principales
 */

/**
 * Tablas de información principal, configuración de los objetos principales
 */

$db_prefix = "item_"; //prefijo de la base de datos
$db_datos = array();
$db_datos[] = $core->get_alias_campo("catalogos",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_epoca",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_geofisica_dev_config",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_geofisica_dev_lineabase",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_geofisica_tomografia_config",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_manantial_medio",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_manantial_permanencia",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_manantial_tipo",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_manantial_usoagua",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_constructivo_rejillafiltro",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_constructivo_sello",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_constructivo_tuberia",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_electrico_parametro",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_hidra_tipo_prueba",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_hidra_tipo_bombeo",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_implementacion_tipo",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_litologico_permeabilidad",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_perforacion",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_perforacion_metodo",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_perforacion_tipo",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_proposito",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_tipo",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_usoagua",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_tipo",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_monitor_calidad_parametro",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_monitor_calidad_compuesto",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_monitor_isotopico_parametro",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_monitor_isotopico_compuesto",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_general_epsas",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_perforacion_revestimiento",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_pozo_perforacion_excavacion",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_acuifero",$db_prefix,"");
$db_datos[] = $core->get_alias_campo("catalogo_cuenca",$db_prefix,"");

$CFGm->tabla = array_merge($CFGm->tabla,$core->get_tablas_from_array($db_datos,"",$dbname,"",""));
unset($db_datos);
unset($db_prefix);

/*$db_datos = array();
$db_datos[] = $core->get_alias_campo("anexo_categoria","","");
$db_datos[] = $core->get_alias_campo("geofisica_dev_config","","");
$db_datos[] = $core->get_alias_campo("geofisica_dev_lineabase","","");
$db_datos[] = $core->get_alias_campo("geofisica_tomografia_config","","");

$CFGm->tabla = array_merge($CFGm->tabla,$core->get_tablas_from_array($db_datos,"c",$dbname,"",""));
unset($db_datos);
unset($db_prefix);*/

/**
 * Otras base de datos
 */
/*$dbname = "vrhr_territorio"; // otra base de datos que no es la principal
$db_datos = array();
$db_datos[] = $core->get_alias_campo("departamento","","");
$db_datos[] = $core->get_alias_campo("provincia","","");
$db_datos[] = $core->get_alias_campo("municipio","","");
$CFGm->tabla = array_merge($CFGm->tabla,$core->get_tablas_from_array($db_datos,"o",$dbname));
unset($db_datos);
unset($dbname);
unset($db_prefix);*/

$dbname = "vrhr_snir"; // otra base de datos que no es la principal
$db_prefix= "core_";
$db_datos[] = $core->get_alias_campo($db_prefix."usuario",$db_prefix,"");
$CFGm->tabla = array_merge($CFGm->tabla,$core->get_tablas_from_array($db_datos,"o",$dbname));
unset($db_datos);
unset($dbname);
unset($db_prefix);

/* /
print_struc($CFGm->tabla);
print_struc($CFG->tabla);
exit;
/**/