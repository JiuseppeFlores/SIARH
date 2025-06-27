<?php
/**
 * Todo el sub Control se recuperará mediante llamadas por ajax
 */
$templateModule = $templateModuleAjax;

switch($accion){

    /**
     * Página por defecto (index)
     */
    default:

        // print_struc($CFGm->tabla);
        // exit();

        //$core->writeLog($privFace,__FILE__,__LINE__);
        // $subObjCatalog->conf_catalog_datos_general();
        // $cataobj = $subObjCatalog->getCatalogList();
        // $smarty->assign("cataobj",$cataobj);

        // $smarty->assign("type",$type);
        // if($type=="update"){
        //     $item = $objItem->get_item($id,"item");
        //     $smarty->assign("item",$item);
        // }
        // $smarty->assign("subpage",$webm["sc_index"]);
        // break;

        // echo $id;
        // exit();

        $smarty->assign("type", $type);
        $smarty->assign("pozoId", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type,"tab_monitor");        
        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "monitorcantidad"); //bombeo_pozo

        //$smarty->assign("menu_tab_active", "monitorcalidad");
        
        $smarty->assign("subpage", $webm["monitorc_item_sc_index"]);
        break;

    case 'itemGrillamonitorcantidad': //itemGrillaBombeoPozo
        $smarty->assign("pozoId", $pozoId);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_monitorcantidad");
        $smarty->assign("grill_list", $grill_list);

        $smarty->assign("subpage", $webm["monitor_cantidad_sc_index"]);
        break;

    case 'getItemListMonitorCantidad':
        $respuesta = $subObjItem->get_item_datatable_Rows("monitor", "grilla_monitorcantidad", "pozoId=".$pozoId); //"hidra", "grilla_bombeo_pozo", "tipobombeoId=1 AND pozoId=".$pozoId
        // foreach ($respuesta['data'] as $clave => $valor) {
        //     $respuesta['data'][$clave]['fecha'] = date_format(date_create($valor['fecha']),"d/m/Y");
        // }
        $core->print_json($respuesta);
        break;

    case 'itemUpdateMonitorCantidad':
        $smarty->assign("type", $type);
        $smarty->assign("pozoId", $pozoId);
        $smarty->assign("id", $id);

        if($type=="update"){
            $item = $subObjItem->get_item($id, "monitor");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["monitor_cantidad_form_sc_index"]);
        break;

    case 'itemupdatesqlMonitorCantidad':
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_monitorcantidad", $type, "monitor");
        $core->print_json($respuesta);
        break;

    case 'itemDeleteMonitorCantidad':
        $respuesta = $subObjItem->item_delete($id, "monitor");
        $core->print_json($respuesta);
        break;

    //Monitoreo Calidad
    case 'itemGrillamonitorcalidad': //itemGrillaMonitorCalidad
        $smarty->assign("pozoId", $pozoId);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_monitorcalidad");
        $smarty->assign("grill_list", $grill_list);

        $smarty->assign("subpage", $webm["monitor_calidad_sc_index"]);
        break;

    case 'getItemListMonitorCalidad':
        $respuesta = $subObjItem->get_item_datatable_Rows("monitor_calidad", "grilla_monitorcalidad", "pozoId=".$pozoId); //"hidra", "grilla_bombeo_pozo", "tipobombeoId=1 AND pozoId=".$pozoId
        // foreach ($respuesta['data'] as $clave => $valor) {
        //     $respuesta['data'][$clave]['fecha'] = date_format(date_create($valor['fecha']),"d/m/Y");
        // }
        $core->print_json($respuesta);
        break;

    case 'itemUpdateMonitorCalidad':
        $smarty->assign("type", $type);
        $smarty->assign("pozoId", $pozoId);
        $smarty->assign("id", $id);

        if($type=="update"){
            $item = $subObjItem->get_item($id, "monitor_calidad");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["monitor_calidad_form_sc_index"]);
        break;

    case 'itemupdatesqlMonitorCalidad':
        //$smarty->assign("pozoId", $pozoId);
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_monitorcalidad", $type, "monitor_calidad");
        $core->print_json($respuesta);
        break;

    case 'itemDeleteMonitorCalidad':
        $respuesta = $subObjItem->item_delete($id, "monitor_calidad");
        $core->print_json($respuesta);
        break;

    /**
     * Acciones para agregar compuestos
     */
    case 'itemGrillaTipoMonitorCalidad':
        $smarty->assign("monitorcalidadId", $pruebabombeoId);

        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_tipo_bombeo_pozo");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["tipo_bombeo_pozo_sc_index"]);
        break;

    //Monitoreo Isotópico
    case 'itemGrillamonitorisotopico': //itemGrillaMonitorIsotopico
        $smarty->assign("pozoId", $pozoId);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_monitorcantidad");
        $smarty->assign("grill_list", $grill_list);

        $smarty->assign("subpage", $webm["monitor_cantidad_sc_index"]);
        break;







    // case 'itemupdatesql':
    //     $respuesta = $subObjItem->item_update($item,$itemId,"item",$type);
    //     $core->print_json($respuesta);
    //     break;
}