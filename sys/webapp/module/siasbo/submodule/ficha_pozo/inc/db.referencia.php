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
$db_datos[] = $core->get_alias_campo("item",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."anexo",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."foto",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."video",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."tipo",$db_prefix,"");

// $db_datos[] = $core->get_alias_campo($db_prefix."geofisica",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."pozo",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."archivo_adjunto",$db_prefix,"");

// $db_prefix = "item_geofisica_"; //prefijo de la base de datos
// $db_datos[] = $core->get_alias_campo($db_prefix."dev_capa",$db_prefix,"");

$db_prefix = "item_pozo_"; //prefijo de la base de datos
$db_datos[] = $core->get_alias_campo($db_prefix."constructivo_diseno",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."constructivo_sello",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."electrico_parametro",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."hidra_bombeo",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."estado_operativo",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."hidra_bombeo_dato",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."hidra_observacion",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."hidra_observacion_dato",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."hidra_recuperacion",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."hidra_recuperacion_dato",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."hidra_recupera_observa",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."hidra_recupera_observa_dato",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."litologica",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."monitor",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."perforacion",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."proposito",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."usoagua",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."hidra",$db_prefix,"");

$db_datos[] = $core->get_alias_campo($db_prefix."monitor_calidad",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."monitor_calidad_dato",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."monitor_isotopico",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."monitor_isotopico_dato",$db_prefix,"");

// $db_prefix = "manantial_"; //prefijo de la base de datos
// $db_datos[] = $core->get_alias_campo($db_prefix."monitoreo",$db_prefix,"");
// $db_datos[] = $core->get_alias_campo($db_prefix."usoagua",$db_prefix,"");

$CFGm->tabla = array_merge($CFGm->tabla,$core->get_tablas_from_array($db_datos,"",$dbname,"",""));
unset($db_datos);
unset($db_prefix);

//Catalogos
$db_datos = array();
$db_datos[] = $core->get_alias_campo("pozo_usoagua","","");
$db_datos[] = $core->get_alias_campo("pozo_proposito","","");

$db_datos[] = $core->get_alias_campo("pozo_perforacion","","");
$db_datos[] = $core->get_alias_campo("pozo_perforacion_metodo","","");
$db_datos[] = $core->get_alias_campo("pozo_perforacion_tipo","","");

$db_datos[] = $core->get_alias_campo("pozo_constructivo_tuberia","","");
$db_datos[] = $core->get_alias_campo("pozo_constructivo_sello","","");
$db_datos[] = $core->get_alias_campo("pozo_constructivo_rejillafiltro","","");

$db_datos[] = $core->get_alias_campo("pozo_electrico_parametro","","");

$db_datos[] = $core->get_alias_campo("pozo_hidra_tipo_bombeo","","");

$db_datos[] = $core->get_alias_campo("pozo_implementacion_tipo","","");

$db_datos[] = $core->get_alias_campo("pozo_litologico_permeabilidad","","");
$db_datos[] = $core->get_alias_campo("pozo_estado_operativo","","");
$db_datos[] = $core->get_alias_campo("pozo_proveedor_energia","","");

$db_datos[] = $core->get_alias_campo("epoca","","");

$db_datos[] = $core->get_alias_campo("pozo_hidra_tipo_prueba","","");

$db_datos[] = $core->get_alias_campo("pozo_monitor_calidad_parametro","","");
$db_datos[] = $core->get_alias_campo("pozo_monitor_calidad_compuesto","","");
$db_datos[] = $core->get_alias_campo("pozo_monitor_isotopico_parametro","","");
$db_datos[] = $core->get_alias_campo("pozo_monitor_isotopico_compuesto","","");

$db_datos[] = $core->get_alias_campo("pozo_general_epsas","","");

$db_datos[] = $core->get_alias_campo("pozo_perforacion_revestimiento","","");
$db_datos[] = $core->get_alias_campo("pozo_perforacion_excavacion","","");

$db_datos[] = $core->get_alias_campo("acuifero","","");
$db_datos[] = $core->get_alias_campo("cuenca","","");


$CFGm->tabla = array_merge($CFGm->tabla,$core->get_tablas_from_array($db_datos,"c",$dbname,"",""));
unset($db_datos);



$db_datos = array();
// $db_datos[] = $core->get_alias_campo("anexo_categoria","","");
// $db_datos[] = $core->get_alias_campo("geofisica_dev_config","","");
$db_datos[] = $core->get_alias_campo("geofisica_dev_lineabase","","");
// $db_datos[] = $core->get_alias_campo("geofisica_tomografia_config","","");

$CFGm->tabla = array_merge($CFGm->tabla,$core->get_tablas_from_array($db_datos,"c",$dbname,"",""));
unset($db_datos);
unset($db_prefix);

/**
 * Otras base de datos
 */
$dbname = "vrhr_territorio"; // otra base de datos que no es la principal
$db_datos = array();
$db_datos[] = $core->get_alias_campo("departamento","","");
$db_datos[] = $core->get_alias_campo("provincia","","");
$db_datos[] = $core->get_alias_campo("municipio","","");
$db_datos[] = $core->get_alias_campo("comunidad","","");
$db_datos[] = $core->get_alias_campo("localidad","","");
$CFGm->tabla = array_merge($CFGm->tabla,$core->get_tablas_from_array($db_datos,"o",$dbname));
unset($db_datos);
unset($dbname);
unset($db_prefix);


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
