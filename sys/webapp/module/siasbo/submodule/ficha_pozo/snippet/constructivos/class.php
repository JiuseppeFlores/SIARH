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
    function procesa_datos($que_form, $rec, $accion="new"){
        $dato_resultado = array();
        switch($que_form){
            case 'campos_constructivo':
                /**
                 * $rec = es el arreglo de datos que proviene del formulario, desde el frontend
                 * $$this->item_form = es el arreglo de configuraciòn de datos que se procesaran
                 * $accion = new, update
                 */
                $dato_resultado = $this->procesa_campos_sbm($rec,$this->campos[$que_form],$accion);
                /**
                 * Si es nuevo el registro, haré que el ID sea igual a la gestion_id
                 */
                
                /**
                 * Procesos Adicionales al momento de guardar los datos
                 */
                break;

            case 'campos_diseno':
                $dato_resultado = $this->procesa_campos_sbm($rec,$this->campos[$que_form],$accion);
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

    function get_datos_pozo($pozoId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT
        a.itemId,
        a.nombre,
        a.codigo,
        b.perforacion_pozoId AS tipo,
        b.perforacion_profundidad AS profundidad
        FROM ".$this->tabla["item"]." a, ".$this->tabla["pozo"]." b
        WHERE a.itemId = b.itemId AND a.itemId=".$pozoId."
        LIMIT 1";

        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }

    function get_datos_diseno($pozoId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT
        itemId,
        profundidad_desde AS desde,
        profundidad_hasta AS hasta
        FROM ".$this->tabla["constructivo_diseno"]." 
        WHERE pozoId=".$pozoId."
        ORDER BY desde, hasta ASC";

        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }

    function get_verificar_registros_iguales($pozoId, $desde, $hasta){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT  
        profundidad_hasta AS profundidad
        FROM item_pozo_constructivo_diseno 
        WHERE pozoId=".$pozoId." 
        AND profundidad_desde=".$desde." 
        AND profundidad_hasta=".$hasta." 
        LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_verificar_registros_desde_hasta($pozoId, $desde, $hasta){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT  
        profundidad_desde, 
        profundidad_hasta
        FROM item_pozo_constructivo_diseno 
        WHERE pozoId=".$pozoId." 
        AND (profundidad_hasta=".$desde." 
        OR profundidad_hasta=".$hasta.")";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_verificar_profundidad_perforacion($pozoId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT 
        perforacion_profundidad AS profundidad 
        FROM item_pozo 
        WHERE itemId=".$pozoId." 
        LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

}