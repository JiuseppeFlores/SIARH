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
        //$extraWhere = "tipo=1 and userUpdate=".$_SESSION[userv][itemId];

        if($_SESSION[userv][usuario] == "admin" || $_SESSION[userv][tipoUsuario] == 1){
            $extraWhere = "tipo=5";
        }else if($_SESSION[userv][tipoUsuario] == 1){
            $extraWhere = "tipo=5 and estado IN ('Registrado', 'Observado', 'Revisado')"; //and userUpdate=".$_SESSION[userv][itemId];
        }else if($_SESSION[userv][tipoUsuario] == 2){
            $extraWhere = "tipo=5 and estado='Registrado'";
        }else if($_SESSION[userv][tipoUsuario] == 3){
            $extraWhere = "tipo=5 and estado IN ('Observado', 'Revisado') and userUpdate=".$_SESSION[userv][itemId];
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
        // var_dump($resultado);
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

    //Funciones para la importacion de datos desde Excel
    function verificarConfiguracion($contenedor){
        $nombrehoja = ["GENERAL", "ESPECIFICO", "PERFORACION", "PERFORACION_EXCAVADO", "CONSTRUCTIVOS", "CONSTRUCTIVOS_REJILLA_FILTRO",
                       "COLUMNA_LITOLOGICA", "PERFILAJE_ELECTRICO", "IMPLEMENTACION", "MONITOREO_CANTIDAD",
                       "MONITOREO_CALIDAD", "MC_CAMPO", "MC_BASICOS", "MC_INORGANICOS", "MC_ORGANICOS", "MC_MICROORGANISMOS", 
                       "MC_PLAGUICIDAS", "MONITOREO_ISOTOPICO", "MI_RADIOACTIVIDAD", "MI_ISOTOPOS", "MI_OTROS", 
                       "HIDRAULICOS", "HPB_ESCALONADO", "ESCALONADO_ESCALON", "ESCALONADO_RECUPERACION", "ESCALONADO_RECUPERACION_ESCALON", 
                       "ESC_REC_OBSERVACION", "ESC_REC_OBSERVACION_ESCALON", "ESCALONADO_OBSERVACION", "ESCALONADO_OBSERVACION_ESCALON", 
                       "HPB_CONTINUO", "CONTINUO_ESCALON", "CONTINUO_RECUPERACION", "CONTINUO_RECUPERACION_ESCALON", 
                       "CON_REC_OBSERVACION", "CON_REC_OBSERVACION_ESCALON", "CONTINUO_OBSERVACION", "CONTINUO_OBSERVACION_ESCALON",
                       "MC_DATOS_COMPUESTO"];
        $numhojas = count($contenedor);
        for ($i=0; $i<=$numhojas-1; $i++){
            if(!in_array(strtoupper($contenedor[$i]), $nombrehoja)){
                return false;
                exit();
            }
        }

        return true;
    }

    // function ultimoId(){
    //     $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
    //     $ultimoid = $this->dbm->Execute("SELECT max(id) AS codigo FROM prueba");
    //     return $ultimoid;
    // }

    function formatearTexto($contenedor, $DatoIn){
        foreach($contenedor as $key => $value){
            if(strtoupper($DatoIn) == $key){
                return strtoupper($DatoIn);
            }else if(ucwords($DatoIn) == $key){
                return ucwords($DatoIn);
            }else{
                $DatosIn = explode(" ", $DatoIn);
                if(strtoupper($DatosIn[0])." ".ucwords($DatosIn[1]) == $key){
                    return strtoupper(trim($DatosIn[0]))." ".ucwords(trim($DatosIn[1]));
                }
            }
        }
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

    function obtenerAcuifero(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_acuifero   
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datosacu = [];
        foreach ($datos as $value){
            $datosacu[$value[nombre]] = $value[itemId];
        }

        return $datosacu;
    }

    function obtenerEpsas(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_pozo_general_epsas    
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datoseps = [];
        foreach ($datos as $value){
            $datoseps[$value[nombre]] = $value[itemId];
        }

        return $datoseps;
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

    // function obtenerCodigo(){
    //     $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
    //     $sql = "SELECT codigo    
    //             FROM item  
    //             ORDER BY itemId ASC";

    //     $datos = $this->dbm->Execute($sql);

    //     $datoscod = [];
    //     foreach ($datos as $value){
    //         $datoscod[] = $value[codigo];
    //     }

    //     return $datoscod;
    // }

    //Obtnemos los id's de todos los catologos necesarios para ESPECIFICOS
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

    function obtenerPropositoPozo(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_pozo_proposito    
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datospropoz = [];
        foreach ($datos as $value){
            $datospropoz[$value[nombre]] = $value[itemId];
        }

        return $datospropoz;
    }

    //Obtnemos los id's de todos los catologos necesarios para PERFORACION y PERFORACION_EXCAVADO
    function obtenerPerTipoPozo(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_pozo_perforacion    
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datospertippoz = [];
        foreach ($datos as $value){
            $datospertippoz[$value[nombre]] = $value[itemId];
        }

        return $datospertippoz;
    }

    function obtenerPerTipoPerforacion(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_pozo_perforacion_tipo    
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datospertipper = [];
        foreach ($datos as $value){
            $datospertipper[$value[nombre]] = $value[itemId];
        }

        return $datospertipper;
    }

    function obtenerPerMetodoPerforacion(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_pozo_perforacion_metodo     
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datospermetper = [];
        foreach ($datos as $value){
            $datospermetper[$value[nombre]] = $value[itemId];
        }

        return $datospermetper;
    }

    function obtenerPerTipoRevestimiento(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_pozo_perforacion_revestimiento     
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datospertiprev = [];
        foreach ($datos as $value){
            $datospertiprev[$value[nombre]] = $value[itemId];
        }

        return $datospertiprev;
    }

    function obtenerPerTipoExcavacion(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_pozo_perforacion_excavacion      
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datospertipexc = [];
        foreach ($datos as $value){
            $datospertipexc[$value[nombre]] = $value[itemId];
        }

        return $datospertipexc;
    }

    //Obtnemos los id's de todos los catologos necesarios para CONSTRUCTIVOS
    function obtenerConTipoTuberia(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_pozo_constructivo_tuberia     
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datoscontiptub = [];
        foreach ($datos as $value){
            $datoscontiptub[$value[nombre]] = $value[itemId];
        }

        return $datoscontiptub;
    }

    function obtenerConTipoSello(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_pozo_constructivo_sello      
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datoscontipsel = [];
        foreach ($datos as $value){
            $datoscontipsel[$value[nombre]] = $value[itemId];
        }

        return $datoscontipsel;
    }

    //Obtnemos los id's de todos los catologos necesarios para CONSTRUCTIVOS REJILLA FILTRO
    function obtenerTipoRejillaFiltro(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_pozo_constructivo_rejillafiltro       
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datoscontiprejfil = [];
        foreach ($datos as $value){
            $datoscontiprejfil[$value[nombre]] = $value[itemId];
        }

        return $datoscontiprejfil;
    }

    //Obtnemos los id's de todos los catologos necesarios para COLUMNA LITOLOGICA
    function obtenerTipoPermeabilidad(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_pozo_litologico_permeabilidad        
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datoscoltipper = [];
        foreach ($datos as $value){
            $datoscoltipper[$value[nombre]] = $value[itemId];
        }

        return $datoscoltipper;
    }

    //Obtnemos los id's de todos los catologos necesarios para PERFILAJE ELECTRICO
    function obtenerTipoParametro(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_pozo_electrico_parametro        
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datospertippar = [];
        foreach ($datos as $value){
            $datospertippar[$value[nombre]] = $value[itemId];
        }

        return $datospertippar;
    }

    //Obtnemos los id's de todos los catologos necesarios para IMPLEMENTACION
    function obtenerTipoEnergia(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_pozo_implementacion_tipo        
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datosimptipene = [];
        foreach ($datos as $value){
            $datosimptipene[$value[nombre]] = $value[itemId];
        }

        return $datosimptipene;
    }

    //Obtnemos los id's de todos los catologos necesarios para MONITOREO CANTIDAD
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

    //Obtnemos los id's de todos los catologos necesarios para HIDRAULICOS
    function obtenerTipoPrueba(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_pozo_hidra_tipo_prueba        
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datoshidra = [];
        foreach ($datos as $value){
            $datoshidra[$value[nombre]] = $value[itemId];
        }

        return $datoshidra;
    }

    function obtenerTipoBombeo(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_pozo_hidra_tipo_bombeo        
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $datostipbom = [];
        foreach ($datos as $value){
            $datostipbom[$value[nombre]] = $value[itemId];
        }

        return $datostipbom;
    }

    //Funciones globales
    function convertirFecha($dato){
        //   -----   INICIO CODIGO ORIGINAL    -------
        // if ($dato != '') {
        //     $fecha = date_create_from_format('d/m/Y', $dato);
        //     return date_format($fecha, 'Y-m-d');
        // }else{
        //     return "0000-00-00";
        // }
        //   -----   FIN DE CODIGO ORIGINAL    -------
        //print_struc($dato); // el formato de la fecha es Mes/Dia/Anio
        
        if (strlen($dato)==8){
            $mes = substr($dato, 0,2);
            $dia = substr($dato, 3,2);
            $anio = substr($dato,  6,2);
            if (((int)$anio ) <= date("y")) {
                $anio = "20".$anio;
            }
            else{
                $anio = "19".$anio;
            }
            // print_struc("la Fecha es :".$anio."-".$mes."-".$dia); //exit;
            $fecha = $anio."-".$mes."-".$dia;
            return $fecha;
        }
        elseif (strlen($dato)==10) {
            $dia = substr($dato, 0,2);
            $mes = substr($dato, 3,2);
            $anio = substr($dato,  6,4);
            //print_struc("la Fecha es :".$anio."-".$mes."-".$dia); exit;
            $fecha = $anio."-".$mes."-".$dia;
            return $fecha;
        }
        else{
            if ($dato != '') {
                $fecha = date_create_from_format('d/m/Y', $dato);    // La funcion en algunos casos genera una cadena vacia
                if (trim($fecha) == "") {
                    return "0000-00-00";
                } 
                else{
                    return date_format($fecha, 'Y-m-d');
                }
            }else{
                return "0000-00-00";
            }
        }
        
    }

    //Agregar datos de las hojas Excel a la BD
    function agregarGeneral($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $id = [];
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans(); 

        //  ------    ORGINALMENTE LA DATA SE PREPARABA DE ESTA MANERA    -------
        // $sql = $this->dbm->Prepare("INSERT INTO item (tipo, codigo, nombre, latitud, latitudDec, 
        //                                               longitud, longitudDec, latitudUtm, longitudUtm, 
        //                                               utmZona, altitud, departamentoId, provinciaId, municipioId, 
        //                                               comunidadId, localidadId, comunidad, localidad, descripcion,
        //                                               acuiferoId, epsasId, epsasnoregularizadas, cooperativas, 
        //                                               cuencaId, cuencaestrategicaId, estado, 
        //                                               dateCreate, dateUpdate, userCreate, userUpdate) 
        //                             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        //print_struc($datos);
        foreach($datos as $key => $value){
            
            if ($value[14]=='' || is_null($value[14])) { $value[14]=0; }
            if ($value[15]=='' || is_null($value[15])) { $value[15]=0; }
            if ($value[20]=='' || is_null($value[20])) { $value[20]="NULL"; } //COD EPSAS
            if ($value[10]=='' || is_null($value[10])) { $value[10]="NULL"; }  //altITUD
            if ($value[24]=='' || is_null($value[24])) { $value[24]="NULL"; }  //Cuenca estrategica no identificada

            $sql = "INSERT INTO item (tipo, codigo, nombre, latitud, latitudDec, longitud, longitudDec, latitudUtm, longitudUtm, utmZona
                   , altitud, departamentoId, provinciaId, municipioId, comunidadId, localidadId, comunidad, localidad, descripcion, acuiferoId
                   , epsasId, epsasnoregularizadas, cooperativas, cuencaId, cuencaestrategicaId, estado, dateCreate, dateUpdate, userCreate, userUpdate) 
            VALUES (".$value[0].",'".$value[1]."','".$value[2]."','".$value[3]."','".$value[4]."','".$value[5]."','".$value[6]."','".$value[7]."',".$value[8].",'".$value[9]."',"
                    .$value[10].",".$value[11].",".$value[12].",".$value[13].",".$value[14].",".$value[15].",'".$value[16]."','".$value[17]."','".$value[18]."',".$value[19].","
                    .$value[20].",'".$value[21]."','".$value[22]."',".$value[23].",".$value[24].",'".$value[25]."','".$value[26]."','".$value[27]."',".$value[28].",".$value[29].");";

            //print_struc($sql);
            //if(!$this->dbm->Execute($sql, $value)) {  //  ORIGINALMENTE ESTABA LA LINEA
            if(!$this->dbm->Execute($sql)) {                    
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              $_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }
            $id[] = $this->dbm->Insert_ID();
            $_SESSION['codigos'][$value[30]]= $this->dbm->Insert_ID();
            $cont++;
        }

        $indices = implode(',', $id);
        $sqlupdate = "UPDATE item SET codigo=CONCAT(codigo,'-',itemId) WHERE itemId IN ($indices)"; //Revisar este dato IN(1, 2, 3, 4, 5)
        
        if ($this->dbm->Execute($sqlupdate)){
            $this->dbm->CommitTrans();
            $this->dbm->autoCommit = true;
            return array("res"=>true, "filasafectadas"=>$cont);
        }else{
            $this->dbm->RollbackTrans();
            return array("res"=>false, "filasafectadas"=>$cont);
        }

        

        //Insertar Postgres
        // global $dbm_siasbo;
        // $dbm_siasbo->SetFetchMode(ADODB_FETCH_ASSOC);

        // $dbm_siasbo->autoCommit = false;
        // $dbm_siasbo->SetTransactionMode("SERIALIZABLE");
        // $dbm_siasbo->BeginTrans(); 
        // $sql = $dbm_siasbo->Prepare("INSERT INTO item (tipo, codigo, nombre, latitud, latitudDec, 
        //                                               longitud, longitudDec, latitudUtm, longitudUtm, 
        //                                               utmZona, altitud, departamentoId, provinciaId, municipioId, 
        //                                               comunidadId, localidadId, comunidad, localidad, descripcion,
        //                                               acuiferoId, epsasId, epsasnoregularizadas, cooperativas, cuencaId,
        //                                               dateCreate, dateUpdate, userCreate, userUpdate, itemId) 
        //                             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        //$contid = 0;

        // foreach($datos as $key => $value){
        //     //$value['itemId'] = $id[$contid];
        //     if(!$dbm_siasbo->Execute($sql, $value)) { 
        //       $err = $dbm_siasbo->ErrorMsg();
        //       $dbm_siasbo->RollbackTrans();
        //       $_SESSION['codigos'] = NULL;
        //       trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
        //     }

        //     //$contid++;
        // }

        
        //Funcional
        // $sql = "INSERT INTO item (itemId, tipo, codigo, nombre) 
        //         VALUES (1, 1, 'CODIGO', 'POZO1', '1', '1', '1', '1')";

        // //$dbm_siasbo->Execute($sql, array(1, "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"));
        // if ($dbm_siasbo->Execute($sql)) {
        //     return array("res"=>true, "filasafectadas"=>$cont);
        // }else{
        //     return array("res"=>false, "filasafectadas"=>$cont);
        // }

        
        // $dbm_siasbo->CommitTrans();
        // $dbm_siasbo->autoCommit = true;

        
        //return $_SESSION['codigos'];
    }

    // function agregarCodigo(){
    //     $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

    //     $gencod = obtenerCodigo();
    //     $codine = obtenerCatDepartamentoIne();

    //     $cont = 0;
    //     $this->dbm->autoCommit = false;
    //     $this->dbm->SetTransactionMode("SERIALIZABLE");
    //     $this->dbm->BeginTrans(); 
    //     $sql = $this->dbm->Prepare("UPDATE item SET codigo=CONCAT(itemId,'-',cuencaId)"); //,'-P-',itemId

    //     foreach($gencod as $key => $value){
    //         if ($value != ""){
    //             if(!$this->dbm->Execute($sql, $value)){
    //                 $err = $this->dbm->ErrorMsg();
    //                 $this->dbm->RollbackTrans();
    //                 //$_SESSION['codigos'] = NULL;
    //                 trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
    //             }

    //             $cont++;
    //         }            
    //     }

    //     //$this->dbm->Execute("UPDATE item SET codigo=CONCAT(codigo,'-',itemId)"); //Revisar este dato IN(1, 2, 3, 4, 5)
        
    //     $this->dbm->CommitTrans();
    //     $this->dbm->autoCommit = true;

    //     return array("res"=>true, "filasafectadas"=>$cont);
    //     //return $_SESSION['codigos'];
    // }

    function agregarEspecifico($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $conti = 0;
        $contu = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();
        if ($_SESSION['banderaSql'] == 1) {
            $cadena1 = "INSERT INTO item_pozo (itemId, fuente_informacion, codigo, usoaguaId, 
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
        }else{
            $cadena1 = "INSERT INTO item_pozo (itemId, fuente_informacion, codigo, usoaguaId, 
                                              propositoId, propietario, observaciones) 
                    VALUES (?, ?, ?, ?, ?, ?, ?)";

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


            $cadena1 = "UPDATE item_pozo SET itemId=?, fuente_informacion=?, codigo=?, usoaguaId=?, propositoId=?, propietario=?, observaciones=?";

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
        }

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        $_SESSION['banderaSql'] = 2;
        return array("res"=>true, "filasafectadas"=>$conti+$contu);

    }

    function agregarPerforacion($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $conti = 0;
        $contu = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();
        //print_struc($_SESSION['banderaSql']); exit;
        if ($_SESSION['banderaSql']==1) {
            $cadena2 = "INSERT INTO item_pozo (perforacion_fecha, perforacion_pozoId, perforacion_tipoId, 
                                              perforacion_metodoId, perforacion_profundidad, perforacion_diametro, 
                                              perforacion_diametro_final, perforacion_observaciones, itemId,
                                              dateCreate, dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"; //STR_TO_DATE(?, '%d/%m/%Y')   //STR_TO_DATE(?, '%d/%m/%Y')

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
        }else{
            // $cadena2 = "INSERT INTO item_pozo (perforacion_fecha, perforacion_pozoId, perforacion_tipoId, 
            //                                   perforacion_metodoId, perforacion_profundidad, perforacion_diametro, 
            //                                   perforacion_diametro_final, perforacion_observaciones, itemId, 
            //                                   dateCreate, dateUpdate, userCreate, userUpdate) 
            //         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"; //STR_TO_DATE(?, '%d/%m/%Y')   //STR_TO_DATE(?, '%d/%m/%Y')

            // $sql = $this->dbm->Prepare($cadena2);
            // foreach($datos as $key => $value){
            //     if ($_SESSION['controltransaccion'][$value[0]] != $value[0]) {
            //         if(!$this->dbm->Execute($sql, $value)) {
            //           $err = $this->dbm->ErrorMsg();
            //           $this->dbm->RollbackTrans();
            //           //$_SESSION['codigos'] = NULL;
            //           trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            //         }
            //         $_SESSION['controltransaccion'][$value[0]] = $value[0];
            //         $conti++;
            //     }                
            // }

            // ----------------     CODIGO ORIGINAL     ----------------------
            // $cadena2 = "UPDATE item_pozo SET perforacion_fecha=?, perforacion_pozoId=?, perforacion_tipoId=?, 
            //                                 perforacion_metodoId=?, perforacion_profundidad=?, perforacion_diametro=?, 
            //                                 perforacion_diametro_final=?, perforacion_observaciones=?        
            //         WHERE itemId=?";

            // $sql = $this->dbm->Prepare($cadena2);
            // foreach($datos as $key => $value){
            //     if ($_SESSION['controltransaccion'][$value[0]] == $value[0]) {
            //         if(!$this->dbm->Execute($sql, $value)) {
            //           $err = $this->dbm->ErrorMsg();
            //           $this->dbm->RollbackTrans();
            //           //$_SESSION['codigos'] = NULL;
            //           trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            //         }
            //         $contu++;
            //     }                
            // }
            // ----------------    FIN CODIGO ORIGINAL     ----------------------

            //$sql = $this->dbm->Prepare($cadena2);

            //print_struc($datos); exit;
            foreach($datos as $key => $value){
                if ($value[0] == "" || $value[0] == "NULL")  { $value[0] = "NULL"; }  else { $value[0] = "'".$value[0]."'"; }
                if ($value[4] == "" || $value[4] == "NULL")  { $value[4] = "NULL"; }
                if ($value[5] == "" || $value[5] == "NULL")  { $value[5] = "NULL"; }
                if ($value[6] == "" || $value[6] == "NULL")  { $value[6] = "NULL"; }

                 $sql = "UPDATE item_pozo SET perforacion_fecha= ".$value[0].", perforacion_pozoId=".$value[1].", perforacion_tipoId=".$value[2].", 
                 perforacion_metodoId=".$value[3].", perforacion_profundidad=".$value[4].", perforacion_diametro=".$value[5].", 
                 perforacion_diametro_final=".$value[6].", perforacion_observaciones='".$value[7]."'        
                 WHERE itemId=".$value[8]."";
                 //print_struc($sql); exit;
                if(!$this->dbm->Execute($sql)) {
                    $err = $this->dbm->ErrorMsg();
                    $this->dbm->RollbackTrans();
                    trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
                }
                else { $contu++; }
            }

        }

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        $_SESSION['banderaSql'] = 2;
        return array("res"=>true, "filasafectadas"=>$contu); //+$conti
    }

    function agregarPerforacionExcavado($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $conti = 0;
        $contu = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();
        if ($_SESSION['banderaSql']==1) {
            $cadena2 = "INSERT INTO item_pozo (perforacion_fecha, perforacion_pozoId, perforacion_revestimientoId, 
                                              perforacion_excavacionId, perforacion_profundidadexcavada, perforacion_diametroexcavacion, 
                                              perforacion_nivelfreatico, perforacion_caudal, perforacion_observaciones, itemId, 
                                              dateCreate, dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"; //STR_TO_DATE(?, '%d/%m/%Y')   //STR_TO_DATE(?, '%d/%m/%Y')

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
        }else{

            $cadena2 = "INSERT INTO item_pozo (perforacion_fecha, perforacion_pozoId, perforacion_revestimientoId, 
                                              perforacion_excavacionId, perforacion_profundidadexcavada, perforacion_diametroexcavacion, 
                                              perforacion_nivelfreatico, perforacion_caudal, perforacion_observaciones, itemId, 
                                              dateCreate, dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"; //STR_TO_DATE(?, '%d/%m/%Y')   //STR_TO_DATE(?, '%d/%m/%Y')

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
            //  ------------        CODIGO ORIGINAL      ----------------
            $cadena2 = "UPDATE item_pozo SET perforacion_fecha=?, perforacion_pozoId=?, perforacion_revestimientoId=?, 
                                            perforacion_excavacionId=?, perforacion_profundidadexcavada=?, perforacion_diametroexcavacion=?, 
                                            perforacion_nivelfreatico=?, perforacion_caudal=?, perforacion_observaciones=?        
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
            //  ------------       FIN CODIGO ORIGINAL      ----------------
        }

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        $_SESSION['banderaSql'] = 2;
        return array("res"=>true, "filasafectadas"=>$contu); //+$conti
    }

    function agregarConstructivos($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $conti = 0;
        $contu = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();
        if ($_SESSION['banderaSql']==1) {
            $cadena3 = "INSERT INTO item_pozo (constructivo_entubado, constructivo_entubado_diametro, constructivo_altura, 
                                              constructivo_tuberiaId, constructivo_diametro, constructivo_selloId, 
                                              constructivo_observaciones, itemId, dateCreate, dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            $sql = $this->dbm->Prepare($cadena3);
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
        }else{
            $cadena3 = "INSERT INTO item_pozo (constructivo_entubado, constructivo_entubado_diametro, constructivo_altura, 
                                              constructivo_tuberiaId, constructivo_diametro, constructivo_selloId, 
                                              constructivo_observaciones, itemId) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            $sql = $this->dbm->Prepare($cadena3);
            foreach($datos as $key => $value){
                if ($_SESSION['controltransaccion'][$value[0]] != $value[0]){
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
            //  -------------      CODIGO ORIGINAL      ------------------
            // $cadena3 = "UPDATE item_pozo SET constructivo_entubado=?, constructivo_entubado_diametro=?, constructivo_altura=?, 
            //                                 constructivo_tuberiaId=?, constructivo_diametro=?, constructivo_selloId=?, constructivo_observaciones=? 
            //         WHERE itemId=?";
            // $sql = $this->dbm->Prepare($cadena3);
            // foreach($datos as $key => $value){
            //     if ($_SESSION['controltransaccion'][$value[0]] == $value[0]){
            //         if(!$this->dbm->Execute($sql, $value)) {
            //           $err = $this->dbm->ErrorMsg();
            //           $this->dbm->RollbackTrans();
            //           //$_SESSION['codigos'] = NULL;
            //           trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            //         }
            //         $contu++;
            //     }                
            // }
            //  -------------     FIN CODIGO ORIGINAL      ------------------

            //print_struc($datos); exit;
            foreach($datos as $key => $value){
                if ($value[0] == "" || $value[0] == "NULL")  { $value[0] = "NULL"; }
                if ($value[1] == "" || $value[1] == "NULL")  { $value[1] = "NULL"; }
                if ($value[2] == "" || $value[2] == "NULL")  { $value[2] = "NULL"; }
                if ($value[4] == "" || $value[4] == "NULL")  { $value[4] = "NULL"; }

                 $sql = "UPDATE item_pozo SET constructivo_entubado=".$value[0].", constructivo_entubado_diametro=".$value[1].", constructivo_altura=".$value[2].", 
                 constructivo_tuberiaId=".$value[3].", constructivo_diametro=".$value[4].", constructivo_selloId=".$value[5].", constructivo_observaciones='".$value[6]."' 
                 WHERE itemId=".$value[7]."";
                 //print_struc($sql); exit;
                 if(!$this->dbm->Execute($sql)) {
                    $err = $this->dbm->ErrorMsg();
                    $this->dbm->RollbackTrans();
                    trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
                }
                else { $contu++; }
            }
            
        }        

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        $_SESSION['banderaSql'] = 2;
        return array("res"=>true, "filasafectadas"=>$contu); //+$conti
    }

    function agregarConstructivosRejillaFiltro($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();              

        $cadena4 = "INSERT INTO item_pozo_constructivo_diseno (pozoId, profundidad_desde, profundidad_hasta, rejillafiltroId, 
                                                               abertura, observaciones, dateCreate, dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $sql = $this->dbm->Prepare($cadena4);
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

    function agregarColumnaLitologica($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();

        $cadena5 = "INSERT INTO item_pozo_litologica (pozoId, profundidad_desde, profundidad_hasta, 
                                                               litologia1, porcentaje1, litologia2, porcentaje2, 
                                                               litologia3, porcentaje3, litologia4, porcentaje4, 
                                                               permeabilidad, observaciones, 
                                                               dateCreate, dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $sql = $this->dbm->Prepare($cadena5);
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

    function agregarPerfilajeElectrico($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $conti = 0;
        $contu = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();
        if ($_SESSION['banderaSql']==1) {
            $cadena6 = "INSERT INTO item_pozo (electrico_fecha, electrico_profundidad, electrico_parametroId, 
                                              electrico_diagnostico, electrico_observaciones, itemId, 
                                              dateCreate, dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            $sql = $this->dbm->Prepare($cadena6);
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
        }else{
            $cadena6 = "INSERT INTO item_pozo (electrico_fecha, electrico_profundidad, electrico_parametroId, 
                                              electrico_diagnostico, electrico_observaciones, itemId) 
                    VALUES (?, ?, ?, ?, ?, ?)";

            $sql = $this->dbm->Prepare($cadena6);
            foreach($datos as $key => $value){
                if ($_SESSION['controltransaccion'][$value[0]] != $value[0]){
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

            $cadena6 = "UPDATE item_pozo SET electrico_fecha=?, electrico_profundidad=?, electrico_parametroId=?, 
                                            electrico_diagnostico=?, electrico_observaciones=?  
                    WHERE itemId=?";

            $sql = $this->dbm->Prepare($cadena6);
            foreach($datos as $key => $value){
                if ($_SESSION['controltransaccion'][$value[0]] == $value[0]){
                    if(!$this->dbm->Execute($sql, $value)) {
                      $err = $this->dbm->ErrorMsg();
                      $this->dbm->RollbackTrans();
                      //$_SESSION['codigos'] = NULL;
                      trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
                    }

                    $contu++;
                }                
            }
        }        

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        $_SESSION['banderaSql'] = 2;
        return array("res"=>true, "filasafectadas"=>$contu); //+$conti
    }

    function agregarImplementacion($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $conti = 0;
        $contu = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();
        if ($_SESSION['banderaSql']==1) {
            $cadena7 = "INSERT INTO item_pozo (imple_profundidad, imple_tipoId, imple_caudal, 
                                              imple_horario_bombeo, imple_potencia, imple_observaciones, itemId,
                                              dateCreate, dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            $sql = $this->dbm->Prepare($cadena7);
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
        }else{
            $cadena7 = "INSERT INTO item_pozo (imple_profundidad, imple_tipoId, imple_caudal, 
                                              imple_horario_bombeo, imple_potencia, imple_observaciones, itemId) 
                    VALUES (?, ?, ?, ?, ?, ?, ?)";

            $sql = $this->dbm->Prepare($cadena7);
            foreach($datos as $key => $value){
                if ($_SESSION['controltransaccion'][$value[0]] != $value[0]){
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

            //  ----------------  INCIO CODIGO ORIGINAL    -----------------------
            // $cadena7 = "UPDATE item_pozo SET imple_profundidad=?, imple_tipoId=?, imple_caudal=?, 
            //                                 imple_horario_bombeo=?, imple_potencia=?, imple_observaciones=? 
            //         WHERE itemId=?";
            // $sql = $this->dbm->Prepare($cadena7);
            // foreach($datos as $key => $value){
            //     if ($_SESSION['controltransaccion'][$value[0]] == $value[0]){
            //         if(!$this->dbm->Execute($sql, $value)) {
            //           $err = $this->dbm->ErrorMsg();
            //           $this->dbm->RollbackTrans();
            //           //$_SESSION['codigos'] = NULL;
            //           trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            //         }
            //         $contu++;
            //     }                
            // }
            //  ----------------  FIN DE CODIGO ORIGINAL    -----------------------

            //print_struc($datos); exit;
            foreach($datos as $key => $value){
                if ($value[0] == "" || $value[0] == "NULL")  { $value[0] = "NULL"; }
                if ($value[1] == "" || $value[1] == "NULL")  { $value[1] = "NULL"; }
                if ($value[2] == "" || $value[2] == "NULL")  { $value[2] = "NULL"; }
                if ($value[3] == "" || $value[3] == "NULL")  { $value[3] = "NULL"; }

                $sql = "UPDATE item_pozo SET imple_profundidad=".$value[0].", imple_tipoId=".$value[1].", imple_caudal=".$value[2].", 
                imple_horario_bombeo=".$value[3].", imple_potencia='".$value[4]."', imple_observaciones='".$value[5]."' 
                WHERE itemId=".$value[6]."";
                //print_struc($sql); exit;
                if(!$this->dbm->Execute($sql)) {
                    $err = $this->dbm->ErrorMsg();
                    $this->dbm->RollbackTrans();
                    trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
                }
                else { $contu++; }
            }
        }        

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        $_SESSION['banderaSql'] = 2;
        return array("res"=>true, "filasafectadas"=>$contu); //+$conti
    }

    function agregarMonitoreoCantidad($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();
        //print_struc($datos); exit;
        // -----------    INICIO CODIGO ORIGINAL     --------------
        // $cadena8 = "INSERT INTO item_pozo_monitor (pozoId, fecha, hora, 
        //                                            epocaId, puntoreferencia, elevacion, nivel_freatico, 
        //                                            nivel_dinamico, nivel_estatico, caudal, caudalautorizado, 
        //                                            observaciones, dateCreate, dateUpdate, userCreate, userUpdate) 
        //             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        // $sql = $this->dbm->Prepare($cadena8);
        // foreach($datos as $key => $value){
        //     if(!$this->dbm->Execute($sql, $value)) {
        //       $err = $this->dbm->ErrorMsg();
        //       $this->dbm->RollbackTrans();
        //       //$_SESSION['codigos'] = NULL;
        //       trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
        //     }
        //     $cont++;
        // } 
        // -----------    FIN CODIGO ORIGINAL     -----------------------

        //$sql = $this->dbm->Prepare($cadena8);
        //print_struc($datos); exit;

        foreach($datos as $key => $value){
            //if ($value[1] == "" || $value[1] == "NULL")  { $value[1] = "NULL"; }
            if ($value[2] == "" || $value[2] == "NULL")  { $value[2] = "NULL"; }
            if ($value[3] == "" || $value[3] == "NULL")  { $value[3] = "NULL"; }
            if ($value[5] == "" || $value[5] == "NULL")  { $value[5] = "NULL"; }
            if ($value[6] == "" || $value[6] == "NULL")  { $value[6] = "NULL"; }
            if ($value[7] == "" || $value[7] == "NULL")  { $value[7] = "NULL"; }
            if ($value[8] == "" || $value[8] == "NULL")  { $value[8] = "NULL"; }
            $sql = "INSERT INTO item_pozo_monitor (pozoId, fecha, hora, epocaId, puntoreferencia, elevacion, nivel_freatico, nivel_dinamico, nivel_estatico, caudal, caudalautorizado, 
                observaciones, dateCreate, dateUpdate, userCreate, userUpdate) 
                VALUES (".$value[0].", '".$value[1]."', ".$value[2].", ".$value[3].", '".$value[4]."', ".$value[5].", ".$value[6].", ".$value[7].", ".$value[8].", '".$value[9]."', '".$value[10]."', '".$value[11]."', '".$value[12]."', '".$value[13]."', ".$value[14].", ".$value[15].")";
            //print_struc($sql); exit;
            if(!$this->dbm->Execute($sql)) {
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              //$_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }
            else { $cont++; }
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

        // -----------    INICIO CODIGO ORIGINAL     -----------------------
        // $cadena9 = "INSERT INTO item_pozo_monitor_calidad (pozoId, fecha_muestreo, hora_muestreo, 
        //                                                    epocaId, entidad, codigo_muestra, fecha_analisis, 
        //                                                    hora_analisis, nombre_laboratorio, codigo_laboratorio, profundidad, 
        //                                                    observaciones, dateCreate, dateUpdate, userCreate, userUpdate) 
        //             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        // $sql = $this->dbm->Prepare($cadena9);
        // foreach($datos as $key => $value){
        //     if(!$this->dbm->Execute($sql, $value)) {
        //       $err = $this->dbm->ErrorMsg();
        //       $this->dbm->RollbackTrans();
        //       //$_SESSION['codigos'] = NULL;
        //       trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
        //     }
        //     //$_SESSION['codigomoncal'][$value[16]] = $this->dbm->Insert_ID();
        //     $_SESSION['codigomoncal'][$cont] = $this->dbm->Insert_ID();
        //     $cont++;
        // }
        // -----------    FIN CODIGO ORIGINAL     -----------------------

        //$sql = $this->dbm->Prepare($cadena8);
        //print_struc($datos); exit; 
        foreach($datos as $key => $value){
            if ($value[1] == "" || $value[1] == "NULL")  { $value[1] = "NULL"; }  // fecha
            if ($value[2] == "" || $value[2] == "NULL")  { $value[2] = "NULL"; }  // hora
            if ($value[3] == "" || $value[3] == "NULL")  { $value[3] = "NULL"; }  //

            if ($value[6] == "" || $value[6] == "NULL")  { $value[6] = "NULL"; }
            if ($value[7] == "" || $value[7] == "NULL")  { $value[7] = "NULL"; }
            if ($value[9] == "" || $value[9] == "NULL")  { $value[9] = "NULL"; }
            if ($value[10] == "" || $value[10] == "NULL")  { $value[10] = "NULL"; }

            $sql = "INSERT INTO item_pozo_monitor_calidad (pozoId, fecha_muestreo, hora_muestreo, epocaId, entidad, codigo_muestra, fecha_analisis, hora_analisis, nombre_laboratorio, codigo_laboratorio
            , profundidad, observaciones, dateCreate, dateUpdate, userCreate, userUpdate) 
            VALUES (".$value[0].", '".$value[1]."', ".$value[2].", ".$value[3].", '".$value[4]."', '".$value[5]."', ".$value[6].", ".$value[7].", '".$value[8]."', ".$value[9]."
            , ".$value[10].", '".$value[11]."', '".$value[12]."', '".$value[13]."', ".$value[14]." , ".$value[15].")";
            //print_struc($sql); exit;
            if(!$this->dbm->Execute($sql)) {
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              //$_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }
            else { 
                $_SESSION['codigomoncal'][$cont] = $this->dbm->Insert_ID();
                $cont++; 
            }
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

        //   ---------   INICIO CODIGO ORIGINAL    ----------
        // $cadena10 = "INSERT INTO item_pozo_monitor_calidad_dato (calidadId, parametroId, compuestoId, 
        //                                                          valor, observaciones, dateCreate, 
        //                                                          dateUpdate, userCreate, userUpdate) 
        //             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        // $sql = $this->dbm->Prepare($cadena10);
        // foreach($datos as $key => $value){
        //     if(!$this->dbm->Execute($sql, $value)) {
        //       $err = $this->dbm->ErrorMsg();
        //       $this->dbm->RollbackTrans();
        //       //$_SESSION['codigos'] = NULL;
        //       trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
        //     }
        //     $cont++;
        // }
        //   ---------   INICIO CODIGO ORIGINAL    ----------        

        //print_struc($datos); exit;
        foreach($datos as $key => $value){
            if ($value[3] == "" || $value[3] == "NULL")  { $value[3] = "NULL"; }  //
            $sql = "INSERT INTO item_pozo_monitor_calidad_dato (calidadId, parametroId, compuestoId, valor, observaciones, dateCreate, dateUpdate, userCreate, userUpdate) 
            VALUES (".$value[0].", ".$value[1].", ".$value[2].", ".$value[3].", '".$value[4]."', '".$value[5]."', '".$value[6]."', ".$value[7].", ".$value[8].")";
            //print_struc($sql); exit;
            if(!$this->dbm->Execute($sql)) {
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              //$_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }
            else { $cont++; }
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
            
            case 13:
                return 13;
                break;

            case 14:
                return 14;
                break;

            case 15:
                return 15;
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
        //   ------------------   INICIO CODIGO ORIGINAL   ----------------
        // $cadena9 = "INSERT INTO item_pozo_monitor_isotopico (pozoId, fecha_muestreo, hora_muestreo, 
        //                                                    epocaId, entidad, codigo_muestra, fecha_analisis, 
        //                                                    hora_analisis, nombre_laboratorio, codigo_laboratorio, profundidad, 
        //                                                    observaciones, dateCreate, dateUpdate, userCreate, userUpdate) 
        //             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        //  print_struc($datos); exit;
        // $sql = $this->dbm->Prepare($cadena9);
        // foreach($datos as $key => $value){
        //     if(!$this->dbm->Execute($sql, $value)) {
        //       $err = $this->dbm->ErrorMsg();
        //       $this->dbm->RollbackTrans();
        //       //$_SESSION['codigos'] = NULL;
        //       trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
        //     }
        //     //$_SESSION['codigomoniso'][$value[16]] = $this->dbm->Insert_ID();
        //     $_SESSION['codigomoniso'][$cont] = $this->dbm->Insert_ID();
        //     $cont++;
        // }
        //   ------------------   FIN CODIGO ORIGINAL   ----------------
        
        //print_struc($datos); exit;
        foreach($datos as $key => $value){
            if ($value[1] == "" || $value[1] == "NULL")  { $value[1] = "NULL"; }  // FECHA
            if ($value[2] == "" || $value[2] == "NULL")  { $value[2] = "NULL"; }  //  HORA
            if ($value[3] == "" || $value[3] == "NULL")  { $value[3] = "NULL"; }  //  EPOCA
            if ($value[6] == "" || $value[6] == "NULL")  { $value[6] = "NULL"; }  //  FECHA ANALISIS
            if ($value[7] == "" || $value[7] == "NULL")  { $value[7] = "NULL"; }  //  HORA ANALISIS
            if ($value[10] == "" || $value[10] == "NULL")  { $value[10] = "NULL"; }  //  PROFUNDIDAD

            $sql = "INSERT INTO item_pozo_monitor_isotopico (pozoId, fecha_muestreo, hora_muestreo, epocaId, entidad, codigo_muestra, fecha_analisis, hora_analisis, nombre_laboratorio, codigo_laboratorio
            , profundidad, observaciones, dateCreate, dateUpdate, userCreate, userUpdate) 
            VALUES (".$value[0].", '".$value[1]."', ".$value[2].", ".$value[3].", '".$value[4]."', '".$value[5]."', ".$value[6].", ".$value[7].", '".$value[8]."', '".$value[9]."'
            , ".$value[10].", '".$value[11]."','".$value[12]."', '".$value[13]."', ".$value[14].", ".$value[15].")";
            //print_struc($sql); exit;
            if(!$this->dbm->Execute($sql)) {
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              //$_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }
            else { 
                $_SESSION['codigomoniso'][$cont] = $this->dbm->Insert_ID();
                $cont++; 
            }
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

        // ---------  INICIO CODIGO ORIGINAL  ---------
        // $cadena10 = "INSERT INTO item_pozo_monitor_isotopico_dato (isotopicoId, isotoparametroId, isotocompuestoId, 
        //                                                            valor, observaciones, dateCreate, 
        //                                                            dateUpdate, userCreate, userUpdate) 
        //             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        // $sql = $this->dbm->Prepare($cadena10);
        // foreach($datos as $key => $value){
        //     if(!$this->dbm->Execute($sql, $value)) {
        //       $err = $this->dbm->ErrorMsg();
        //       $this->dbm->RollbackTrans();
        //       //$_SESSION['codigos'] = NULL;
        //       trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
        //     }
            
        //     $cont++;
        // }
        // ---------  FIN CODIGO ORIGINAL  ---------
        //print_struc($datos); exit;
        foreach($datos as $key => $value){
            if ($value[1] == "" || $value[1] == "NULL")  { $value[1] = "NULL"; }  // FECHA
            if ($value[2] == "" || $value[2] == "NULL")  { $value[2] = "NULL"; }  //  HORA
            if ($value[3] == "" || $value[3] == "NULL")  { $value[3] = "NULL"; }  //  EPOCA
            // if ($value[6] == "" || $value[6] == "NULL")  { $value[6] = "NULL"; }  //  FECHA ANALISIS
            // if ($value[7] == "" || $value[7] == "NULL")  { $value[7] = "NULL"; }  //  HORA ANALISIS
            // if ($value[10] == "" || $value[10] == "NULL")  { $value[10] = "NULL"; }  //  PROFUNDIDAD

            $sql = "INSERT INTO item_pozo_monitor_isotopico_dato (isotopicoId, isotoparametroId, isotocompuestoId, valor, observaciones, dateCreate, dateUpdate, userCreate, userUpdate) 
            VALUES (".$value[0].", ".$value[1].", ".$value[2].", ".$value[3].", '".$value[4]."', '".$value[5]."', '".$value[6]."', ".$value[7].", ".$value[8].")";
            //print_struc($sql); exit;
            if(!$this->dbm->Execute($sql)) {
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              //$_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }
            else { 
                //$_SESSION['codigomoniso'][$cont] = $this->dbm->Insert_ID();
                $cont++; 
            }
        } 

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        return array("res"=>true, "filasafectadas"=>$cont);
    }

    function obtenerIdRadioActividad($columna){
        switch ($columna) {
            case 1:
                return 1;
                break;

            case 2:
                return 2;
                break;
            
            default:
                break;
        }
    }

    function obtenerIdIsotopos($columna){
        switch ($columna) {
            case 1:
                return 3;
                break;

            case 2:
                return 4;
                break;

            case 3:
                return 5;
                break;

            case 4:
                return 6;
                break;

            case 5:
                return 7;
                break;

            case 6:
                return 8;
                break;

            case 7:
                return 9;
                break;

            case 8:
                return 10;
                break;

            case 9:
                return 11;
                break;

            case 10:
                return 12;
                break;

            case 11:
                return 13;
                break;

            case 12:
                return 14;
                break;

            case 13:
                return 15;
                break;
            
            default:
                break;
        }
    }

    function obtenerIdOtros($columna){
        switch ($columna) {
            case 1:
                return 16;
                break;

            case 2:
                return 17;
                break;
            
            default:
                break;
        }
    }

    function agregarHidraulicos($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();

        $cadena9 = "INSERT INTO item_pozo_hidra (pozoId, tipopruebaId, fecha, 
                                                 conductividad, transmisividad, coeficiente, radio, 
                                                 porosidad, observaciones, dateCreate, dateUpdate, 
                                                 userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $sql = $this->dbm->Prepare($cadena9);
        foreach($datos as $key => $value){
            if(!$this->dbm->Execute($sql, $value)) {
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              //$_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }
            $_SESSION['codigohidra'][$value[13]] = $this->dbm->Insert_ID();
            $cont++;
        }        

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        return array("res"=>true, "filasafectadas"=>$cont);
    }

    function agregarHPBEscalonado($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();

        $cadena10 = "INSERT INTO item_pozo_hidra_bombeo (pruebabombeoId, tipo, fecha, 
                                                         nivel_estatico, nivel_dinamico, duracion, 
                                                         profundidad, potencia, observaciones, dateCreate, 
                                                         dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $sql = $this->dbm->Prepare($cadena10);
        foreach($datos as $key => $value){
            if(!$this->dbm->Execute($sql, $value)) {
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              //$_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }
            $_SESSION['codigohpbescalonado'][$value[13]] = $this->dbm->Insert_ID();
            $cont++;
        }        

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        return array("res"=>true, "filasafectadas"=>$cont);
    }

    function agregarEscalones($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();

        $cadena10 = "INSERT INTO item_pozo_hidra_bombeo_dato (tipobombeoId, tiempo, nivel_dinamico, 
                                                              caudal, etapa, dateCreate, 
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

    function agregarEscRecuperacion($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();

        $cadena10 = "INSERT INTO item_pozo_hidra_recuperacion (tipobombeoId, fecha, nivel_estatico, 
                                                              nivel_dinamico_final, duracion, observaciones, dateCreate, 
                                                              dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $sql = $this->dbm->Prepare($cadena10);
        foreach($datos as $key => $value){
            if(!$this->dbm->Execute($sql, $value)) {
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              //$_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }
            $_SESSION['codigoescrecesc'][$value[10]] = $this->dbm->Insert_ID();
            $cont++;
        }        

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        return array("res"=>true, "filasafectadas"=>$cont);
    }

    function agregarEscRecEscalon($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();

        $cadena10 = "INSERT INTO item_pozo_hidra_recuperacion_dato (recuperacionId, tiempo, nivel_dinamico, 
                                                              dateCreate, dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?)";

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

    //FALTA DESDE HPB_CONTINUA
    function agregarHPBContinuo($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();

        $cadena10 = "INSERT INTO item_pozo_hidra_bombeo (pruebabombeoId, tipo, fecha, 
                                                         nivel_estatico, nivel_dinamico, duracion, 
                                                         profundidad, potencia, caudal, observaciones, dateCreate, 
                                                         dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $sql = $this->dbm->Prepare($cadena10);
        foreach($datos as $key => $value){
            if(!$this->dbm->Execute($sql, $value)) {
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              //$_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }
            $_SESSION['codigohpbcontinuo'][$value[14]] = $this->dbm->Insert_ID();
            $cont++;
        }        

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        return array("res"=>true, "filasafectadas"=>$cont);
    }

    function agregarEscalonesContinuo($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();

        $cadena10 = "INSERT INTO item_pozo_hidra_bombeo_dato (tipobombeoId, tiempo, nivel_dinamico, 
                                                              dateCreate, dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?)";

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

    function agregarConRecuperacion($datos){ //Es igual a agregarEscRecuperacion
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();

        $cadena10 = "INSERT INTO item_pozo_hidra_recuperacion (tipobombeoId, fecha, nivel_estatico, 
                                                              nivel_dinamico_final, duracion, observaciones, dateCreate, 
                                                              dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $sql = $this->dbm->Prepare($cadena10);
        foreach($datos as $key => $value){
            if(!$this->dbm->Execute($sql, $value)) {
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              //$_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }
            $_SESSION['codigoconrecesc'][$value[10]] = $this->dbm->Insert_ID();
            $cont++;
        }        

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        return array("res"=>true, "filasafectadas"=>$cont);
    }

    function agregarConRecEscalon($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();

        $cadena10 = "INSERT INTO item_pozo_hidra_recuperacion_dato (recuperacionId, tiempo, nivel_dinamico, 
                                                                    dateCreate, dateUpdate, userCreate, userUpdate) 
                    VALUES (?, ?, ?, ?, ?, ?, ?)";

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
    function get_ubicacion_macrocuenca($latitudDecimal, $longitudDecimal) {
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
    function get_ubicacion_cuenca_estrategica($latitudDecimal, $longitudDecimal) {
        global $dbm_siasbo;
        $dbm_siasbo->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT id AS cuencaestraid
        FROM cuenca_estra_25 
        WHERE  
        ST_Contains(geom, ST_GeomFromText(CONCAT('POINT(', ".$longitudDecimal.", ' ', ".$latitudDecimal.", ')'),4326)) 
        LIMIT 1";
        //print_struc($sql); exit;
        $datos = $dbm_siasbo->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    // Obtiene código INE departamento
    function get_codigo_ine_departamento($deptoId) {
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

    //Permisos de usuario
    function get_permisos($usuario, $itemIdSubmoduloPozo){

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
                    'nombre' => '5.- Redes de Monitoreo'
                    ) 
                );
        } else {
            //$this->dbm->debug = true;
            $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
            $sql = "SELECT b.crear, b.editar, b.eliminar, c.itemId, c.nombre, a.tipoUsuario, b.usuarioId
            FROM vrhr_snir.core_usuario as a inner join vrhr_snir.core_usuario_permisos as b on a.itemId = b.usuarioId 
            inner join vrhr_snir.core_submodulo as c on b.subModuloId = c.itemId 
            WHERE a.usuario='".$usuario."' and c.itemId=".$itemIdSubmoduloPozo;
            $datos = $this->dbm->Execute($sql);
            $datos = $datos->GetRows();
            return $datos;
        }
    }

    /**
     * FUNCIONES DE IMPORTACIÓN DE DATOS DE MONITOREO DE
     * CANTIDAD Y CALIDAD DESDE ARCHIVOS EXCEL
     * Funciones de definición de parámetros
     */
    function obtenerDefinicionHojasMonitoreo() {
        return array(
            "MONITOREO_CANTIDAD",
            "MONITOREO_CALIDAD"
        );
    }

    function obtenerDefinicionHojasMonitoreoCalidad() {
        return array(
            "MC_CAMPO",
            "MC_BASICOS",
            "MC_INORGANICOS",
            "MC_ORGANICOS",
            "MC_MICROORGANISMOS",
            "MC_PLAGUICIDAS_PESTICIDAS"
        );
    }

    // Devuelve IDs de los parámetros de calidad de la BD
    // Tabla: catalogo_pozo_monitor_calidad_parametro
    function obtenerDefinicionParametrosCalidad() {
        return array(
            "MC_CAMPO" => 1, // Parametros de Campo
            "MC_BASICOS" => 2, // Parametros Basicos
            "MC_INORGANICOS" => 3, // Compuestos Inorgánicos
            "MC_ORGANICOS" => 4, // Compuestos Organicos
            "MC_MICROORGANISMOS" => 5, // Microorganismos
            "MC_PLAGUICIDAS_PESTICIDAS" => 6 // Plaguicidas Pesticidas
        );
    }

    /**
     * Funciones de validación de datos
     */
    function validarFechaDatosMonitoreo($fecha, $formato = 'Y-m-d') {
        $nuevaFecha = DateTime::createFromFormat($formato, $fecha);
        return $nuevaFecha && $nuevaFecha->format($formato) == $fecha;
    }

    function validarHoraDatosMonitoreo($hora, $formato = 'H:i:s') {
        $nuevaHora = DateTime::createFromFormat($formato, $hora);
        return $nuevaHora && ($nuevaHora->format($formato) == $hora || ltrim($nuevaHora->format($formato), "0") == $hora);
    }

    function validarNumerosDecimalesDatosMonitoreo($numeroDecimal) {
        return is_numeric($numeroDecimal) && is_float((float)$numeroDecimal);
    }

    function validarCadenasTextoDatosMonitoreo($cadenaTexto, $longitudCadenaTexto) {
        return is_string($cadenaTexto) && (strlen($cadenaTexto) <= $longitudCadenaTexto);
    }

    function validarDatosMonitoreoCantidad($datos, $filaInicio) {
        $cantFilas = count($hojas);
        $msgValidacion = "";
        foreach ($datos as $indice => $valor) {
            $validacion = "";
            if ($valor[1] != null && !$this->validarFechaDatosMonitoreo($valor[1], 'd/m/Y')) {
                $validacion .= "Celda C".($indice + $filaInicio)." fecha incorrecta | ";
            }

            if ($valor[2] != null && !$this->validarHoraDatosMonitoreo($valor[2], 'H:i:s')) {
                $validacion .= "Celda D".($indice + $filaInicio)." hora incorrecta | ";
            }

            if ($valor[3] != null && is_numeric($valor[3])) {
                $validacion .= "Celda E".($indice + $filaInicio)." texto incorrecto | ";
            }

            if ($valor[4] != null && !is_sctring($valor[4])) {
                $validacion .= "Celda F".($indice + $filaInicio)." texto incorrecto | ";
            }

            if ($valor[5] != null && !$this->validarNumerosDecimalesDatosMonitoreo($valor[5])) {
                $validacion .= "Celda G".($indice + $filaInicio)." valor incorrecto | ";
            }

            if ($valor[6] != null && !$this->validarNumerosDecimalesDatosMonitoreo($valor[6])) {
                $validacion .= "Celda H".($indice + $filaInicio)." valor incorrecto | ";
            }

            if ($valor[7] != null && !$this->validarNumerosDecimalesDatosMonitoreo($valor[7])) {
                $validacion .= "Celda I".($indice + $filaInicio)." valor incorrecto | ";
            }

            if ($valor[8] != null && !$this->validarNumerosDecimalesDatosMonitoreo($valor[8])) {
                $validacion .= "Celda J".($indice + $filaInicio)." valor incorrecto | ";
            }

            if ($valor[9] != null && !$this->validarCadenasTextoDatosMonitoreo($valor[9], 45)) {
                $validacion .= "Celda K".($indice + $filaInicio)." texto incorrecto | ";
            }

            if ($valor[10] != null && !$this->validarCadenasTextoDatosMonitoreo($valor[10], 45)) {
                $validacion .= "Celda L".($indice + $filaInicio)." texto incorrecto | ";
            }

            if ($valor[11] != null && !$this->validarCadenasTextoDatosMonitoreo($valor[11], 255)) {
                $validacion .= "Celda M".($indice + $filaInicio)." texto incorrecto | ";
            }

            if ($validacion != "") {
                $msgValidacion .= $validacion."<br>";
            }
        }

        $resValidacion = $msgValidacion == "" ? true : false;

        return array("estado" => $resValidacion, "mensaje" => $msgValidacion);
    }

    function validarDatosMonitoreoCalidad($datos, $filaInicio) {
        $cantFilas = count($hojas);
        $msgValidacion = "";
        foreach ($datos as $indice => $valor) {
            $validacion = "";
            if ($valor[1] != null && !$this->validarFechaDatosMonitoreo($valor[1], 'd/m/Y')) {
                $validacion .= "Celda C".($indice + $filaInicio)." fecha incorrecta | ";
            }

            if ($valor[2] != null && !$this->validarHoraDatosMonitoreo($valor[2], 'H:i:s')) {
                $validacion .= "Celda D".($indice + $filaInicio)." hora incorrecta | ";
            }

            if ($valor[3] != null && is_numeric($valor[3])) {
                $validacion .= "Celda E".($indice + $filaInicio)." texto incorrecto | ";
            }

            if ($valor[4] != null && !$this->validarCadenasTextoDatosMonitoreo($valor[4], 100)) {
                $validacion .= "Celda F".($indice + $filaInicio)." texto incorrecto | ";
            }

            if ($valor[5] != null && !$this->validarCadenasTextoDatosMonitoreo($valor[5], 100)) {
                $validacion .= "Celda G".($indice + $filaInicio)." texto incorrecto | ";
            }

            if ($valor[6] != null && !$this->validarFechaDatosMonitoreo($valor[6], 'd/m/Y')) {
                $validacion .= "Celda H".($indice + $filaInicio)." fecha incorrecta | ";
            }

            if ($valor[7] != null && !$this->validarHoraDatosMonitoreo($valor[7], 'H:i:s')) {
                $validacion .= "Celda I".($indice + $filaInicio)." hora incorrecta | ";
            }

            if ($valor[8] != null && !$this->validarCadenasTextoDatosMonitoreo($valor[8], 100)) {
                $validacion .= "Celda J".($indice + $filaInicio)." texto incorrecto | ";
            }

            if ($valor[9] != null && !$this->validarCadenasTextoDatosMonitoreo($valor[9], 100)) {
                $validacion .= "Celda K".($indice + $filaInicio)." texto incorrecto | ";
            }

            if ($valor[10] != null && !$this->validarNumerosDecimalesDatosMonitoreo($valor[10])) {
                $validacion .= "Celda L".($indice + $filaInicio)." valor incorrecto | ";
            }

            if ($valor[11] != null && !is_string($valor[11])) {
                $validacion .= "Celda M".($indice + $filaInicio)." texto incorrecto | ";
            }

            if ($validacion != "") {
                $msgValidacion .= $validacion."<br>";
            }
        }

        $resValidacion = $msgValidacion == "" ? true : false;

        return array("estado" => $resValidacion, "mensaje" => $msgValidacion);
    }

    function validarDatosCompuestosMonitoreoCalidad($datos) {
        $msgValidacion = "";
        foreach ($datos as $indice => $valor) {
            $validacion = "";

            if ($valor[4] != null && !$this->validarNumerosDecimalesDatosMonitoreo($valor[4])) {
                $validacion .= "Hoja: ".$valor[0]." Fila: ".$valor[1]." Columna: ".$valor[3].", valor incorrecto | ";
            }

            if ($validacion != "") {
                $msgValidacion .= $validacion."<br>";
            }
        }

        $resValidacion = $msgValidacion == "" ? true : false;

        return array("estado" => $resValidacion, "mensaje" => $msgValidacion);
    }

    /**
     * Funciones de transformación de datos
     */
    function transformarFechaDatosMonitoreo($fecha, $formato = 'Y-m-d') {
        return DateTime::createFromFormat($formato, $fecha)->format('Y-m-d');
    }

    function transformarHoraDatosMonitoreo($hora, $formato = 'H:i:s') {
        return DateTime::createFromFormat($formato, $hora)->format('H:i:s');
    }

    function transformarDatosMonitoreoCantidad($datos, $catalogoEpocas) {
        $numFilas = count($datos);
        for ($i = 0; $i < $numFilas; $i++) {
            if ($datos[$i][1] != null) {
                $datos[$i][1] = $this->transformarFechaDatosMonitoreo($datos[$i][1], 'd/m/Y');
            }

            if ($datos[$i][2] != null) {
                $datos[$i][2] = $this->transformarHoraDatosMonitoreo($datos[$i][2], 'H:i:s');
            }

            if ($datos[$i][3] != null) {
                $datos[$i][3] = $catalogoEpocas[$datos[$i][3]];
            }
        }

        return $datos;
    }

    function transformarDatosMonitoreoCalidad($datos, $catalogoEpocas) {
        $numFilas = count($datos);
        foreach ($datos as $clave => $valor) {
            if ($datos[$clave][1] != null) {
                $datos[$clave][1] = $this->transformarFechaDatosMonitoreo($datos[$clave][1], 'd/m/Y');
            }

            if ($datos[$clave][2] != null) {
                $datos[$clave][2] = $this->transformarHoraDatosMonitoreo($datos[$clave][2], 'H:i:s');
            }

            if ($datos[$clave][3] != null) {
                $datos[$clave][3] = $catalogoEpocas[$datos[$clave][3]];
            }

            if ($datos[$clave][6] != null) {
                $datos[$clave][6] = $this->transformarFechaDatosMonitoreo($datos[$clave][6], 'd/m/Y');
            }

            if ($datos[$clave][7] != null) {
                $datos[$clave][7] = $this->transformarHoraDatosMonitoreo($datos[$clave][7], 'H:i:s');
            }
        }

        return $datos;
    }

    function transformarDatosCompuestosMonitoreoCalidad($datos, $idsMuestra, $catalogoCompuestosCalidad) {
        $numFilas = count($datos);
        for ($i = 0; $i < $numFilas; $i++) {
            if ($datos[$i][1] != null) {
                $datos[$i][1] = $idsMuestra[$datos[$i][1]];
            }

            if ($datos[$i][3] != null) {
                $datos[$i][3] = $catalogoCompuestosCalidad[$datos[$i][3]];
            }
        }

        return $datos;
    }

    /**
     * Funciones de acceso a BD
     */
    function obtenerCatalogoCompuestosCalidad() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre   
                FROM catalogo_pozo_monitor_calidad_compuesto        
                WHERE activo=1 
                ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);

        $res = [];
        foreach ($datos as $value) {
            $res[$value[nombre]] = $value[itemId];
        }

        return $res;
    }

    function prepararArregloFechaHoraDatosCantidad($datos) {
        $arregloBusqueda = array();
        foreach($datos as $key => $value) {
            if ($value[1] != null && $value[2] != null) {
                $arregloBusqueda[] = '\''.$value[1].' '.$value[2].'\'';
            }
        }

        return $arregloBusqueda;
    }

    function validarExistenciaDatosMonitoreoCantidad($fichaId, $datos) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT count(*) AS cantidad
                FROM item_pozo_monitor
                WHERE pozoId=".$fichaId."
                AND CONCAT(fecha,' ',hora) IN (".implode(',', $this->prepararArregloFechaHoraDatosCantidad($datos)).")";

        $datos = $this->dbm->Execute($sql);

        return $datos->fields['cantidad'];
    }

    function guardarDatosMonitoreoCantidad($datos) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();

        foreach ($datos as $key => $value) {
            //if ($value[1] == "" || $value[1] == "NULL")  { $value[1] = "NULL"; }
            if ($value[2] == "" || $value[2] == "NULL")  { $value[2] = "NULL"; }
            if ($value[3] == "" || $value[3] == "NULL")  { $value[3] = "NULL"; }
            //if ($value[4] == "" || $value[4] == "NULL")  { $value[4] = "NULL"; }
            if ($value[5] == "" || $value[5] == "NULL")  { $value[5] = "NULL"; }
            if ($value[6] == "" || $value[6] == "NULL")  { $value[6] = "NULL"; }
            if ($value[7] == "" || $value[7] == "NULL")  { $value[7] = "NULL"; }
            if ($value[8] == "" || $value[8] == "NULL")  { $value[8] = "NULL"; }
            //if ($value[9] == "" || $value[9] == "NULL")  { $value[9] = "NULL"; }
            //if ($value[10] == "" || $value[10] == "NULL")  { $value[10] = "NULL"; }
            //if ($value[11] == "" || $value[11] == "NULL")  { $value[11] = "NULL"; }
            $sql = "INSERT INTO item_pozo_monitor (pozoId, fecha, hora, epocaId, puntoreferencia, elevacion, nivel_freatico, nivel_dinamico, 
            nivel_estatico, caudal, caudalautorizado, observaciones, dateCreate, dateUpdate, userCreate, userUpdate) 
                VALUES (".$value[0].", '".$value[1]."', '".$value[2]."', ".$value[3].", '".$value[4]."', ".$value[5].", ".$value[6].", ".$value[7].", ".$value[8].", '".$value[9]."', '".$value[10]."', '".$value[11]."', '".$value[12]."', '".$value[13]."', ".$value[14].", ".$value[15].")";

            if (!$this->dbm->Execute($sql)) {
                $err = $this->dbm->ErrorMsg();
                $this->dbm->RollbackTrans();
                trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            } else {
                $cont++;
            }
        } 

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        return array("estado"=>true, "filasafectadas"=>$cont);
    }

    function prepararArregloFechaHoraDatosCalidad($datos) {
        $arregloBusqueda = array();
        foreach($datos as $key => $value) {
            if ($value[1] != null) {
                $arregloBusqueda[] = '\''.$value[1].'\'';
            }
        }

        return $arregloBusqueda;
    }

    function validarExistenciaDatosMonitoreoCalidad($fichaId, $datos) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT count(*) AS cantidad
                FROM item_pozo_monitor_calidad
                WHERE pozoId=".$fichaId."
                AND CONCAT(fecha_muestreo) IN (".implode(',', $this->prepararArregloFechaHoraDatosCalidad($datos)).")";

        $datos = $this->dbm->Execute($sql);

        return $datos->fields['cantidad'];
    }

    function guardarDatosMonitoreoCalidad($datos, $datosCompuestos, $idsMuestra, $catalogoCompuestosCalidad) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $contador = 0;
        $contadorCompuestos = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans();

        // Guarda datos de calidad
        foreach ($datos as $key => $value) {
            //if ($value[1] == "" || $value[1] == "NULL")  { $value[1] = "NULL"; }
            if ($value[2] == "" || $value[2] == "NULL")  { $value[2] = "NULL"; }
            if ($value[3] == "" || $value[3] == "NULL")  { $value[3] = "NULL"; }
            //if ($value[4] == "" || $value[4] == "NULL")  { $value[4] = "NULL"; }
            //if ($value[5] == "" || $value[5] == "NULL")  { $value[5] = "NULL"; }
            if ($value[6] == "" || $value[6] == "NULL")  { $value[6] = "NULL"; }
            if ($value[7] == "" || $value[7] == "NULL")  { $value[7] = "NULL"; }
            //if ($value[8] == "" || $value[8] == "NULL")  { $value[8] = "NULL"; }
            //if ($value[9] == "" || $value[9] == "NULL")  { $value[9] = "NULL"; }
            if ($value[10] == "" || $value[10] == "NULL")  { $value[10] = "NULL"; }
            //if ($value[11] == "" || $value[11] == "NULL")  { $value[11] = "NULL"; }
            $sql = "INSERT INTO item_pozo_monitor_calidad (pozoId, fecha_muestreo, hora_muestreo, epocaId, entidad, codigo_muestra, 
            fecha_analisis, hora_analisis, nombre_laboratorio, codigo_laboratorio, profundidad, observaciones, dateCreate, dateUpdate, userCreate, userUpdate) 
                VALUES (".$value[0].", '".$value[1]."', '".$value[2]."', ".$value[3].", '".$value[4]."', '".$value[5]."', '".$value[6]."', '".$value[7]."', '".$value[8]."', '".$value[9]."', ".$value[10].", '".$value[11]."', '".$value[12]."', '".$value[13]."', ".$value[14].", ".$value[15].")";

            if (!$this->dbm->Execute($sql)) {
                $err = $this->dbm->ErrorMsg();
                $this->dbm->RollbackTrans();
                trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            } else {
                $idsMuestra[$key] = $this->dbm->insert_Id();
                $contador++;
            }
        }

        // Transforma datos de compuestos de calidad
        $datosCompuestosTransformado = $this->transformarDatosCompuestosMonitoreoCalidad($datosCompuestos, $idsMuestra, $catalogoCompuestosCalidad);

        // Guarda datos de compuestos de calidad
        foreach ($datosCompuestosTransformado as $key => $value) {
            //if ($value[1] == "" || $value[1] == "NULL")  { $value[1] = "NULL"; }
            //if ($value[2] == "" || $value[2] == "NULL")  { $value[2] = "NULL"; }
            if ($value[3] == "" || $value[3] == "NULL")  { $value[3] = "NULL"; }
            //if ($value[4] == "" || $value[4] == "NULL")  { $value[4] = "NULL"; }
            //if ($value[5] == "" || $value[5] == "NULL")  { $value[5] = "NULL"; }
            $sql = "INSERT INTO item_pozo_monitor_calidad_dato (calidadId, parametroId, compuestoId, valor, observaciones, dateCreate, dateUpdate, userCreate, userUpdate) 
                VALUES (".$value[1].", ".$value[2].", ".$value[3].", ".$value[4].", '".$value[5]."', '".$value[6]."', '".$value[7]."', ".$value[8].", ".$value[9].")";

            if (!$this->dbm->Execute($sql)) {
                $err = $this->dbm->ErrorMsg();
                $this->dbm->RollbackTrans();
                trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            } else {
                $contadorCompuestos++;
            }
        } 

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        return array(
            "estado" => true,
            "filasafectadas" => $contador,
            "filasAfectadasCompuestos" => $contadorCompuestos
        );
    }

}