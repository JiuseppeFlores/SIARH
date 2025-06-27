<?
/**
 * Include de clase general
 */


include_once($pathmodule."classes/class.modulo_core.php");
$modulo_core = new Modulo_Core();
/**
 * Configuraciones del módulo
 */
$module_conf = array();
/**
 * Textos
 */
$module_conf["btn_inicio"]="Inicio Mi Proyecto";
$module_conf["btn_inicio_principal"]="Volver a SIARH";
$module_conf["menu_titulo"]="Mi Proyecto";
$module_conf["dashboard_titulo"]="Mi primer proyecto";

/**
 * colores
 */

$module_conf["menu_bgcolor"]="#01579B";
$module_conf["menu_bgcolor_logo"] = "#03a6c2";
$module_conf["menu_bgcolor_over"]="#02518f";
$module_conf["menu_bgcolor_active"]="#014a83";


$module_conf["menu_link_ico"]="#90b3cf";
$module_conf["menu_link_text"]=$module_conf["menu_link_ico"];
$module_conf["menu_link_arrow"]=$module_conf["menu_link_ico"];

$module_conf["menu_link_ico_over"]="#4FC3F7";
$module_conf["menu_link_text_over"]=$module_conf["menu_link_ico_over"];

$module_conf["menu_link_ico_active"]="#40C4FF";
$module_conf["menu_link_text_active"]=$module_conf["menu_link_ico_active"];
$module_conf["menu_link_arrow_active"]=$module_conf["menu_link_ico_active"];


$module_conf["submenu_link_ico"]="#9fa8da";
$module_conf["submenu_link_text"]=$module_conf["submenu_link_ico"];
$module_conf["submenu_link_arrow"]=$module_conf["submenu_link_ico"];

$module_conf["submenu_link_ico_over"]="#aee5fe";
$module_conf["submenu_link_text_over"]=$module_conf["submenu_link_ico_over"];
$module_conf["submenu_link_arrow_over"]=$module_conf["submenu_link_ico_over"];

$module_conf["submenu_link_ico_over_active"]="#8BC34A";
$module_conf["submenu_link_text_over_active"]=$module_conf["submenu_link_ico_over_active"];
$module_conf["submenu_link_arrow_over_active"]=$module_conf["submenu_link_ico_over_active"];

$smarty->assign("module_conf",$module_conf);

/*    */
//print_struc($menu);
//exit;
/**/