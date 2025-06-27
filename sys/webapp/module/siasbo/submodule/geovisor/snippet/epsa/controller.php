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
        $epsaId = (int) $epsaId;
        $pozosTotal = 0;
        $manantialTotal = 0;
        $captacionTotal = 0;

        $pozosEtiquetas = array();
        $pozosDatos = array();

        $datosFicha = $subObjItem->get_ficha($epsaId);
        if (empty($datosFicha)) {
            echo 0;
            exit();
        }

        foreach ($datosFicha as $clave => $valor) {
            switch ($valor['fuente_id']) {
                case '1':
                    $pozosTotal += $valor['total'];
                    $pozosEtiquetas[] = $valor['municipio'];
                    $pozosDatos[] = $valor['total'];
                    break;

                case '3':
                    $manantialTotal += $valor['total'];
                    break;

                case '4':
                    $captacionTotal += $valor['total'];
                    break;
            }
        }

        foreach ($pozosDatos as $clave => $valor) {
            $pozosDatos[$clave] = round(($valor*100)/$pozosTotal, 2);
            $pozosEtiquetas[$clave] = $pozosEtiquetas[$clave].' ('.$pozosDatos[$clave].'%)';
        }

        $caudalPozos = 0;
        $caudalProduccionPozos = $subObjItem->get_caudal_pozos($epsaId);
        if (!empty($caudalProduccionPozos)) {
            $caudalPozos = round($caudalProduccionPozos[0]['total_caudal'], 2);
        }
        $caudalManantiales = 0;
        $caudalProduccionManantiales = $subObjItem->get_caudal_manantiales($epsaId);
        if (!empty($caudalProduccionManantiales)) {
            $caudalManantiales = round($caudalProduccionManantiales[0]['total_caudal'], 2);
        }

        $smarty->assign("epsaId", $epsaId);

        $smarty->assign("pozosTotal", $pozosTotal);
        $smarty->assign("manantialTotal", $manantialTotal);
        $smarty->assign("captacionTotal", $captacionTotal);
        $smarty->assign("nombreEpsa", $datosFicha[0]['epsa']);

        $smarty->assign("pozosEtiquetas",json_encode($pozosEtiquetas));
        $smarty->assign("pozosDatos",json_encode($pozosDatos));

        $smarty->assign("caudalProduccionPozos", $caudalPozos);
        $smarty->assign("caudalProduccionManantiales", $caudalManantiales);
        
        $smarty->assign("subpage",$webm["sc_index"]);
        break;

    case 'getConsultaAnioPerforacion':
        $epsaId = (int) $epsaId;
        $anio_perforacion = (int) $anio_perforacion;
        $pozosTotal = 0;

        $datosFicha = $subObjItem->get_ficha_anio_perforacion($epsaId, $anio_perforacion);
        if (empty($datosFicha)) {
            echo 0;
            exit();
        }

        foreach ($datosFicha as $clave => $valor) {
            $pozosTotal += $valor['total'];
        }

        $smarty->assign("pozosTotal", $pozosTotal);
        $smarty->assign("nombreEpsa", $datosFicha[0]['epsa']);
        $smarty->assign("subpage",$webm["consulta_anio_sc_index"]);

        unset($datosFicha);
        break;

    case 'getConsultaProfundidad':
        $epsaId = (int) $epsaId;
        $profundidad = (int) $profundidad;

        switch ($profundidad) {
            case 1:
                $datosFicha = $subObjItem->get_ficha_profundidad_menor($epsaId, 30);
                break;
            case 2:
                $datosFicha = $subObjItem->get_ficha_profundidad($epsaId, 30, 60);
                break;
            case 3:
                $datosFicha = $subObjItem->get_ficha_profundidad($epsaId, 60, 100);
                break;
            case 4:
                $datosFicha = $subObjItem->get_ficha_profundidad($epsaId, 100, 200);
                break;
            case 5:
                $datosFicha = $subObjItem->get_ficha_profundidad($epsaId, 200, 300);
                break;
            case 6:
                $datosFicha = $subObjItem->get_ficha_profundidad_mayor($epsaId, 300);
                break;
        }

        $pozosTotal = 0;

        if (empty($datosFicha)) {
            echo 0;
            exit();
        }

        foreach ($datosFicha as $clave => $valor) {
            $pozosTotal += $valor['total'];
        }

        $smarty->assign("pozosTotal", $pozosTotal);
        $smarty->assign("nombreEpsa", $datosFicha[0]['epsa']);
        $smarty->assign("subpage",$webm["consulta_profundidad_sc_index"]);

        unset($datosFicha);
        break;

    case 'getConsultaUso':
        $epsaId = (int) $epsaId;
        $pozosTotal = 0;
        $pozosEtiquetas = array();
        $pozosDatos = array();

        $datosFicha = $subObjItem->get_ficha_uso($epsaId);
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
        $smarty->assign("nombreEpsa", $datosFicha[0]['epsa']);
        $smarty->assign("pozosCantidadEtiquetas", (count($pozosEtiquetas)/8) < 1 ? 150 : (count($pozosEtiquetas)/8)*150);

        $smarty->assign("pozosEtiquetas",json_encode($pozosEtiquetas));
        $smarty->assign("pozosDatos",json_encode($pozosDatos));
        $smarty->assign("subpage",$webm["consulta_uso_sc_index"]);

        unset($datosFicha);
        break;

    case 'getConsultaProposito':
        $epsaId = (int) $epsaId;
        $pozosTotal = 0;
        $pozosEtiquetas = array();
        $pozosDatos = array();

        $datosFicha = $subObjItem->get_ficha_proposito($epsaId);
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
        $smarty->assign("nombreEpsa", $datosFicha[0]['epsa']);
        $smarty->assign("pozosCantidadEtiquetas", (count($pozosEtiquetas)/8) < 1 ? 150 : (count($pozosEtiquetas)/8)*150);

        $smarty->assign("pozosEtiquetas",json_encode($pozosEtiquetas));
        $smarty->assign("pozosDatos",json_encode($pozosDatos));
        $smarty->assign("subpage",$webm["consulta_proposito_sc_index"]);

        unset($datosFicha);
        break;

    case 'getPuntosPozo':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $epsaId = (int) $epsaId;
        $fuenteInfo = $subObjItem->get_puntos(1, $epsaId);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max($epsaId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosGeofisica':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $epsaId = (int) $epsaId;
        $fuenteInfo = $subObjItem->get_puntos(2, $epsaId);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max($epsaId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosManantial':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $epsaId = (int) $epsaId;
        $fuenteInfo = $subObjItem->get_puntos(3, $epsaId);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max($epsaId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoAnioPerforacion':
        $epsaId = (int) $epsaId;
        $anio_perforacion = (int) $anio_perforacion;
        $fuenteInfo = $subObjItem->get_puntos_anio_perforacion($epsaId, $anio_perforacion);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max_epsa_pozos($epsaId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoProfundidad':
        $epsaId = (int) $epsaId;
        $profundidad = (int) $profundidad;
        switch ($profundidad) {
            case 1:
                $fuenteInfo = $subObjItem->get_puntos_profundidad_menor($epsaId, 30);
                break;
            case 2:
                $fuenteInfo = $subObjItem->get_puntos_profundidad($epsaId, 30, 60);
                break;
            case 3:
                $fuenteInfo = $subObjItem->get_puntos_profundidad($epsaId, 60, 100);
                break;
            case 4:
                $fuenteInfo = $subObjItem->get_puntos_profundidad($epsaId, 100, 200);
                break;
            case 5:
                $fuenteInfo = $subObjItem->get_puntos_profundidad($epsaId, 200, 300);
                break;
            case 6:
                $fuenteInfo = $subObjItem->get_puntos_profundidad_mayor($epsaId, 300);
                break;
        }
        //$fuenteInfo = $subObjItem->get_puntos_profundidad($epsaId, $profundidad);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max_epsa_pozos($epsaId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoUso':
        $epsaId = (int) $epsaId;
        $fuenteInfo = $subObjItem->get_puntos_uso($epsaId);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max_epsa_pozos($epsaId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoProposito':
        $epsaId = (int) $epsaId;
        $fuenteInfo = $subObjItem->get_puntos_proposito($epsaId);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max_epsa_pozos($epsaId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getGraficaPiper':
        $epsaId = (int) $epsaId;
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
        $datosCompuestos = $subObjItem->get_compuestos($epsaId);
        if (empty($datosCompuestos)) {
            echo 0;
            exit();
        }
        foreach ($datosCompuestos as $clave => $valor) {
            $datos = array();
            $datos['epsa'] = $valor['epsa'];
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

        $smarty->assign("compuestosDatos",json_encode($compuestosDatos, JSON_NUMERIC_CHECK));
        $smarty->assign("subpage",$webm["piper_sc_index"]);
        break;

    case 'getGraficaCaudales':
        $epsaId = (int) $epsaId;
        $datosCaudales = $subObjItem->get_caudal_caudalautorizado($epsaId);
        $smarty->assign("datosCaudales",json_encode($datosCaudales));
        $smarty->assign("subpage",$webm["caudal_sc_index"]);
        break;

    case 'getGraficaIsotopicos':
        // $epsaId = (int) $epsaId;
        // $datosIsotopicos = $subObjItem->get_isotopicos($epsaId, '01', '2010');
        // $smarty->assign("datosIsotopicos",json_encode($datosIsotopicos));
        // $smarty->assign("subpage",$webm["isotopico_sc_index"]);
        // break;

        $epsaId = (int) $epsaId;
        $campanias = $subObjItem->get_campanias($epsaId);
        $smarty->assign("campanias",json_encode($campanias));
        $smarty->assign("epsaId",$epsaId);
        $smarty->assign("subpage",$webm["isotopico_sc_index"]);
        break;

    case 'getDatosIsotopicos':
        $fecha = explode('/', $campaniaId);        
        $mes = (int) $fecha[0];
        $anio = (int) $fecha[1];
        $epsaId = (int) $epsaId;
        //$datosIsotopicos = $subObjItem->get_isotopicos($epsaId, '01', '2010');
        $datosIsotopicos = $subObjItem->get_isotopicos($epsaId, $mes, $anio);
        echo json_encode($datosIsotopicos);
        exit();
        // $smarty->assign("datosIsotopicos",json_encode($datosIsotopicos));
        // $smarty->assign("subpage",$webm["isotopico_sc_index"]);
        break;

    case 'getAnioPerforacion':
        $epsaId = (int) $epsaId;
        $anioPerforacion = $subObjItem->get_anio_perforacion($epsaId);
        echo json_encode($anioPerforacion, JSON_NUMERIC_CHECK);
        exit();
        break;

    case 'getFormConsulta':
        $subObjCatalog->conf_catalog_datos_general();
        $cataobj = $subObjCatalog->getCatalogList();
        $smarty->assign("cataobj", $cataobj);
        $smarty->assign("subpage",$webm["form_consulta_sc_index"]);
        break;

    case 'getDescargarPozosExcel':
        $epsaId = (int) $epsaId;
        /*$metadatos = array(
                'titulo' => 'Reporte de pozos',
                'asunto' => 'Reporte de pozos',
                'descripcion' => 'Reporte de pozos por EPSA',
                'palabras_clave' => 'pozos',
                'categoria' => 'pozos',
            );
        $tituloDocumento = 'REPORTE DE POZOS POR EPSA';
        $subObjItem->get_datos_pozos_excel($metadatos, $tituloDocumento, $epsaId);*/
        date_default_timezone_set('America/La_Paz');
        $nombreArchivo = "REPORTE_POZOS_EPSA_".date('d-m-Y').'_'.date('H:i').'.csv';
        $tituloDocumento = 'REPORTE DE POZOS POR EPSA';
        $subObjItem->get_archivo_csv($tituloDocumento, $nombreArchivo, $epsaId);
        exit();
        break;

    case 'codice':
        echo "Definir función...";
        break;
}