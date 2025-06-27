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
        /**
         * Cargamos catalogos necesarios
         */
        $objCatalog->conf_catalog_datos_general();
        $cataobj = $objCatalog->getCatalogList();
        $smarty->assign("cataobj", $cataobj);
        $smarty->assign("subpage", $webm["index"]);
        $smarty->assign("subpage_js", $webm["index_js"]);
        break;

    case 'getFuenteInfo':
        $catalogo_epsas = $objItem->get_catalogo_epsas();
        $fuenteInfo = $objItem->get_fuente_info($id, $tipo);
        
        if (empty($fuenteInfo)) {
            echo 0;
            exit();
        }

        if ($fuenteInfo[0]['acuifero'] == null || $fuenteInfo[0]['acuifero'] == '') {
            $fuenteInfo[0]['acuifero'] = '';
        }
        if ($fuenteInfo[0]['epsa'] == null || $fuenteInfo[0]['epsa'] == '') {
            $fuenteInfo[0]['epsa'] = '';
        } else {
            $fuenteInfo[0]['epsa'] = $catalogo_epsas[$fuenteInfo[0]['epsa']];
        }
        if ($fuenteInfo[0]['proposito'] == null || $fuenteInfo[0]['proposito'] == '') {
            $fuenteInfo[0]['proposito'] = '';
        }
        if ($fuenteInfo[0]['uso'] == null || $fuenteInfo[0]['uso'] == '') {
            $fuenteInfo[0]['uso'] = '';
        }
        
        $fuenteInfo[0]['calidad'] = ($fuenteInfo[0]['calidad'] == 0 ) ? 'No' : 'Si';
        $fuenteInfo[0]['isotopico'] = ($fuenteInfo[0]['isotopico'] == 0 ) ? 'No' : 'Si';

        if ($tipo == '1') {
            $datos_diseno = $objItem->get_datos_diseno($id);
            $fuenteInfo[0]['diseno'] = ($datos_diseno[0]['diseno'] == 0 ) ? 'No' : 'Si';
            unset($datos_diseno);

            $datos_litologia = $objItem->get_datos_litologia($id);
            $fuenteInfo[0]['litologia'] = ($datos_litologia[0]['litologia'] == 0 ) ? 'No' : 'Si';
            unset($datos_litologia);

            $datos_caudal = $objItem->get_datos_caudal($id);
            $fuenteInfo[0]['caudal'] = ($datos_caudal[0]['caudal'] == 0 ) ? 'No' : 'Si';
            unset($datos_caudal);

            $datos_abatimiento = $objItem->get_datos_abatimiento($id);
            $fuenteInfo[0]['abatimiento'] = ($datos_abatimiento[0]['abatimiento'] == 0 ) ? 'No' : 'Si';
            unset($datos_abatimiento);

            $datos_escalon = $objItem->get_datos_escalon($id);
            $fuenteInfo[0]['escalon'] = ($datos_escalon[0]['escalon'] == 0 ) ? 'No' : 'Si';
            unset($datos_escalon);

            $datos_recuperacion = $objItem->get_datos_recuperacion($id);
            $fuenteInfo[0]['recuperacion'] = ($datos_recuperacion[0]['recuperacion'] == 0 ) ? 'No' : 'Si';
            unset($datos_recuperacion);
        }
        
        $core->print_json($fuenteInfo);
        break;

    case 'getFicha':
        $id = (int) $id;
        $tipo = 'pdf';
        $objItem->get_reporte($id, $tipo, $reporte_file);
        break;

    case 'getBuscaPunto':
        $dato_buscado = trim($dato);
        $puntos_busqueda = $objItem->get_puntos_busqueda($dato_buscado);
        if (count($puntos_busqueda) == 0) {
            echo 0;
            exit();
        }
        $datosGeograficos = $objItem->get_geojson($puntos_busqueda);
        unset($puntos_busqueda);
        echo $datosGeograficos;
        exit();
        break;

    case 'codice':
        echo "es una mala llamada de un snippet";
        exit;
        break;
}