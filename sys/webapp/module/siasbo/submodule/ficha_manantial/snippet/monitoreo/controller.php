<?php
/**
 * Todo el sub Control se recuperará mediante llamadas por ajax
 */
$templateModule = $templateModuleAjax;

switch($accion){

    /**
     * Acciones para Cantidad
     */
    default:
        //print_struc($CFGm->tabla);
        //$core->writeLog($privFace,__FILE__,__LINE__);
        $smarty->assign("type", $type);
        $smarty->assign("manantialId", $id);
        $smarty->assign("subpage", $webm["sc_index"]);
        break;

    case 'getItemGrillaCantidad':
        $smarty->assign("type", $type);
        $smarty->assign("manantialId", $id);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_cantidad");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["cantidad_sc_index"]);
        break;

    case 'getItemListCantidad':
        $respuesta = $subObjItem->get_item_datatable_Rows("manantial_monitoreo", "grilla_cantidad", "manantialId=".$manantialId);
        foreach ($respuesta['data'] as $clave => $valor) {
            $respuesta['data'][$clave]['fecha'] = date_format(date_create($valor['fecha']),"d/m/Y");
        }
        $core->print_json($respuesta);
        break;

    case 'itemUpdateCantidad':
        $subObjCatalog->conf_catalog_datos_general();
        $cataobj = $subObjCatalog->getCatalogList();
        $smarty->assign("cataobj", $cataobj);

        $smarty->assign("type", $type);
        $smarty->assign("manantialId", $manantialId);
        $smarty->assign("id", $id);
        if($type=="update"){
            $item = $subObjItem->get_item($id, "manantial_monitoreo");
            
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["cantidad_form_sc_index"]);
        break;

    case 'itemupdatesqlCantidad':
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_cantidad", $type, "manantial_monitoreo");
        $core->print_json($respuesta);
        break;

    case 'itemDeleteCantidad':
        $respuesta = $subObjItem->item_delete($id, "manantial_monitoreo");
        $core->print_json($respuesta);
        break;

    //Para Graficas
    case 'getItemHidrograma':
        $datosHidrograma = $subObjItem->get_datos_hidrograma($manantialId);
        echo json_encode($datosHidrograma);
        exit;
        break;

    case 'getItemCaudal':
        $datosCaudal = $subObjItem->get_datos_caudal($manantialId);
        echo json_encode($datosCaudal);
        exit;
        break;

    /**
     * Acciones monitoreo de calidad
     */
    case 'getItemGrillaCalidad':
        $smarty->assign("type", $type);
        $smarty->assign("manantialId", $id);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_calidad");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["calidad_sc_index"]);
        break;

    case 'getItemListCalidad':
        $respuesta = $subObjItem->get_item_datatable_Rows("manantial_monitor_calidad", "grilla_calidad", "manantialId=".$manantialId);
        foreach ($respuesta['data'] as $clave => $valor) {
            $respuesta['data'][$clave]['fecha_muestreo'] = date_format(date_create($valor['fecha_muestreo']),"d/m/Y");
            $respuesta['data'][$clave]['fecha_analisis'] = date_format(date_create($valor['fecha_analisis']),"d/m/Y");
        }
        $core->print_json($respuesta);
        break;

    case 'itemUpdateCalidad':
        $subObjCatalog->conf_catalog_datos_general();
        $cataobj = $subObjCatalog->getCatalogList();
        $smarty->assign("cataobj", $cataobj);
        
        $smarty->assign("type", $type);
        $smarty->assign("manantialId", $manantialId);
        $smarty->assign("id", $id);
        if($type=="update"){
            $item = $subObjItem->get_item($id, "manantial_monitor_calidad");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["calidad_form_sc_index"]);
        break;

    case 'itemupdatesqlCalidad':
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_calidad", $type, "manantial_monitor_calidad");
        $core->print_json($respuesta);
        break;

    case 'itemDeleteCalidad':
        $respuesta = $subObjItem->item_delete($id, "manantial_monitor_calidad");
        $core->print_json($respuesta);
        break;

    /**
     * Acciones monitoreo de calidad compuestos
     */
    case 'getItemGrillaCalidadCompuesto':
        $smarty->assign("type", $type);
        $smarty->assign("calidadId", $calidadId);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_calidad_compuesto");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["calidad_compuesto_sc_index"]);
        break;

    case 'getItemListCalidadCompuesto':
        $respuesta = $subObjItem->get_item_datatable_Rows("manantial_monitor_calidad_dato", "grilla_calidad_compuesto", "calidadId=".$calidadId);
        $core->print_json($respuesta);
        break;

    case 'itemUpdateCalidadCompuesto':
        $subObjCatalog->conf_catalog_datos_general();
        $cataobj = $subObjCatalog->getCatalogList();
        $smarty->assign("cataobj", $cataobj);
        
        $smarty->assign("type", $type);
        $smarty->assign("calidadId", $calidadId);
        $smarty->assign("id", $id);
        if($type=="update"){
            $item = $subObjItem->get_item($id, "manantial_monitor_calidad_dato");
            $smarty->assign("item", $item);

            $resultado = $subObjItem->get_calidad_compuesto($item['parametroId']);
            $compuesto = array();
            foreach ($resultado as $clave => $valor) {
                $compuesto[$valor["itemId"]] = $valor["nombre"];
            }
            $smarty->assign("calidad_compuesto", $compuesto);
        }
        $smarty->assign("subpage", $webm["calidad_compuesto_form_sc_index"]);
        break;

    case 'itemupdatesqlCalidadCompuesto':
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_calidad_compuesto", $type, "manantial_monitor_calidad_dato");
        $core->print_json($respuesta);
        break;

    case 'itemDeleteCalidadCompuesto':
        $respuesta = $subObjItem->item_delete($id, "manantial_monitor_calidad_dato");
        $core->print_json($respuesta);
        break;

    //Para Graficas
    case 'getItemStiff':
        $datosStiff = $subObjItem->get_datos_stiff($calidadId);
        echo json_encode($datosStiff);
        exit;
        break;

    /**
     * Acciones monitoreo isotópico
     */
    case 'getItemGrillaIsotopico':
        $smarty->assign("type", $type);
        $smarty->assign("manantialId", $id);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_isotopico");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["isotopico_sc_index"]);
        break;

    case 'getItemListIsotopico':
        $respuesta = $subObjItem->get_item_datatable_Rows("manantial_monitor_isotopico", "grilla_isotopico", "manantialId=".$manantialId);
        foreach ($respuesta['data'] as $clave => $valor) {
            $respuesta['data'][$clave]['fecha_muestreo'] = date_format(date_create($valor['fecha_muestreo']),"d/m/Y");
            $respuesta['data'][$clave]['fecha_analisis'] = date_format(date_create($valor['fecha_analisis']),"d/m/Y");
        }
        $core->print_json($respuesta);
        break;

    case 'itemUpdateIsotopico':
        $subObjCatalog->conf_catalog_datos_general();
        $cataobj = $subObjCatalog->getCatalogList();
        $smarty->assign("cataobj", $cataobj);
        
        $smarty->assign("type", $type);
        $smarty->assign("manantialId", $manantialId);
        $smarty->assign("id", $id);
        if($type=="update"){
            $item = $subObjItem->get_item($id, "manantial_monitor_isotopico");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["isotopico_form_sc_index"]);
        break;

    case 'itemupdatesqlIsotopico':
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_isotopico", $type, "manantial_monitor_isotopico");
        $core->print_json($respuesta);
        break;

    case 'itemDeleteIsotopico':
        $respuesta = $subObjItem->item_delete($id, "manantial_monitor_isotopico");
        $core->print_json($respuesta);
        break;

    /**
     * Acciones monitoreo isotópico compuestos
     */
    case 'getItemGrillaIsotopicoCompuesto':
        $smarty->assign("type", $type);
        $smarty->assign("isotopicoId", $isotopicoId);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_isotopico_compuesto");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["isotopico_compuesto_sc_index"]);
        break;

    case 'getItemListIsotopicoCompuesto':
        $respuesta = $subObjItem->get_item_datatable_Rows("manantial_monitor_isotopico_dato", "grilla_isotopico_compuesto", "isotopicoId=".$isotopicoId);
        $core->print_json($respuesta);
        break;

    case 'itemUpdateIsotopicoCompuesto':
        $subObjCatalog->conf_catalog_datos_general();
        $cataobj = $subObjCatalog->getCatalogList();
        $smarty->assign("cataobj", $cataobj);
        
        $smarty->assign("type", $type);
        $smarty->assign("isotopicoId", $isotopicoId);
        $smarty->assign("id", $id);
        if($type=="update"){
            $item = $subObjItem->get_item($id, "manantial_monitor_isotopico_dato");
            $smarty->assign("item", $item);

            $resultado = $subObjItem->get_isotopico_compuesto($item['isotoparametroId']);
            $compuesto = array();
            foreach ($resultado as $clave => $valor) {
                $compuesto[$valor["itemId"]] = $valor["nombre"];
            }
            $smarty->assign("isotopico_compuesto", $compuesto);
        }
        $smarty->assign("subpage", $webm["isotopico_compuesto_form_sc_index"]);
        break;

    case 'itemupdatesqlIsotopicoCompuesto':
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_isotopico_compuesto", $type, "manantial_monitor_isotopico_dato");
        $core->print_json($respuesta);
        break;

    case 'itemDeleteIsotopicoCompuesto':
        $respuesta = $subObjItem->item_delete($id, "manantial_monitor_isotopico_dato");
        $core->print_json($respuesta);
        break;

    case 'getCalidadCompuesto':
        $res = $subObjItem->get_calidad_compuesto($parametroId);
        $core->print_json($res);
        break;

    case 'getIsotopicoCompuesto':
        $res = $subObjItem->get_isotopico_compuesto($parametroId);
        $core->print_json($res);
        break;

}