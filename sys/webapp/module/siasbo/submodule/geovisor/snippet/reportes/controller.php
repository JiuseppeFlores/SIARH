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

    /*case 'getFicha':
        $id = (int) $id;
        $tipo = 'pdf';
        $objItem->get_reporte($id, $tipo, $reporte_file);
        break;*/

    case 'getFichaPozo':
        $pozoId = (int) $pozoId;
        $nombre_archivo = 'FICHA_POZO_'.$pozoId.'.docx';

        $subObjItem->get_ficha_pozo($pozoId, $nombre_archivo);
        break;

    case 'getFichaManantial':
        $manantialId = (int) $manantialId;
        $nombre_archivo = 'FICHA_MANANTIAL_'.$manantialId.'.docx';
        $subObjItem->get_ficha_manantial($manantialId, $nombre_archivo);
        break;

    case 'getFichaCaptacionSuperficial':
        $captacionId = (int) $captacionId;
        $nombre_archivo = 'FICHA_CAPTACION_SUPERFICIAL_'.$captacionId.'.docx';
        $subObjItem->get_ficha_captacion_superficial($captacionId, $nombre_archivo);
        break;

    case 'getFichaGeoSev':
        $pozoId = (int) $pozoId;
        $nombre_archivo = 'FICHA_GEO_SEV_'.$pozoId.'.docx';

        $subObjItem->get_fichageosev($pozoId, $nombre_archivo);
        break;

    case 'getFichaGeoTomografia':
        $pozoId = (int) $pozoId;
        $nombre_archivo = 'FICHA_GEO_TOMOGRAFIA_'.$pozoId.'.docx';

        $subObjItem->get_fichageotomografia($pozoId, $nombre_archivo);
        break;

    case 'codice':
        echo "Definir función...";
        break;
}