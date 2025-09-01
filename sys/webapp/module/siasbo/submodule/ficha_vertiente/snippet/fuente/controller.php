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
        $grill_list = $subObjItem->get_grilla_list_sbm("grilla_fuente");

        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["sc_index"]);
        break;

    case 'itemupdatesql':
        // var_dump("itemupdatesql",$item,$itemId,"campos_fuente",$type);
        $respuesta = $subObjItem->item_update($item,$itemId,"campos_fuente",$type);
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

        $datofuente = $subObjItem->get_item_fuente($pozoId);
        // var_dump( "DF::",$datofuente[0]);
        $smarty->assign("datofuente", $datofuente[0]);

        switch ($datofuente[0]['tipoFuenteId']) {
            case 1: // Rios
                $smarty->assign("div_uno_row", "display: flex !important;");
                $smarty->assign("div_caudal", "display: block;");
                $smarty->assign("div_tirante", "display: block;");
                $smarty->assign("div_dos_row", "display: flex !important;");
                $smarty->assign("div_flujo", "display: block;");
                $smarty->assign("div_velocidad", "display: block;");
                $smarty->assign("div_tres_row", "display: flex !important;");
                $smarty->assign("div_tipoId", "display: block;");
                $smarty->assign("div_conexionSubterranea", "display: none;");
                $smarty->assign("div_cuatro_row", "display: none;");
                $smarty->assign("div_altura", "display: none;");
                $smarty->assign("div_tipo", "display: none;");
                $smarty->assign("div_fechainstalacion", "display: none;");
                $smarty->assign("div_cinco_row", "display: none;");
                $smarty->assign("div_alturaAgua", "display: none;");
                $smarty->assign("div_alturaBorde", "display: none;");
                $smarty->assign("div_seis_row", "display: none;");
                $smarty->assign("div_conexionesagua", "display: none;");
                $smarty->assign("div_almacenamiento", "display: none;");
                $smarty->assign("div_siete_row", "display: none;");
                $smarty->assign("div_coberturaagua", "display: none;");
                $smarty->assign("div_numero", "display: none;");
                $smarty->assign("div_ocho_row", "display: none;");
                $smarty->assign("div_capacidad", "display: none;");
                $smarty->assign("div_aduccion", "display: none;");
                $smarty->assign("div_nueve_row", "display: none;");
                $smarty->assign("div_red", "display: none;");
                $smarty->assign("div_area", "display: none;");
                break;
            case 2: // Lago
                $smarty->assign("div_uno_row", "display: none;");
                $smarty->assign("div_caudal", "display: none;");
                $smarty->assign("div_tirante", "display: none;");
                $smarty->assign("div_dos_row", "display: none;");
                $smarty->assign("div_flujo", "display: none;");
                $smarty->assign("div_velocidad" , "display: none;");
                $smarty->assign("div_tres_row", "display: flex !important;");
                $smarty->assign("div_tipoId", "display: block;");
                $smarty->assign("div_conexionSubterranea", "display: none;");
                $smarty->assign("div_cuatro_row", "display: flex !important;");
                $smarty->assign("div_altura", "display: block;");
                $smarty->assign("div_tipo", "display: none;");
                $smarty->assign("div_fechainstalacion", "display: none;");
                $smarty->assign("div_cinco_row", "display: none;");
                $smarty->assign("div_alturaAgua" , "display: none;");
                $smarty->assign("div_alturaBorde", "display: none;");
                $smarty->assign("div_seis_row", "display: none;");
                $smarty->assign("div_conexionesagua", "display: none;");
                $smarty->assign("div_almacenamiento", "display: none;");
                $smarty->assign("div_siete_row", "display: none;");
                $smarty->assign("div_coberturaagua", "display: none;");
                $smarty->assign("div_numero", "display: none;");
                $smarty->assign("div_ocho_row", "display: none;");
                $smarty->assign("div_capacidad", "display: none;");
                $smarty->assign("div_aduccion", "display: none;");
                $smarty->assign("div_nueve_row", "display: none;");
                $smarty->assign("div_red", "display: none;");
                $smarty->assign("div_area", "display: none;");

                // $smarty->assign("div_uno_row", "display: block;");
                // $smarty->assign("div_caudal", "display: block;");
                // $smarty->assign("div_tirante", "display: block;");
                // $smarty->assign("div_dos_row", "display: block;");
                // $smarty->assign("div_flujo", "display: block;");
                // $smarty->assign("div_velocidad" , "display: block;");
                // $smarty->assign("div_tres_row", "display: block;");
                // $smarty->assign("div_tipoId", "display: block;");
                // $smarty->assign("div_conexionSubterranea", "display: block;");
                // $smarty->assign("div_cuatro_row", "display: block;");
                // $smarty->assign("div_altura", "display: block;");
                // $smarty->assign("div_tipo", "display: block;");
                // $smarty->assign("div_cinco_row", "display: block;");
                // $smarty->assign("div_alturaAgua" , "display: block;");
                // $smarty->assign("div_alturaBorde", "display: block;");
                // $smarty->assign("div_seis_row", "display: block;");
                // $smarty->assign("div_conexionesagua", "display: block;");
                // $smarty->assign("div_almacenamiento", "display: block;");
                // $smarty->assign("div_siete_row", "display: block;");
                // $smarty->assign("div_coberturaagua", "display: block;");
                // $smarty->assign("div_numero", "display: block;");
                // $smarty->assign("div_ocho_row", "display: block;");
                // $smarty->assign("div_capacidad", "display: block;");
                // $smarty->assign("div_aduccion", "display: block;");
                // $smarty->assign("div_nueve_row", "display: block;");
                // $smarty->assign("div_red", "display: block;");
                // $smarty->assign("div_area", "display: block;");
                break;
            case 3: // Represa
                $smarty->assign("div_uno_row", "display: none;");
                $smarty->assign("div_caudal", "display: none;");
                $smarty->assign("div_tirante", "display: none;");
                $smarty->assign("div_dos_row", "display: none;");
                $smarty->assign("div_flujo", "display: none;");
                $smarty->assign("div_velocidad" , "display: none;");
                $smarty->assign("div_tres_row", "display: flex !important;");
                $smarty->assign("div_tipoId", "display: block;");
                $smarty->assign("div_conexionSubterranea", "display: none;");
                $smarty->assign("div_cuatro_row", "display: flex !important;");
                $smarty->assign("div_altura", "display: block;");
                $smarty->assign("div_tipo", "display: none;");
                $smarty->assign("div_fechainstalacion", "display: none;");
                $smarty->assign("div_cinco_row", "display: none;");
                $smarty->assign("div_alturaAgua" , "display: none;");
                $smarty->assign("div_alturaBorde", "display: none;");
                $smarty->assign("div_seis_row", "display: none;");
                $smarty->assign("div_conexionesagua", "display: none;");
                $smarty->assign("div_almacenamiento", "display: none;");
                $smarty->assign("div_siete_row", "display: none;");
                $smarty->assign("div_coberturaagua", "display: none;");
                $smarty->assign("div_numero", "display: none;");
                $smarty->assign("div_ocho_row", "display: none;");
                $smarty->assign("div_capacidad", "display: none;");
                $smarty->assign("div_aduccion", "display: none;");
                $smarty->assign("div_nueve_row", "display: none;");
                $smarty->assign("div_red", "display: none;");
                $smarty->assign("div_area", "display: none;");
                break;
            case 4: // Qotaña/Vigiña
                $smarty->assign("div_uno_row", "display: none;");
                $smarty->assign("div_caudal", "display: none;");
                $smarty->assign("div_tirante", "display: none;");
                $smarty->assign("div_dos_row", "display: none;");
                $smarty->assign("div_flujo", "display: none;");
                $smarty->assign("div_velocidad" , "display: none;");
                $smarty->assign("div_tres_row", "display: flex !important;");
                $smarty->assign("div_tipoId", "display: none;");
                $smarty->assign("div_conexionSubterranea", "display: block;");
                $smarty->assign("div_cuatro_row", "display: none;");
                $smarty->assign("div_altura", "display: none;");
                $smarty->assign("div_tipo", "display: none;");
                $smarty->assign("div_fechainstalacion", "display: none;");
                $smarty->assign("div_cinco_row", "display: flex !important;");
                $smarty->assign("div_alturaAgua" , "display: block;");
                $smarty->assign("div_alturaBorde", "display: block;");
                $smarty->assign("div_seis_row", "display: flex !important;");
                $smarty->assign("div_conexionesagua", "display: block;");
                $smarty->assign("div_almacenamiento", "display: none;");
                $smarty->assign("div_siete_row", "display: none;");
                $smarty->assign("div_coberturaagua", "display: none;");
                $smarty->assign("div_numero", "display: none;");
                $smarty->assign("div_ocho_row", "display: none;");
                $smarty->assign("div_capacidad", "display: none;");
                $smarty->assign("div_aduccion", "display: none;");
                $smarty->assign("div_nueve_row", "display: none;");
                $smarty->assign("div_red", "display: none;");
                $smarty->assign("div_area", "display: none;");
                break;
            case 5: // Colector de lluvia
                $smarty->assign("div_uno_row", "display: none;");
                $smarty->assign("div_caudal", "display: none;");
                $smarty->assign("div_tirante", "display: none;");
                $smarty->assign("div_dos_row", "display: none;");
                $smarty->assign("div_flujo", "display: none;");
                $smarty->assign("div_velocidad" , "display: none;");
                $smarty->assign("div_tres_row", "display: none;");
                $smarty->assign("div_tipoId", "display: none;");
                $smarty->assign("div_conexionSubterranea", "display: none;");
                $smarty->assign("div_cuatro_row", "display: flex !important;");
                $smarty->assign("div_altura", "display: block;");
                $smarty->assign("div_tipo", "display: none;");
                $smarty->assign("div_fechainstalacion", "display: block;");
                $smarty->assign("div_cinco_row", "display: none;");
                $smarty->assign("div_alturaAgua" , "display: none;");
                $smarty->assign("div_alturaBorde", "display: none;");
                $smarty->assign("div_seis_row", "display: none;");
                $smarty->assign("div_conexionesagua", "display: none;");
                $smarty->assign("div_almacenamiento", "display: none;");
                $smarty->assign("div_siete_row", "display: none;");
                $smarty->assign("div_coberturaagua", "display: none;");
                $smarty->assign("div_numero", "display: none;");
                $smarty->assign("div_ocho_row", "display: none;");
                $smarty->assign("div_capacidad", "display: none;");
                $smarty->assign("div_aduccion", "display: none;");
                $smarty->assign("div_nueve_row", "display: none;");
                $smarty->assign("div_red", "display: none;");
                $smarty->assign("div_area", "display: none;");
                break;
            case 6: // Captación de agua superficial
                $smarty->assign("div_uno_row", "display: flex !important;");
                $smarty->assign("div_caudal", "display: block;");
                $smarty->assign("div_tirante", "display: none;");
                $smarty->assign("div_dos_row", "display: none;");
                $smarty->assign("div_flujo", "display: none;");
                $smarty->assign("div_velocidad" , "display: none;");
                $smarty->assign("div_tres_row", "display: none;");
                $smarty->assign("div_tipoId", "display: none;");
                $smarty->assign("div_conexionSubterranea", "display: none;");
                $smarty->assign("div_cuatro_row", "display: none;");
                $smarty->assign("div_altura", "display: none;");
                $smarty->assign("div_tipo", "display: none;");
                $smarty->assign("div_fechainstalacion", "display: none;");
                $smarty->assign("div_cinco_row", "display: none;");
                $smarty->assign("div_alturaAgua" , "display: none;");
                $smarty->assign("div_alturaBorde", "display: none;");
                $smarty->assign("div_seis_row", "display: flex !important;");
                $smarty->assign("div_conexionesagua", "display: block;");
                $smarty->assign("div_almacenamiento", "display: block;");
                $smarty->assign("div_siete_row", "display: flex !important;");
                $smarty->assign("div_coberturaagua", "display: block;");
                $smarty->assign("div_numero", "display: block;");
                $smarty->assign("div_ocho_row", "display: flex !important;");
                $smarty->assign("div_capacidad", "display: block;");
                $smarty->assign("div_aduccion", "display: block;");
                $smarty->assign("div_nueve_row", "display: flex !important;");
                $smarty->assign("div_red", "display: block;");
                $smarty->assign("div_area", "display: block;");
                break;
            default:
                $smarty->assign("div_uno_row", "display: flex !important;");
                $smarty->assign("div_caudal", "display: block;");
                $smarty->assign("div_tirante", "display: block;");
                $smarty->assign("div_dos_row", "display: flex !important;");
                $smarty->assign("div_flujo", "display: block;");
                $smarty->assign("div_velocidad" , "display: block;");
                $smarty->assign("div_tres_row", "display: flex !important;");
                $smarty->assign("div_tipoId", "display: block;");
                $smarty->assign("div_conexionSubterranea", "display: block;");
                $smarty->assign("div_cuatro_row", "display: flex !important;");
                $smarty->assign("div_altura", "display: block;");
                $smarty->assign("div_tipo", "display: block;");
                $smarty->assign("div_fechainstalacion", "display: block;");
                $smarty->assign("div_cinco_row", "display: flex !important;");
                $smarty->assign("div_alturaAgua" , "display: block;");
                $smarty->assign("div_alturaBorde", "display: block;");
                $smarty->assign("div_seis_row", "display: flex !important;");
                $smarty->assign("div_conexionesagua", "display: block;");
                $smarty->assign("div_almacenamiento", "display: block;");
                $smarty->assign("div_siete_row", "display: flex !important;");
                $smarty->assign("div_coberturaagua", "display: block;");
                $smarty->assign("div_numero", "display: block;");
                $smarty->assign("div_ocho_row", "display: flex !important;");
                $smarty->assign("div_capacidad", "display: block;");
                $smarty->assign("div_aduccion", "display: block;");
                $smarty->assign("div_nueve_row", "display: flex !important;");
                $smarty->assign("div_red", "display: block;");
                $smarty->assign("div_area", "display: block;");
                break;
        }
        // var_dump("itemUpdate",$id,$type,$item);
        if($type=="update"){
            $item = $subObjItem->get_item($id, "superficial");
            $smarty->assign("item", $item);
        }

        $smarty->assign("type", $type);
        // var_dump("itemUpdate",$id,$type,$webm);
        $smarty->assign("subpage", $webm["superficial_sc_index"]);
        break;

    case 'itemDelete':
        $respuesta = $subObjItem->item_delete($id, "superficial");
        $core->print_json($respuesta);
        break;
    
    //Para Graficas
    // case 'getGraficaColumnaSeguimiento':
        //echo $tipoId;
        // $datosSeguimiento = $subObjItem->get_datos_fuente($id);
        // echo json_encode($datosSeguimiento);
        // exit;
        // break;

        // $datosEscalon = $subObjItem->get_datos_fuente($id);
        // if(count($datosEscalon) > 0){
        //     $smarty->assign("datos",json_encode($datosEscalon));
        //     //$smarty->assign("subpage",$webm["escalon_sc_index"]);
        //     $smarty->assign("subpage",$webm["seguimiento_grafico_sc_index"]);
        // }else{
        //     return 0;
        // }
        // break;

        // $datosSeguimiento = $subObjItem->get_datos_fuente($id);
        // if(count($datosSeguimiento) > 0){
        //     $smarty->assign("subpage",$webm["seguimiento_grafico_sc_index"]);
        // }else{
        //     return 0;
        // }        
        
        // break;

    case 'getItemSeguimiento':
        $datosSeguimiento = $subObjItem->get_datos_fuente($id);
        echo json_encode($datosSeguimiento);
        exit;
        break;
}