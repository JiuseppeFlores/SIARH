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
        /**
         * Sacamos los datos de la grilla
         */
        $smarty->assign("geofisicaId", $id);
        $grill_list = $objItem->get_grilla_list_sbm("grilla_archivo");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage",$webm["sc_index"]);
        break;

    case 'getItemList':
        $respuesta = $subObjItem->get_item_datatable_Rows($geofisicaId);
        foreach ($respuesta['data'] as $clave => $valor) {
            $respuesta['data'][$clave]['fecha'] = date_format(date_create($valor['fecha']),"d/m/Y");
        }
        $core->print_json($respuesta);
        break;

    case 'itemUpdate':
        $smarty->assign("geofisicaId", $geofisicaId);
        $smarty->assign("id", $id);

        if($type=="update"){
            $item = $subObjItem->get_item($id);
            $smarty->assign("item",$item);
        }

        $smarty->assign("type", $type);
        $smarty->assign("subpage",$webm["form_sc_index"]);
        break;

    case 'itemupdatesql':
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_archivo", $type, $item['fichaId'], $archivo_adjunto);
        $core->print_json($respuesta);
        break;

    case 'itemDelete':
        $res = $subObjItem->item_delete($id, $geofisicaId);
        $core->print_json($res);
        break;

    case 'itemDescarga':
        $subObjItem->get_file($id, $geofisicaId);
        break;

}