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
            $item = $objItem->get_item($id,"pozo"); //tabla bd item_pozo
            if (empty($item)) {
                $type = "new";
            }else{
                $smarty->assign("item",$item);
            }            
        }
        $smarty->assign("pozoCod", $id);
        $smarty->assign("type", $type);
        $smarty->assign("subpage",$webm["sc_index"]);
        break;

    case 'itemupdatesql':       
        // echo $item["perforacion_pozoId"];
        // exit();
        if ($item["perforacion_pozoId"] == 1 || $item["perforacion_pozoId"] == 3) {
            $item["perforacion_revestimientoId"] = "null";
            $item["perforacion_excavacionId"] = "null";
            $item["perforacion_profundidadexcavada"] = "null";
            $item["perforacion_diametroexcavacion"] = "null";
            $item["perforacion_nivelfreatico"] = "null";
            $item["perforacion_caudal"] = "null";            
        }else if($item["perforacion_pozoId"] == 2){
            $item["perforacion_tipoId"] = "null";
            $item["perforacion_metodoId"] = "null";
            $item["perforacion_profundidad"] = "null";
            $item["perforacion_diametro"] = "null";
            $item["perforacion_diametro_final"] = "null";            
        }
        $respuesta = $subObjItem->item_update($item,$itemId,"campos_perforacion",$type);//item        
        //$respuesta = $subObjItem->item_update($item,$itemId,"campos_perforacion",$type);//item      
        $core->print_json($respuesta);
        break;

    // case 'getPerforacion':
    //     //Aqui obtiene datos del archivo class.php function get_especifico($Id)
    //     $res = $subObjItem->get_perforacion($id);
    //     $core->print_json($res);

    //     break;

    // case 'getTipoPozo':
    //     $res = $subObjItem->get_tipopozo();
    //     $core->print_json($res);

    //     break;

    // case 'getTipoPerforacion':
    //     $res = $subObjItem->get_tipoperforacion();
    //     $core->print_json($res);

    //     break;

    // case 'getMetodoPerforacion':
    //     $res = $subObjItem->get_metodoperforacion();
    //     $core->print_json($res);

    //     break;
}