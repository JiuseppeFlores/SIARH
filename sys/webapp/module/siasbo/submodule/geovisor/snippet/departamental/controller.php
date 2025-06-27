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
        $deptoId = (int) $deptoId;
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

        $datosFicha = $subObjItem->get_ficha($deptoId);
        if (empty($datosFicha)) {
            echo 0;
            exit();
        }
        $datosFichaEpsas = $subObjItem->get_ficha_epsas($deptoId);

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
            $pozosEtiquetas[$clave] = $pozosEtiquetas[$clave].' ('.$valor.' = '.$pozosDatos[$clave].'%)';
        }

        foreach ($manantialDatos as $clave => $valor) {
            $manantialDatos[$clave] = round(($valor*100)/$manantialTotal, 2);
            $manantialEtiquetas[$clave] = $manantialEtiquetas[$clave].' ('.$valor.' = '.$manantialDatos[$clave].'%)';
        }

        foreach ($geofisicaDatos as $clave => $valor) {
            $geofisicaDatos[$clave] = round(($valor*100)/$geofisicaTotal, 2);
            $geofisicaEtiquetas[$clave] = $geofisicaEtiquetas[$clave].' ('.$valor.' = '.$geofisicaDatos[$clave].'%)';
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
            $epsasEtiquetas[$clave] = $epsasEtiquetas[$clave].' ('.$valor.' = '.$epsasDatos[$clave].'%)';
        }

        $smarty->assign("pozosTotal", $pozosTotal);
        $smarty->assign("manantialTotal", $manantialTotal);
        $smarty->assign("geofisicaTotal", $geofisicaTotal);
        $smarty->assign("pozosEpsasTotal", $pozosEpsasTotal);
        $smarty->assign("cantidadEpsas", $cantidadEpsas);
        $smarty->assign("nombreDepto", $datosFicha[0]['departamento']);

        $smarty->assign("pozosCantidadEtiquetas", (count($pozosEtiquetas)/8) < 1 ? 150 : (count($pozosEtiquetas)/8)*150);
        $smarty->assign("epsasCantidadEtiquetas", (count($epsasEtiquetas)/8) < 1 ? 150 : (count($epsasEtiquetas)/8)*150);
        $smarty->assign("manantialCantidadEtiquetas", (count($manantialEtiquetas)/8) < 1 ? 150 : (count($manantialEtiquetas)/8)*150);
        $smarty->assign("geofisicaCantidadEtiquetas", (count($geofisicaEtiquetas)/8) < 1 ? 150 : (count($geofisicaEtiquetas)/8)*150);

        $smarty->assign("pozosEtiquetas",json_encode($pozosEtiquetas));
        $smarty->assign("pozosDatos",json_encode($pozosDatos));

        $smarty->assign("manantialEtiquetas",json_encode($manantialEtiquetas));
        $smarty->assign("manantialDatos",json_encode($manantialDatos));

        $smarty->assign("geofisicaEtiquetas",json_encode($geofisicaEtiquetas));
        $smarty->assign("geofisicaDatos",json_encode($geofisicaDatos));

        $smarty->assign("epsasEtiquetas",json_encode($epsasEtiquetas));
        $smarty->assign("epsasDatos",json_encode($epsasDatos));

        $smarty->assign("deptoId",$deptoId);

        $smarty->assign("subpage",$webm["sc_index"]);

        unset($datosFicha);
        unset($datosFichaEpsas);
        break;

    case 'getConsultaAnioPerforacion':
        $deptoId = (int) $deptoId;
        $anio_perforacion = (int) $anio_perforacion;

        $pozosTotal = 0;
        $pozosEpsasTotal = 0;
        $cantidadEpsas = 0;

        $pozosEtiquetas = array();
        $pozosDatos = array();
        $epsasEtiquetas = array();
        $epsasDatos = array();

        $datosFicha = $subObjItem->get_ficha_anio_perforacion($deptoId, $anio_perforacion);
        if (empty($datosFicha)) {
            echo 0;
            exit();
        }
        $datosFichaEpsas = $subObjItem->get_ficha_epsas_anio_perforacion($deptoId, $anio_perforacion);

        foreach ($datosFicha as $clave => $valor) {
            switch ($valor['fuente_id']) {
                case '1':
                    $pozosTotal += $valor['total'];
                    $pozosEtiquetas[] = $valor['municipio'];
                    $pozosDatos[] = $valor['total'];
                    break;
            }
        }

        $contador = 0;
        foreach ($datosFichaEpsas as $clave => $valor) {
            $pozosEpsasTotal += $valor['total'];
            $epsasDatos[$contador] = $valor['total'];
            $epsasEtiquetas[$contador] = $valor['epsa'];
            $contador++;
            $cantidadEpsas++;
        }

        foreach ($pozosDatos as $clave => $valor) {
            $pozosDatos[$clave] = round(($valor*100)/$pozosTotal, 2);
            $pozosEtiquetas[$clave] = $pozosEtiquetas[$clave].' ('.$valor.' = '.$pozosDatos[$clave].'%)';
        }

        foreach ($epsasDatos as $clave => $valor) {
            $epsasDatos[$clave] = round(($valor*100)/$pozosEpsasTotal, 2);
            $epsasEtiquetas[$clave] = $epsasEtiquetas[$clave].' ('.$valor.' = '.$epsasDatos[$clave].'%)';
        }

        $smarty->assign("pozosTotal", $pozosTotal);
        $smarty->assign("pozosEpsasTotal", $pozosEpsasTotal);
        $smarty->assign("cantidadEpsas", $cantidadEpsas);
        $smarty->assign("nombreDepto", $datosFicha[0]['departamento']);

        $smarty->assign("pozosCantidadEtiquetas", (count($pozosEtiquetas)/8) < 1 ? 150 : (count($pozosEtiquetas)/8)*150);
        $smarty->assign("epsasCantidadEtiquetas", (count($epsasEtiquetas)/8) < 1 ? 150 : (count($epsasEtiquetas)/8)*150);

        $smarty->assign("pozosEtiquetas",json_encode($pozosEtiquetas));
        $smarty->assign("pozosDatos",json_encode($pozosDatos));

        $smarty->assign("epsasEtiquetas",json_encode($epsasEtiquetas));
        $smarty->assign("epsasDatos",json_encode($epsasDatos));
        
        $smarty->assign("subpage",$webm["consulta_anio_sc_index"]);

        unset($datosFicha);
        unset($datosFichaEpsas);
        break;

    case 'getConsultaProfundidad':
        $deptoId = (int) $deptoId;
        $profundidad = (int) $profundidad;
        switch ($profundidad) {
            case 1:
                $datosFicha = $subObjItem->get_ficha_profundidad_menor(1, $deptoId, 30);
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_profundidad_menor(1, $deptoId, 30);
                break;
            case 2:
                $datosFicha = $subObjItem->get_ficha_profundidad(1, $deptoId, 30, 60);
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_profundidad(1, $deptoId, 30, 60);
                break;
            case 3:
                $datosFicha = $subObjItem->get_ficha_profundidad(1, $deptoId, 60, 100);
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_profundidad(1, $deptoId, 60, 100);
                break;
            case 4:
                $datosFicha = $subObjItem->get_ficha_profundidad(1, $deptoId, 100, 200);
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_profundidad(1, $deptoId, 100, 200);
                break;
            case 5:
                $datosFicha = $subObjItem->get_ficha_profundidad(1, $deptoId, 200, 300);
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_profundidad(1, $deptoId, 200, 300);
                break;
            case 6:
                $datosFicha = $subObjItem->get_ficha_profundidad_mayor(1, $deptoId, 300);
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_profundidad_mayor(1, $deptoId, 300);
                break;
        }

        $pozosTotal = 0;
        $pozosEpsasTotal = 0;
        $cantidadEpsas = 0;

        $pozosEtiquetas = array();
        $pozosDatos = array();
        $epsasEtiquetas = array();
        $epsasDatos = array();

        //$datosFicha = $subObjItem->get_ficha_anio_perforacion($profundidad);
        if (empty($datosFicha)) {
            echo 0;
            exit();
        }
        //$datosFichaEpsas = $subObjItem->get_ficha_epsas_anio_perforacion($profundidad);

        foreach ($datosFicha as $clave => $valor) {
            switch ($valor['fuente_id']) {
                case '1':
                    $pozosTotal += $valor['total'];
                    $pozosEtiquetas[] = $valor['departamento'];
                    $pozosDatos[] = $valor['total'];
                    break;
            }
        }

        $contador = 0;
        foreach ($datosFichaEpsas as $clave => $valor) {
            $pozosEpsasTotal += $valor['total'];
            $epsasDatos[$contador] = $valor['total'];
            $epsasEtiquetas[$contador] = $valor['epsa'];
            $contador++;
            $cantidadEpsas++;
        }

        foreach ($pozosDatos as $clave => $valor) {
            $pozosDatos[$clave] = round(($valor*100)/$pozosTotal, 2);
            $pozosEtiquetas[$clave] = $pozosEtiquetas[$clave].' ('.$valor.' = '.$pozosDatos[$clave].'%)';
        }

        foreach ($epsasDatos as $clave => $valor) {
            $epsasDatos[$clave] = round(($valor*100)/$pozosEpsasTotal, 2);
            $epsasEtiquetas[$clave] = $epsasEtiquetas[$clave].' ('.$valor.' = '.$epsasDatos[$clave].'%)';
        }

        $smarty->assign("pozosTotal", $pozosTotal);
        $smarty->assign("pozosEpsasTotal", $pozosEpsasTotal);
        $smarty->assign("cantidadEpsas", $cantidadEpsas);
        $smarty->assign("nombreDepto", $datosFicha[0]['departamento']);

        $smarty->assign("pozosCantidadEtiquetas", (count($pozosEtiquetas)/8) < 1 ? 150 : (count($pozosEtiquetas)/8)*150);
        $smarty->assign("epsasCantidadEtiquetas", (count($epsasEtiquetas)/8) < 1 ? 150 : (count($epsasEtiquetas)/8)*150);

        $smarty->assign("pozosEtiquetas",json_encode($pozosEtiquetas));
        $smarty->assign("pozosDatos",json_encode($pozosDatos));

        $smarty->assign("epsasEtiquetas",json_encode($epsasEtiquetas));
        $smarty->assign("epsasDatos",json_encode($epsasDatos));
        
        $smarty->assign("subpage",$webm["consulta_profundidad_sc_index"]);

        unset($datosFicha);
        unset($datosFichaEpsas);
        break;

    case 'getConsultaUso':
        $deptoId = (int) $deptoId;
        $pozosTotal = 0;

        $pozosEtiquetas = array();
        $pozosDatos = array();

        $datosFicha = $subObjItem->get_ficha_uso($deptoId);
        if (empty($datosFicha)) {
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
        $smarty->assign("nombreDepto", $datosFicha[0]['departamento']);

        $smarty->assign("pozosCantidadEtiquetas", (count($pozosEtiquetas)/8) < 1 ? 150 : (count($pozosEtiquetas)/8)*150);

        $smarty->assign("pozosEtiquetas",json_encode($pozosEtiquetas));
        $smarty->assign("pozosDatos",json_encode($pozosDatos));
        
        $smarty->assign("subpage",$webm["consulta_uso_sc_index"]);

        unset($datosFicha);
        break;

    case 'getConsultaProposito':
        $deptoId = (int) $deptoId;
        $pozosTotal = 0;

        $pozosEtiquetas = array();
        $pozosDatos = array();

        $datosFicha = $subObjItem->get_ficha_proposito($deptoId);
        if (empty($datosFicha)) {
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
        $smarty->assign("nombreDepto", $datosFicha[0]['departamento']);

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
        $deptoId = (int) $deptoId;
        $fuenteInfo = $subObjItem->get_puntos(1, $deptoId);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max($deptoId);
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
        $deptoId = (int) $deptoId;
        $fuenteInfo = $subObjItem->get_puntos(2, $deptoId);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max($deptoId);
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
        $deptoId = (int) $deptoId;
        $fuenteInfo = $subObjItem->get_puntos(3, $deptoId);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max($deptoId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoAnioPerforacion':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $deptoId = (int) $deptoId;
        $anio_perforacion = (int) $anio_perforacion;
        $fuenteInfo = $subObjItem->get_puntos_anio_perforacion(1, $deptoId, $anio_perforacion);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max($deptoId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosGeofisicaAnioPerforacion':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $deptoId = (int) $deptoId;
        $anio_perforacion = (int) $anio_perforacion;
        $fuenteInfo = $subObjItem->get_puntos_anio_perforacion(2, $deptoId, $anio_perforacion);
       $coordenadaMinMax =  $subObjItem->get_coordenada_min_max($deptoId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosManantialAnioPerforacion':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $deptoId = (int) $deptoId;
        $anio_perforacion = (int) $anio_perforacion;
        $fuenteInfo = $subObjItem->get_puntos_anio_perforacion(3, $deptoId, $anio_perforacion);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max($deptoId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoProfundidad':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $deptoId = (int) $deptoId;
        $profundidad = (int) $profundidad;
        switch ($profundidad) {
            case 1:
                $fuenteInfo = $subObjItem->get_puntos_profundidad_menor(1, $deptoId, 30);
                break;
            case 2:
                $fuenteInfo = $subObjItem->get_puntos_profundidad(1, $deptoId, 30, 60);
                break;
            case 3:
                $fuenteInfo = $subObjItem->get_puntos_profundidad(1, $deptoId, 60, 100);
                break;
            case 4:
                $fuenteInfo = $subObjItem->get_puntos_profundidad(1, $deptoId, 100, 200);
                break;
            case 5:
                $fuenteInfo = $subObjItem->get_puntos_profundidad(1, $deptoId, 200, 300);
                break;
            case 6:
                $fuenteInfo = $subObjItem->get_puntos_profundidad_mayor(1, $deptoId, 300);
                break;
        }
        //$fuenteInfo = $subObjItem->get_puntos_profundidad(1, $profundidad);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max($deptoId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoUso':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $deptoId = (int) $deptoId;
        $fuenteInfo = $subObjItem->get_puntos_uso($deptoId);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max($deptoId);
        $minMaxLonLat = array($coordenadaMinMax[0]['longitudMin'], $coordenadaMinMax[0]['latitudMin'], $coordenadaMinMax[0]['longitudMax'], $coordenadaMinMax[0]['latitudMax']);
        unset($coordenadaMinMax);
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo, $minMaxLonLat);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoProposito':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $deptoId = (int) $deptoId;
        $fuenteInfo = $subObjItem->get_puntos_proposito($deptoId);
        $coordenadaMinMax =  $subObjItem->get_coordenada_min_max($deptoId);
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
        $smarty->assign("subpage",$webm["form_consulta_sc_index"]);
        break;

    case 'getAnioPerforacion':
        $deptoId = (int) $deptoId;
        $anioPerforacion = $subObjItem->get_anio_perforacion($deptoId);
        echo json_encode($anioPerforacion, JSON_NUMERIC_CHECK);
        exit();
        break;

    case 'getDescargarPozosExcel':
        /*$deptoId = (int) $deptoId;
        $metadatos = array(
                'titulo' => 'Reporte de pozos',
                'asunto' => 'Reporte de pozos',
                'descripcion' => 'Reporte de pozos a nivel departamental',
                'palabras_clave' => 'pozos',
                'categoria' => 'pozos',
            );
        $tituloDocumento = 'REPORTE DE POZOS A NIVEL DEPARTAMENTAL';
        $subObjItem->get_datos_pozos_excel($metadatos, $tituloDocumento, $deptoId);*/
        date_default_timezone_set('America/La_Paz');
        $nombreArchivo = "REPORTE_POZOS_DEPARTAMENTAL_".date('d-m-Y').'_'.date('H:i').'.csv';
        $tituloDocumento = 'REPORTE DE POZOS POR DEPARTAMENTO';
        $subObjItem->get_archivo_csv($tituloDocumento, $nombreArchivo, $deptoId);
        exit();
        break;

    case 'codice':
        echo "Definir función...";
        break;
}