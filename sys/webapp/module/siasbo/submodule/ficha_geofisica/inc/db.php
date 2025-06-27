<?php
/**
 * configuración de conexión a base de datos del sub módulo
 */
$db_conf = array();
/**
 * configuraciòn de Conexion a base de datos de datatable,
 * este arreglo sera usado para las conexiones, para generar los json de la grilla
 */
$db_conf_datatable = array();
/**
 * Conexión a la base de datos del módulo
 */
$db_conf["type"]        = "mysqli";
$db_conf["server"]      = $CFG->dbServer;
$db_conf["user"]        = $CFG->dbUser;
$db_conf["password"]    = $CFG->dbPassword;
$db_conf["database"]    = "mmaya_siasbo";

$db_conf_datatable["principal"] = $db_conf;

$dbm = ADONewConnection($db_conf["type"]);
$dbm->Connect($db_conf["server"],$db_conf["user"] ,$db_conf["password"],$db_conf["database"]) or die("ERROR CONNECT " . $db_conf["database"]);
$dbm->setCharset('utf8');

/**
 * Conexión a otras bases de datos de ejemplo
 */

/*
$db_conf["type"]        = "mysqli";
$db_conf["server"]      = $CFG->dbServer;
$db_conf["user"]        = $CFG->dbUser;
$db_conf["password"]    = $CFG->dbPassword;
$db_conf["database"]    = "codice_codice";

$db_conf_datatable["codice"] = $db_conf;

$dbm_codice = ADONewConnection($db_conf["type"]);
$dbm_codice->Connect($db_conf["server"],$db_conf["user"] ,$db_conf["password"],$db_conf["database"]) or die("ERROR CONNECT " . $db_conf["database"]);
*/

// Conexión a localhost de prueba
/*$db_conf["type"]        = "postgres";
$db_conf["server"]      = "localhost";
$db_conf["user"]        = "postgres";
$db_conf["password"]    = "admin";
$db_conf["database"]    = "bolivia";*/

// Conexión a base de datos de Siasbo (PostgreSql)
// $db_conf["type"]        = "postgres";
// $db_conf["server"]      = "192.168.5.82";
// $db_conf["user"]        = "siasbo";
// $db_conf["password"]    = "?/|)tz";
// $db_conf["database"]    = "sirh_siasbo";
$db_conf["type"]        = "postgres";
$db_conf["server"]      = "localhost";
$db_conf["user"]        = "postgres";
$db_conf["password"]    = "123";
$db_conf["database"]    = "sirh_siasbo";

$db_conf_datatable["principal_postgres"] = $db_conf;

global $dbm_siasbo;

$dbm_siasbo = ADONewConnection($db_conf["type"]);
$dbm_siasbo->Connect($db_conf["server"],$db_conf["user"] ,$db_conf["password"],$db_conf["database"]) or die("ERROR CONNECT " . $db_conf["database"]);
$dbm_siasbo->setCharset('utf8');
