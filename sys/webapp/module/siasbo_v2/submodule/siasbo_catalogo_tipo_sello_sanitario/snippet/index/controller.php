<?php
/**
 * Created by PhpStorm.
 * User: henrytaby
 * Date: 3/5/2018
 * Time: 15:27
 */

/**
 * Modified by SublimeText 2.
 * User: Edwin Callisaya Bautista
 * Date: 01/07/2018
 * Time: 09:00
 */
require_once 'modelo_db.php';

switch($accion) {
    default:
        /**
         * Renderizar vista principal
         * 
         * $modeloEtiquetas: configuración de etiquetas definida en inc/inc.php
         * $modeloGrid: configuración de grilla definida en inc/grilla.php
         * $modeloTab: configuración de tabs definida en inc/tab.php
         * $modeloDatos: almacena datos de la consulta
         */
        $smarty->assign("modeloEtiquetas", $modeloEtiquetas);
        $modeloGrilla = $objItem->get_grilla_list_sbm("index");
        $smarty->assign("modeloGrilla", $modeloGrilla);
        $modeloTab = $objItem->get_item_tab_sbm($type, "index");
        $smarty->assign("modeloTab", $modeloTab);

        //$modeloDatos = $objItem->get_all_rows();
        //$smarty->assign("modeloDatos", json_encode($modeloDatos));
        $modeloDatos = new ModeloBD();
        $smarty->assign("modeloDatos", json_encode($modeloDatos->listarRegistros()));

        $smarty->assign("subpage", $webm["index"]);
        $smarty->assign("subpage_js", $webm["index_js"]);
        break;

    case 'list':
        /**
         * Listar registros de la BD
         * 
         * $modeloDatos: almacena datos de la consulta y
         * y se devuelve como un objeto json
         */
        //$modeloDatos = $objItem->get_all_rows();
        //$core->print_json($modeloDatos);
        $modeloDatos = new ModeloBD();
        $core->print_json($modeloDatos->listarRegistros());
        break;

    case 'delete':
        /**
         * Eliminar un registro de la BD
         * 
         * $modeloDatos: almacena datos de la consulta y
         * y se devuelve como un objeto json
         * $id: código del registro a eliminarse
         */
        //$modeloDatos = $objItem->delete_row($id);
        //$core->print_json($modeloDatos);
        $modeloDatos = new ModeloBD();
        $core->print_json($modeloDatos->eliminarRegistro($accion, $id));
        break;

    case 'create':
        /**
         * Crear un registro en la BD
         * 
         * $modeloDatos: almacena datos de la consulta y
         * y se devuelve como un objeto json
         * $datosForm: datos del formulario que se envia en la solicitud
         * $id: código del registro (para la creación no es necesario)
         * $modeloCampos: configuración de campos definida en inc/campos.php
         * $accion="new": acción que indica la inserción de un nuevo registro 
         */
        //$modeloDatos = $objItem->create_row($datosForm, "", $modeloCampos, "new");
        //$core->print_json($modeloDatos);
        $modeloDatos = new ModeloBD();
        $core->print_json($modeloDatos->crearRegistro($datosForm, $accion));
        break;

    case 'update':
        /**
         * Actualizar registro en la BD
         * 
         * $modeloDatos: almacena datos de la consulta y
         * y se devuelve como un objeto json
         * $datosForm: datos del formulario que se envia en la solicitud
         * $id: código del registro a actualizarse
         * $modeloCampos: configuración de campos definida en inc/campos.php
         * $accion="update": acción que indica la actualización del registro 
         */
        //$modeloDatos = $objItem->update_row($datosForm, $id, $modeloCampos, "update");
        //$core->print_json($modeloDatos);
        $modeloDatos = new ModeloBD();
        $core->print_json($modeloDatos->actualizarRegistro($datosForm, $accion, $id));
        break;

    case 'desactivar':
        /**
         * Actualizar campo estado='INACTIVO' del registro en la BD, 
         * 
         * $modeloDatos: almacena datos de la consulta y
         * y se devuelve como un objeto json
         * $id: código del registro a actualizarse
         * $accion="update": acción que indica la actualización del registro 
         */
        //$modeloDatos = $objItem->update_row($datosForm, $id, $modeloCampos, "update");
        //$core->print_json($modeloDatos);
        $modeloDatos = new ModeloBD();
        $core->print_json($modeloDatos->desactivarRegistro($accion, $id));
        break;
}