<?php
/**
 * Todo el sub Control se recuperará mediante llamadas por ajax
 */
$templateModule = $templateModuleAjax;

switch($accion) {
    /**
     * Página por defecto (index)
     */
    default:
        $smarty->assign("type", $type);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_tomografia");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["sc_index"]);
        break;

    case 'itemupdatesql':
        $option = $item["configuracionId"];
        $optionId = "";
        foreach ($option as $clave => $valor) {
            $optionId .= $valor . ",";
        }
        $item["tomografia_configId"] = rtrim($optionId, ",");

        $respuesta = $subObjItem->item_update($item, $itemId, "campos_tomografia", $type, "geofisica");
        $core->print_json($respuesta);
        break;

    case 'getItemList':
        $respuesta = $subObjItem->get_item_datatable_Rows("geofisica", "grilla_tomografia", "tipo=2 AND geofisicaId=".$id);
        foreach ($respuesta['data'] as $clave => $valor) {
            $respuesta['data'][$clave]['fecha'] = date_format(date_create($valor['fecha']),"d/m/Y");
        }
        $core->print_json($respuesta);
        break;

    case 'itemUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);
        $smarty->assign("geofisicaId", $geofisicaId);

        $subObjCatalog->conf_catalog_datos_general();
        $cataobj = $subObjCatalog->getCatalogList();
        $smarty->assign("cataobj", $cataobj);

        if($type=="update"){
            $item = $subObjItem->get_item($id, "geofisica");
            $item["fecha"] = date_format(date_create($item["fecha"]),"d/m/Y");
            $opcionAux = explode(",", $item["tomografia_configId"]);
            $opcionChecked = array();
            foreach ($opcionAux as $clave => $valor) {
                if (array_key_exists($valor, $cataobj["tomografiaconfig"])) {
                    $opcionChecked[$valor] = $valor;
                }
            }
            $smarty->assign("opcionChecked", $opcionChecked);
            $smarty->assign("item", $item);
        }

        $smarty->assign("subpage", $webm["tomografia_sc_index"]);
        break;

    case 'itemDelete':
        $respuesta = $subObjItem->item_delete($id, "geofisica");
        $core->print_json($respuesta);
        break;

    case 'itemUpdateCapa':
        $smarty->assign("type", $type);
        $smarty->assign("geofisicaId", $geofisicaId);
        $smarty->assign("id", $id);
        if($type=="update"){
            $item = $subObjItem->get_item($id, "geofisica_dev_capa");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["capa_form_sc_index"]);
        break;

    case 'itemGrillaCapa':
        $smarty->assign("geofisicaId", $geofisicaId);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_capa");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["capa_sc_index"]);
        break;

    case 'getItemListCapa':
        $respuesta = $subObjItem->get_item_datatable_Rows("geofisica_dev_capa", "grilla_capa", "geofisicaId=".$geofisicaId);
        $core->print_json($respuesta);
        break;

    case 'itemupdatesqlCapa':
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_capa", $type, "geofisica_dev_capa");
        $core->print_json($respuesta);
        break;

    case 'itemDeleteCapa':
        $respuesta = $subObjItem->item_delete($id, "geofisica_dev_capa");
        $core->print_json($respuesta);
        break;

    case 'getItemListVinculoPozo':
        $respuesta = $subObjItem->get_item_datatable_Rows("geofisica_vinculo_pozo", "grilla_vinculo_pozo", "lineabaseId=".$lineabaseId);
        $core->print_json($respuesta);
        break;

    case 'itemupdatesqlVinculoPozo':
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_vinculo_pozo", $type, "geofisica_vinculo_pozo");
        $core->print_json($respuesta);
        break;

    case 'itemDeleteVinculoPozo':
        $respuesta = $subObjItem->item_delete($id, "geofisica_vinculo_pozo");
        $core->print_json($respuesta);
        break;

    case 'itemUpdateVinculoPozo':
        $smarty->assign("type", $type);
        $smarty->assign("lineabaseId", $lineabaseId);
        $smarty->assign("id", $id);

        $resultado = $subObjItem->get_pozos();
        $lista_pozos = array();
        foreach ($resultado as $clave => $valor) {
            $lista_pozos[$valor["itemId"]] = $valor["codigo"] . ' - ' . $valor["nombre"];
        }
        $smarty->assign("lista_pozos", $lista_pozos);
        if($type=="update"){
            $item = $subObjItem->get_item($id, "geofisica_vinculo_pozo");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["vinculo_pozo_form_sc_index"]);
        break;

    case 'itemGrillaVinculoPozo':
        $smarty->assign("lineabaseId", $lineabaseId);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_vinculo_pozo");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["vinculo_pozo_sc_index"]);
        break;

    case 'itemGrillaPozo':
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_pozo");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["pozo_sc_index"]);
        break;

    case 'getItemListPozo':
        $respuesta = $subObjItem->get_item_datatable_Rows("item", "grilla_pozo", "tipo=1");
        $core->print_json($respuesta);
        break;

}