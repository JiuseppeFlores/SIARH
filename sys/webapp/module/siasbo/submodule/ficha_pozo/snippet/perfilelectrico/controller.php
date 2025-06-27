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
        //print_struc($CFGm->tabla);

        //$core->writeLog($privFace,__FILE__,__LINE__);
        $subObjCatalog->conf_catalog_datos_general();
        $cataobj = $subObjCatalog->getCatalogList();
        $smarty->assign("cataobj",$cataobj);

        $smarty->assign("type",$type);
        if($type=="update"){
            $item = $objItem->get_item($id,"pozo"); //tabla item_pozo

            if (empty($item)) {
                $type = "new";
            } else {
                $optionAux = explode(",", $item["electrico_parametroId"]); //se define en el formulario index.tpl
                $optionChecked = array();
                foreach ($optionAux as $clave => $valor) {
                    if (array_key_exists($valor, $cataobj["tipoparametro"])) { //se define en class.catalog.php
                        $optionChecked[$valor] = $valor;
                    }
                }
                $smarty->assign("parametroChecked", $optionChecked);
            }

            $smarty->assign("pozoCod", $id);
            $smarty->assign("type", $type);
            $smarty->assign("item",$item);
        }

        $smarty->assign("id", $id);
        $smarty->assign("type", $type);
        $smarty->assign("subpage",$webm["sc_index"]);
        break;

    case 'itemupdatesql':
        $electrico_parametro = $item["electrico_parametroId"]; //se define en el formulario index.tpl
        $electrico_parametroId = "";
        foreach ($electrico_parametro as $clave => $valor) {
            $electrico_parametroId .= $valor . ",";
        }
        $item["electrico_parametroId"] = rtrim($electrico_parametroId, ",");

        $respuesta = $subObjItem->item_update($item,$itemId,"campos_perfilajeelectrico",$type); //se define en el archivo campos.php
        $core->print_json($respuesta);
        break;
}