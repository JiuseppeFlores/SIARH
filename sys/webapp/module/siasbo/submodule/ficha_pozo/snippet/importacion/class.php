<?php
class Snippet extends Table
{
    function __construct() {
        /**
         * Inicializamos todas las librerias y variables para el submodulo
         */
        $this->submodule_init_sbm();
    }
    /**
     * Implementación desde aca
     */

    public function get_item_datatable_Rows($pozoId) {
        global $db_conf_datatable;
        /**
         * tabla de la base de datos que listaremos
         */
        $table = $this->tabla["archivo_adjunto"];
        /**
         * El nombre del campo que guarda id principal
         */
        $primaryKey = 'itemId';
        /**
         * Que configuraciòn de grilla utilizaremos
         */
        $grilla = "grilla_archivo";
        /**
         * la configuración de base de datos que utilizaremos
         * que se la realiza en inc/db.php
         */
        $db=$db_conf_datatable["principal"];
        /**
         * Configuraciones adicionales
         */
        $extraWhere = "fichaId=".$pozoId;
        $groupBy = "";
        $having = "";
        /**
         * Resultado de la consulta enviada
         */
        $resultado = $this->get_grilla_datatable_simple($db, $grilla, $table, $primaryKey, $extraWhere, $groupBy, $having);
        /**
         * apartir de aca podemos transformar datos, de acuerdo a requerimiento
         */
        return $resultado;

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
    function item_update($rec, $itemId, $que_form, $accion, $item_id, $archivo_adjunto) {
        $tabla = $this->tabla["archivo_adjunto"];
        /**
         * preprocesamos los datos
         */
        $respuesta_procesa = $this->procesa_datos($que_form, $rec, $accion, $item_id);
        /**
         * Guardo los datos ya procesados
         */
        $campo_id="itemId";
        $where = "";
        $res = $this->item_update_sbm($itemId, $respuesta_procesa, $tabla, $accion, $campo_id, $where);
        $res["accion"] = $accion;
        /**
         * Procesamos el archivo
         */
        if( $res["res"]==1){
            $item = $this->get_item($res["id"], $tabla);
            $adjunto = $this->item_adjunto_sbm($archivo_adjunto, $item_id, $res["id"], $item, $tabla, $accion, 'fichaId');
            //print_r($adjunto);
        }
        return $res;
        //return $res;
    }

    /**
     * Funcion que valida los campos a ser guardados
     **/
    function procesa_datos($que_form, $rec, $accion="new", $item_id) {
        $dato_resultado = array();
        switch($que_form){
            case 'campos_archivo':
                /**
                 * $rec = es el arreglo de datos que proviene del formulario, desde el frontend
                 * $$this->item_form = es el arreglo de configuraciòn de datos que se procesaran
                 * $accion = new, update
                 */
                $dato_resultado = $this->procesa_campos_sbm($rec, $this->campos[$que_form], $accion);
                /**
                 * Procesos Adicionales al momento de guardar los datos
                 */
                $dato_resultado["item_id"] = $item_id;
                break;
            case 'otros_formularios':
                break;
        }
        return $dato_resultado;
    }

    /**
     * Funcion que recupera un registro de la tabla archivos adjuntos
     **/
    function get_item($id) {
        $sql = "SELECT * FROM ".$this->tabla["archivo_adjunto"]." WHERE itemId = ".$id;
        $item = $this->dbm->Execute($sql);
        $item = $item->fields;
        return $item;
    }

    /**
     * Funcion que recupera un archivo y lo envia para descarga
     **/
    function get_file($id, $item_id) {
        $item = $this->get_item($id, $item_id);

        if($item["itemId"] != "") {
            $dir  = $this->get_dir_item_archivo_sbm($item_id);
            $archivo = $dir.$id.".".$item["adjunto_extension"];
            header ("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
            header ("Last-Modified: " . gmdate("D,d M YH:i:s") . " GMT");
            header ("Cache-Control: no-cache, must-revalidate");
            header ("Pragma: no-cache");
            header ("Content-Type:".$item["adjunto_tipo"]);
            header ('Content-Disposition: attachment; filename="'.$item["adjunto_nombre"].'"');
            header ("Content-Length: " . $item["adjunto_tamano"]);
            readfile($archivo);
            exit;
        } else {
            echo "<center><b><font color='red' face='arial'>El archivo no existe.</font></b></center>";
            exit;
        }
    }

    /**
     * Borrar un registro de la base de datos
     */
    function item_delete($id, $item_id) {
        /**
         * borramos el archivo primero
         */
        $this->item_delete_archivo_sbm($id, $item_id);
        /**
         * Luego borramos el registro de la base de datos
         */
        $campo_id="itemId";
        $where = "";
        $res = $this->item_delete_sbm($id, $campo_id, $this->tabla["archivo_adjunto"], $where);

        return $res;
    }


    //Funciones para la importacion de datos desde Excel
    function verificarConfiguracion($contenedor){
        $nombrehoja = ["GENERAL", "ESPECIFICO", "PERFORACION", "CONSTRUCTIVOS", "CONSTRUCTIVOS_DISEÑO",
                       "COLUMNA_LITOLOGICA", "PERFILAJE_ELECTRICO", "IMPLEMENTACION", "MONITOREO_CANTIDAD",
                       "MONITOREO_CALIDAD", "MONITOREO_ISOTOPICO"];
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

    // function agregarDatosGenerales($datos){
    //     $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

    //     //$ides = [];
    //     $cont = 0;
    //     $this->dbm->autoCommit = false;
    //     $this->dbm->SetTransactionMode("SERIALIZABLE");
    //     $this->dbm->BeginTrans(); 
    //     $sql = $this->dbm->Prepare("INSERT INTO prueba (nombre, paterno, materno, telefono, email) VALUES (?, ?, ?, ?, ?)");
    //     foreach($datos as $key => $value){
    //         if(!$this->dbm->Execute($sql, $value)) {
    //           $err = $this->dbm->ErrorMsg();
    //           $this->dbm->RollbackTrans();
    //           $_SESSION['codigos'] = NULL;
    //           trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
    //         }
    //         //$ides[] = array($value[1]=>$this->dbm->Insert_ID());
    //         //$_SESSION['codigos'][]= array($value[1]=>$this->dbm->Insert_ID());
    //         $_SESSION['codigos'][$value[1]]= $this->dbm->Insert_ID();
    //         $cont++;
    //     }

    //     $this->dbm->CommitTrans();
    //     $this->dbm->autoCommit = true;
    //     //return true;
    //     return array("res"=>true, "filasafectadas"=>$cont);
    //     //return $_SESSION['codigos']; //$ides;
    // }

    // function agregarDatosEspecificos($datos){
    //     $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

    //     //$ides = [];
    //     $cont = 0;
    //     $this->dbm->autoCommit = false;
    //     $this->dbm->SetTransactionMode("SERIALIZABLE");
    //     $this->dbm->BeginTrans(); 
    //     $sql = $this->dbm->Prepare("INSERT INTO pruebaespecifico (nombre, paterno, materno, telefono) VALUES (?, ?, ?, ?)");
    //     foreach($datos as $key => $value){
    //         if(!$this->dbm->Execute($sql, $value)) {
    //           $err = $this->dbm->ErrorMsg();
    //           $this->dbm->RollbackTrans();
    //           $_SESSION['codigos'] = NULL;
    //           trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
    //         }
    //         //$ides[] = array($value[1]=>$this->dbm->Insert_ID());
    //         //$_SESSION['codigos'][]= array($value[1]=>$this->dbm->Insert_ID());
    //         //$_SESSION['codigos'][$value[1]]= $this->dbm->Insert_ID();
    //         $cont++;
    //     }

    //     $this->dbm->CommitTrans();
    //     $this->dbm->autoCommit = true;
    //     //return true;
    //     return array("res"=>true, "filasafectadas"=>$cont);
    //     //return $_SESSION['codigos']; //$ides;
    // }

    function agregarGeneral($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans(); 
        $sql = $this->dbm->Prepare("INSERT INTO item (tipo, codigo, nombre, latitud, latitudDec, 
                                                      longitud, longitudDec, latitudUtm, longitudUtm, 
                                                      utmZona, altitud, departamentoId, provinciaId, municipioId, 
                                                      comunidadId, localidadId, comunidad, localidad, descripcion,
                                                      acuiferoId, epsasId, epsasnoregularizadas, cooperativas, cuencaId,
                                                      dateCreate, dateUpdate, userCreate, userUpdate) 
                                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        foreach($datos as $key => $value){
            if(!$this->dbm->Execute($sql, $value)) {
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              $_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }

            $_SESSION['codigos'][$value[28]]= $this->dbm->Insert_ID();
            $cont++;
        }

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;

        //return array("res"=>true, "filasafectadas"=>$cont);
        return $_SESSION['codigos'];
    }

    function agregarEspecifico($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $cont = 0;
        $this->dbm->autoCommit = false;
        $this->dbm->SetTransactionMode("SERIALIZABLE");
        $this->dbm->BeginTrans(); 
        $sql = $this->dbm->Prepare("INSERT INTO item_pozo (itemId, fuente_informacion, codigo, usoaguaId, 
                                                           propositoId, propietario, observaciones) 
                                    VALUES (?, ?, ?, ?, ?, ?, ?)");
        //$sql = $this->dbm->Prepare("UPDATE item_pozo SET itemId=?, fuente_informacion=?, codigo=?, usoaguaId=?, propositoId=?, propietario=?, observaciones=?");
        foreach($datos as $key => $value){
            if(!$this->dbm->Execute($sql, $value)) {
              $err = $this->dbm->ErrorMsg();
              $this->dbm->RollbackTrans();
              $_SESSION['codigos'] = NULL;
              trigger_error('Consulta incorrecta: ' . $sql . ' Error: ' . $err . '<br>', E_USER_ERROR);
            }

            $cont++;
        }

        $this->dbm->CommitTrans();
        $this->dbm->autoCommit = true;
        return array("res"=>true, "filasafectadas"=>$cont);
    }
}