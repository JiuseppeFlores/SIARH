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
        $acuiferoId = (int) $acuiferoId;
        $pozosTotal = 0;
        $manantialTotal = 0;
        $geofisicaTotal = 0;
        $pozosEpsasTotal = 0;
        $cantidadEpsas = 0;

        $pozosEtiquetas = array();
        $pozosDatos = array();
        $manantialEtiquetas = array();
        $manantialDatos = array();
        $geofisicaEtiquetas = array();
        $geofisicaDatos = array();
        $epsasEtiquetas = array();
        $epsasDatos = array();

        $datosFicha = $subObjItem->get_ficha($acuiferoId);
        if (empty($datosFicha)) {
            echo 0;
            exit();
        }
        $datosFichaEpsas = $subObjItem->get_ficha_epsas($acuiferoId);

        foreach ($datosFicha as $clave => $valor) {
            switch ($valor['fuente_id']) {
                case '1':
                    $pozosTotal += $valor['total'];
                    $pozosEtiquetas[] = $valor['municipio'];
                    $pozosDatos[] = $valor['total'];
                    break;

                case '3':
                    $manantialTotal += $valor['total'];
                    $manantialEtiquetas[] = $valor['municipio'];
                    $manantialDatos[] = $valor['total'];
                    break;

                case '2':
                    $geofisicaTotal += $valor['total'];
                    $geofisicaEtiquetas[] = $valor['municipio'];
                    $geofisicaDatos[] = $valor['total'];
                    break;
            }
        }

        foreach ($pozosDatos as $clave => $valor) {
            $pozosDatos[$clave] = round(($valor*100)/$pozosTotal, 2);
            $pozosEtiquetas[$clave] = $pozosEtiquetas[$clave].' ('.$pozosDatos[$clave].'%)';
        }

        foreach ($manantialDatos as $clave => $valor) {
            $manantialDatos[$clave] = round(($valor*100)/$manantialTotal, 2);
            $manantialEtiquetas[$clave] = $manantialEtiquetas[$clave].' ('.$manantialDatos[$clave].'%)';
        }

        foreach ($geofisicaDatos as $clave => $valor) {
            $geofisicaDatos[$clave] = round(($valor*100)/$geofisicaTotal, 2);
            $geofisicaEtiquetas[$clave] = $geofisicaEtiquetas[$clave].' ('.$geofisicaDatos[$clave].'%)';
        }

        $contador = 0;
        foreach ($datosFichaEpsas as $clave => $valor) {
            $pozosEpsasTotal += $valor['total'];
            $epsasDatos[$contador] = $valor['total'];
            $epsasEtiquetas[$contador] = $valor['epsa'];
            $contador++;
            $cantidadEpsas++;
        }

        foreach ($epsasDatos as $clave => $valor) {
            $epsasDatos[$clave] = round(($valor*100)/$pozosEpsasTotal, 2);
            $epsasEtiquetas[$clave] = $epsasEtiquetas[$clave].' ('.$epsasDatos[$clave].'%)';
        }

        $smarty->assign("acuiferoId", $acuiferoId);
        $smarty->assign("pozosTotal", $pozosTotal);
        $smarty->assign("manantialTotal", $manantialTotal);
        $smarty->assign("geofisicaTotal", $geofisicaTotal);
        $smarty->assign("pozosEpsasTotal", $pozosEpsasTotal);
        $smarty->assign("cantidadEpsas", $cantidadEpsas);
        $smarty->assign("nombreAcuifero", $datosFicha[0]['acuifero']);

        $smarty->assign("subpage",$webm["sc_index"]);

        unset($datosFicha);
        unset($datosFichaEpsas);
        break;

    case 'getConsultaAcuiferoCampania':
        $acuiferoId = (int) $acuiferoId;
        $fecha = explode('-', $campaniaId);

        $pozosTotal = 0;
        $manantialTotal = 0;
        $geofisicaTotal = 0;
        $pozosEpsasTotal = 0;
        $cantidadEpsas = 0;

        $pozosEtiquetas = array();
        $pozosDatos = array();
        $manantialEtiquetas = array();
        $manantialDatos = array();
        $geofisicaEtiquetas = array();
        $geofisicaDatos = array();
        $epsasEtiquetas = array();
        $epsasDatos = array();

        $datosFicha = $subObjItem->get_ficha_campania($acuiferoId, $fecha[0], $fecha[1]);
        if (empty($datosFicha)) {
            echo 0;
            exit();
        }
        $datosFichaEpsas = $subObjItem->get_ficha_epsas_campania($acuiferoId, $fecha[0], $fecha[1]);

        foreach ($datosFicha as $clave => $valor) {
            switch ($valor['fuente_id']) {
                case '1':
                    $pozosTotal += $valor['total'];
                    $pozosEtiquetas[] = $valor['municipio'];
                    $pozosDatos[] = $valor['total'];
                    break;

                case '3':
                    $manantialTotal += $valor['total'];
                    $manantialEtiquetas[] = $valor['municipio'];
                    $manantialDatos[] = $valor['total'];
                    break;

                case '2':
                    $geofisicaTotal += $valor['total'];
                    $geofisicaEtiquetas[] = $valor['municipio'];
                    $geofisicaDatos[] = $valor['total'];
                    break;
            }
        }

        foreach ($pozosDatos as $clave => $valor) {
            $pozosDatos[$clave] = round(($valor*100)/$pozosTotal, 2);
            $pozosEtiquetas[$clave] = $pozosEtiquetas[$clave].' ('.$pozosDatos[$clave].'%)';
        }

        foreach ($manantialDatos as $clave => $valor) {
            $manantialDatos[$clave] = round(($valor*100)/$manantialTotal, 2);
            $manantialEtiquetas[$clave] = $manantialEtiquetas[$clave].' ('.$manantialDatos[$clave].'%)';
        }

        foreach ($geofisicaDatos as $clave => $valor) {
            $geofisicaDatos[$clave] = round(($valor*100)/$geofisicaTotal, 2);
            $geofisicaEtiquetas[$clave] = $geofisicaEtiquetas[$clave].' ('.$geofisicaDatos[$clave].'%)';
        }

        $contador = 0;
        foreach ($datosFichaEpsas as $clave => $valor) {
            $pozosEpsasTotal += $valor['total'];
            $epsasDatos[$contador] = $valor['total'];
            $epsasEtiquetas[$contador] = $valor['epsa'];
            $contador++;
            $cantidadEpsas++;
        }

        foreach ($epsasDatos as $clave => $valor) {
            $epsasDatos[$clave] = round(($valor*100)/$pozosEpsasTotal, 2);
            $epsasEtiquetas[$clave] = $epsasEtiquetas[$clave].' ('.$epsasDatos[$clave].'%)';
        }

        $smarty->assign("acuiferoId", $acuiferoId);
        $smarty->assign("campaniaId", $campaniaId);
        $smarty->assign("pozosTotal", $pozosTotal);
        $smarty->assign("manantialTotal", $manantialTotal);
        $smarty->assign("geofisicaTotal", $geofisicaTotal);
        $smarty->assign("pozosEpsasTotal", $pozosEpsasTotal);
        $smarty->assign("cantidadEpsas", $cantidadEpsas);
        $smarty->assign("nombreAcuifero", $datosFicha[0]['acuifero']);
        
        $smarty->assign("subpage",$webm["consulta_campania_sc_index"]);

        unset($datosFicha);
        unset($datosFichaEpsas);
        break;

    case 'getConsultaAnioPerforacion':
        $acuiferoId = (int) $acuiferoId;
        $anio_perforacion = (int) $anio_perforacion;

        $pozosTotal = 0;
        $pozosEpsasTotal = 0;
        $cantidadEpsas = 0;

        $datosFicha = $subObjItem->get_ficha_anio_perforacion($acuiferoId, $anio_perforacion);
        if (empty($datosFicha)) {
            echo 0;
            exit();
        }
        $datosFichaEpsas = $subObjItem->get_ficha_epsas_anio_perforacion($acuiferoId, $anio_perforacion);

        foreach ($datosFicha as $clave => $valor) {
            $pozosTotal += $valor['total'];
        }

        $contador = 0;
        foreach ($datosFichaEpsas as $clave => $valor) {
            $pozosEpsasTotal += $valor['total'];
            $contador++;
            $cantidadEpsas++;
        }

        $smarty->assign("pozosTotal", $pozosTotal);
        $smarty->assign("pozosEpsasTotal", $pozosEpsasTotal);
        $smarty->assign("cantidadEpsas", $cantidadEpsas);
        $smarty->assign("nombreAcuifero", $datosFicha[0]['acuifero']);
        $smarty->assign("subpage",$webm["consulta_anio_sc_index"]);

        unset($datosFicha);
        unset($datosFichaEpsas);
        break;

    case 'getConsultaProfundidad':
        $acuiferoId = (int) $acuiferoId;
        $profundidad = (int) $profundidad;

        switch ($profundidad) {
            case 1:
                $datosFicha = $subObjItem->get_ficha_profundidad_menor($acuiferoId, 30);
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_profundidad_menor($acuiferoId, 30);
                break;
            case 2:
                $datosFicha = $subObjItem->get_ficha_profundidad($acuiferoId, 30, 60);
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_profundidad($acuiferoId, 30, 60);
                break;
            case 3:
                $datosFicha = $subObjItem->get_ficha_profundidad($acuiferoId, 60, 100);
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_profundidad($acuiferoId, 60, 100);
                break;
            case 4:
                $datosFicha = $subObjItem->get_ficha_profundidad($acuiferoId, 100, 200);
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_profundidad($acuiferoId, 100, 200);
                break;
            case 5:
                $datosFicha = $subObjItem->get_ficha_profundidad($acuiferoId, 200, 300);
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_profundidad($acuiferoId, 200, 300);
                break;
            case 6:
                $datosFicha = $subObjItem->get_ficha_profundidad_mayor($acuiferoId, 300);
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_profundidad_mayor($acuiferoId, 300);
                break;
        }

        $pozosTotal = 0;
        $pozosEpsasTotal = 0;
        $cantidadEpsas = 0;

        if (empty($datosFicha)) {
            echo 0;
            exit();
        }

        foreach ($datosFicha as $clave => $valor) {
            $pozosTotal += $valor['total'];
        }

        $contador = 0;
        foreach ($datosFichaEpsas as $clave => $valor) {
            $pozosEpsasTotal += $valor['total'];
            $contador++;
            $cantidadEpsas++;
        }

        $smarty->assign("pozosTotal", $pozosTotal);
        $smarty->assign("pozosEpsasTotal", $pozosEpsasTotal);
        $smarty->assign("cantidadEpsas", $cantidadEpsas);
        $smarty->assign("nombreAcuifero", $datosFicha[0]['acuifero']);
        $smarty->assign("subpage",$webm["consulta_profundidad_sc_index"]);

        unset($datosFicha);
        unset($datosFichaEpsas);
        break;

    case 'getConsultaUso':
        $acuiferoId = (int) $acuiferoId;
        $pozosTotal = 0;
        $pozosEtiquetas = array();
        $pozosDatos = array();

        $datosFicha = $subObjItem->get_ficha_uso($acuiferoId);
        if ($datosFicha[0]['total'] == '') {
            echo 0;
            exit();
        }

        foreach ($datosFicha as $clave => $valor) {
            $valor['total'] != '' ? $pozosTotal += $valor['total'] : $pozosTotal += 0;
            $pozosEtiquetas[] = $valor['nombre'];
            $valor['total'] != '' ? $pozosDatos[] = $valor['total'] : $pozosDatos[] = 0;
        }

        foreach ($pozosDatos as $clave => $valor) {
            $pozosDatos[$clave] = round(($valor*100)/$pozosTotal, 2);
            $pozosEtiquetas[$clave] = $pozosEtiquetas[$clave].' ('.$valor.' = '.$pozosDatos[$clave].'%)';
        }

        $smarty->assign("pozosTotal", $pozosTotal);
        $smarty->assign("nombreAcuifero", $datosFicha[0]['acuifero']);
        $smarty->assign("pozosCantidadEtiquetas", (count($pozosEtiquetas)/8) < 1 ? 150 : (count($pozosEtiquetas)/8)*150);

        $smarty->assign("pozosEtiquetas",json_encode($pozosEtiquetas));
        $smarty->assign("pozosDatos",json_encode($pozosDatos));
        $smarty->assign("subpage",$webm["consulta_uso_sc_index"]);

        unset($datosFicha);
        break;

    case 'getConsultaProposito':
        $acuiferoId = (int) $acuiferoId;
        $pozosTotal = 0;
        $pozosEtiquetas = array();
        $pozosDatos = array();

        $datosFicha = $subObjItem->get_ficha_proposito($acuiferoId);
        if ($datosFicha[0]['total'] == '') {
            echo 0;
            exit();
        }

        foreach ($datosFicha as $clave => $valor) {
            $valor['total'] != '' ? $pozosTotal += $valor['total'] : $pozosTotal += 0;
            $pozosEtiquetas[] = $valor['nombre'];
            $valor['total'] != '' ? $pozosDatos[] = $valor['total'] : $pozosDatos[] = 0;
        }

        foreach ($pozosDatos as $clave => $valor) {
            $pozosDatos[$clave] = round(($valor*100)/$pozosTotal, 2);
            $pozosEtiquetas[$clave] = $pozosEtiquetas[$clave].' ('.$valor.' = '.$pozosDatos[$clave].'%)';
        }

        $smarty->assign("pozosTotal", $pozosTotal);
        $smarty->assign("nombreAcuifero", $datosFicha[0]['acuifero']);
        $smarty->assign("pozosCantidadEtiquetas", (count($pozosEtiquetas)/8) < 1 ? 150 : (count($pozosEtiquetas)/8)*150);

        $smarty->assign("pozosEtiquetas",json_encode($pozosEtiquetas));
        $smarty->assign("pozosDatos",json_encode($pozosDatos));
        $smarty->assign("subpage",$webm["consulta_proposito_sc_index"]);

        unset($datosFicha);
        break;

    case 'getConsultaCalidad':
        $acuiferoId = (int) $acuiferoId;
        
        if ($campaniaId == '') {
            $datosCalidad = $subObjItem->get_reporte_calidad($acuiferoId);
        } else {
            $fecha = explode('-', $campaniaId);
            $mes = (int) $fecha[0];
            $anio = (int) $fecha[1];
            $datosCalidad = $subObjItem->get_reporte_calidad_campania($acuiferoId, $mes, $anio);
        }
        //$datosCalidad = $subObjItem->get_reporte_calidad($acuiferoId);

        /**funcion consulta($acuifero, $mes,$gestion)
        *parametro:mes valores 1-12
        *parametro:gestion valores ej 2018 */
        $tabla =  $subObjCatalog->consulta();
        $normaRMCH = $subObjCatalog->valoresRMCH();
        /***
        //este metodo o funcion es la misma que consulta con la diferencia que esta filtrando los compuestos quimicos con id (8,27,37,54,59,70,71,75,83,93,94)
        $tabla =  $subObjCatalog->consultaFiltroCompuestosQuimicos();
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
        }
        //lista de parametros existentes
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
        $subObjCatalog->generarExcel($matriz,$pozos,$paramXclase,$paramXNB512);
        break;

    case 'getGraficaPiper':
        $acuiferoId = (int) $acuiferoId;
        $campaniaId = $campaniaId;
        $compuestoEquivalencias = array(
            47 => 61.016,
            54 => 20.04,
            59 => 35.453,
            75 => 12.1525,
            90 => 39.098,
            93 => 22.9898,
            94 => 48.03
        );
        $compuestosDatos = array();
        if ($campaniaId == '') {
            $datosCompuestos = $subObjItem->get_compuestos($acuiferoId);
        } else {
            $fecha = explode('-', $campaniaId);
            $datosCompuestos = $subObjItem->get_compuestos_campania($acuiferoId, $fecha[0], $fecha[1]);
        }
        if (empty($datosCompuestos)) {
            echo 0;
            exit();
        }
        foreach ($datosCompuestos as $clave => $valor) {
            $datos = array();
            $datos['acuifero'] = $valor['acuifero'];
            $datos['nombre'] = $valor['nombre'];
            $datos['codigo'] = $valor['codigo'];
            $compuestosAux = explode(',', $valor['compuestos']);
            $valorAux = explode(',', $valor['valor']);
            $totalCationes = 0;
            $totalAniones = 0;

            foreach ($valorAux as $claveDato => $valorDato) {
                if ($valorDato == NULL || $valorDato == '') {
                    unset($valorAux[$claveDato]);
                    unset($compuestosAux[$claveDato]);
                }
            }

            if (count($compuestosAux) != 7 || count($valorAux) != 7) {
                unset($datos);
                continue;
            }

            foreach ($compuestosAux as $claveAux => $datoAux) {
                switch ($datoAux) {
                    case '47':
                        $datos['valorHco'] = $valorAux[$claveAux] * (1 / $compuestoEquivalencias[$datoAux]);
                        break;
                    case '54':
                        $datos['valorCa'] = $valorAux[$claveAux]  * (1 / $compuestoEquivalencias[$datoAux]);
                        break ; 
                    case '59':
                        $datos['valorCl'] = $valorAux[$claveAux] * (1 / $compuestoEquivalencias[$datoAux]);
                        break;
                    case '75':
                        $datos['valorMg'] = $valorAux[$claveAux] * (1 / $compuestoEquivalencias[$datoAux]);
                        break;
                    case '90':
                        $datos['valorK'] = $valorAux[$claveAux] * (1 / $compuestoEquivalencias[$datoAux]);
                        break;
                    case '93':
                        $datos['valorNa'] = $valorAux[$claveAux] * (1 / $compuestoEquivalencias[$datoAux]);
                        break;
                    case '94':
                        $datos['valorSo'] = $valorAux[$claveAux] * (1 / $compuestoEquivalencias[$datoAux]);
                        break;
                }
            }
            
            $datos['valorNaK'] = $datos['valorNa'] + $datos['valorK'];
            $totalCationes = $datos['valorNaK'] + $datos['valorMg'] + $datos['valorCa'];
            $totalAniones = $datos['valorHco'] + $datos['valorSo'] + $datos['valorCl'];

            $datos['valorNaK'] = ($datos['valorNaK'] * 100) / $totalCationes;
            $datos['valorMg'] = ($datos['valorMg'] * 100) / $totalCationes;
            $datos['valorCa'] = ($datos['valorCa'] * 100) / $totalCationes;
            $datos['valorHco'] = ($datos['valorHco'] * 100) / $totalAniones;
            $datos['valorSo'] = ($datos['valorSo'] * 100) / $totalAniones;
            $datos['valorCl'] = ($datos['valorCl'] * 100) / $totalAniones;
            $compuestosDatos[] = $datos;
            unset($datos);
        }

        if (empty($compuestosDatos)) {
            echo 0;
            exit();
        }

        $campania = $fecha[0]."/".$fecha[1];
        $smarty->assign("compuestosDatos",json_encode($compuestosDatos, JSON_NUMERIC_CHECK));
        $smarty->assign("datoCampania", $campania);
        $smarty->assign("subpage",$webm["piper_sc_index"]);
        break;

    case 'getPuntosPozoAcuifero':
        $acuiferoId = (int) $acuiferoId;
        $fuenteInfo = $subObjItem->get_puntos_acuifero(1, $acuiferoId);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max_acuifero($acuiferoId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosGeofisicaAcuifero':
        $acuiferoId = (int) $acuiferoId;
        $fuenteInfo = $subObjItem->get_puntos_acuifero(2, $acuiferoId);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max_acuifero($acuiferoId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosManantialAcuifero':
        $acuiferoId = (int) $acuiferoId;
        $fuenteInfo = $subObjItem->get_puntos_acuifero(3, $acuiferoId);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max_acuifero($acuiferoId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoCampania':
        $acuiferoId = (int) $acuiferoId;
        $fecha = explode('-', $campaniaId);
        $fuenteInfo = $subObjItem->get_puntos_campania(1, $acuiferoId, $fecha[0], $fecha[1]);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max_acuifero($acuiferoId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosGeofisicaCampania':
        $acuiferoId = (int) $acuiferoId;
        $fecha = explode('-', $campaniaId);
        $fuenteInfo = $subObjItem->get_puntos_campania(2, $acuiferoId, $fecha[0], $fecha[1]);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max_acuifero($acuiferoId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosManantialCampania':
        $acuiferoId = (int) $acuiferoId;
        $fecha = explode('-', $campaniaId);
        $fuenteInfo = $subObjItem->get_puntos_campania(3, $acuiferoId);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max_acuifero($acuiferoId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoAnioPerforacion':
        $acuiferoId = (int) $acuiferoId;
        $anio_perforacion = (int) $anio_perforacion;
        $fuenteInfo = $subObjItem->get_puntos_anio_perforacion($acuiferoId, $anio_perforacion);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max_acuifero_pozos($acuiferoId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoProfundidad':
        $acuiferoId = (int) $acuiferoId;
        $profundidad = (int) $profundidad;
        switch ($profundidad) {
            case 1:
                $fuenteInfo = $subObjItem->get_puntos_profundidad_menor($acuiferoId, 30);
                break;
            case 2:
                $fuenteInfo = $subObjItem->get_puntos_profundidad($acuiferoId, 30, 60);
                break;
            case 3:
                $fuenteInfo = $subObjItem->get_puntos_profundidad($acuiferoId, 60, 100);
                break;
            case 4:
                $fuenteInfo = $subObjItem->get_puntos_profundidad($acuiferoId, 100, 200);
                break;
            case 5:
                $fuenteInfo = $subObjItem->get_puntos_profundidad($acuiferoId, 200, 300);
                break;
            case 6:
                $fuenteInfo = $subObjItem->get_puntos_profundidad_mayor($acuiferoId, 300);
                break;
        }
        //$fuenteInfo = $subObjItem->get_puntos_profundidad($acuiferoId, $profundidad);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max_acuifero_pozos($acuiferoId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoUso':
        $acuiferoId = (int) $acuiferoId;
        $fuenteInfo = $subObjItem->get_puntos_uso($acuiferoId);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max_acuifero_pozos($acuiferoId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoProposito':
        $acuiferoId = (int) $acuiferoId;
        $fuenteInfo = $subObjItem->get_puntos_proposito($acuiferoId);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max_acuifero_pozos($acuiferoId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getFormConsulta':
        $subObjCatalog->conf_catalog_datos_general();
        $cataobj = $subObjCatalog->getCatalogList();
        $smarty->assign("cataobj", $cataobj);
        $smarty->assign("subpage",$webm["consulta_sc_index"]);
        break;

    case 'getCampanias':
        $respuesta = $subObjItem->get_campanias($acuiferoId);
        $core->print_json($respuesta);
        break;

    case 'getAnioPerforacion':
        $acuiferoId = (int) $acuiferoId;
        $anioPerforacion = $subObjItem->get_anio_perforacion($acuiferoId);
        echo json_encode($anioPerforacion, JSON_NUMERIC_CHECK);
        exit();
        break;

    case 'getDescargarPozosExcel':
        $acuiferoId = (int) $acuiferoId;
        /*$metadatos = array(
                'titulo' => 'Reporte de pozos',
                'asunto' => 'Reporte de pozos',
                'descripcion' => 'Reporte de pozos por acuífero',
                'palabras_clave' => 'pozos',
                'categoria' => 'pozos',
            );
        $tituloDocumento = 'REPORTE DE POZOS POR ACUÍFERO';
        $subObjItem->get_datos_pozos_excel($metadatos, $tituloDocumento, $acuiferoId);*/
        date_default_timezone_set('America/La_Paz');
        $nombreArchivo = "REPORTE_POZOS_ACUIFERO_".date('d-m-Y').'_'.date('H:i').'.csv';
        $tituloDocumento = 'REPORTE DE POZOS POR ACUÍFERO';
        $subObjItem->get_archivo_csv($tituloDocumento, $nombreArchivo, $acuiferoId);
        exit();
        break;

    case 'getGraficaIsotopicos':
        // $epsaId = (int) $epsaId;
        // $datosIsotopicos = $subObjItem->get_isotopicos($epsaId, '01', '2010');
        // $smarty->assign("datosIsotopicos",json_encode($datosIsotopicos));
        // $smarty->assign("subpage",$webm["isotopico_sc_index"]);
        // break;
        $acuiferoId = (int) $acuiferoId;
        $campanias = $subObjItem->get_campanias_isotopico($acuiferoId);
        $smarty->assign("campanias",json_encode($campanias));
        $smarty->assign("acuiferoId",$acuiferoId);
        $smarty->assign("subpage",$webm["isotopico_sc_index"]);

        // $epsaId = (int) $epsaId;
        // $campanias = $subObjItem->get_campanias_isotopico($epsaId);
        // $smarty->assign("campanias",json_encode($campanias));
        // $smarty->assign("epsaId",$epsaId);
        // $smarty->assign("subpage",$webm["isotopico_sc_index"]);
        break;

    case 'getDatosIsotopicos':
        $fecha = explode('/', $campaniaId);        
        $mes = (int) $fecha[0];
        $anio = (int) $fecha[1];
        $acuiferoId = (int) $acuiferoId;
        //$datosIsotopicos = $subObjItem->get_isotopicos($epsaId, '01', '2010');
        $datosIsotopicos = $subObjItem->get_isotopicos($acuiferoId, $mes, $anio);
        echo json_encode($datosIsotopicos);
        exit();
        // $smarty->assign("datosIsotopicos",json_encode($datosIsotopicos));
        // $smarty->assign("subpage",$webm["isotopico_sc_index"]);
        break;

    case 'codice':
        echo "Definir función...";
        break;
}