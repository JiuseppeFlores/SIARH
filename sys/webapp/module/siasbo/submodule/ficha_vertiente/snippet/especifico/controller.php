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
            $item = $objItem->get_item($id, "captacion_superficial");
            if (empty($item)) {
                $type = "new";
            } else {
                $usoaguaAux = explode(",", $item["usoaguaId"]);
                $usoaguaChecked = array();
                foreach ($usoaguaAux as $clave => $valor) {
                    if (array_key_exists($valor, $cataobj["usoagua_captacion"])) {
                        $usoaguaChecked[$valor] = $valor;
                    }
                }
                $smarty->assign("usoaguaChecked", $usoaguaChecked);

                $propositoAux = explode(",", $item["propositoId"]);
                $propositoChecked = array();
                foreach ($propositoAux as $clave => $valor) {
                    if (array_key_exists($valor, $cataobj["proposito_captacion"])) {
                        $propositoChecked[$valor] = $valor;
                    }
                }
                $smarty->assign("propositoChecked", $propositoChecked);
            }
            $smarty->assign("item", $item);
        }
        
        $smarty->assign("captacionId", $id);
        $smarty->assign("type", $type);
        $smarty->assign("subpage",$webm["sc_index"]);
        break;

    case 'itemupdatesql':
        $usoagua = $item["usoaguaId"];
        $usoaguaId = "";
        foreach ($usoagua as $clave => $valor) {
            $usoaguaId .= $valor . ",";
        }
        $item["usoaguaId"] = rtrim($usoaguaId, ",");

        $proposito = $item["propositoId"];
        $propositoId = "";
        foreach ($proposito as $clave => $valor) {
            $propositoId .= $valor . ",";
        }
        $item["propositoId"] = rtrim($propositoId, ",");

        $respuesta = $subObjItem->item_update($item, $itemId, "campos_especifico", $type);
        $core->print_json($respuesta);
        break;

}