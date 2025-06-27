<?php
/**
 * Created by PhpStorm.
 * User: henrytaby
 * Date: 3/5/2018
 * Time: 15:27
 */

switch($accion) {
    /**
     * Página por defecto
     */
    default:
        /**funcion consulta($acuifero, $mes,$gestion)
        *parametro:mes valores 1-12
        *parametro:gestion valores ej 2018 */
        $tabla =  $objCatalog->consulta();
        $normaRMCH = $objCatalog->valoresRMCH();
        /***
        //este metodo o funcion es la misma que consulta con la diferencia que esta filtrando los compuestos quimicos con id (8,27,37,54,59,70,71,75,83,93,94)
        $tabla =  $objCatalog->consultaFiltroCompuestosQuimicos();
        */
        //lista de pozos existentes
        $pozos = [];
        foreach ($tabla as $k => $fila) {
            $sw = 0;
            foreach ($pozos as $key => $pozo) {
                if($key == $fila['itemId']){
                    $sw = 1;
                    break;
                }
            }
            if($sw == 0){
                //$pozos[$fila['itemId']] = $fila['pozo'];
                $codigo = explode("/",$fila['pozo']);
                $pozos[$fila['itemId']] = end($codigo);
            }
        }//lista de parametros existentes
        $parametros = [];
        foreach ($tabla as $k => $fila) {
            $sw = 0;
            foreach ($parametros as $key => $parametro) {
                if($key == $fila['parametro']){
                    $sw = 1;
                    break;
                }
            }
            if($sw == 0){
                $par = explode(" (",$fila['nombre']);
                $parametros[$fila['parametro']]['unidad'] = str_replace(")","",array_pop($par));
                $parametros[$fila['parametro']]['nombre'] = implode("",$par);
            }
        }
        //creacion y construccion de matriz parametros-pozos
        $paramXpozos = [];
        $paramXclase = [];
        $paramXNB512 = [];
        foreach ($parametros as $k => $fila) {
            foreach ($pozos as $key => $pozo) {
                $paramXpozos[$k][$key] = '';
                $paramXclase[$k]['item'] = '';
                $paramXclase[$k]['claseAmin'] = '';
                $paramXclase[$k]['claseAmax'] = '';
                $paramXclase[$k]['claseBmin'] = '';
                $paramXclase[$k]['claseBmax'] = '';
                $paramXclase[$k]['claseCmin'] = '';
                $paramXclase[$k]['claseCmax'] = '';
                $paramXclase[$k]['claseDmin'] = '';
                $paramXclase[$k]['claseDmax'] = '';
                $paramXclase[$k]['formato'] = '';
                $paramXclase[$k]['cancerigeno'] = '';
                $paramXNB512[$k]['min'] = '';
                $paramXNB512[$k]['max'] = '';
                $paramXNB512[$k]['formato'] = '';
            }
        }
        foreach ($tabla as $f => $fila) {
            $para = $fila['parametro'];
            $paramXpozos[$para][$fila['itemId']] = $fila['valor'];
            if(is_array($normaRMCH[$para])){
                $paramXclase[$para]['item'] = $normaRMCH[$para]['item'];
                $paramXclase[$para]['claseAmin'] = $normaRMCH[$para]['claseA']['min'];
                $paramXclase[$para]['claseAmax'] = $normaRMCH[$para]['claseA']['max'];
                $paramXclase[$para]['claseBmin'] = $normaRMCH[$para]['claseB']['min'];
                $paramXclase[$para]['claseBmax'] = $normaRMCH[$para]['claseB']['max'];
                $paramXclase[$para]['claseCmin'] = $normaRMCH[$para]['claseC']['min'];
                $paramXclase[$para]['claseCmax'] = $normaRMCH[$para]['claseC']['max'];
                $paramXclase[$para]['claseDmin'] = $normaRMCH[$para]['claseD']['min'];
                $paramXclase[$para]['claseDmax'] = $normaRMCH[$para]['claseD']['max'];
            }
            unset($paramXclase[$para]['nombre']);
            unset($paramXclase[$para]['unidad']);
        }
        //generar nueva tabla con nombres de los parametros
        $matriz = [];
        foreach ($paramXpozos as $k => $fila) {
            $matriz[$k]['parametro'] =  $parametros[$k]['nombre'];
            $matriz[$k]['unidad'] =  $parametros[$k]['unidad'];
            foreach ($fila as $key => $celda) {
                $matriz[$k][$key] = $celda;
            } 
        }
        //generar nueva tabla con nombres de los parametros y pozos
        $matriz2 = [];
        foreach ($paramXpozos as $k => $fila) {
            $matriz2[$k]['parametro'] =  $parametros[$k]['nombre'];
            $matriz2[$k]['unidad'] =  $parametros[$k]['unidad'];
            foreach ($fila as $key => $celda) {
                $matriz2[$k][$pozos[$key]] = $celda;
            } 
        }
//print_struc($paramXNB512);exit;
        $objCatalog->generarExcel($matriz,$pozos,$paramXclase,$paramXNB512);
        $pagina = $templateDir."tabla.tpl";
        $smarty->assign("matriz",$matriz);
        $smarty->assign("pozos",$pozos);
        $smarty->assign("subpage", $pagina);
    /*@set_time_limit(0);
            ini_set('memory_limit','8000M');
            //print_struc($_REQUEST);
            $objItem->getExcelFile($item,$userprint);
            exit;*/
        break;



}

