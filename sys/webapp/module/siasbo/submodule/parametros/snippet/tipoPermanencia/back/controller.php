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
        
        //$subObjCatalog->conf_catalog_datos_general();
        //$cataobj = $subObjCatalog->getCatalogList();
        //$smarty->assign("cataobj",$cataobj);

        $smarty->assign("type",$type);
        if($type=="update"){
            $item = $objItem->get_item($id,"catalogo_manantial_permanencia");
            $smarty->assign("item",$item);
        }
        $smarty->assign("subpage",$webm["sc_index"]);
        break;

    case 'itemupdatesql':
        $respuesta = $subObjItem->item_update($item,$itemId,"tipo_permanencia",$type);
        $core->print_json($respuesta);
        break;
}