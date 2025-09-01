<?php
/**
 * Todo el sub Control se recuperará mediante llamadas por ajax
 */
$templateModule = $templateModuleAjax;
// var_dump($templateModule,$accion);
switch($accion){
    /**
     * Página por defecto (index)
     */
    default:
        $subObjCatalog->conf_catalog_datos_general();
        $cataobj = $subObjCatalog->getCatalogList();
        $smarty->assign("cataobj",$cataobj);

        $smarty->assign("type",$type);
        if($type=="update"){
            $item = $objItem->get_item($id,"item");
            $smarty->assign("item", $item);
            $smarty->assign("latitud", explode("-", $item["latitud"]));
            $smarty->assign("longitud", explode("-", $item["longitud"]));

            if (trim($item['provinciaId']) != ""){
            	$resultado = $subObjItem->get_provincia($item['departamentoId']);
	            $provincia = array();
	            foreach ($resultado as $clave => $valor) {
	                $provincia[$valor["itemId"]] = $valor["nombre"];
	            }
            }else{
            	$provincia = array();
            }
            
            if (trim($item['municipioId']) != ""){
            	$resultado = $subObjItem->get_municipio($item['provinciaId']);
	            $municipio = array();
	            foreach ($resultado as $clave => $valor) {
	                $municipio[$valor["itemId"]] = $valor["nombre"];
	            }
            }else{
            	$municipio = array();
            }
            
            if (trim($item['comunidadId']) != "") {
                $resultado = $subObjItem->get_comunidad($item['municipioId']);
                $comunidad = array();
                foreach ($resultado as $clave => $valor) {
                    $comunidad[$valor["itemId"]] = $valor["nombre"];
                }
            }else{
                $comunidad = array();
            }
            
            if (trim($item['localidadId']) != "") {
                $resultado = $subObjItem->get_localidad($item['comunidadId']);
                $localidad = array();
                foreach ($resultado as $clave => $valor) {
                    $localidad[$valor["itemId"]] = $valor["nombre"];
                }
            }else{
                $localidad = array();
            }

            $smarty->assign("provincia", $provincia);
            $smarty->assign("municipio", $municipio);
            $smarty->assign("comunidad", $comunidad);
            $smarty->assign("localidad", $localidad);
        }
        $smarty->assign("subpage",$webm["sc_index"]);
        break;

    case 'itemupdatesql':
        if ($type == 'new') {
            $nuevo_codigo = $subObjItem->get_nuevo_codigo($item['departamentoId'], $item['cuencaId']);
            $item['codigo'] = $nuevo_codigo;
        }
        
        $item["latitud"] = trim($item["lat_gra"])."-".trim($item["lat_min"])."-".trim($item["lat_seg"]);
        $item["longitud"] = trim($item["lon_gra"])."-".trim($item["lon_min"])."-".trim($item["lon_seg"]);
        
        $respuesta = $subObjItem->item_update($item,$itemId,"item",$type);
        // var_dump('ver::',$respuesta);
        //Realiza transacciones en la tabla item (PostgreSQL)
        if ($respuesta["res"] == 1) {
            $item_pg = array();
            foreach ($item as $clave => $valor) {
                $item_pg[strtolower($clave)] = $valor;
            }
            $item_pg["itemid"] = $respuesta["id"];
            //Guarda datos en la tabla item (PostgreSQL)
            $subObjItem->abrir_conexion_pg();
            $respuesta_pg = $subObjItem->item_update_pg($item_pg, $respuesta["id"],"item_pg", $type);
            $subObjItem->cerrar_conexion_pg();
            //Actualiza el campo geom de la tabla item (PostgreSQL)
            $respuesta_geom_pg = $subObjItem->item_update_geom($respuesta["id"]);
        }

        $core->print_json($respuesta);
        break;

    case 'getProvincia':
        $res = $subObjItem->get_provincia($deptoId);
        $core->print_json($res);
        break;

    case 'getMunicipio':
        $res = $subObjItem->get_municipio($provinciaId);
        $core->print_json($res);
        break;

    case 'getComunidad':
        $res = $subObjItem->get_comunidad($municipioId);
        $core->print_json($res);
        break;

    case 'getLocalidad':
        $res = $subObjItem->get_localidad($comunidadId);
        $core->print_json($res);
        break;

    case 'convertirDmsToDecUtm':
        $latitudDMS = '-'.(int) $lat_gra.'o'.(int) $lat_min.'\''.(float) $lat_seg.'"';
        $longitudDMS = '-'.(int) $lon_gra.'o'.(int) $lon_min.'\''.(float) $lon_seg.'"';

        $coordenadaDecimal = $subObjItem->convertirLatLonDmsToDec($latitudDMS, $longitudDMS);
        $coordenadaUtm = $subObjItem->convertirLatLonDecToUtm($coordenadaDecimal['lat_decimal'], $coordenadaDecimal['lon_decimal']);

        echo json_encode(array(
                'lat_decimal' => $coordenadaDecimal['lat_decimal'],
                'lon_decimal' => $coordenadaDecimal['lon_decimal'],
                'lat_utm' => $coordenadaUtm['lat_utm'],
                'lon_utm' => $coordenadaUtm['lon_utm'],
                'zona_utm' => $coordenadaUtm['zona_utm']
            ), JSON_NUMERIC_CHECK);
        exit;
        break;

    case 'convertirUtmToDecDms':    
        $latitudUtm = (float) $lat_utm;
        $longitudUtm = (float) $lon_utm;
        $zonaUtm = trim($zona_utm);

        $coordenadaDecimal = $subObjItem->convertirUtmToDec($latitudUtm, $longitudUtm, $zonaUtm);
        $coordenadaDms = $subObjItem->convertirLatLonDecToDms($coordenadaDecimal['lat_decimal'], $coordenadaDecimal['lon_decimal']);

        echo json_encode(array(
                'lat_decimal' => $coordenadaDecimal['lat_decimal'],
                'lon_decimal' => $coordenadaDecimal['lon_decimal'],
                'lat_gra' => $coordenadaDms['lat_gra'],
                'lat_min' => $coordenadaDms['lat_min'],
                'lat_seg' => $coordenadaDms['lat_seg'],
                'lon_gra' => $coordenadaDms['lon_gra'],
                'lon_min' => $coordenadaDms['lon_min'],
                'lon_seg' => $coordenadaDms['lon_seg']
            ), JSON_NUMERIC_CHECK);
        exit;
        break;

    case 'convertirDecToDmsUtm':        
        $longitudDecimal = (float) $coordenada[0];
        $latitudDecimal = (float) $coordenada[1];

        $coordenadaUtm = $subObjItem->convertirLatLonDecToUtm($latitudDecimal, $longitudDecimal);
        $coordenadaDms = $subObjItem->convertirLatLonDecToDms($latitudDecimal, $longitudDecimal);

        /**/
        $respuesta = array(
            'lat_decimal' => $latitudDecimal,
            'lon_decimal' => $longitudDecimal,
            'lat_gra' => $coordenadaDms['lat_gra'],
            'lat_min' => $coordenadaDms['lat_min'],
            'lat_seg' => $coordenadaDms['lat_seg'],
            'lon_gra' => $coordenadaDms['lon_gra'],
            'lon_min' => $coordenadaDms['lon_min'],
            'lon_seg' => $coordenadaDms['lon_seg'],
            'lat_utm' => $coordenadaUtm['lat_utm'],
            'lon_utm' => $coordenadaUtm['lon_utm'],
            'zona_utm' => $coordenadaUtm['zona_utm']
        );
        $core->print_json($respuesta);
        /**/

            /*

        echo json_encode(array(
                'lat_decimal' => $latitudDecimal,
                'lon_decimal' => $longitudDecimal,
                'lat_gra' => $coordenadaDms['lat_gra'],
                'lat_min' => $coordenadaDms['lat_min'],
                'lat_seg' => $coordenadaDms['lat_seg'],
                'lon_gra' => $coordenadaDms['lon_gra'],
                'lon_min' => $coordenadaDms['lon_min'],
                'lon_seg' => $coordenadaDms['lon_seg'],
                'lat_utm' => $coordenadaUtm['lat_utm'],
                'lon_utm' => $coordenadaUtm['lon_utm'],
                'zona_utm' => $coordenadaUtm['zona_utm']
            ), JSON_NUMERIC_CHECK);
            /**/

        break;

    case 'obtenerUbicacionGeografica':
        $latitudDecimal = (float) $lat_decimal;
        $longitudDecimal = (float) $lon_decimal;
        $ubicacionPolitica = $subObjItem->get_ubicacion_politica($latitudDecimal, $longitudDecimal);
        $ubicacionMacrocuenca = $subObjItem->get_ubicacion_macrocuenca($latitudDecimal, $longitudDecimal);
        $ubicacionCuencaEstrategica = $subObjItem->get_ubicacion_cuenca_estrategica($latitudDecimal, $longitudDecimal);
        $ubicacionGeografica = array(
            'res' => 1,
            'deptoId' => $ubicacionPolitica[0]['deptoid'],
            'provinciaId' => $ubicacionPolitica[0]['provinciaid'],
            'municipioId' => $ubicacionPolitica[0]['municipioid'],
            'macroId' => $ubicacionMacrocuenca[0]['macroid'],
            'cuencaestraId' => $ubicacionCuencaEstrategica[0]['cuencaestraid']
        );
        unset($ubicacionPolitica);
        unset($ubicacionMacrocuenca);
        unset($ubicacionCuencaEstrategica);
        echo json_encode($ubicacionGeografica, JSON_NUMERIC_CHECK);
        exit;
        break;

    case 'setObservado':
        $res = $subObjItem->set_observado($idpozo);
        //$core->print_json($res);
        echo json_encode($res);
        exit;
        break;

    case 'setRevisado':
        $res = $subObjItem->set_revisado($idpozo);
        //$core->print_json($res);
        echo json_encode($res);
        exit;
        break;

    case 'setRegistrado':
        $res = $subObjItem->set_registrado($idpozo);
        //$core->print_json($res);
        echo json_encode($res);
        exit;
        break;

    case 'obtenerEstado':
        //$dbm->debug = true;
        $res = $subObjItem->obtener_estado($idpozo);
        //$core->print_json($res);
        echo json_encode($res);
        exit;
        break;
}