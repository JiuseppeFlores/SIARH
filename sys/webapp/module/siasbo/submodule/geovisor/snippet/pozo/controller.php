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
        
        break;

    case 'getConsultaDiseno':
        $tipo_consulta = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;

        $pozosTotal = 0;
        $pozosEpsasTotal = 0;
        $cantidadEpsas = 0;

        switch ($tipo_consulta) {
            case 'c1':
                $datosFicha = $subObjItem->get_ficha_diseno();
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_diseno();

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
                $smarty->assign("subpage",$webm["consulta_diseno_nacional_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
            
            case 'c2':
                $datosFicha = $subObjItem->get_ficha_diseno_departamental($deptoId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_diseno_departamental($deptoId);

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
                $smarty->assign("subpage",$webm["consulta_diseno_departamental_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;

            case 'c3':
                $datosFicha = $subObjItem->get_ficha_diseno_municipal($municipioId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_diseno_municipal($municipioId);

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
                $smarty->assign("subpage",$webm["consulta_diseno_municipal_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
        }
        break;

    case 'getConsultaLitologia':
        $tipo_consulta = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;

        $pozosTotal = 0;
        $pozosEpsasTotal = 0;
        $cantidadEpsas = 0;

        switch ($tipo_consulta) {
            case 'c1':
                $datosFicha = $subObjItem->get_ficha_litologia();
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_litologia();

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
                $smarty->assign("subpage",$webm["consulta_litologia_nacional_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
            
            case 'c2':
                $datosFicha = $subObjItem->get_ficha_litologia_departamental($deptoId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_litologia_departamental($deptoId);

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
                $smarty->assign("subpage",$webm["consulta_litologia_departamental_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;

            case 'c3':
                $datosFicha = $subObjItem->get_ficha_litologia_municipal($municipioId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_litologia_municipal($municipioId);

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
                $smarty->assign("subpage",$webm["consulta_litologia_municipal_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
        }
        break;

    case 'getConsultaElectrico':
        $tipo_consulta = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;

        $pozosTotal = 0;
        $pozosEpsasTotal = 0;
        $cantidadEpsas = 0;

        switch ($tipo_consulta) {
            case 'c1':
                $datosFicha = $subObjItem->get_ficha_electrico();
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_electrico();

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
                $smarty->assign("subpage",$webm["consulta_electrico_nacional_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
            
            case 'c2':
                $datosFicha = $subObjItem->get_ficha_electrico_departamental($deptoId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_electrico_departamental($deptoId);

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
                $smarty->assign("subpage",$webm["consulta_electrico_departamental_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;

            case 'c3':
                $datosFicha = $subObjItem->get_ficha_electrico_municipal($municipioId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_electrico_municipal($municipioId);

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
                $smarty->assign("subpage",$webm["consulta_electrico_municipal_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
        }
        break;

    case 'getConsultaHidraulicoEscalon':
        $tipo_consulta = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;

        $pozosTotal = 0;
        $pozosEpsasTotal = 0;
        $cantidadEpsas = 0;

        switch ($tipo_consulta) {
            case 'c1':
                $datosFicha = $subObjItem->get_ficha_hidraulico_escalon();
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_hidraulico_escalon();

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
                $smarty->assign("subpage",$webm["consulta_hidraulico_escalon_nacional_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
            
            case 'c2':
                $datosFicha = $subObjItem->get_ficha_hidraulico_escalon_departamental($deptoId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_hidraulico_escalon_departamental($deptoId);

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
                $smarty->assign("subpage",$webm["consulta_hidraulico_escalon_departamental_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;

            case 'c3':
                $datosFicha = $subObjItem->get_ficha_hidraulico_escalon_municipal($municipioId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_hidraulico_escalon_municipal($municipioId);

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
                $smarty->assign("subpage",$webm["consulta_hidraulico_escalon_municipal_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
        }
        break;

    case 'getConsultaHidraulicoRecuperacion':
        $tipo_consulta = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;

        $pozosTotal = 0;
        $pozosEpsasTotal = 0;
        $cantidadEpsas = 0;

        switch ($tipo_consulta) {
            case 'c1':
                $datosFicha = $subObjItem->get_ficha_hidraulico_recuperacion();
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_hidraulico_recuperacion();

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
                $smarty->assign("subpage",$webm["consulta_hidraulico_recuperacion_nacional_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
            
            case 'c2':
                $datosFicha = $subObjItem->get_ficha_hidraulico_recuperacion_departamental($deptoId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_hidraulico_recuperacion_departamental($deptoId);

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
                $smarty->assign("subpage",$webm["consulta_hidraulico_recuperacion_departamental_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;

            case 'c3':
                $datosFicha = $subObjItem->get_ficha_hidraulico_recuperacion_municipal($municipioId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_hidraulico_recuperacion_municipal($municipioId);

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
                $smarty->assign("subpage",$webm["consulta_hidraulico_recuperacion_municipal_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
        }
        break;

    case 'getConsultaHidraulicoObservacion':
        $tipo_consulta = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;

        $pozosTotal = 0;
        $pozosEpsasTotal = 0;
        $cantidadEpsas = 0;

        switch ($tipo_consulta) {
            case 'c1':
                $datosFicha = $subObjItem->get_ficha_hidraulico_observacion();
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_hidraulico_observacion();

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
                $smarty->assign("subpage",$webm["consulta_hidraulico_observacion_nacional_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
            
            case 'c2':
                $datosFicha = $subObjItem->get_ficha_hidraulico_observacion_departamental($deptoId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_hidraulico_observacion_departamental($deptoId);

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
                $smarty->assign("subpage",$webm["consulta_hidraulico_observacion_departamental_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;

            case 'c3':
                $datosFicha = $subObjItem->get_ficha_hidraulico_observacion_municipal($municipioId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_hidraulico_observacion_municipal($municipioId);

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
                $smarty->assign("subpage",$webm["consulta_hidraulico_observacion_municipal_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
        }
        break;

    case 'getConsultaImplementacion':
        $tipo_consulta = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;

        $pozosTotal = 0;
        $pozosEpsasTotal = 0;
        $cantidadEpsas = 0;

        switch ($tipo_consulta) {
            case 'c1':
                $datosFicha = $subObjItem->get_ficha_implementacion();
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_implementacion();

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
                $smarty->assign("subpage",$webm["consulta_implementacion_nacional_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
            
            case 'c2':
                $datosFicha = $subObjItem->get_ficha_implementacion_departamental($deptoId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_implementacion_departamental($deptoId);

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
                $smarty->assign("subpage",$webm["consulta_implementacion_departamental_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;

            case 'c3':
                $datosFicha = $subObjItem->get_ficha_implementacion_municipal($municipioId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_implementacion_municipal($municipioId);

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
                $smarty->assign("subpage",$webm["consulta_implementacion_municipal_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
        }
        break;

    case 'getConsultaMonitorCantidad':
        $tipo_consulta = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;

        $pozosTotal = 0;
        $pozosEpsasTotal = 0;
        $cantidadEpsas = 0;

        switch ($tipo_consulta) {
            case 'c1':
                $datosFicha = $subObjItem->get_ficha_monitor_cantidad();
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_monitor_cantidad();

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
                $smarty->assign("subpage",$webm["consulta_monitor_cantidad_nacional_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
            
            case 'c2':
                $datosFicha = $subObjItem->get_ficha_monitor_cantidad_departamental($deptoId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_monitor_cantidad_departamental($deptoId);

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
                $smarty->assign("subpage",$webm["consulta_monitor_cantidad_departamental_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;

            case 'c3':
                $datosFicha = $subObjItem->get_ficha_monitor_cantidad_municipal($municipioId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_monitor_cantidad_municipal($municipioId);

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
                $smarty->assign("subpage",$webm["consulta_monitor_cantidad_municipal_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
        }
        break;

    case 'getConsultaMonitorCalidad':
        $tipo_consulta = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;

        $pozosTotal = 0;
        $pozosEpsasTotal = 0;
        $cantidadEpsas = 0;

        switch ($tipo_consulta) {
            case 'c1':
                $datosFicha = $subObjItem->get_ficha_monitor_calidad();
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_monitor_calidad();

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
                $smarty->assign("subpage",$webm["consulta_monitor_calidad_nacional_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
            
            case 'c2':
                $datosFicha = $subObjItem->get_ficha_monitor_calidad_departamental($deptoId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_monitor_calidad_departamental($deptoId);

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
                $smarty->assign("subpage",$webm["consulta_monitor_calidad_departamental_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;

            case 'c3':
                $datosFicha = $subObjItem->get_ficha_monitor_calidad_municipal($municipioId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_monitor_calidad_municipal($municipioId);

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
                $smarty->assign("subpage",$webm["consulta_monitor_calidad_municipal_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
        }
        break;

    case 'getConsultaMonitorIsotopico':
        $tipo_consulta = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;

        $pozosTotal = 0;
        $pozosEpsasTotal = 0;
        $cantidadEpsas = 0;

        switch ($tipo_consulta) {
            case 'c1':
                $datosFicha = $subObjItem->get_ficha_monitor_isotopico();
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_monitor_isotopico();

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
                $smarty->assign("subpage",$webm["consulta_monitor_isotopico_nacional_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
            
            case 'c2':
                $datosFicha = $subObjItem->get_ficha_monitor_isotopico_departamental($deptoId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_monitor_isotopico_departamental($deptoId);

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
                $smarty->assign("subpage",$webm["consulta_monitor_isotopico_departamental_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;

            case 'c3':
                $datosFicha = $subObjItem->get_ficha_monitor_isotopico_municipal($municipioId);
                if (empty($datosFicha)) {
                    echo 0;
                    exit();
                }
                $datosFichaEpsas = $subObjItem->get_ficha_epsas_monitor_isotopico_municipal($municipioId);

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
                $smarty->assign("subpage",$webm["consulta_monitor_isotopico_municipal_sc_index"]);

                unset($datosFicha);
                unset($datosFichaEpsas);
                break;
        }
        break;

    case 'getPuntosPozoDiseno':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $tipo = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;
        switch ($tipo) {
            case 'c1':
                $fuenteInfo = $subObjItem->get_puntos_diseno();
                break;
            case 'c2':
                $fuenteInfo = $subObjItem->get_puntos_diseno_departamental($deptoId);
                break;
            case 'c3':
                $fuenteInfo = $subObjItem->get_puntos_diseno_municipal($municipioId);
                break;
        }
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoLitologia':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $tipo = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;
        switch ($tipo) {
            case 'c1':
                $fuenteInfo = $subObjItem->get_puntos_litologia();
                break;
            case 'c2':
                $fuenteInfo = $subObjItem->get_puntos_litologia_departamental($deptoId);
                break;
            case 'c3':
                $fuenteInfo = $subObjItem->get_puntos_litologia_municipal($municipioId);
                break;
        }
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoElectrico':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $tipo = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;
        switch ($tipo) {
            case 'c1':
                $fuenteInfo = $subObjItem->get_puntos_electrico();
                break;
            case 'c2':
                $fuenteInfo = $subObjItem->get_puntos_electrico_departamental($deptoId);
                break;
            case 'c3':
                $fuenteInfo = $subObjItem->get_puntos_electrico_municipal($municipioId);
                break;
        }
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoHidraulicoEscalon':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $tipo = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;
        switch ($tipo) {
            case 'c1':
                $fuenteInfo = $subObjItem->get_puntos_hidraulico_escalon();
                break;
            case 'c2':
                $fuenteInfo = $subObjItem->get_puntos_hidraulico_escalon_departamental($deptoId);
                break;
            case 'c3':
                $fuenteInfo = $subObjItem->get_puntos_hidraulico_escalon_municipal($municipioId);
                break;
        }
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoHidraulicoRecuperacion':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $tipo = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;
        switch ($tipo) {
            case 'c1':
                $fuenteInfo = $subObjItem->get_puntos_hidraulico_recuperacion();
                break;
            case 'c2':
                $fuenteInfo = $subObjItem->get_puntos_hidraulico_recuperacion_departamental($deptoId);
                break;
            case 'c3':
                $fuenteInfo = $subObjItem->get_puntos_hidraulico_recuperacion_municipal($municipioId);
                break;
        }
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoHidraulicoObservacion':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $tipo = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;
        switch ($tipo) {
            case 'c1':
                $fuenteInfo = $subObjItem->get_puntos_hidraulico_observacion();
                break;
            case 'c2':
                $fuenteInfo = $subObjItem->get_puntos_hidraulico_observacion_departamental($deptoId);
                break;
            case 'c3':
                $fuenteInfo = $subObjItem->get_puntos_hidraulico_observacion_municipal($municipioId);
                break;
        }
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoImplementacion':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $tipo = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;
        switch ($tipo) {
            case 'c1':
                $fuenteInfo = $subObjItem->get_puntos_implementacion();
                break;
            case 'c2':
                $fuenteInfo = $subObjItem->get_puntos_implementacion_departamental($deptoId);
                break;
            case 'c3':
                $fuenteInfo = $subObjItem->get_puntos_implementacion_municipal($municipioId);
                break;
        }
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoMonitorCantidad':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $tipo = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;
        switch ($tipo) {
            case 'c1':
                $fuenteInfo = $subObjItem->get_puntos_monitor_cantidad();
                break;
            case 'c2':
                $fuenteInfo = $subObjItem->get_puntos_monitor_cantidad_departamental($deptoId);
                break;
            case 'c3':
                $fuenteInfo = $subObjItem->get_puntos_monitor_cantidad_municipal($municipioId);
                break;
        }
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoMonitorCalidad':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $tipo = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;
        switch ($tipo) {
            case 'c1':
                $fuenteInfo = $subObjItem->get_puntos_monitor_calidad();
                break;
            case 'c2':
                $fuenteInfo = $subObjItem->get_puntos_monitor_calidad_departamental($deptoId);
                break;
            case 'c3':
                $fuenteInfo = $subObjItem->get_puntos_monitor_calidad_municipal($municipioId);
                break;
        }
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo);
        unset($fuenteInfo);
        echo $datosGeograficos;
        exit();
        break;

    case 'getPuntosPozoMonitorIsotopico':
        // Pozo = 1
        // Geofisica = 2
        // Manantial = 3
        // Captación = 4
        $tipo = $tipo;
        $deptoId = (int) $deptoId;
        $municipioId = (int) $municipioId;
        switch ($tipo) {
            case 'c1':
                $fuenteInfo = $subObjItem->get_puntos_monitor_isotopico();
                break;
            case 'c2':
                $fuenteInfo = $subObjItem->get_puntos_monitor_isotopico_departamental($deptoId);
                break;
            case 'c3':
                $fuenteInfo = $subObjItem->get_puntos_monitor_isotopico_municipal($municipioId);
                break;
        }
        $datosGeograficos = $subObjItem->get_geojson($fuenteInfo);
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

    case 'getDescargarExcelDiseno':
        /*$metadatos = array(
                'titulo' => 'Reporte de pozos',
                'asunto' => 'Reporte de pozos',
                'descripcion' => 'Reporte de pozos con datos constructivos',
                'palabras_clave' => 'pozos',
                'categoria' => 'pozos',
            );
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS CONSTRUCTIVOS';
        $subObjItem->get_datos_pozos_excel($metadatos, $tituloDocumento, 'rep_diseno');*/
        date_default_timezone_set('America/La_Paz');
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS CONSTRUCTIVOS';
        $nombreArchivo = 'REPORTE_POZOS_DATOS_CONSTRUCTIVOS_'.date('d-m-Y').'_'.date('H:i').'.csv';
        $subObjItem->get_archivo_csv($tituloDocumento, $nombreArchivo, 'rep_diseno');
        exit();
        break;

    case 'getDescargarExcelLitologia':
        /*$metadatos = array(
                'titulo' => 'Reporte de pozos',
                'asunto' => 'Reporte de pozos',
                'descripcion' => 'Reporte de pozos con datos de litología',
                'palabras_clave' => 'pozos',
                'categoria' => 'pozos',
            );
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS DE LITOLOGÍA';
        $subObjItem->get_datos_pozos_excel($metadatos, $tituloDocumento, 'rep_litologia');*/
        date_default_timezone_set('America/La_Paz');
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS DE LITOLOGÍA';
        $nombreArchivo = 'REPORTE_POZOS_DATOS_LITOLOGIA_'.date('d-m-Y').'_'.date('H:i').'.csv';
        $subObjItem->get_archivo_csv($tituloDocumento, $nombreArchivo, 'rep_litologia');
        exit();
        break;

    case 'getDescargarExcelElectrico':
        /*$metadatos = array(
                'titulo' => 'Reporte de pozos',
                'asunto' => 'Reporte de pozos',
                'descripcion' => 'Reporte de pozos con datos de perfilaje eléctrico',
                'palabras_clave' => 'pozos',
                'categoria' => 'pozos',
            );
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS DE PERFILAJE ELÉCTRICO';
        $subObjItem->get_datos_pozos_excel($metadatos, $tituloDocumento, 'rep_electrico');*/
        date_default_timezone_set('America/La_Paz');
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS DE PERFILAJE ELÉCTRICO';
        $nombreArchivo = 'REPORTE_POZOS_DATOS_PERFILAJE_ELECTRICO_'.date('d-m-Y').'_'.date('H:i').'.csv';
        $subObjItem->get_archivo_csv($tituloDocumento, $nombreArchivo, 'rep_electrico');
        exit();
        break;

    case 'getDescargarExcelHidraulicoEscalon':
        /*$metadatos = array(
                'titulo' => 'Reporte de pozos',
                'asunto' => 'Reporte de pozos',
                'descripcion' => 'Reporte de pozos con datos hidráulicos (escalones)',
                'palabras_clave' => 'pozos',
                'categoria' => 'pozos',
            );
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS HIDRÁULICOS (ESCALONES)';
        $subObjItem->get_datos_pozos_excel($metadatos, $tituloDocumento, 'rep_hidraulico_escalon');*/
        date_default_timezone_set('America/La_Paz');
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS HIDRÁULICOS (ESCALONES)';
        $nombreArchivo = 'REPORTE_POZOS_DATOS_HIDRAULICO_ESCALON_'.date('d-m-Y').'_'.date('H:i').'.csv';
        $subObjItem->get_archivo_csv($tituloDocumento, $nombreArchivo, 'rep_hidraulico_escalon');
        exit();
        break;

    case 'getDescargarExcelHidraulicoRecuperacion':
        /*$metadatos = array(
                'titulo' => 'Reporte de pozos',
                'asunto' => 'Reporte de pozos',
                'descripcion' => 'Reporte de pozos con datos hidráulicos (prueba de recuperación)',
                'palabras_clave' => 'pozos',
                'categoria' => 'pozos',
            );
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS HIDRÁULICOS (PRUEBA DE RECUPERACIÓN)';
        $subObjItem->get_datos_pozos_excel($metadatos, $tituloDocumento, 'rep_hidraulico_recuperacion');*/
        date_default_timezone_set('America/La_Paz');
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS HIDRÁULICOS (PRUEBA DE RECUPERACIÓN)';
        $nombreArchivo = 'REPORTE_POZOS_DATOS_HIDRAULICO_RECUPERACION_'.date('d-m-Y').'_'.date('H:i').'.csv';
        $subObjItem->get_archivo_csv($tituloDocumento, $nombreArchivo, 'rep_hidraulico_recuperacion');
        exit();
        break;

    case 'getDescargarExcelHidraulicoObservacion':
        /*$metadatos = array(
                'titulo' => 'Reporte de pozos',
                'asunto' => 'Reporte de pozos',
                'descripcion' => 'Reporte de pozos con datos hidráulicos (prueba de observación)',
                'palabras_clave' => 'pozos',
                'categoria' => 'pozos',
            );
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS HIDRÁULICOS (PRUEBA DE OBSERVACIÓN)';
        $subObjItem->get_datos_pozos_excel($metadatos, $tituloDocumento, 'rep_hidraulico_observacion');*/
        date_default_timezone_set('America/La_Paz');
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS HIDRÁULICOS (PRUEBA DE OBSERVACIÓN)';
        $nombreArchivo = 'REPORTE_POZOS_DATOS_HIDRAULICO_OBSERVACION_'.date('d-m-Y').'_'.date('H:i').'.csv';
        $subObjItem->get_archivo_csv($tituloDocumento, $nombreArchivo, 'rep_hidraulico_observacion');
        exit();
        break;

    case 'getDescargarExcelImplementacion':
        /*$metadatos = array(
                'titulo' => 'Reporte de pozos',
                'asunto' => 'Reporte de pozos',
                'descripcion' => 'Reporte de pozos con datos de implementación',
                'palabras_clave' => 'pozos',
                'categoria' => 'pozos',
            );
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS DE IMPLEMENTACIÓN';
        $subObjItem->get_datos_pozos_excel($metadatos, $tituloDocumento, 'rep_implementacion');*/
        date_default_timezone_set('America/La_Paz');
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS DE IMPLEMENTACIÓN';
        $nombreArchivo = 'REPORTE_POZOS_DATOS_IMPLEMENTACION_'.date('d-m-Y').'_'.date('H:i').'.csv';
        $subObjItem->get_archivo_csv($tituloDocumento, $nombreArchivo, 'rep_implementacion');
        exit();
        break;

    case 'getDescargarExcelMonitorCantidad':
        /*$metadatos = array(
                'titulo' => 'Reporte de pozos',
                'asunto' => 'Reporte de pozos',
                'descripcion' => 'Reporte de pozos con datos de monitoreo de cantidad',
                'palabras_clave' => 'pozos',
                'categoria' => 'pozos',
            );
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS DE MONITOREO DE CANTIDAD';
        $subObjItem->get_datos_pozos_excel($metadatos, $tituloDocumento, 'rep_monitor_cantidad');*/
        date_default_timezone_set('America/La_Paz');
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS DE MONITOREO DE CANTIDAD';
        $nombreArchivo = 'REPORTE_POZOS_DATOS_MONITOR_CANTIDAD_'.date('d-m-Y').'_'.date('H:i').'.csv';
        $subObjItem->get_archivo_csv($tituloDocumento, $nombreArchivo, 'rep_monitor_cantidad');
        exit();
        break;

    case 'getDescargarExcelMonitorCalidad':
        /*$metadatos = array(
                'titulo' => 'Reporte de pozos',
                'asunto' => 'Reporte de pozos',
                'descripcion' => 'Reporte de pozos con datos de monitoreo de calidad',
                'palabras_clave' => 'pozos',
                'categoria' => 'pozos',
            );
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS DE MONITOREO DE CALIDAD';
        $subObjItem->get_datos_pozos_excel($metadatos, $tituloDocumento, 'rep_monitor_calidad');*/
        date_default_timezone_set('America/La_Paz');
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS DE MONITOREO DE CALIDAD';
        $nombreArchivo = 'REPORTE_POZOS_DATOS_MONITOR_CALIDAD_'.date('d-m-Y').'_'.date('H:i').'.csv';
        $subObjItem->get_archivo_csv($tituloDocumento, $nombreArchivo, 'rep_monitor_calidad');
        exit();
        break;

    case 'getDescargarExcelMonitorIsotopico':
        /*$metadatos = array(
                'titulo' => 'Reporte de pozos',
                'asunto' => 'Reporte de pozos',
                'descripcion' => 'Reporte de pozos con datos de monitoreo de isotópico',
                'palabras_clave' => 'pozos',
                'categoria' => 'pozos',
            );
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS DE MONITOREO ISOTÓPICO';
        $subObjItem->get_datos_pozos_excel($metadatos, $tituloDocumento, 'rep_monitor_isotopico');*/
        date_default_timezone_set('America/La_Paz');
        $tituloDocumento = 'REPORTE DE POZOS CON DATOS DE MONITOREO DE ISOTÓPICO';
        $nombreArchivo = 'REPORTE_POZOS_DATOS_MONITOR_ISOTOPICO_'.date('d-m-Y').'_'.date('H:i').'.csv';
        $subObjItem->get_archivo_csv($tituloDocumento, $nombreArchivo, 'rep_monitor_isotopico');
        exit();
        break;

    case 'codice':
        echo "Definir función...";
        break;
}