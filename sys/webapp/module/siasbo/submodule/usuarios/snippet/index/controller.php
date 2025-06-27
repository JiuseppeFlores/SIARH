<?php
/**
 * Created by PhpStorm.
 * User: henrytaby
 * Date: 3/5/2018
 * Time: 15:27
 */

switch($accion) {
    /**
     * Página por defecto
     */
    default:
        //print_struc($CFGm->tabla);
        //print_struc($_SESSION);
        //exit();

        //$grill_list = $objItem->get_grilla_list_sbm("item");
        $grill_list = $objItem->get_grilla_list_sbm("lista_usuarios");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["index"]);
        $smarty->assign("subpage_js", $webm["index_js"]);
        break;

    /**
     * Creación de JSON
     */
    case 'getItemList':
        $res = $objItem->get_item_datatable_Rows();
        $core->print_json($res);
        break;

    case 'itemUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type,"index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "item");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["item_index"]);
        $smarty->assign("subpage_js", $webm["item_index_js"]);
        break;

    case 'itemDelete':
        $res = $objItem->item_delete($id);
        $core->print_json($res);
        break;

//--------------Permisos---------------------------------
    case 'getUsuarios':
        // $res = $objItem->obtenerUsuarios();
        // echo json_encode($res);
        // $core->print_json($res);
        // print_r($res);
        // exit();

        // $res = $objItem->obtenerSubmodulos();
        // print_r($res);
        // exit();
        break;

    //Obtener los permisos para ficha pozo
    case 'obtenerPermisos':
        //$itemIdSubmoduloPozo = 842; //dev=842; //home=499
        //$res = $objItem->get_permisos($_SESSION[userv][usuario], $itemIdSubmoduloPozo); //$perpozo
        $res = $objItem->get_permisos($_SESSION[userv][usuario], $_SESSION[userv][tipoUsuario], "1.- Acciones de Usuario"); //$itemIdSubmoduloPozo
        echo json_encode($res);
        //print_r($res);
        exit;
        break;

    case 'setPermisoBasico':
        $res = $objItem->permisoBasico($id);     
        echo json_encode($res);
        exit;
        break;   

    case 'setPermisoMedio':
        $res = $objItem->permisoMedio($id);
        echo json_encode($res);
        exit;
        break;    

    case 'setPermisoAvanzado':
        $res = $objItem->permisoAvanzado($id);
        echo json_encode($res);
        exit;
        break;   

    case 'codice':
        echo "es una mala llamada de un snippet";
        exit;
        break;
}