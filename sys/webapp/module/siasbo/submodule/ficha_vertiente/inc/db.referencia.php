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
$db_datos[] = $core->get_alias_campo($db_prefix."captacion_superficial",$db_prefix,"");
$db_datos[] = $core->get_alias_campo($db_prefix."archivo_adjunto",$db_prefix,"");

$CFGm->tabla = array_merge($CFGm->tabla,$core->get_tablas_from_array($db_datos,"",$dbname,"",""));
unset($db_datos);
unset($db_prefix);

//Catalogos
$db_datos = array();
$db_datos[] = $core->get_alias_campo("captacion_usoagua","","");
$db_datos[] = $core->get_alias_campo("captacion_proposito","","");
$db_datos[] = $core->get_alias_campo("cuenca","","");

$CFGm->tabla = array_merge($CFGm->tabla,$core->get_tablas_from_array($db_datos,"c",$dbname,"",""));
unset($db_datos);

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