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
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_litologica");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["sc_index"]);
        break;

    case 'itemupdatesql':    
        $respuesta = $subObjItem->item_update($item,$itemId,"campos_litologico",$type);
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
            $item = $subObjItem->get_item($id, "litologica");
            $smarty->assign("item", $item);
        }

        $smarty->assign("type", $type);
        $smarty->assign("subpage", $webm["litologico_sc_index"]);
        break;

    case 'itemDelete':
        $respuesta = $subObjItem->item_delete($id, "litologica");
        $core->print_json($respuesta);
        break;
    
    //Para Graficas
    case 'getGraficaColumnaLitologica':
        //echo $tipoId;
        // $datosLitologia = $subObjItem->get_datos_litologia($id);
        // echo json_encode($datosLitologia);
        // exit;
        // break;

        // $datosEscalon = $subObjItem->get_datos_litologia($id);
        // if(count($datosEscalon) > 0){
        //     $smarty->assign("datos",json_encode($datosEscalon));
        //     //$smarty->assign("subpage",$webm["escalon_sc_index"]);
        //     $smarty->assign("subpage",$webm["litologico_grafico_sc_index"]);
        // }else{
        //     return 0;
        // }
        // break;

        $datosLitologia = $subObjItem->get_datos_litologia($id);
        if(count($datosLitologia) > 0){
            $smarty->assign("subpage",$webm["litologico_grafico_sc_index"]);
        }else{
            return 0;
        }        
        
        break;

    case 'getItemLitologia':
        $datosLitologia = $subObjItem->get_datos_litologia($id);
        echo json_encode($datosLitologia);
        exit;
        break;
}