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

    function get_item($idItem,$tipoTabla,$variante="") {
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
            $info = $this->dbm->Execute($sql);
            $info = $info->fields;
        }
        return $info;
    }

    public function get_item_datatable_Rows() {
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
        //$extraWhere = "tipo=3 and userUpdate=".$_SESSION[userv][itemId];

        // if($_SESSION[userv][usuario] != "admin"){
        //     $extraWhere = "tipo=3 and userUpdate=".$_SESSION[userv][itemId];
        // }else{
        //     $extraWhere = "tipo=3";
        // }

        if($_SESSION[userv][usuario] == "admin" || $_SESSION[userv][tipoUsuario] == 1){
            $extraWhere = "tipo=3";
        }else if($_SESSION[userv][tipoUsuario] == 1){
            $extraWhere = "tipo=3 and estado IN ('Registrado', 'Observado', 'Revisado')"; //and userUpdate=".$_SESSION[userv][itemId];
        }else if($_SESSION[userv][tipoUsuario] == 2){
            $extraWhere = "tipo=3 and estado='Registrado'";
        }else if($_SESSION[userv][tipoUsuario] == 3){
            $extraWhere = "tipo=3 and estado IN ('Observado', 'Revisado') and userUpdate=".$_SESSION[userv][itemId];
        }
        
        $groupBy = "";
        $having = "";
        /**
         * Resultado de la consulta enviada
         */
        $resultado = $this->get_grilla_datatable_simple($db,$grilla,$table, $primaryKey, $extraWhere, $groupBy, $having);
        /**
         * apartir de aca podemos transformar datos, de acuerdo a requerimiento
         */
        return $resultado;
    }

    /**
     * Borrar un registro de la base de datos
     */
    function item_delete($id) {
        $campo_id="itemId";
        $res = $this->item_delete_sbm($id,$campo_id,$this->tabla["item"]);
        return $res;
    }

    //Funciones para la importacion de datos desde Excel
    function verificarConfiguracion($contenedor){
        $nombrehoja = ["GENERAL", "ESPECIFICO", "MONITOREO_CANTIDAD",
                       "MONITOREO_CALIDAD", "MC_CAMPO", "MC_BASICOS", "MC_INORGANICOS", "MC_ORGANICOS", "MC_MICROORGANISMOS", 
                       "MC_PLAGUICIDAS", "MONITOREO_ISOTOPICO", "MI_RADIOACTIVIDAD", "MI_ISOTOPOS", "MI_OTROS", "MC_DATOS_COMPUESTO"];
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
    function obtenerTipoManantial(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_manantial_tipo   
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datostipman = [];
        foreach ($datos as $value){
            $datostipman[$value[nombre]] = $value[itemId];
        }

        return $datostipman;
    }

    function obtenerUsoAgua(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_pozo_usoagua   
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datosusoagua = [];
        foreach ($datos as $value){
            $datosusoagua[$value[nombre]] = $value[itemId];
        }

        return $datosusoagua;
    }

    function obtenerMedioSurgencia(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_manantial_medio   
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datosmedio = [];
        foreach ($datos as $value){
            $datosmedio[$value[nombre]] = $value[itemId];
        }

        return $datosmedio;
    }

    function obtenerPermanencia(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_manantial_permanencia   
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datospermannecia = [];
        foreach ($datos as $value){
            $datospermannecia[$value[nombre]] = $value[itemId];
        }

        return $datospermannecia;
    }

    //Obtnemos los id's de todos los catologos necesarios para MONITOREO CALIDAD
    function obtenerTipoEpoca(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_epoca        
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datoscantipepo = [];
        foreach ($datos as $value){
            $datoscantipepo[$value[nombre]] = $value[itemId];
        }

        return $datoscantipepo;
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
            if(!$this->dbm->Execute($sql, $value)) {
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
        if($this->dbm->Execute($sqlupdate)){
            $this->dbm->CommitTrans();
            $this->dbm->autoCommit = true;
            return array("res"=>true, "filasafectadas"=>$cont);
        }else{
            $this->dbm->RollbackTrans();
            return array("res"=>false, "filasafectadas"=>$cont);
        }
    }

    function agregarEspecifico($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();
        $cadena = "INSERT INTO manantial (itemId, fuente, codigo, tipoId, cantidad, usoaguaId, 
                                           propiedad_agua, propiedad_terreno, administrador, medioId, 
                                           permanenciaId, observaciones, edad, litologia, estructura, 
                                           dateCreate, dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $sql = $this->dbm->Prepare($cadena);
        foreach($datos as $key => $value){
            if(!$this->dbm->Execute($sql, $value)){
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              //$_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }

            $cont++;
        }

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        
        return array("res"=>true, "filasafectadas"=>$cont);

    }

    function agregarMonitoreoCantidad($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();

        $cadena8 = "INSERT INTO manantial_monitoreo (manantialId, fecha, caudal, observaciones, 
                                                   dateCreate, dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        $sql = $this->dbm->Prepare($cadena8);
        foreach($datos as $key => $value){
            if(!$this->dbm->Execute($sql, $value)) {
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              //$_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }
            $cont++;
        }        

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        return array("res"=>true, "filasafectadas"=>$cont);
    }

    function agregarMonitoreoCalidad($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();

        $cadena9 = "INSERT INTO manantial_monitor_calidad (manantialId, fecha_muestreo, hora_muestreo, 
                                                           epocaId, entidad, codigo_muestra, fecha_analisis, 
                                                           hora_analisis, nombre_laboratorio, codigo_laboratorio, profundidad, 
                                                           observaciones, dateCreate, dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $sql = $this->dbm->Prepare($cadena9);
        foreach($datos as $key => $value){
            if(!$this->dbm->Execute($sql, $value)) {
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              //$_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }
            $_SESSION['codigomoncal'][$value[16]] = $this->dbm->Insert_ID();
            $cont++;
        }        

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        return array("res"=>true, "filasafectadas"=>$cont);
    }

    function agregarMonCalCampo($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();

        $cadena10 = "INSERT INTO manantial_monitor_calidad_dato (calidadId, parametroId, compuestoId, 
                                                                 valor, observaciones, dateCreate, 
                                                                 dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $sql = $this->dbm->Prepare($cadena10);
        foreach($datos as $key => $value){
            if(!$this->dbm->Execute($sql, $value)) {
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              //$_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }
            
            $cont++;
        }        

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        return array("res"=>true, "filasafectadas"=>$cont);
    }

    function obtenerIdCampo($columna){
        switch ($columna) {
            case 1:
                return 1;
                break;

            case 2:
                return 2;
                break;

            case 3:
                return 3;
                break;

            case 4:
                return 4;
                break;

            case 5:
                return 5;
                break;

            case 6:
                return 6;
                break;

            case 7:
                return 7;
                break;

            case 8:
                return 8;
                break;

            case 9:
                return 9;
                break;

            case 10:
                return 10;
                break;

            case 11:
                return 11;
                break;

            case 12:
                return 12;
                break;
            
            default:
                break;
        }
    }

    function obtenerIdBasicos($columna){
        switch ($columna) {
            case 1:
                return 13;
                break;

            case 2:
                return 14;
                break;

            case 3:
                return 15;
                break;

            case 4:
                return 16;
                break;

            case 5:
                return 17;
                break;

            case 6:
                return 18;
                break;

            case 7:
                return 19;
                break;

            case 8:
                return 20;
                break;

            case 9:
                return 21;
                break;

            case 10:
                return 22;
                break;

            case 11:
                return 23;
                break;

            case 12:
                return 24;
                break;

            case 13:
                return 25;
                break;

            case 14:
                return 26;
                break;

            case 15:
                return 27;
                break;

            case 16:
                return 28;
                break;

            case 17:
                return 29;
                break;

            case 18:
                return 30;
                break;

            case 19:
                return 31;
                break;

            case 20:
                return 32;
                break;

            case 21:
                return 33;
                break;

            case 22:
                return 34;
                break;

            default:
                break;
        }
    }

    function obtenerIdInorganicos($columna){
        switch ($columna) {
            case 1:
                return 35;
                break;

            case 2:
                return 36;
                break;

            case 3:
                return 37;
                break;

            case 4:
                return 38;
                break;

            case 5:
                return 39;
                break;

            case 6:
                return 40;
                break;

            case 7:
                return 41;
                break;

            case 8:
                return 42;
                break;

            case 9:
                return 43;
                break;

            case 10:
                return 44;
                break;

            case 11:
                return 45;
                break;

            case 12:
                return 46;
                break;

            case 13:
                return 47;
                break;

            case 14:
                return 48;
                break;

            case 15:
                return 49;
                break;

            case 16:
                return 50;
                break;

            case 17:
                return 51;
                break;

            case 18:
                return 52;
                break;

            case 19:
                return 53;
                break;

            case 20:
                return 54;
                break;

            case 21:
                return 55;
                break;

            case 22:
                return 56;
                break;

            case 23:
                return 57;
                break;

            case 24:
                return 58;
                break;

            case 25:
                return 59;
                break;

            case 26:
                return 60;
                break;

            case 27:
                return 61;
                break;

            case 28:
                return 62;
                break;

            case 29:
                return 63;
                break;

            case 30:
                return 64;
                break;

            case 31:
                return 65;
                break;

            case 32:
                return 66;
                break;

            case 33:
                return 67;
                break;

            case 34:
                return 68;
                break;

            case 35:
                return 69;
                break;

            case 36:
                return 70;
                break;

            case 37:
                return 71;
                break;

            case 38:
                return 72;
                break;

            case 39:
                return 73;
                break;

            case 40:
                return 74;
                break;

            case 41:
                return 75;
                break;

            case 42:
                return 76;
                break;

            case 43:
                return 77;
                break;

            case 44:
                return 78;
                break;

            case 45:
                return 79;
                break;

            case 46:
                return 80;
                break;

            case 47:
                return 81;
                break;

            case 48:
                return 82;
                break;

            case 49:
                return 83;
                break;

            case 50:
                return 84;
                break;

            case 51:
                return 85;
                break;

            case 52:
                return 86;
                break;

            case 53:
                return 87;
                break;

            case 54:
                return 88;
                break;

            case 55:
                return 89;
                break;

            case 56:
                return 90;
                break;

            case 57:
                return 91;
                break;

            case 58:
                return 92;
                break;

            case 59:
                return 93;
                break;

            case 60:
                return 94;
                break;

            case 61:
                return 95;
                break;

            case 62:
                return 96;
                break;

            case 63:
                return 97;
                break;

            case 64:
                return 98;
                break;

            case 65:
                return 99;
                break;

            case 66:
                return 100;
                break;
                            
            default:
                break;
        }
    }

    function obtenerIdOrganicos($columna){
        switch ($columna) {
            case 1:
                return 101;
                break;

            case 2:
                return 102;
                break;

            case 3:
                return 103;
                break;

            case 4:
                return 104;
                break;

            case 5:
                return 105;
                break;

            case 6:
                return 106;
                break;

            case 7:
                return 107;
                break;

            case 8:
                return 108;
                break;

            case 9:
                return 109;
                break;

            case 10:
                return 110;
                break;

            case 11:
                return 111;
                break;

            case 12:
                return 112;
                break;

            case 13:
                return 113;
                break;

            case 14:
                return 114;
                break;

            case 15:
                return 115;
                break;

            case 16:
                return 116;
                break;

            case 17:
                return 117;
                break;

            case 18:
                return 118;
                break;

            case 19:
                return 119;
                break;

            case 20:
                return 120;
                break;

            case 21:
                return 121;
                break;

            case 22:
                return 122;
                break;

            case 23:
                return 123;
                break;

            case 24:
                return 124;
                break;

            case 25:
                return 125;
                break;

            case 26:
                return 126;
                break;

            case 27:
                return 127;
                break;

            case 28:
                return 128;
                break;

            case 29:
                return 129;
                break;

            case 30:
                return 130;
                break;

            case 31:
                return 131;
                break;

            default:
                break;
        }
    }

    function obtenerIdMicroorganismos($columna){
        switch ($columna) {
            case 1:
                return 132;
                break;

            case 2:
                return 133;
                break;

            case 3:
                return 134;
                break;

            case 4:
                return 135;
                break;

            case 5:
                return 136;
                break;

            case 6:
                return 137;
                break;

            case 7:
                return 138;
                break;

            case 8:
                return 139;
                break;

            case 9:
                return 140;
                break;

            case 10:
                return 141;
                break;

            case 11:
                return 142;
                break;

            case 12:
                return 143;
                break;

            case 13:
                return 144;
                break;            

            default:
                break;
        }
    }

    function obtenerIdPlaguicidas($columna){
        switch ($columna) {
            case 1:
                return 145;
                break;

            case 2:
                return 146;
                break;

            case 3:
                return 147;
                break;

            case 4:
                return 148;
                break;

            case 5:
                return 149;
                break;

            case 6:
                return 150;
                break;

            case 7:
                return 151;
                break;

            case 8:
                return 152;
                break;

            case 9:
                return 153;
                break;

            case 10:
                return 154;
                break;

            case 11:
                return 155;
                break;

            case 12:
                return 156;
                break;

            case 13:
                return 157;
                break;

            case 14:
                return 158;
                break;

            case 15:
                return 159;
                break;

            case 16:
                return 160;
                break;

            case 17:
                return 161;
                break;

            case 18:
                return 162;
                break;

            case 19:
                return 163;
                break;

            case 20:
                return 164;
                break;

            case 21:
                return 165;
                break;

            case 22:
                return 166;
                break;

            case 23:
                return 167;
                break;

            case 24:
                return 168;
                break;

            case 25:
                return 169;
                break;

            case 26:
                return 170;
                break;

            case 27:
                return 171;
                break;

            case 28:
                return 172;
                break;

            case 29:
                return 173;
                break;

            case 30:
                return 174;
                break;

            case 31:
                return 175;
                break;

            case 32:
                return 176;
                break;

            case 33:
                return 177;
                break;

            case 34:
                return 178;
                break;

            case 35:
                return 179;
                break;

            case 36:
                return 180;
                break;

            case 37:
                return 181;
                break;

            case 38:
                return 182;
                break;

            case 39:
                return 183;
                break;

            case 40:
                return 184;
                break;

            case 41:
                return 185;
                break;

            case 42:
                return 186;
                break;

            case 43:
                return 187;
                break;

            case 44:
                return 188;
                break;

            case 45:
                return 189;
                break;

            case 46:
                return 190;
                break;

            case 47:
                return 191;
                break;

            case 48:
                return 192;
                break;

            case 49:
                return 193;
                break;

            case 50:
                return 194;
                break;

            case 51:
                return 195;
                break;

            case 52:
                return 196;
                break;

            case 53:
                return 197;
                break;

            case 54:
                return 198;
                break;

            case 55:
                return 199;
                break;

            case 56:
                return 200;
                break;

            case 57:
                return 201;
                break;            

            default:
                break;
        }
    }

    function agregarMonitoreoIsotopico($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();

        $cadena9 = "INSERT INTO manantial_monitor_isotopico (manantialId, fecha_muestreo, hora_muestreo, 
                                                             epocaId, entidad, codigo_muestra, fecha_analisis, 
                                                             hora_analisis, nombre_laboratorio, codigo_laboratorio, profundidad, 
                                                             observaciones, dateCreate, dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $sql = $this->dbm->Prepare($cadena9);
        foreach($datos as $key => $value){
            if(!$this->dbm->Execute($sql, $value)) {
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              //$_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }
            $_SESSION['codigomoniso'][$value[16]] = $this->dbm->Insert_ID();
            $cont++;
        }        

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        return array("res"=>true, "filasafectadas"=>$cont);
    }

    function agregarMonIsoCampo($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();

        $cadena10 = "INSERT INTO manantial_monitor_isotopico_dato (isotopicoId, isotoparametroId, isotocompuestoId, 
                                                                   valor, observaciones, dateCreate, 
                                                                   dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $sql = $this->dbm->Prepare($cadena10);
        foreach($datos as $key => $value){
            if(!$this->dbm->Execute($sql, $value)) {
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              //$_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }
            
            $cont++;
        }        

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        return array("res"=>true, "filasafectadas"=>$cont);
    }

    //Permisos de usuario
    function get_permisos($usuario, $itemIdSubmoduloPozo){ //$tiposubmodulo
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
                    'nombre' => '2.- Manantiales'
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
}