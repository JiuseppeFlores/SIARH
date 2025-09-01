<?php
/**
 * Created by PhpStorm.
 * User: henrytaby
 * Date: 3/5/2018
 * Time: 15:23
 */

require_once ('lib/gpoint/Class.GeoConversao.php');
require_once ('lib/gpoint/gPoint.php');

class Index extends Table {

    function __construct()
    {
        /**
         * Inicializamos todas las librerias y variables para el submodulo
         */
        $this->submodule_init_sbm();
    }

    function get_item($idItem,$tipoTabla,$variante=""){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $info = '';
        if($idItem!=''){
            if($tipoTabla=='item'){
                $sqlSelect = ' i.*
                           , CONCAT_WS(" ",u1.nombre,u1.apellido) as userCreater
                           , CONCAT_WS(" ",u2.nombre,u2.apellido) as userUpdater';
                $sqlFrom = ' '.$this->tabla[$tipoTabla].' i
                         LEFT JOIN '.$this->tabla["o_usuario"].' u1 on u1.itemId=i.userCreate
                         LEFT JOIN '.$this->tabla["o_usuario"].' u2 on u2.itemId=i.userUpdate';
                $sqlWhere = ' i.itemId='.$idItem;
                $sqlGroup = ' GROUP BY i.itemId';
            }else{
                $sqlSelect = ' i.*';
                $sqlFrom = ' '.$this->tabla[$tipoTabla].' i ';
                $sqlWhere = ' i.itemId='.$idItem;
            }

            $sql = 'SELECT '.$sqlSelect.'
                  FROM '.$sqlFrom.'
                  WHERE '.$sqlWhere.'
                  '.$sqlGroup;
                //   var_dump("get_item",$sql);
            $info = $this->dbm->Execute($sql);
            $info = $info->fields;
        }
        return $info;
    }


    public function get_item_datatable_Rows(){
        global $db_conf_datatable;
        /**
         * tabla de la base de datos que listaremos
         */
        $table = $this->tabla["item"];
        /**
         * El nombre del campo que guarda id principal
         */
        $primaryKey = 'itemId';
        /**
         * Que configuraciòn de grilla utilizaremos
         */
        $grilla = "item";
        /**
         * la configuración de base de datos que utilizaremos
         * que se la realiza en inc/db.php
         */
        $db=$db_conf_datatable["principal"];
        /**
         * Configuraciones adicionales
         */
        //$extraWhere = "tipo=4 and userUpdate=".$_SESSION[userv][itemId];

        // if($_SESSION[userv][usuario] != "admin"){
        //     $extraWhere = "tipo=4 and userUpdate=".$_SESSION[userv][itemId];
        // }else{
        //     $extraWhere = "tipo=4";
        // }

        if($_SESSION[userv][usuario] == "admin" || $_SESSION[userv][tipoUsuario] == 1){
            $extraWhere = "tipo=4";
        }else if($_SESSION[userv][tipoUsuario] == 1){
            $extraWhere = "tipo=4 and estado IN ('Registrado', 'Observado', 'Revisado')"; //and userUpdate=".$_SESSION[userv][itemId];
        }else if($_SESSION[userv][tipoUsuario] == 2){
            $extraWhere = "tipo=4 and estado='Registrado'";
        }else if($_SESSION[userv][tipoUsuario] == 3){
            $extraWhere = "tipo=4 and estado IN ('Observado', 'Revisado') and userUpdate=".$_SESSION[userv][itemId];
        }
        
        $groupBy = "";
        $having = "";
        /**
         * Resultado de la consulta enviada
         */
        $resultado = $this->get_grilla_datatable_simple($db,$grilla,$table, $primaryKey, $extraWhere, $groupBy, $having);
        // var_dump('buscando filas::',$resultado);
        /**
         * apartir de aca podemos transformar datos, de acuerdo a requerimiento
         */
        return $resultado;
    }

    /**
     * Borrar un registro de la base de datos
     */
    function item_delete($id){
        $campo_id="itemId";
        $res = $this->item_delete_sbm($id,$campo_id,$this->tabla["item"]);
        return $res;
    }

    //Funciones para la importacion de datos desde Excel //Falta desde aqui
    function verificarConfiguracion($contenedor){
        $nombrehoja = ["GENERAL", "ESPECIFICO", "CAPTACION"];
        $numhojas = count($contenedor);
        for ($i=0; $i<=$numhojas-1; $i++){
            if(!in_array(strtoupper($contenedor[$i]), $nombrehoja)){
                return false;
                exit();
            }
        }

        return true;
    }

    //Obtnemos los id's de todos los catologos necesarios para GENERALES
    function obtenerCatDepartamento(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre, codigo_ine 
                FROM vrhr_territorio.departamento  
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datosdep = [];
        foreach ($datos as $value){
            $datosdep[$value[nombre]] = $value[itemId];
        }

        return $datosdep;
    }

    function obtenerCatDepartamentoIne(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, codigo_ine 
                FROM vrhr_territorio.departamento  
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datosdep = [];
        foreach ($datos as $value){
            $datosdep[$value[itemId]] = $value[codigo_ine];
        }

        return $datosdep;
    }

    function obtenerCatProvincia(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre 
                FROM vrhr_territorio.provincia  
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datospro = [];
        foreach ($datos as $value){
            $datospro[$value[nombre]] = $value[itemId];
        }

        return $datospro;
    }

    function obtenerCatMunicipio(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre 
                FROM vrhr_territorio.municipio   
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datosmun = [];
        foreach ($datos as $value){
            $datosmun[$value[nombre]] = $value[itemId];
        }

        return $datosmun;
    }

    function obtenerCatComunidad(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre 
                FROM vrhr_territorio.comunidad 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datoscom = [];
        foreach ($datos as $key => $value){
            $datoscom[$value[nombre]] = $value[itemId];
        }

        return $datoscom;
    }

    function obtenerCatLocalidad(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre 
                FROM vrhr_territorio.localidad 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datosloc = [];
        foreach ($datos as $value){
            $datosloc[$value[nombre]] = $value[itemId];
        }

        return $datosloc;
    }    

    function obtenerCuenca(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_cuenca   
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datoscue = [];
        foreach ($datos as $value){
            $datoscue[$value[nombre]] = $value[itemId];
        }

        return $datoscue;
    }

    //Obtnemos los id's de todos los catologos necesarios para ESPECIFICOS
    function obtenerUsoAgua(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_captacion_usoagua   
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datosusoagua = [];
        foreach ($datos as $value){
            $datosusoagua[$value[nombre]] = $value[itemId];
        }

        return $datosusoagua;
    }

    function obtenerProposito(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_captacion_proposito   
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datosproposito = [];
        foreach ($datos as $value){
            $datosproposito[$value[nombre]] = $value[itemId];
        }

        return $datosproposito;
    }

    //Funciones globales
    function convertirFecha($dato){
        if ($dato != '') {
            $fecha = date_create_from_format('d/m/Y', $dato);
            return date_format($fecha, 'Y-m-d');
        }else{
            return "0000-00-00";
        }
    }

    function tiempo_segundos($horas, $minutos, $segundos) {
        return ((int) $horas * 3600) + ((int) $minutos * 60) + ((int) $segundos);
    }

    // Convierte Latitud y longitud (Grado-Min.-Seg.) en decimal
    function convertirLatLonDmsToDec($latitudDms, $longitudDms) {
        $conversor = new GeoConversao();
        $latitudDecimal = $conversor->DMS2Dd($latitudDms);
        $longitudDecimal = $conversor->DMS2Dd($longitudDms);
        unset($conversor);
        return array(
            'lat_decimal' => (float) $latitudDecimal,
            'lon_decimal' => (float) $longitudDecimal
        );
    }

    // Convierte latitud y longitud decimal a utm
    function convertirLatLonDecToUtm($latitudDecimal, $longitudDecimal) {
        $punto = new gPoint("WGS 84");
        $punto->setLongLat($longitudDecimal, $latitudDecimal);
        $punto->convertLLtoTM();
        $latitudUtm = $punto->utmEasting;
        $longitudUtm = $punto->utmNorthing;
        $zonaUtm = $punto->utmZone;
        if ($zonaUtm[strlen($zonaUtm) - 1] == 'L') {
            $zonaUtm = rtrim($zonaUtm, 'L');
            $zonaUtm = $zonaUtm.'K';
        }
        unset($punto);
        return array(
            'lat_utm' => (float) round($latitudUtm, 3),
            'lon_utm' => (float) round($longitudUtm, 3),
            'zona_utm' => $zonaUtm
        );
    }

    // Convierte utm a latitud y longitud decimal
    function convertirUtmToDec($latitudUtm, $longitudUtm, $zonaUtm) {
        $punto = new gPoint("WGS 84");
        $punto->setUTM($latitudUtm, $longitudUtm, $zonaUtm);
        $punto->convertTMtoLL();
        $latitudDecimal = $punto->lat;
        $longitudDecimal = $punto->long;
        unset($punto);
        return array(
            'lat_decimal' => (float) $latitudDecimal,
            'lon_decimal' => (float) $longitudDecimal
        );
    }

    // Convierte latitud y longitud decimal a Latitud y longitud (Grado-Min.-Seg.)
    function convertirLatLonDecToDms($latitudDecimal, $longitudDecimal) {
        $conversor = new GeoConversao();
        $latitudDMS = explode('-', $conversor->Dd2DMS($latitudDecimal.'s'));
        $longitudDMS = explode('-', $conversor->Dd2DMS($longitudDecimal.'o'));
        unset($conversor);
        return array(
            'lat_gra' => (int) $latitudDMS[0],
            'lat_min' => (int) trim(str_replace('','\u0000', $latitudDMS[1])),
            'lat_seg' => (float) round($latitudDMS[2], 3),
            'lon_gra' => (int) $longitudDMS[0],
            'lon_min' => (int) trim(str_replace('','\u0000', $longitudDMS[1])),
            'lon_seg' => (float) round($longitudDMS[2], 3)
        );
    }

    // Obtiene los IDs de departamento, provincia y municipio de la BD sirh_siasbo de postgresql
    function get_ubicacion_politica($latitudDecimal, $longitudDecimal){
        global $dbm_siasbo;
        $dbm_siasbo->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT deptoid AS deptoid,
        provid AS provinciaid,
        municipid AS municipioid
        FROM municipios 
        WHERE  
        ST_Contains(geom, ST_GeomFromText(CONCAT('POINT(', ".$longitudDecimal.", ' ', ".$latitudDecimal.", ')'),4326)) 
        LIMIT 1";
        $datos = $dbm_siasbo->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    // Obtiene el ID de macrocuenca de la BD sirh_siasbo de postgresql
    function get_ubicacion_macrocuenca($latitudDecimal, $longitudDecimal){
        global $dbm_siasbo;
        $dbm_siasbo->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT id AS macroid
        FROM macrocuencas 
        WHERE  
        ST_Contains(geom, ST_GeomFromText(CONCAT('POINT(', ".$longitudDecimal.", ' ', ".$latitudDecimal.", ')'),4326)) 
        LIMIT 1";
        $datos = $dbm_siasbo->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    // Obtiene el ID de cuenca estrategica de la BD sirh_siasbo de postgresql
    function get_ubicacion_cuenca_estrategica($latitudDecimal, $longitudDecimal){
        global $dbm_siasbo;
        $dbm_siasbo->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT id AS cuencaestraid
        FROM cuenca_estra_25 
        WHERE  
        ST_Contains(geom, ST_GeomFromText(CONCAT('POINT(', ".$longitudDecimal.", ' ', ".$latitudDecimal.", ')'),4326)) 
        LIMIT 1";
        $datos = $dbm_siasbo->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    // Obtiene código INE departamento
    function get_codigo_ine_departamento($deptoId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT
        itemId,
        codigo_ine 
        FROM ".$this->tabla["o_departamento"]." 
        WHERE itemId=".$deptoId." 
        LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    //Agregar datos de las hojas Excel a la BD
    function agregarGeneral($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $id = [];
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans(); 
        $sql = $this->dbm->Prepare("INSERT INTO item (tipo, codigo, nombre, latitud, latitudDec, 
                                                      longitud, longitudDec, latitudUtm, longitudUtm, 
                                                      utmZona, altitud, departamentoId, provinciaId, municipioId, 
                                                      comunidadId, localidadId, comunidad, localidad, descripcion,
                                                      cuencaId, estado, dateCreate, dateUpdate, userCreate, userUpdate) 
                                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        foreach($datos as $key => $value){
            if(!$this->dbm->Execute($sql, $value)){
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              $_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }
            $id[] = $this->dbm->Insert_ID();
            $_SESSION['codigos'][$value[25]]= $this->dbm->Insert_ID();
            $cont++;
        }

        $indices = implode(',', $id);
        $sqlupdate = "UPDATE item SET codigo=CONCAT(codigo,'-',itemId) WHERE itemId IN ($indices)"; //Revisar este dato IN(1, 2, 3, 4, 5)
        if ($this->dbm->Execute($sqlupdate)) {
            $this->dbm->CommitTrans();
            $this->dbm->autoCommit = true;
            return array("res"=>true, "filasafectadas"=>$cont);
        }else{
            $this->dbm->RollbackTrans();
            return array("res"=>false, "filasafectadas"=>$cont);
        }
        
        
        //return $_SESSION['codigos'];
    }

    function agregarEspecifico($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $conti = 0;
        $contu = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();
        if ($_SESSION['banderaSql'] == 1) {
            $cadena1 = "INSERT INTO item_captacion_superficial (itemId, fuente, codigo, usoaguaId, 
                                                                propositoId, propietario, observaciones, 
                                                                dateCreate, dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            $sql = $this->dbm->Prepare($cadena1);
            foreach($datos as $key => $value){
                if(!$this->dbm->Execute($sql, $value)){
                  $err = $this->dbm->ErrorMsg();
                  $this->dbm->RollbackTrans();
                  //$_SESSION['codigos'] = NULL;
                  trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
                }
                $_SESSION['controltransaccion'][$value[0]] = $value[0];
                $conti++;
            }

            $this->dbm->CommitTrans();
            $this->dbm->autoCommit = true;
            $_SESSION['banderaSql'] = 2;
            return array("res"=>true, "filasafectadas"=>$conti);
        }else{
            $cadena1 = "INSERT INTO item_captacion_superficial (itemId, fuente, codigo, usoaguaId, 
                                                                propositoId, propietario, observaciones, 
                                                                dateCreate, dateUpdate, userCreate, userUpdate)) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            $sql = $this->dbm->Prepare($cadena1);
            foreach($datos as $key => $value){
                if ($_SESSION['controltransaccion'][$value[0]] != $value[0]) {
                    if(!$this->dbm->Execute($sql, $value)){
                      $err = $this->dbm->ErrorMsg();
                      $this->dbm->RollbackTrans();
                      //$_SESSION['codigos'] = NULL;
                      trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
                    }
                    $_SESSION['controltransaccion'][$value[0]] = $value[0];
                    $conti++;
                }                
            }


            $cadena1 = "UPDATE item_captacion_superficial SET itemId=?, fuente=?, codigo=?, usoaguaId=?, propositoId=?, propietario=?, observaciones=?";

            $sql = $this->dbm->Prepare($cadena1);
            foreach($datos as $key => $value){
                if ($_SESSION['controltransaccion'][$value[0]] == $value[0]) {
                    if(!$this->dbm->Execute($sql, $value)){
                      $err = $this->dbm->ErrorMsg();
                      $this->dbm->RollbackTrans();
                      //$_SESSION['codigos'] = NULL;
                      trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
                    }
                    $contu++;
                }                
            }

            $this->dbm->CommitTrans();
            $this->dbm->autoCommit = true;
            $_SESSION['banderaSql'] = 2;
            return array("res"=>true, "filasafectadas"=>$contu);
        }    

    }

    function agregarCaptacion($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $conti = 0;
        $contu = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();
        if ($_SESSION['banderaSql']==1) {
            $cadena2 = "INSERT INTO item_captacion_superficial (fechainicio, conexionesagua, coberturaagua, 
                                                                numero, caudal, almacenamiento, 
                                                                capacidad, aduccion, red, area, captaobservacion, itemId,
                                                                dateCreate, dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"; //STR_TO_DATE(?, '%d/%m/%Y')   //STR_TO_DATE(?, '%d/%m/%Y')

            $sql = $this->dbm->Prepare($cadena2);
            foreach($datos as $key => $value){
                if(!$this->dbm->Execute($sql, $value)) {
                  $err = $this->dbm->ErrorMsg();
                  $this->dbm->RollbackTrans();
                  //$_SESSION['codigos'] = NULL;
                  trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
                }
                $_SESSION['controltransaccion'][$value[0]] = $value[0];
                $conti++;
            }

            $this->dbm->CommitTrans();
            $this->dbm->autoCommit = true;
            $_SESSION['banderaSql'] = 2;
            return array("res"=>true, "filasafectadas"=>$conti);
        }else{
            $cadena2 = "INSERT INTO item_captacion_superficial (fechainicio, conexionesagua, coberturaagua, 
                                                                numero, caudal, almacenamiento, 
                                                                capacidad, aduccion, red, area, captaobservacion, itemId, 
                                                                dateCreate, dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"; //STR_TO_DATE(?, '%d/%m/%Y')   //STR_TO_DATE(?, '%d/%m/%Y')

            $sql = $this->dbm->Prepare($cadena2);
            foreach($datos as $key => $value){
                if ($_SESSION['controltransaccion'][$value[0]] != $value[0]) {
                    if(!$this->dbm->Execute($sql, $value)) {
                      $err = $this->dbm->ErrorMsg();
                      $this->dbm->RollbackTrans();
                      //$_SESSION['codigos'] = NULL;
                      trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
                    }
                    $_SESSION['controltransaccion'][$value[0]] = $value[0];
                    $conti++;
                }                
            }


            $cadena2 = "UPDATE item_captacion_superficial SET fechainicio=?, conexionesagua=?, coberturaagua=?, 
                                                              numero=?, caudal=?, almacenamiento=?, 
                                                              capacidad=?, aduccion=?, red=?, area=?, captaobservacion=?         
                    WHERE itemId=?";

            $sql = $this->dbm->Prepare($cadena2);
            foreach($datos as $key => $value){
                if ($_SESSION['controltransaccion'][$value[0]] == $value[0]) {
                    if(!$this->dbm->Execute($sql, $value)) {
                      $err = $this->dbm->ErrorMsg();
                      $this->dbm->RollbackTrans();
                      //$_SESSION['codigos'] = NULL;
                      trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
                    }
                    $contu++;
                }                
            }

            $this->dbm->CommitTrans();
            $this->dbm->autoCommit = true;
            $_SESSION['banderaSql'] = 2;
            return array("res"=>true, "filasafectadas"=>$contu);
        }        
    }

    //Permisos de usuario
    function get_permisos($usuario, $itemIdSubmoduloPozo){ //$tiposubmodulos
        $tipoUsuario = $_SESSION["userv"]["tipoUsuario"];

        //if ($usuario === 'admin') {
        if ($tipoUsuario == "0" || $tipoUsuario == "1"){
            return array(array(
                    'crear' => 1,
                    'editar' => 1,
                    'eliminar' => 1,
                    'usuarioId' => 0,
                    'tipoUsuario' => intval($tipoUsuario),
                    'itemId' => $itemIdSubmoduloPozo,
                    'nombre' => '4.- Captación superficial'
                    ) 
                );
        } else {
            $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
            $sql = "SELECT b.crear, b.editar, b.eliminar, c.itemId, c.nombre, a.tipoUsuario, b.usuarioId
            FROM vrhr_snir.core_usuario as a inner join vrhr_snir.core_usuario_permisos as b on a.itemId = b.usuarioId 
            inner join vrhr_snir.core_submodulo as c on b.subModuloId = c.itemId 
            WHERE a.usuario='".$usuario."' and c.itemId=$itemIdSubmoduloPozo";//.$itemIdSubmoduloPozo;
            $datos = $this->dbm->Execute($sql);
            $datos = $datos->GetRows();
            return $datos;
        }

        // $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        // $sql = "SELECT b.crear, b.editar, b.eliminar, c.itemId, c.nombre 
        // FROM vrhr_snir.core_usuario as a inner join vrhr_snir.core_usuario_permisos as b on a.itemId = b.usuarioId 
        // inner join vrhr_snir.core_submodulo as c on b.subModuloId = c.itemId 
        // WHERE a.usuario='".$usuario."' and c.nombre='".$tiposubmodulo."'";
        // $datos = $this->dbm->Execute($sql);
        // $datos = $datos->GetRows();
        // return $datos;
    }

    function get_datos_fuente($Id){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $sql = "SELECT a.nombre, b.itemId, b.fecha, b.hora, b.fecha, b.hora, e.nombre AS tipoagua FROM item a, item_fuente_tipo_agua b, catalogo_fuente_tipo_agua e WHERE a.itemId=b.pozoId AND b.tipoId=e.itemId AND b.pozoId = $Id ORDER BY b.fecha ASC, b.hora ASC";
        echo $sql;
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        var_dump($datos);
        return $datos;
    }
}