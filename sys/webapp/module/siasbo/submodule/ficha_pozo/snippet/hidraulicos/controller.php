<?php
/**
 * Todo el sub Control se recuperará mediante llamadas por ajax
 */
$templateModule = $templateModuleAjax;

switch($accion){

    /**
     * Acciones para Prueba de Bombeo en Pozo
     */
    default:
        //print_struc($CFGm->tabla);
        //$core->writeLog($privFace,__FILE__,__LINE__);
        $smarty->assign("type", $type);
        $smarty->assign("pozoId", $id);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_prueba");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["sc_index"]);
        break;

    case 'getItemListPrueba':
        $respuesta = $subObjItem->get_item_datatable_Rows("hidra", "grilla_prueba", "pozoId=".$pozoId);
        foreach ($respuesta['data'] as $clave => $valor) {
            $respuesta['data'][$clave]['fecha'] = date_format(date_create($valor['fecha']),"d/m/Y");
        }
        $core->print_json($respuesta);
        break;

    case 'itemUpdatePrueba':
        $subObjCatalog->conf_catalog_datos_general();
        $cataobj = $subObjCatalog->getCatalogList();
        $smarty->assign("cataobj", $cataobj);
        
        $smarty->assign("type", $type);
        $smarty->assign("pozoId", $pozoId);
        $smarty->assign("id", $id);
        if($type=="update"){
            $item = $subObjItem->get_item($id, "hidra");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["prueba_form_sc_index"]);
        break;

    case 'itemupdatesqlPrueba':
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_prueba", $type, "hidra");
        $core->print_json($respuesta);
        break;

    case 'itemDeletePrueba':
        $respuesta = $subObjItem->item_delete($id, "hidra");
        $core->print_json($respuesta);
        break;

    /**
     * Acciones para Tipo de Prueba de Bombeo en Pozo
     */
    case 'itemGrillaTipo':
        $smarty->assign("pruebaId", $pruebaId);
        $smarty->assign("pozoId", $pozoId);
        $smarty->assign("tipoprueba", $tipoprueba);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_tipo");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["tipo_sc_index"]);
        break;

    case 'getItemListTipo':
        $respuesta = $subObjItem->get_item_datatable_Rows("hidra_bombeo", "grilla_tipo", "pruebabombeoId=".$pruebaId);
        foreach ($respuesta['data'] as $clave => $valor) {
            $respuesta['data'][$clave]['fecha'] = date_format(date_create($valor['fecha']),"d/m/Y");
            $tiempo = $subObjItem->segundos_tiempo($respuesta['data'][$clave]['duracion']);
            $respuesta['data'][$clave]['duracion'] = $tiempo['horas']."h. ".$tiempo['minutos']."m. ".$tiempo['segundos']."s.";
        }
        $core->print_json($respuesta);
        break;

    case 'itemUpdateTipo':
        $subObjCatalog->conf_catalog_datos_general();
        $cataobj = $subObjCatalog->getCatalogList();
        $smarty->assign("cataobj", $cataobj);

        $smarty->assign("type", $type);
        $smarty->assign("pruebaId", $pruebaId);
        $smarty->assign("id", $id);
        if($type=="update"){
            $item = $subObjItem->get_item($id, "hidra_bombeo");
            $tiempo = $subObjItem->segundos_tiempo($item['duracion']);
            $smarty->assign("tiempo", $tiempo);
            //$duracion = explode('-', $item['duracion']);
            //$smarty->assign("duracion", $duracion);
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["tipo_form_sc_index"]);
        break;

    case 'itemupdatesqlTipo':
        //$item['duracion'] = $item['hora'].'-'.$item['minuto'].'-'.$item['segundo'];
        $item['duracion'] = $subObjItem->tiempo_segundos($item['horas'], $item['minutos'], $item['segundos']);
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_tipo", $type, "hidra_bombeo");
        $core->print_json($respuesta);
        break;

    case 'itemDeleteTipo':
        $respuesta = $subObjItem->item_delete($id, "hidra_bombeo");
        $core->print_json($respuesta);
        break;

    /**
     * Acciones para Escalon Tipo de Prueba de Bombeo en Pozo
     */
    case 'itemGrillaEscalon':
        $smarty->assign("pozoId", $pozoId);
        $smarty->assign("pruebaId", $pruebaId);
        $smarty->assign("tipoId", $tipoId);
        $smarty->assign("tipobombeo", $tipobombeo);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_escalon");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["escalon_sc_index"]);
        break;

    case 'getItemListEscalon':
        $respuesta = $subObjItem->get_item_datatable_Rows("hidra_bombeo_dato", "grilla_escalon", "tipobombeoId=".$tipoId);
        foreach ($respuesta['data'] as $clave => $valor) {
            $tiempo = $subObjItem->segundos_tiempo($respuesta['data'][$clave]['tiempo']);
            $respuesta['data'][$clave]['tiempo'] = $tiempo['horas']."h. ".$tiempo['minutos']."m. ".$tiempo['segundos']."s.";
        }
        $core->print_json($respuesta);
        break;

    case 'itemUpdateEscalon':
        $subObjCatalog->conf_catalog_datos_general();
        $cataobj = $subObjCatalog->getCatalogList();
        $smarty->assign("cataobj", $cataobj);

        $smarty->assign("type", $type);
        $smarty->assign("tipoId", $tipoId);
        $smarty->assign("id", $id);
        $smarty->assign("tipobombeo", $tipobombeo);
        if($type=="update"){
            $item = $subObjItem->get_item($id, "hidra_bombeo_dato");
            $tiempo = $subObjItem->segundos_tiempo($item['tiempo']);
            $smarty->assign("tiempo", $tiempo);
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["escalon_form_sc_index"]);
        break;

    case 'itemupdatesqlEscalon':
        $item['tiempo'] = $subObjItem->tiempo_segundos($item['horas'], $item['minutos'], $item['segundos']);
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_escalon", $type, "hidra_bombeo_dato");
        $core->print_json($respuesta);
        break;

    case 'itemDeleteEscalon':
        $respuesta = $subObjItem->item_delete($id, "hidra_bombeo_dato");
        $core->print_json($respuesta);
        break;
    //Para graficas de escalones
    case 'getItemEscalon':
        // $datosEscalon = $subObjItem->get_datos_escalon($tipoId);
        // echo json_encode($datosEscalon);
        // exit;
        // break;

        $datosEscalon = $subObjItem->get_datos_escalon($id, $tipo);
        if(count($datosEscalon) > 0){
            $smarty->assign("tipo",$tipo);
            $smarty->assign("datos",json_encode($datosEscalon));
            //$smarty->assign("subpage",$webm["escalon_sc_index"]);
            $smarty->assign("subpage",$webm["escalon_grafica_sc_index"]);
        }else{
            return 0;
        }
        break;

    /**
     * Acciones para Escalon Tipo de Prueba de Bombeo en Pozo
     */
    case 'itemGrillaRecuperacion':
        $smarty->assign("pozoId", $pozoId);
        $smarty->assign("pruebaId", $pruebaId);
        $smarty->assign("tipoId", $tipoId);
        $smarty->assign("tipobombeo", $tipobombeo);
        $smarty->assign("tipoprueba", $tipoprueba);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_recuperacion");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["recuperacion_sc_index"]);
        break;

    case 'getItemListRecuperacion':
        $respuesta = $subObjItem->get_item_datatable_Rows("hidra_recuperacion", "grilla_recuperacion", "tipobombeoId=".$tipoId);
        foreach ($respuesta['data'] as $clave => $valor) {
            $respuesta['data'][$clave]['fecha'] = date_format(date_create($valor['fecha']),"d/m/Y");
            $tiempo = $subObjItem->segundos_tiempo($respuesta['data'][$clave]['duracion']);
            $respuesta['data'][$clave]['duracion'] = $tiempo['horas']."h. ".$tiempo['minutos']."m. ".$tiempo['segundos']."s.";
        }
        $core->print_json($respuesta);
        break;

    case 'itemUpdateRecuperacion':
        $smarty->assign("type", $type);
        $smarty->assign("tipoId", $tipoId);
        $smarty->assign("id", $id);
        $smarty->assign("tipobombeo", $tipobombeo);
        if($type=="update"){
            $item = $subObjItem->get_item($id, "hidra_recuperacion");
            $duracion = $subObjItem->segundos_tiempo($item['duracion']);
            $smarty->assign("duracion", $duracion);
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["recuperacion_form_sc_index"]);
        break;

    case 'itemupdatesqlRecuperacion':
        $item['duracion'] = $subObjItem->tiempo_segundos($item['horas'], $item['minutos'], $item['segundos']);
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_recuperacion", $type, "hidra_recuperacion");
        $core->print_json($respuesta);
        break;

    case 'itemDeleteRecuperacion':
        $respuesta = $subObjItem->item_delete($id, "hidra_recuperacion");
        $core->print_json($respuesta);
        break;

    /**
     * Acciones para Escalon Tipo de Prueba de Bombeo en Pozo
     */
    case 'itemGrillaRecuperaEscalon':
        $smarty->assign("pozoId", $pozoId);
        $smarty->assign("recuperacionId", $recuperacionId);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_recuperacion_escalon");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["recuperacion_escalon_sc_index"]);
        break;

    case 'getItemListRecuperaEscalon':
        $respuesta = $subObjItem->get_item_datatable_Rows("hidra_recuperacion_dato", "grilla_recuperacion_escalon", "recuperacionId=".$recuperacionId);
        foreach ($respuesta['data'] as $clave => $valor) {
            $tiempo = $subObjItem->segundos_tiempo($respuesta['data'][$clave]['tiempo']);
            $respuesta['data'][$clave]['tiempo'] = $tiempo['horas']."h. ".$tiempo['minutos']."m. ".$tiempo['segundos']."s.";
        }
        $core->print_json($respuesta);
        break;

    case 'itemUpdateRecuperaEscalon':
        $smarty->assign("type", $type);
        $smarty->assign("recuperacionId", $recuperacionId);
        $smarty->assign("id", $id);
        if($type=="update"){
            $item = $subObjItem->get_item($id, "hidra_recuperacion_dato");
            $tiempo = $subObjItem->segundos_tiempo($item['tiempo']);
            $smarty->assign("tiempo", $tiempo);
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["recuperacion_escalon_form_sc_index"]);
        break;

    case 'itemupdatesqlRecuperaEscalon':
        $item['tiempo'] = $subObjItem->tiempo_segundos($item['horas'], $item['minutos'], $item['segundos']);
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_recuperacion_escalon", $type, "hidra_recuperacion_dato");
        $core->print_json($respuesta);
        break;

    case 'itemDeleteRecuperaEscalon':
        $respuesta = $subObjItem->item_delete($id, "hidra_recuperacion_dato");
        $core->print_json($respuesta);
        break;
    //Para graficas
    case 'getItemEscalonRecuperacion':
        // $datosEscalon = $subObjItem->get_datos_escalonrecuperacion($recuperacionId);
        // echo json_encode($datosEscalon);
        // exit;
        // break;

        $datosEscalon = $subObjItem->get_datos_escalonrecuperacion($id);
        if(count($datosEscalon) > 0){
            $smarty->assign("datos",json_encode($datosEscalon));
            //$smarty->assign("subpage",$webm["escalon_sc_index"]);
            $smarty->assign("subpage",$webm["recuperacion_escalon_grafica_sc_index"]);
        }else{
            return 0;
        }
        break;

    /**
     * Acciones para Escalon Tipo de Prueba de Bombeo en Pozo
     */
    case 'itemGrillaObservacion':
        $smarty->assign("pozoId", $pozoId);
        $smarty->assign("pruebaId", $pruebaId);
        $smarty->assign("tipoId", $tipoId);
        $smarty->assign("tipobombeo", $tipobombeo);

        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_observacion");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["observacion_sc_index"]);
        break;

    case 'getItemListObservacion':
        $respuesta = $subObjItem->get_item_datatable_Rows("hidra_observacion", "grilla_observacion", "tipobombeoId=".$tipoId);
        foreach ($respuesta['data'] as $clave => $valor) {
            $respuesta['data'][$clave]['fecha'] = date_format(date_create($valor['fecha']),"d/m/Y");
            $tiempo = $subObjItem->segundos_tiempo($respuesta['data'][$clave]['duracion']);
            $respuesta['data'][$clave]['duracion'] = $tiempo['horas']."h. ".$tiempo['minutos']."m. ".$tiempo['segundos']."s.";
        }
        $core->print_json($respuesta);
        break;

    case 'itemUpdateObservacion':
        $smarty->assign("type", $type);
        $smarty->assign("tipoId", $tipoId);
        $smarty->assign("id", $id);
        $smarty->assign("tipobombeo", $tipobombeo);
        if($type=="update"){
            $item = $subObjItem->get_item($id, "hidra_observacion");
            $duracion = $subObjItem->segundos_tiempo($item['duracion']);
            $smarty->assign("duracion", $duracion);
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["observacion_form_sc_index"]);
        break;

    case 'itemupdatesqlObservacion':
        $item['duracion'] = $subObjItem->tiempo_segundos($item['horas'], $item['minutos'], $item['segundos']);
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_observacion", $type, "hidra_observacion");
        $core->print_json($respuesta);
        break;

    case 'itemDeleteObservacion':
        $respuesta = $subObjItem->item_delete($id, "hidra_observacion");
        $core->print_json($respuesta);
        break;

    /**
     * Acciones para Escalon Tipo de Prueba de Bombeo en Pozo
     */
    case 'itemGrillaObservaEscalon':
        $smarty->assign("pozoId", $pozoId);
        $smarty->assign("observacionId", $observacionId);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_observacion_escalon");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["observacion_escalon_sc_index"]);
        break;

    case 'getItemListObservaEscalon':
        $respuesta = $subObjItem->get_item_datatable_Rows("hidra_observacion_dato", "grilla_observacion_escalon", "observacionId=".$observacionId);
        foreach ($respuesta['data'] as $clave => $valor) {
            $tiempo = $subObjItem->segundos_tiempo($respuesta['data'][$clave]['tiempo']);
            $respuesta['data'][$clave]['tiempo'] = $tiempo['horas']."h. ".$tiempo['minutos']."m. ".$tiempo['segundos']."s.";
        }
        $core->print_json($respuesta);
        break;

    case 'itemUpdateObservaEscalon':
        $smarty->assign("type", $type);
        $smarty->assign("observacionId", $observacionId);
        $smarty->assign("id", $id);
        if($type=="update"){
            $item = $subObjItem->get_item($id, "hidra_observacion_dato");
            $tiempo = $subObjItem->segundos_tiempo($item['tiempo']);
            $smarty->assign("tiempo", $tiempo);
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["observacion_escalon_form_sc_index"]);
        break;

    case 'itemupdatesqlObservaEscalon':
        $item['tiempo'] = $subObjItem->tiempo_segundos($item['horas'], $item['minutos'], $item['segundos']);
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_observacion_escalon", $type, "hidra_observacion_dato");
        $core->print_json($respuesta);
        break;

    case 'itemDeleteObservaEscalon':
        $respuesta = $subObjItem->item_delete($id, "hidra_observacion_dato");
        $core->print_json($respuesta);
        break;

    /**
     * Acciones para Recuperacion observacion
     */
    case 'itemGrillaRecuperaObserva':
        $smarty->assign("pozoId", $pozoId);
        $smarty->assign("recuperacionId", $recuperacionId);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_recupera_observa");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["recupera_observa_sc_index"]);
        break;

    case 'getItemListRecuperaObserva':
        $respuesta = $subObjItem->get_item_datatable_Rows("hidra_recupera_observa", "grilla_recupera_observa", "recuperacionId=".$recuperacionId);
        foreach ($respuesta['data'] as $clave => $valor) {
            $respuesta['data'][$clave]['fecha'] = date_format(date_create($valor['fecha']),"d/m/Y");
            $tiempo = $subObjItem->segundos_tiempo($respuesta['data'][$clave]['duracion']);
            $respuesta['data'][$clave]['duracion'] = $tiempo['horas']."h. ".$tiempo['minutos']."m. ".$tiempo['segundos']."s.";
        }
        $core->print_json($respuesta);
        break;

    case 'itemUpdateRecuperaObserva':
        $smarty->assign("type", $type);
        $smarty->assign("recuperacionId", $recuperacionId);
        $smarty->assign("id", $id);
        if($type=="update"){
            $item = $subObjItem->get_item($id, "hidra_recupera_observa");
            $duracion = $subObjItem->segundos_tiempo($item['duracion']);
            $smarty->assign("duracion", $duracion);
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["recupera_observa_form_sc_index"]);
        break;

    case 'itemupdatesqlRecuperaObserva':
        $item['duracion'] = $subObjItem->tiempo_segundos($item['horas'], $item['minutos'], $item['segundos']);
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_recupera_observa", $type, "hidra_recupera_observa");
        $core->print_json($respuesta);
        break;

    case 'itemDeleteRecuperaObserva':
        $respuesta = $subObjItem->item_delete($id, "hidra_recupera_observa");
        $core->print_json($respuesta);
        break;

    /**
     * Acciones para recuperacion observacon escalon
     */
    case 'itemGrillaRecuperaObservaEscalon':
        $smarty->assign("pozoId", $pozoId);
        $smarty->assign("recuperaobservaId", $recuperaobservaId);
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_recupera_observa_escalon");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["recupera_observa_escalon_sc_index"]);
        break;

    case 'getItemListRecuperaObservaEscalon':
        $respuesta = $subObjItem->get_item_datatable_Rows("hidra_recupera_observa_dato", "grilla_recupera_observa_escalon", "recuperaobservaId=".$recuperaobservaId);
        foreach ($respuesta['data'] as $clave => $valor) {
            $tiempo = $subObjItem->segundos_tiempo($respuesta['data'][$clave]['tiempo']);
            $respuesta['data'][$clave]['tiempo'] = $tiempo['horas']."h. ".$tiempo['minutos']."m. ".$tiempo['segundos']."s.";
        }
        $core->print_json($respuesta);
        break;

    case 'itemUpdateRecuperaObservaEscalon':
        $smarty->assign("type", $type);
        $smarty->assign("recuperaobservaId", $recuperaobservaId);
        $smarty->assign("id", $id);
        if($type=="update"){
            $item = $subObjItem->get_item($id, "hidra_recupera_observa_dato");
            $tiempo = $subObjItem->segundos_tiempo($item['tiempo']);
            $smarty->assign("tiempo", $tiempo);
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["recupera_observa_escalon_form_sc_index"]);
        break;

    case 'itemupdatesqlRecuperaObservaEscalon':
        $item['tiempo'] = $subObjItem->tiempo_segundos($item['horas'], $item['minutos'], $item['segundos']);
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_recupera_observa_escalon", $type, "hidra_recupera_observa_dato");
        $core->print_json($respuesta);
        break;

    case 'itemDeleteRecuperaObservaEscalon':
        $respuesta = $subObjItem->item_delete($id, "hidra_recupera_observa_dato");
        $core->print_json($respuesta);
        break;

    /**
     * Acciones para listar pozos
     */
    case 'itemGrillaPozo':
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_pozo");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["pozo_sc_index"]);
        break;

    case 'getItemListPozo':
        $respuesta = $subObjItem->get_item_datatable_Rows("item", "grilla_pozo", "tipo=1");
        $core->print_json($respuesta);
        break;

}