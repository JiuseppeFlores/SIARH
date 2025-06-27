<?PHP
/**
 * Conexión a la base de datos
 */
$dbType         = "mysqli";
// $dbServer       = "192.168.5.176";
// $dbUser         = "erwin.ajhuacho";
// $dbPassword     = "P@ssw0rd!2025";
// user: admin
// 2c32b66f25dad1777884ccde1ded9cf0
$dbServer       = "localhost";
$dbUser         = "jiuseppe";
$dbPassword     = "123";
$dbDatabase     = "vrhr_snir";
$prefix     = ""; //Prefijo de base de datos a ser utilizado, si que tuviera
/* se añade el prefijo si tuviera */
$dbDatabase     = $prefix.$dbDatabase;
/**
 * Dirección donde se encuentra los archivos de sistema
 */
$dataFile = "./../../dataFile/";

