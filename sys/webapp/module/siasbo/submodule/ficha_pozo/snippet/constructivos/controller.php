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

        if($type=="update"){
            $item = $objItem->get_item($id,"pozo");
            if (empty($item)) {
                $type = "new";
            }
            $smarty->assign("item",$item);
        }
        $smarty->assign("pozoCod", $id);
        $smarty->assign("type", $type);
        $smarty->assign("subpage",$webm["sc_index"]);
        break;

    case 'itemupdatesql':
        $respuesta = $subObjItem->item_update($item,$itemId,"campos_constructivo",$type, "pozo");
        $core->print_json($respuesta);
        break;

    case 'itemUpdateDiseno':
        $subObjCatalog->conf_catalog_datos_general();
        $cataobj = $subObjCatalog->getCatalogList();
        $smarty->assign("cataobj",$cataobj);

        $smarty->assign("type", $type);
        $smarty->assign("pozoId", $pozoId);
        $smarty->assign("id", $id);
        if($type=="update"){
            $item = $subObjItem->get_item($id, "constructivo_diseno");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["diseno_form_sc_index"]);
        break;

    case 'itemGrillaDiseno':
        $smarty->assign("pozoId", $pozoId);
        $datosPozo = $subObjItem->get_datos_pozo($pozoId);
        $smarty->assign("tipoPerforacion", $datosPozo[0]['tipo']);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_diseno");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["diseno_sc_index"]);
        break;

    case 'getItemListDiseno':
        $respuesta = $subObjItem->get_item_datatable_Rows("constructivo_diseno", "grilla_diseno", "pozoId=".$pozoId);
        $core->print_json($respuesta);
        break;

    case 'itemupdatesqlDiseno':
        $profundidad_desde = (float) $item['profundidad_desde'];
        $profundidad_hasta = (float) $item['profundidad_hasta'];

        $profundidad_perforacion = $subObjItem->get_verificar_profundidad_perforacion($item['pozoId']);
        if ($profundidad_perforacion[0]['profundidad'] == '' || $profundidad_perforacion[0]['profundidad'] < $profundidad_hasta) {
            $core->print_json(array('res' => 4, 'id' => '', 'accion' => $type, 'data' => $profundidad_perforacion[0]['profundidad']));
            exit();
        }

        $registrosIguales = $subObjItem->get_verificar_registros_iguales($item['pozoId'], $profundidad_desde, $profundidad_hasta);

        if (!empty($registrosIguales)) {
            $core->print_json(array('res' => 3, 'id' => '', 'accion' => $type));
            exit();
        }

        /*$registrosDesdeHasta = $subObjItem->get_verificar_registros_desde_hasta($item['pozoId'], $profundidad_desde, $profundidad_hasta);
        $cantidadRegistros = count($registrosDesdeHasta);
        if ($cantidadRegistros > 0) {
            switch ($cantidadRegistros) {
                case 1:
                    if ($profundidad_desde == $registrosDesdeHasta[0]['profundidad_desde']) {
                        $core->print_json(array('res' => 5, 'id' => '', 'accion' => $type));
                        exit();
                    }
                    if ($profundidad_hasta == $registrosDesdeHasta[0]['profundidad_hasta']) {
                        $core->print_json(array('res' => 6, 'id' => '', 'accion' => $type));
                        exit();
                    }
                    break;

                case 2:
                    # code...
                    break;
            }
        }*/

        $respuesta = $subObjItem->item_update($item, $itemId, "campos_diseno", $type, "constructivo_diseno");
        $core->print_json($respuesta);
        break;

    case 'itemDeleteDiseno':
        $respuesta = $subObjItem->item_delete($id, "constructivo_diseno");
        $core->print_json($respuesta);
        break;

    case 'itemGraficarDiseno':
        $smarty->assign("pozoId", $pozoId);
        $datosPozo = $subObjItem->get_datos_pozo($pozoId);
        $datosDiseno = $subObjItem->get_datos_diseno($pozoId);
        if (empty($datosDiseno) && $datosPozo[0]['profundidad'] == '') {
            return 0;
            exit();
        }
        $datosPozo[0]['rejillafiltro'] = $datosDiseno;
        $smarty->assign("datosPozo", json_encode($datosPozo));
        $smarty->assign("subpage", $webm["grafica_sc_index"]);
        break;
}