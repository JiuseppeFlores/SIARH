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
        $smarty->assign("pozoCod", $id);
        $smarty->assign("type", $type);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_redes");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["sc_index"]);
        break;

    case 'itemupdatesql':
        // var_dump("itemupdatesql",$item,$itemId,"campos_seguimiento",$type);
        $respuesta = $subObjItem->item_update($item,$itemId,"campos_seguimiento",$type);
        $core->print_json($respuesta);
        break;

    case 'getItemList':
        $respuesta = $subObjItem->get_item_datatable_Rows($id);
        $core->print_json($respuesta);
        break;

    case 'itemUpdate':
        
        $subObjCatalog->conf_catalog_datos_general();
        $cataobj = $subObjCatalog->getCatalogList();
        $smarty->assign("cataobj", $cataobj);
        $smarty->assign("pozoCod", $pozoId);

        if($type=="update"){
            $item = $subObjItem->get_item($id, "estado_operativo");
            $smarty->assign("item", $item);
        }

        $smarty->assign("type", $type);
        // var_dump("itemUpdate",$id,$type,$webm);
        $smarty->assign("subpage", $webm["seguimiento_sc_index"]);
        break;

    case 'itemDelete':
        $respuesta = $subObjItem->item_delete($id, "estado_operativo");
        $core->print_json($respuesta);
        break;
    
    //Para Graficas
    // case 'getGraficaColumnaSeguimiento':
        //echo $tipoId;
        // $datosSeguimiento = $subObjItem->get_datos_Seguimiento($id);
        // echo json_encode($datosSeguimiento);
        // exit;
        // break;

        // $datosEscalon = $subObjItem->get_datos_Seguimiento($id);
        // if(count($datosEscalon) > 0){
        //     $smarty->assign("datos",json_encode($datosEscalon));
        //     //$smarty->assign("subpage",$webm["escalon_sc_index"]);
        //     $smarty->assign("subpage",$webm["seguimiento_grafico_sc_index"]);
        // }else{
        //     return 0;
        // }
        // break;

        // $datosSeguimiento = $subObjItem->get_datos_seguimiento($id);
        // if(count($datosSeguimiento) > 0){
        //     $smarty->assign("subpage",$webm["seguimiento_grafico_sc_index"]);
        // }else{
        //     return 0;
        // }        
        
        // break;

    case 'getItemSeguimiento':
        $datosSeguimiento = $subObjItem->get_datos_seguimiento($id);
        echo json_encode($datosSeguimiento);
        exit;
        break;
}