<?php
/**
 * Created by PhpStorm.
 * User: henrytaby
 * Date: 3/5/2018
 * Time: 15:23
 */

/**
 * Modified by SublimeText 2.
 * User: Edwin Callisaya Bautista
 * Date: 01/07/2018
 * Time: 09:00
 */

class Index extends Table {

    function __construct() {
        $this->submodule_init_sbm();
    }

    public function get_all_rows() {
        global $db_conf_datatable;
        global $modeloTabla;

        $table = $this->tabla[$modeloTabla];
        $primaryKey = 'itemId';
        $grilla = "index";
        $db = $db_conf_datatable["principal"];
        $extraWhere = "";
        $groupBy = "";
        $having = "";
        $resultado = $this->get_grilla_datatable_simple($db, $grilla, $table, $primaryKey, $extraWhere, $groupBy, $having);
        return $resultado;
    }

    function delete_row($id) {
        global $modeloTabla;

        $campoId = "itemId";
        $resultado = $this->item_delete_sbm($id, $campoId, $this->tabla[$modeloTabla]);
        return $resultado;
    }

    function update_row($datosForm, $itemId, $modeloCampos, $accion) {
        global $modeloTabla;
        
        $campoId = "itemId";
        $resultado_validacion = array($this->procesa_campos_sbm($datosForm, $this->campos[$modeloCampos], $accion));
        $resultado = $this->item_update_sbm($itemId, $resultado_validacion, $this->tabla[$modeloTabla], $accion, $campoId);
        $resultado["accion"] = $accion;
        return $resultado;
    }

    function create_row($datosForm, $itemId, $modeloCampos, $accion) {
        global $modeloTabla;

        $campoId = "itemId";
        $resultado_validacion = array($this->procesa_campos_sbm($datosForm, $this->campos[$modeloCampos], $accion));
        $resultado = $this->item_update_sbm($itemId, $resultado_validacion, $this->tabla[$modeloTabla], $accion, $campoId);
        $resultado["accion"] = $accion;
        return $resultado;
    }

}