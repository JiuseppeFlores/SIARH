<?php
// Inclusión librería gpoint para convertir coordenadas
require_once ('lib/gpoint/Class.GeoConversao.php');
require_once ('lib/gpoint/gPoint.php');

class Snippet extends Table {

    var $item_form;
    function __construct() {
        /**
         * Inicializamos todas las librerias y variables para el submodulo
         */
        $this->submodule_init_sbm();

    }
    
    /**
     * Function que actualiza la informacion de datos de un registro
     * $respuesta = $subObjItem->item_update($item,$itemId,0);
     * $rec = arreglo de datos que llega del formulario
     * $itemId= el id del reguistro que quiero actualizar
     * $que_form = El formulario dentro que quiero actualizar, "Es el mismo nombre del grupo de campos que quiero validar"
     * $accion = new, update ,  solo existen 2 acciones
     *
     **/
    function item_update($rec,$itemId,$que_form,$accion){
        global $privFace;
        /**
         * preprocesamos los datos
         */
        $respuesta_procesa = $this->procesa_datos($que_form,$rec,$accion);
        /**
         * Guardo los datos ya procesados
         */
        $campo_id="itemId";

        // var_dump('ver::',$rec,'-4',$respuesta_procesa,'-5',$campo_id);
        $res = $this->item_update_sbm($itemId,$respuesta_procesa,$this->tabla["item"],$accion,$campo_id);

        $res["accion"] = $accion;

        return $res;
    }

    function item_update_pg($rec, $itemId, $que_form, $accion) {
        global $privFace;
        /**
         * preprocesamos los datos
         */
        $respuesta_procesa = $this->procesa_datos($que_form, $rec, $accion);

        /**
         * Guardo los datos ya procesados
         */
        $campo_id = "itemid";
        $tabla = $this->tabla["item"];
        $res = $this->item_update_sbm_pg($itemId, $respuesta_procesa, $tabla, $accion, $campo_id);
        $res["accion"] = $accion;

        return $res;
    }

    /**
     * Abre conexión con el servidor PostgreSQL
     **/
    function abrir_conexion_pg() {
        global $db_conf;
        $this->dbm = ADONewConnection($db_conf["type"]);
        $this->dbm->Connect($db_conf["server"],$db_conf["user"] ,$db_conf["password"],$db_conf["database"]) or die("ERROR CONNECT " . $db_conf["database"]);
        $this->dbm->setCharset('utf8');
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
    }

    /**
     * Cierra conexión con el servidor PostgreSQL
     **/
    function cerrar_conexion_pg() {
        $this->dbm->Close();
    }

    /**
     * Consulta actualización campo geom
     */
    function item_update_geom($itemid) {
        global $db_conf;
        $dbm = ADONewConnection($db_conf["type"]);
        $dbm->Connect($db_conf["server"],$db_conf["user"] ,$db_conf["password"],$db_conf["database"]) or die("ERROR CONNECT " . $db_conf["database"]);
        $dbm->setCharset('utf8');
        $dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "UPDATE item 
        SET geom = st_geometryfromtext('POINT('|| longituddec ||' '||latituddec ||')',4326)
        WHERE itemid=".$itemid;
        $dbm->Execute($sql);
        $filas = $dbm->affected_rows();
        $dbm->Close();
        if ($filas == 1) {
            $datos = array(
                "res" => 1,
                "id" => $itemid,
                "accion" => "update"
            );
        } else {
            $datos = array(
                "res" => 2,
                "id" => $itemid,
                "accion" => "update"
            );
        }
        return $datos;
    }

    /**
     * Funcion que valida los campos a ser guardados
     **/
    function procesa_datos($que_form,$rec,$accion="new"){
        $dato_resultado = array();
        switch($que_form){
            case 'item':
                /**
                 * $rec = es el arreglo de datos que proviene del formulario, desde el frontend
                 * $$this->item_form = es el arreglo de configuraciòn de datos que se procesaran
                 * $accion = new, update
                 */
                $dato_resultado = $this->procesa_campos_sbm($rec,$this->campos[$que_form],$accion);
                /**
                 * Si es nuevo el registro, haré que el ID sea igual a la gestion_id
                 */
                if ($accion=="new"){
                    $dato_resultado["tipo"]=5; // de tipo pozo
                }

                /**
                 * Procesos Adicionales al momento de guardar los datos
                 */
                break;

            case 'item_pg':
                /**
                 * $rec = es el arreglo de datos que proviene del formulario, desde el frontend
                 * $$this->item_form = es el arreglo de configuraciòn de datos que se procesaran
                 * $accion = new, update
                 */
                $dato_resultado = $this->procesa_campos_sbm($rec,$this->campos[$que_form],$accion);
                /**
                 * Si es nuevo el registro, haré que el ID sea igual a la gestion_id
                 */
                if ($accion=="new"){
                    $dato_resultado["tipo"]=5; // de tipo pozo
                }

                /**
                 * Procesos Adicionales al momento de guardar los datos
                 */
                break;

            case 'otros_formularios':
                break;
        }
        return $dato_resultado;
    }

    function get_provincia($deptoId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT
        itemId,
        nombre 
        FROM ".$this->tabla["o_provincia"]." 
        WHERE departamentoId=".$deptoId." 
        AND activo=1 
        ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }

    function get_municipio($provinciaId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT
        itemId,
        nombre 
        FROM ".$this->tabla["o_municipio"]." 
        WHERE provinciaId=".$provinciaId." 
        AND activo=1 
        ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }

    function get_comunidad($municipioId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT
        itemId,
        nombre 
        FROM ".$this->tabla["o_comunidad"]." 
        WHERE municipioId=".$municipioId."
        ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }

    function get_localidad($comunidadId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT
        itemId,
        nombre 
        FROM ".$this->tabla["o_localidad"]." 
        WHERE comunidadId=".$comunidadId."
        ORDER BY itemId ASC";

        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
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
        global $dbm_siasbo, $db_conf;
        $dbm_siasbo = ADONewConnection($db_conf["type"]);
        $dbm_siasbo->Connect($db_conf["server"],$db_conf["user"] ,$db_conf["password"],$db_conf["database"]) or die("ERROR CONNECT " . $db_conf["database"]);
        $dbm_siasbo->setCharset('utf8');
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
        $dbm_siasbo->Close();
        return $datos;
    }

    // Obtiene el ID de macrocuenca de la BD sirh_siasbo de postgresql
    function get_ubicacion_macrocuenca($latitudDecimal, $longitudDecimal){
        global $dbm_siasbo, $db_conf;
        $dbm_siasbo = ADONewConnection($db_conf["type"]);
        $dbm_siasbo->Connect($db_conf["server"],$db_conf["user"] ,$db_conf["password"],$db_conf["database"]) or die("ERROR CONNECT " . $db_conf["database"]);
        $dbm_siasbo->setCharset('utf8');
        $dbm_siasbo->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT id AS macroid
        FROM macrocuencas 
        WHERE  
        ST_Contains(geom, ST_GeomFromText(CONCAT('POINT(', ".$longitudDecimal.", ' ', ".$latitudDecimal.", ')'),4326)) 
        LIMIT 1";
        $datos = $dbm_siasbo->Execute($sql);
        $datos = $datos->GetRows();
        $dbm_siasbo->Close();
        return $datos;
    }

    // Obtiene el ID de cuenca estrategica de la BD sirh_siasbo de postgresql
    function get_ubicacion_cuenca_estrategica($latitudDecimal, $longitudDecimal){
        global $dbm_siasbo, $db_conf;
        $dbm_siasbo = ADONewConnection($db_conf["type"]);
        $dbm_siasbo->Connect($db_conf["server"],$db_conf["user"] ,$db_conf["password"],$db_conf["database"]) or die("ERROR CONNECT " . $db_conf["database"]);
        $dbm_siasbo->setCharset('utf8');
        $dbm_siasbo->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT id AS cuencaestraid
        FROM cuenca_estra_25 
        WHERE  
        ST_Contains(geom, ST_GeomFromText(CONCAT('POINT(', ".$longitudDecimal.", ' ', ".$latitudDecimal.", ')'),4326)) 
        LIMIT 1";
        $datos = $dbm_siasbo->Execute($sql);
        $datos = $datos->GetRows();
        $dbm_siasbo->Close();
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

    // Obtiene código PFAFS de macrocuenca
    function get_codigo_macrocuenca($macrocuencaId){
        global $dbm_siasbo, $db_conf;
        $dbm_siasbo = ADONewConnection($db_conf["type"]);
        $dbm_siasbo->Connect($db_conf["server"],$db_conf["user"] ,$db_conf["password"],$db_conf["database"]) or die("ERROR CONNECT " . $db_conf["database"]);
        $dbm_siasbo->setCharset('utf8');
        $dbm_siasbo->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = 'SELECT id, "COD_PFAFS" AS codigo_pfafs 
        FROM macrocuencas 
        WHERE id='.$macrocuencaId.' 
        LIMIT 1';
        $datos = $dbm_siasbo->Execute($sql);
        $datos = $datos->GetRows();
        $dbm_siasbo->Close();
        return $datos;
    }

    // Obtiene ultima inserción en item
    function get_ultimo_codigo(){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, codigo 
        FROM item 
        WHERE tipo=5
        ORDER BY itemId DESC 
        LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    // Genera código personalizado para tabla item (campo codigo)
    function get_nuevo_codigo($deptoId, $codigo_macrocuenca){
        $deptoId = (int) $deptoId;
        $codigo_ine = $this->get_codigo_ine_departamento($deptoId);
        $cod_macrocuenca = (int) $codigo_macrocuenca;
        $codigo_macrocuenca = $this->get_codigo_macrocuenca($cod_macrocuenca);

        //$nuevo_codigo = $codigo_ine[0]['codigo_ine'].'-'.$codigo_macrocuenca[0]['codigo_pfafs'].'-P-';
        $nuevo_codigo = $codigo_macrocuenca[0]['codigo_pfafs'].'-'.$codigo_ine[0]['codigo_ine'].'-R-';
        $ultimoCodigo = $this->get_ultimo_codigo();
        $correlativo = 0;
        if (empty($ultimoCodigo)) {
            $correlativo = 1;
        } else {
            $aux = explode('-', $ultimoCodigo[0]['codigo']);
            $correlativo = (int) $aux[3] + 1;
        }
        $nuevo_codigo .= $correlativo;

        return $nuevo_codigo;
    }

    //Cambia el estado de un registro pozo
    function set_observado($pozoId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "UPDATE item SET estado='Observado'
        WHERE itemId=".$pozoId;

        $datos = $this->dbm->Execute($sql);
        //$datos = $datos->GetRows();

        return $datos;
    }

    function set_revisado($pozoId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "UPDATE item SET estado='Revisado'
        WHERE itemId=".$pozoId;

        $datos = $this->dbm->Execute($sql);
        //$datos = $datos->GetRows();

        return $datos;
    }

    function set_registrado($pozoId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "UPDATE item SET estado='Registrado'
        WHERE itemId=".$pozoId;

        $datos = $this->dbm->Execute($sql);
        //$datos = $datos->GetRows();

        return $datos;
    }

    function obtener_estado($pozoId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT estado 
        FROM item 
        WHERE itemId='".$pozoId."'";

        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }
}