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
        // var_dump($cataobj);
        $smarty->assign("cataobj", $cataobj);

        // $listaRedMonitoreo = $subObjItem->get_item_datatable_Rows_redes();
        // var_dump($listaRedMonitoreo);
        // $smarty->assign("cataItems", $listaRedMonitoreo);

        if($type=="update") {
            $item = $subObjItem->get_item($id, "pozo");
            // echo "Hola";
            // print_struc($item);
            // exit();
            if (empty($item)) {
                $type = "new";
            } else {
                $optionAux = explode(",", $item["usoaguaId"]);
                $optionChecked = array();
                foreach ($optionAux as $clave => $valor) {
                    if (array_key_exists($valor, $cataobj["usoagua_pozo"])) {
                        $optionChecked[$valor] = $valor;
                    }
                }
                $smarty->assign("usoaguaChecked", $optionChecked);

                $optionAux = explode(",", $item["propositoId"]);
                $optionChecked = array();
                foreach ($optionAux as $clave => $valor) {
                    if (array_key_exists($valor, $cataobj["proposito_pozo"])) {
                        $optionChecked[$valor] = $valor;
                    }
                }
                $smarty->assign("propositoChecked", $optionChecked);
            }
            
            $smarty->assign("item", $item);
        }
        
        $smarty->assign("pozoCod", $id);
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