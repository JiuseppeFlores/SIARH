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
        echo "Defina una acción.";
        break;    

    case 'getItemStiff':
        // echo $id;
        // exit();
        $campanias = $subObjItem->get_campanias($id);
        //$datosStiff = $subObjItem->get_datos_stiff($id, $mes, $anio);
        //echo json_encode($datosStiff);
        /*if (empty($datosStiff)) {
            return 0;
            exit();
        }*/
        $smarty->assign("pozoId",$id);
        $smarty->assign("campanias",$campanias);
        //$smarty->assign("datosStiff",json_encode($datosStiff));
        $smarty->assign("subpage",$webm["stiff_sc_index"]);
        break;

    case 'getDatosStiff':
        $pozoId = (int) $pozoId;
        $fecha = explode('-', $campaniaId);
        $mes = (int) $fecha[0];
        $anio = (int) $fecha[1];
        $datosStiff = $subObjItem->get_datos_stiff($pozoId, $mes, $anio);
        //echo json_encode($datosStiff);
        if (empty($datosStiff)) {
            echo 0;
            exit();
        }
        echo json_encode($datosStiff);
        exit;
        //$smarty->assign("pozoId",$id);
        //$smarty->assign("campanias",$campanias);
        //$smarty->assign("datosStiff",json_encode($datosStiff));
        //$smarty->assign("subpage",$webm["stiff_sc_index"]);
        break;

    case 'getGraficaDiseno':
        $smarty->assign("pozoId", $pozoId);
        $datosPozo = $subObjItem->get_datos_pozo($pozoId);
        $datosDiseno = $subObjItem->get_datos_diseno($pozoId);
        if (empty($datosDiseno) && $datosPozo[0]['profundidad'] == '') {
            return 0;
            exit();
        }
        $datosPozo[0]['rejillafiltro'] = $datosDiseno;
        $smarty->assign("datosPozo", json_encode($datosPozo));
        $smarty->assign("subpage", $webm["diseno_sc_index"]);
        break;

    case 'getGraficaColumnaLitologica':
        $datosLitologia = $subObjItem->get_datos_litologia($id);
        if(count($datosLitologia) > 0){
            $smarty->assign("subpage",$webm["columnalitologica_sc_index"]);
        }else{
            return 0;
        }        
        
        break;

    case 'getItemLitologia':
        $datosLitologia = $subObjItem->get_datos_litologia($id);
        echo json_encode($datosLitologia);
        exit;
        break;

    case 'getGraficaCaudal':
        $datosCaudal = $subObjItem->get_datos_caudal($id);
        if(count($datosCaudal) > 0){
            $smarty->assign("subpage",$webm["caudal_sc_index"]); 
        }else{
            return 0;
        }      
        
        break;

    case 'getItemCaudal':
        $datosCaudal = $subObjItem->get_datos_caudal($id);
        echo json_encode($datosCaudal);
        exit;
        break;

    case 'getGraficaAbatimiento':
        $datosAbatimiento = $subObjItem->get_datos_abatimiento($id);
        if(count($datosAbatimiento) > 0){
            $smarty->assign("subpage",$webm["abatimiento_sc_index"]);
        }else{
            return 0;
        }

        break;    

    case 'getItemAbatimiento':
        $datosAbatimiento = $subObjItem->get_datos_abatimiento($id);
        echo json_encode($datosAbatimiento);
        exit;
        break;

    case 'getGraficaEscalon':
        $subObjCatalog->conf_catalog_datos_hidra();
        $tiposBombeo = ($subObjCatalog->getCatalogList())['tipo_bombeo'];

        $tipo = $subObjItem->get_tipo_escalon_pozo($id);
        $datosEscalon = $subObjItem->get_datos_escalon($id, $tipo);

        if(count($datosEscalon) > 0){
            $smarty->assign("tipo",$tipo);
            $smarty->assign("datos",json_encode($datosEscalon));
            $smarty->assign("subpage",$webm["escalon_sc_index"]);
            $smarty->assign("tiposBombeo",json_encode($tiposBombeo));
        }else{
            return 0;
        }

        break;

    case 'getItemEscalon':
        $datosEscalon = $subObjItem->get_datos_escalon($tipoId);
        echo json_encode($datosEscalon);
        exit;
        break;

    case 'getGraficaRecuperacion':
        $datosRecuperacion = $subObjItem->get_datos_recuperacion($id);
        if(count($datosRecuperacion) > 0){
            $smarty->assign("datos",json_encode($datosRecuperacion));
            $smarty->assign("subpage",$webm["recuperacion_sc_index"]);
        }else{
            return 0;
        }

        break;

    case 'codice':
        echo "Definir función...";
        break;
}