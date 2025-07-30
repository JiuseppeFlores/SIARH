<?php
class Snippet extends Table
{
    var $item_form;
    function __construct()
    {
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
    /**
     * Function que actualiza la informacion de datos de un registro
     * $respuesta = $subObjItem->item_update($item,$itemId,0);
     * $rec = arreglo de datos que llega del formulario
     * $itemId= el id del reguistro que quiero actualizar
     * $que_form = El formulario dentro que quiero actualizar, "Es el mismo nombre del grupo de campos que quiero validar"
     * $accion = new, update ,  solo existen 2 acciones
     *
     **/
    function item_update($rec, $itemId, $que_form, $accion, $mitabla) {
        global $privFace;
        /**
         * preprocesamos los datos
         */
        $respuesta_procesa = $this->procesa_datos($que_form,$rec,$accion);
        /**
         * Guardo los datos ya procesados
         */
        $campo_id="itemId";
        $res = $this->item_update_sbm($itemId,$respuesta_procesa,$this->tabla[$mitabla],$accion,$campo_id);

        $res["accion"] = $accion;

        return $res;
    }

    /**
     * Funcion que valida los campos a ser guardados
     **/
    function procesa_datos($que_form, $rec, $accion="new") {
        $dato_resultado = array();
        switch($que_form) {
            case 'campos_prueba':
                /**
                 * $rec = es el arreglo de datos que proviene del formulario, desde el frontend
                 * $$this->item_form = es el arreglo de configuraciòn de datos que se procesaran
                 * $accion = new, update
                 */
                $dato_resultado = $this->procesa_campos_sbm($rec, $this->campos[$que_form], $accion);
                /**
                 * Si es nuevo el registro, haré que el ID sea igual a la gestion_id
                 */
                /**
                 * Procesos Adicionales al momento de guardar los datos
                 */
                break;

            /*case 'campos_sev_config':
                $dato_resultado = $this->procesa_campos_sbm($rec, $this->campos[$que_form], $accion);
                break;*/

            case 'campos_tipo':
                $dato_resultado = $this->procesa_campos_sbm($rec, $this->campos[$que_form], $accion);
                break;

            case 'campos_escalon':
                $dato_resultado = $this->procesa_campos_sbm($rec, $this->campos[$que_form], $accion);
                break;

            case 'campos_recuperacion':
                $dato_resultado = $this->procesa_campos_sbm($rec, $this->campos[$que_form], $accion);
                break;

            case 'campos_recuperacion_escalon':
                $dato_resultado = $this->procesa_campos_sbm($rec, $this->campos[$que_form], $accion);
                break;

            case 'campos_observacion':
                $dato_resultado = $this->procesa_campos_sbm($rec, $this->campos[$que_form], $accion);
                break;

            case 'campos_observacion_escalon':
                $dato_resultado = $this->procesa_campos_sbm($rec, $this->campos[$que_form], $accion);
                break;

            case 'campos_recupera_observa':
                $dato_resultado = $this->procesa_campos_sbm($rec, $this->campos[$que_form], $accion);
                break;

            case 'campos_recupera_observa_escalon':
                $dato_resultado = $this->procesa_campos_sbm($rec, $this->campos[$que_form], $accion);
                break;
            
            case 'otros_formularios':
                break;
        }
        return $dato_resultado;
    }

    function get_item($idItem, $tipoTabla, $variante="") {
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

    public function get_item_datatable_Rows($miTabla, $miGrilla, $mifiltro) {
        global $db_conf_datatable;
        /**
         * tabla de la base de datos que listaremos
         */
        //$table = $this->tabla["geofisica"];
        $table = $this->tabla[$miTabla];
        /**
         * El nombre del campo que guarda id principal
         */
        $primaryKey = 'itemId';
        /**
         * Que configuraciòn de grilla utilizaremos
         */
        //$grilla = "grilla_sev";
        $grilla = $miGrilla;
        /**
         * la configuración de base de datos que utilizaremos
         * que se la realiza en inc/db.php
         */
        $db = $db_conf_datatable["principal"];
        /**
         * Configuraciones adicionales
         */
        $extraWhere = $mifiltro;
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
     * Borrar un registro de la base de datos
     */
    function item_delete($id, $mitabla) {
        $campo_id = "itemId";
        $res = $this->item_delete_sbm($id, $campo_id, $this->tabla[$mitabla]);
        return $res;
    }

    function tiempo_segundos($horas, $minutos, $segundos) {
        return ((int) $horas * 3600) + ((int) $minutos * 60) + ((int) $segundos);
    }

    function segundos_tiempo($segundos) {
        $tiempo = array();
        $tiempo['horas'] = floor($segundos / 3600);
        $tiempo['minutos'] = floor(($segundos - ($tiempo['horas'] * 3600)) / 60);
        $tiempo['segundos'] = $segundos - ($tiempo['horas'] * 3600) - ($tiempo['minutos'] * 60);
        return $tiempo;
    }        

    function get_datos_escalon($pozoId, $tipoId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        // $sql = "SELECT a.nombre, c.tipo, c.nivel_estatico, d.tiempo, d.nivel_dinamico, d.etapa 
        // FROM item a, item_pozo_hidra b, item_pozo_hidra_bombeo c, item_pozo_hidra_bombeo_dato d 
        // WHERE a.itemId=b.pozoId AND b.itemId=c.pruebabombeoId AND c.itemId=d.tipobombeoId AND d.tipobombeoId = $pozoId 
        // ORDER BY d.itemId ASC";

        $sql = "SELECT a.nombre, 
                        c.tipo, c.nivel_estatico, 
                        d.tiempo, d.nivel_dinamico, d.etapa  
                FROM item a, item_pozo_hidra b, item_pozo_hidra_bombeo c, item_pozo_hidra_bombeo_dato d 
                WHERE a.itemId=b.pozoId 
                    AND b.itemId=c.pruebabombeoId 
                    AND c.itemId=d.tipobombeoId 
                    AND a.itemId=$pozoId
                    AND c.tipo=$tipoId
                ORDER BY d.etapa ASC, d.tiempo ASC";

        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }

    function get_datos_escalonrecuperacion($pozoId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        // $sql = "SELECT a.nombre, d.nivel_estatico, e.tiempo, e.nivel_dinamico   
        // FROM item a, item_pozo_hidra b, item_pozo_hidra_bombeo c, item_pozo_hidra_recuperacion d, item_pozo_hidra_recuperacion_dato e 
        // WHERE a.itemId=b.pozoId AND b.itemId=c.pruebabombeoId AND c.itemId=d.tipobombeoId AND d.itemId=e.recuperacionId 
        // AND e.recuperacionId=$pozoId 
        // ORDER BY e.itemId ASC";

        $sql = "SELECT a.nombre, d.nivel_estatico, e.tiempo, e.nivel_dinamico   
        FROM item a, item_pozo_hidra b, item_pozo_hidra_bombeo c, item_pozo_hidra_recuperacion d, item_pozo_hidra_recuperacion_dato e 
        WHERE a.itemId=b.pozoId AND b.itemId=c.pruebabombeoId AND c.itemId=d.tipobombeoId AND d.itemId=e.recuperacionId 
        AND a.itemId= ".$pozoId." 
        ORDER BY e.itemId ASC";

        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }
}