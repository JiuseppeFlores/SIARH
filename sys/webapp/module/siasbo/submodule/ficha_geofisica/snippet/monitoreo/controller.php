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
        //print_struc($CFGm->tabla);
        //$core->writeLog($privFace,__FILE__,__LINE__);
        $smarty->assign("type", $type);
        $smarty->assign("manantialId", $id);

        $grill_list = $objItem->get_grilla_list_sbm("manantial_monitoreo");
        $smarty->assign("grill_list", $grill_list);

        $smarty->assign("subpage",$webm["sc_index"]);
        break;

    case 'itemupdatesql':
        $respuesta = $subObjItem->item_update($item, $itemId, "manantial_monitoreo", $type);
        $core->print_json($respuesta);
        break;

    case 'getItemList':
        $res = $subObjItem->get_item_datatable_Rows($manantialId);
        foreach ($res['data'] as $clave => $valor) {
            $res['data'][$clave]['fecha'] = date_format(date_create($valor['fecha']),"d/m/Y");
        }
        $core->print_json($res);
        break;

    case 'itemDelete':
        $res = $subObjItem->item_delete($id);
        $core->print_json($res);
        break;

}