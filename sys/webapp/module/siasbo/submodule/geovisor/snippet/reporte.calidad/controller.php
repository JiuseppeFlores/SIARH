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

    case 'getReporteCalidadAcuifero':
        $acuiferoId = (int) $acuiferoId;
        $campania = explode('-', $campaniaId);
        $mes = (int) $campania[0];
        $anio = (int) $campania[1];
        $metadatos = array(
                'titulo' => 'Reporte de pozos',
                'asunto' => 'Reporte de pozos',
                'descripcion' => 'Reporte de calidad',
                'palabras_clave' => 'pozos',
                'categoria' => 'pozos',
            );
        date_default_timezone_set('America/La_Paz');
        $tituloDocumento = 'REPORTE DE CALIDAD';
        $nombreArchivo = 'REPORTE_CALIDAD_RMCH_'.date('d-m-Y').'_'.date('H:i');
        $subObjItem->get_acuifero_datos_pozos_excel($metadatos, $tituloDocumento, $nombreArchivo, $acuiferoId, $mes, $anio);
        exit();
        break;

    case 'getReporteCalidadEpsa':
        $epsaId = (int) $epsaId;
        $metadatos = array(
                'titulo' => 'Reporte de pozos',
                'asunto' => 'Reporte de pozos',
                'descripcion' => 'Reporte de calidad',
                'palabras_clave' => 'pozos',
                'categoria' => 'pozos',
            );
        date_default_timezone_set('America/La_Paz');
        $tituloDocumento = 'REPORTE DE CALIDAD';
        $nombreArchivo = 'REPORTE_CALIDAD_RMCH_'.date('d-m-Y').'_'.date('H:i');
        $subObjItem->get_epsa_datos_pozos_excel($metadatos, $tituloDocumento, $nombreArchivo, $epsaId);
        break;

    case 'codice':
        echo "Definir función...";
        break;
}