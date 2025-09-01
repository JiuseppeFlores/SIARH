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
        // var_dump("item_update",$itemId,$respuesta_procesa,$this->tabla["estado_operativo"],$accion,$campo_id);
        $res = $this->item_update_sbm($itemId,$respuesta_procesa,$this->tabla["estado_operativo"],$accion,$campo_id);

        $res["accion"] = $accion;

        return $res;
    }

    /**
     * Funcion que valida los campos a ser guardados
     **/
    function procesa_datos($que_form,$rec,$accion="new"){
        $dato_resultado = array();
        switch($que_form){
            case 'campos_seguimiento':
                /**
                 * $rec = es el arreglo de datos que proviene del formulario, desde el frontend
                 * $$this->item_form = es el arreglo de configuraciòn de datos que se procesaran
                 * $accion = new, update
                 */
                // var_dump("procesa_datos",$que_form,$this->campos,$rec,$accion);
                $dato_resultado = $this->procesa_campos_sbm($rec,$this->campos[$que_form],$accion);
                // var_dump("dato_resultado",$dato_resultado);
                /**
                 * Si es nuevo el registro, haré que el ID sea igual a la gestion_id
                 */
                // if ($accion=="new"){
                //     $dato_resultado["tipo"]=1; // de tipo pozo
                // }

                /**
                 * Procesos Adicionales al momento de guardar los datos
                 */

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

    public function get_item_datatable_Rows($id) { //, $mifiltro
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
        $grilla = "grilla_redes";  //"grilla_columna_seguimiento";
        /*
         * la configuración de base de datos que utilizaremos
         * que se la realiza en inc/db.php
         */
         
        $db=$db_conf_datatable["principal"];
        /**
         * Configuraciones adicionales
         */
        $extraWhere = "redMonitoreoId=".$id; //"manantialId=".$manantialId;
        $groupBy = "";
        $having = "";
        /**
         * Resultado de la consulta enviada
         */
        // var_dump("get_item_datatable_Rows",$db, $grilla, $table, $primaryKey, $extraWhere, $groupBy, $having);
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

    function item_delete_red($id) {
        // $campo_id = "itemId";
        // $res = $this->item_delete_sbm($id, $campo_id, $this->tabla[$mitabla]);
        $sql_update_red_item = "UPDATE item SET redMonitoreoId = NULL WHERE itemId = $id;";
        $datos = $this->dbm->Execute($sql_update_red_item);

        if ($datos) {
            // ✅ La consulta se ejecutó correctamente
            $filas_afectadas = $this->dbm->Affected_Rows();
            if ($filas_afectadas > 0) {
                $res['msm'] = "Actualización correcta, filas modificadas: " . $filas_afectadas;
                $res['res'] = 1;
            } else {
                $res['msm'] = "No se actualizó ninguna fila (puede que itemId no exista o ya estaba NULL).";
                $res['res'] = 2;
            }
        } else {
            // ❌ Hubo un error en la ejecución
            $res['msm'] = "Error en la actualización: " . $this->dbm->ErrorMsg();
            $res['res'] = 0;
        }

        return $res;
    }

    function get_datos_seguimiento($Id){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $sql = "SELECT a.nombre, b.estadoOperativo as idEstado, b.proveedorEnergia as idProveedor, b.numeroMedidor, b.indicadorGprs, b.fecha, b.hora, e.nombre as estadoOperativo, p.nombre as proveedorEnergia FROM item a, item_pozo_estado_operativo b, catalogo_pozo_estado_operativo e, catalogo_pozo_proveedor_energia p WHERE a.itemId=b.pozoId AND b.estadoOperativo=e.itemId AND b.proveedorEnergia=p.itemId AND b.pozoId = $Id ORDER BY b.fecha ASC, b.hora ASC";
        // echo $sql;
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }

}