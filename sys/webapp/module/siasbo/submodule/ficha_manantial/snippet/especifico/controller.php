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
        $subObjCatalog->conf_catalog_datos_general();
        $cataobj = $subObjCatalog->getCatalogList();
        $smarty->assign("cataobj", $cataobj);

        if($type=="update") {
            $item = $objItem->get_item($id, "manantial");
            if (empty($item)) {
                $type = "new";
            } else {
                $usoaguaAux = explode(",", $item["usoaguaId"]);
                $usoaguaChecked = array();
                foreach ($usoaguaAux as $clave => $valor) {
                    if (array_key_exists($valor, $cataobj["usoagua_manantial"])) {
                        $usoaguaChecked[$valor] = $valor;
                    }
                }
                $smarty->assign("usoaguaChecked", $usoaguaChecked);
            }
            $smarty->assign("item", $item);
        }
        
        $smarty->assign("itemId", $id);
        $smarty->assign("type", $type);
        $smarty->assign("subpage",$webm["sc_index"]);
        break;

    case 'itemupdatesql':
        $usoagua = $item["usoagua"];
        $usoaguaId = "";
        foreach ($usoagua as $clave => $valor) {
            $usoaguaId .= $valor . ",";
        }
        $item["usoaguaId"] = rtrim($usoaguaId, ",");
        $respuesta = $subObjItem->item_update($item, $itemId, "manantial", $type);
        $core->print_json($respuesta);
        break;

}