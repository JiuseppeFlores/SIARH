<?php
/**
 * Created by PhpStorm.
 * User: henrytaby
 * Date: 3/5/2018
 * Time: 15:27
 */
// var_dump($accion);
switch($accion) {
    /**
     * Página por defecto
     */
    default:
        /**
         * Cargamos catalogos necesarios
         */
        
        //print_struc($CFGm->tabla);exit;
        $grill_list = $objItem->get_grilla_list_sbm("item");
        $smarty->assign("grill_list", $grill_list);
        /**
         * usamos el template para mootools
         */
        $smarty->assign("subpage", $webm["index"]);
        $smarty->assign("subpage_js", $webm["index_js"]);
        break;

    /**
     * Creación de JSON
     */
    case 'getItemList':
        $res = $objItem->get_item_datatable_Rows();
        $core->print_json($res);
        break;

    case 'itemUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type,"index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "item");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["item_index"]);
        $smarty->assign("subpage_js", $webm["item_index_js"]);
        break;

    case 'itemDelete':
        $res = $objItem->item_delete($id);
        $core->print_json($res);
        break;

    //Obtener los permisos para ficha pozo
    case 'obtenerPermisos':
        $itemIdSubmoduloGeofisica = 282; //Id del submodulo Ficha Geofisica
        // var_dump($_SESSION[userv][usuario],$itemIdSubmoduloGeofisica);
        $res = $objItem->get_permisos($_SESSION[userv][usuario], $itemIdSubmoduloGeofisica);
        //$core->print_json($res);
        echo json_encode($res);
        //print_r($res);
        //echo json_encode(array("crear"=>"0", "editar"=>"1", "eliminar"=>"1"));
        //echo $_SESSION[userv][usuario]." - ".$perpozo;
        exit;
        break;

    //
    //Importar Archivos desde Excel
    //
    case 'enviarArchivo':
        //print_r($_FILES['file-0']);
        include './lib/phpexcel/Classes/PHPExcel/IOFactory.php';
        $NombreArchivo = $_FILES['file-0']['tmp_name']; //'D://pozo.xlsx';
        $objPHPExcel = PHPExcel_IOFactory::load($NombreArchivo);
        //$objPHPExcel->setActiveSheetIndex(0);

        $nombreHojas = $objPHPExcel->getSheetNames();
        $verificacion = $objItem->verificarConfiguracion($nombreHojas);

        if($verificacion){
            echo json_encode($objPHPExcel->getSheetNames());
        }else{
            echo json_encode(array('res'=>false));
        }
        
        $objPHPExcel->disconnectWorksheets();
        unset($objPHPExcel);
        exit;
        break;

    case 'procesarArchivo':
        include './lib/phpexcel/Classes/PHPExcel/IOFactory.php';
        $NombreArchivo = $_FILES['file-0']['tmp_name'];
        $objPHPExcel = PHPExcel_IOFactory::load($NombreArchivo);

        switch (strtolower($hoja)){
            case 'general':
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

                //echo "Filas: ".$numFilas."\n";
                //echo "Columnas: ".$numColumnasEntero."\n";
                $contadorfilas = 0;
                $datosGenerales = [];
                
                $dep = $objItem->obtenerCatDepartamento();
                $depine = $objItem->obtenerCatDepartamentoIne();
                $pro = $objItem->obtenerCatProvincia();
                $mun = $objItem->obtenerCatMunicipio();
                $com = $objItem->obtenerCatComunidad();
                $loc = $objItem->obtenerCatLocalidad();
                //$acu = $objItem->obtenerAcuifero();
                //$eps = $objItem->obtenerEpsas();
                $cue = $objItem->obtenerCuenca();

                // && $numColumnasEntero == 24
                if($numFilas>1){
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){
                        $utmdecimal = $objItem->convertirUtmToDec((float) $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(7, $i)->getFormattedValue(),
                                                                     (float) $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(8, $i)->getFormattedValue(),
                                                                     $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(9, $i)->getFormattedValue().'K');
                        $dms = $objItem->convertirLatLonDecToDms($utmdecimal['lat_decimal'], $utmdecimal['lon_decimal']);

                        $latitudDecimal = (float) $utmdecimal['lat_decimal'];
                        $longitudDecimal = (float) $utmdecimal['lon_decimal'];
                        $ubicacionPolitica = $objItem->get_ubicacion_politica($latitudDecimal, $longitudDecimal);
                        $ubicacionMacrocuenca = $objItem->get_ubicacion_macrocuenca($latitudDecimal, $longitudDecimal);
                        $codigoinedepto = $objItem->get_codigo_ine_departamento($ubicacionPolitica[0]['deptoid']);

                        $datosGenerales[] = array(
                                                  2,
                                                  "0".$ubicacionMacrocuenca[0]['macroid']."-".$codigoinedepto[0]['codigo_ine']."-G",
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(2, $i)->getFormattedValue(),
                                                  $dms['lat_gra'].'-'.$dms['lat_min'].'-'.$dms['lat_seg'],
                                                  $utmdecimal['lat_decimal'],
                                                  $dms['lon_gra'].'-'.$dms['lon_min'].'-'.$dms['lon_seg'],
                                                  $utmdecimal['lon_decimal'],
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(7, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(8, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(9, $i)->getFormattedValue()."K",
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(10, $i)->getFormattedValue(),
                                                  $ubicacionPolitica[0]['deptoid'],
                                                  $ubicacionPolitica[0]['provinciaid'],
                                                  $ubicacionPolitica[0]['municipioid'],
                                                  $com[trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(14, $i)->getFormattedValue())],
                                                  $loc[trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(15, $i)->getFormattedValue())],
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(16, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(17, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(18, $i)->getFormattedValue(),
                                                  $ubicacionMacrocuenca[0]['macroid'],
                                                  "Registrado",
                                                  date("Y-m-d H:i:s"),
                                                  date("Y-m-d H:i:s"),
                                                  $_SESSION[userv][itemId],
                                                  $_SESSION[userv][itemId],
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()
                                                 );
                        $contadorfilas++;
                      }else{                        
                        break;
                      }                         
                    }
                    //print_struc($datosGenerales); exit;
                    session_start();
                    $_SESSION['datosGenerales'] = $datosGenerales; //Array contiene informacion de la hoja GENERAL
                    //$_SESSION['codigos'] = NULL; //Array contiene inormacion de los Id's autoincrementales y codigo sirh
                    //$_SESSION['controltransaccion'] = [];
                    $_SESSION['banderaSql'] = 1;                    
                    //print_r($datosGenerales);
                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    }                    
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosGenerales);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);

                exit;
                break;

            case 'sev':
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);
                
                // echo "Filas: ".$numFilas."\n";
                // echo "Columnas: ".$numColumnasEntero."\n";
                //echo count($_SESSION['datosGenerales']); 
                //echo "Bandera: ".$_SESSION['banderaSql'];
                // print_r($_SESSION['controltransaccion']);
                // print_r($_SESSION['codigos']);

                $contadorfilas = 0;
                $datosSev = [];

                $tiplinbas = $objItem->obtenerTipoLineaBase();
                $tipconf = $objItem->obtenerTipoConfiguracion();
                
                // && $numColumnasEntero == 7
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){ //validar los datos de $_SESSION['datosGenerales'] si estan vacios
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){

                        $config = explode(",", trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(10, $i)->getFormattedValue()));
                        $configid = "";

                        foreach($config as $key=>$valor){
                          $configid = $configid.$tipconf[trim($valor)].",";
                        }
                        $configid = substr($configid, 0, -1);

                        $datosSev[] = array(                                              
                                            $_SESSION['codigos'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],
                                            $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(1, $i)->getFormattedValue(),
                                            $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(2, $i)->getFormattedValue(),
                                            $objItem->convertirFecha($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(3, $i)->getFormattedValue()),
                                            $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(4, $i)->getFormattedValue(),
                                            $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(5, $i)->getFormattedValue(),
                                            $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(6, $i)->getFormattedValue(),
                                            $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(7, $i)->getFormattedValue(),
                                            $tiplinbas[$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(8, $i)->getFormattedValue()],
                                            $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(9, $i)->getFormattedValue(),
                                            $configid,
                                            $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(11, $i)->getFormattedValue(),
                                            $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(12, $i)->getFormattedValue(),
                                            $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(13, $i)->getFormattedValue(),
                                            $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(14, $i)->getFormattedValue(),
                                            $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(15, $i)->getFormattedValue(),
                                            $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(16, $i)->getFormattedValue(),
                                            date("Y-m-d H:i:s"),
                                            date("Y-m-d H:i:s"),
                                            $_SESSION[userv][itemId],
                                            $_SESSION[userv][itemId],
                                            $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()
                                           );
                        $contadorfilas++;
                      }else{
                        break;
                      }
                    }

                    //session_start();
                    //$_SESSION['numfilas'] = $numFilas;
                    //$_SESSION['numcolumnas'] = $numColumnasEntero;                 
                    $_SESSION['datosSev'] = $datosSev;
                    //$_SESSION['codigos'] = NULL;
                    //print_r($datosSev);

                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    }
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosSev);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);

                exit;
                break;

            case 'sev_capa':
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

                // echo "Filas: ".$numFilas."\n";
                // echo "Columnas: ".$numColumnasEntero."\n";
                //echo count($_SESSION['datosGenerales']); 
                //echo "Bandera: ".$_SESSION['banderaSql'];
                // print_r($_SESSION['controltransaccion']);
                // print_r($_SESSION['codigosev']);

                $contadorfilas = 0;
                $datosSevCapa = [];

                // && $numColumnasEntero == 7
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){ //validar los datos de $_SESSION['datosGenerales'] si estan vacios
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){
                        $datosSevCapa[] = array(                                                  
                                                  $_SESSION['codigosev'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(1, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(2, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(3, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(4, $i)->getFormattedValue(),
                                                  date("Y-m-d H:i:s"),
                                                  date("Y-m-d H:i:s"),
                                                  $_SESSION[userv][itemId],
                                                  $_SESSION[userv][itemId]
                                                 );
                        $contadorfilas++;
                      }else{
                        break;
                      }
                    }

                    //session_start();
                    //$_SESSION['numfilas'] = $numFilas;
                    //$_SESSION['numcolumnas'] = $numColumnasEntero;                 
                    $_SESSION['datosSevCapa'] = $datosSevCapa;
                    //$_SESSION['codigos'] = NULL;
                    //print_r($datosSevCapa);
                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    }
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosSevCapa);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);
                      
                exit();
                break;

            case 'tomografia':
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

                // echo "Filas: ".$numFilas."\n";
                // echo "Columnas: ".$numColumnasEntero."\n";
                //echo count($_SESSION['datosGenerales']); 
                //echo "Bandera: ".$_SESSION['banderaSql'];
                // print_r($_SESSION['controltransaccion']);
                // print_r($_SESSION['codigos']);
                //print_struc($_SESSION['codigos']); exit;
                $contadorfilas = 0;
                $datosTomografia = [];

                $tiplinbastom = $objItem->obtenerTipoLineaBase();
                $tipconftom = $objItem->obtenerTipoConfiguracionTomografia();

                // && $numColumnasEntero == 7
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){ //validar los datos de $_SESSION['datosGenerales'] si estan vacios
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){

                        $configtom = explode(",", trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(10, $i)->getFormattedValue()));
                        $configtomid = "";

                        foreach($configtom as $key=>$valor){
                          $configtomid = $configtomid.$tipconftom[trim($valor)].",";
                        }
                        $configtomid = substr($configtomid, 0, -1);

                        $datosTomografia[] = array(                                                  
                                                  $_SESSION['codigos'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(1, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(2, $i)->getFormattedValue(),
                                                  $objItem->convertirFecha($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(3, $i)->getFormattedValue()),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(4, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(5, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(6, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(7, $i)->getFormattedValue(),
                                                  $tiplinbastom[$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(8, $i)->getFormattedValue()],
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(9, $i)->getFormattedValue(),
                                                  $configtomid,
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(11, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(12, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(13, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(14, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(15, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(16, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(17, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(18, $i)->getFormattedValue(),
                                                  date("Y-m-d H:i:s"),
                                                  date("Y-m-d H:i:s"),
                                                  $_SESSION[userv][itemId],
                                                  $_SESSION[userv][itemId],
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()
                                                 );
                        $contadorfilas++;
                      }else{
                        break;
                      }
                    }
                    //print_struc($datosTomografia); exit;
                    //session_start();
                    //$_SESSION['numfilas'] = $numFilas;
                    //$_SESSION['numcolumnas'] = $numColumnasEntero;                 
                    $_SESSION['datosTomografia'] = $datosTomografia;
                    //$_SESSION['codigos'] = NULL;
                    //print_r($datosTomografia);
                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    }
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosTomografia);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);
                      
                exit();
                break;

            case 'tomografia_capa':
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

                // echo "Filas: ".$numFilas."\n";
                // echo "Columnas: ".$numColumnasEntero."\n";
                //echo count($_SESSION['datosGenerales']); 
                //echo "Bandera: ".$_SESSION['banderaSql'];
                // print_r($_SESSION['controltransaccion']);
                //print_struc($_SESSION['codigotom']); exit;

                $contadorfilas = 0;
                $datosTomCapa = [];

                // && $numColumnasEntero == 7
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){ //validar los datos de $_SESSION['datosGenerales'] si estan vacios
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){
                        $datosTomCapa[] = array(                                                  
                                                  $_SESSION['codigotom'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(1, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(2, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(3, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(4, $i)->getFormattedValue(),
                                                  date("Y-m-d H:i:s"),
                                                  date("Y-m-d H:i:s"),
                                                  $_SESSION[userv][itemId],
                                                  $_SESSION[userv][itemId]
                                                 );
                        $contadorfilas++;
                      }else{
                        break;
                      }
                    }
                    //print_struc($datosTomCapa); exit;
                    //session_start();
                    //$_SESSION['numfilas'] = $numFilas;
                    //$_SESSION['numcolumnas'] = $numColumnasEntero;                 
                    $_SESSION['datosTomCapa'] = $datosTomCapa;
                    //$_SESSION['codigos'] = NULL;
                    //print_r($datosTomCapa);
                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    }
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosTomCapa);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);
                      
                exit();
                break;                       
             
            default:
                echo "Esta hoja excel no se pudo procesar";
                //print_r($_SESSION['codigos']);
                exit();
                break;
         }         

        break;

    case 'guardarArchivo':

        //print_struc("a punto de procesar"); exit;
        //print_struc(strtolower($hoja)); exit;
        switch (strtolower($hoja)){
            case 'general':
                $res = $objItem->agregarGeneral($_SESSION['datosGenerales']);
                //echo json_encode(array("res"=>$res));
                echo json_encode($res);
                //print_r($res);
                break;

            case 'sev':
                $res = $objItem->agregarSev($_SESSION['datosSev']);
                echo json_encode($res);
                break;

            case 'sev_capa':
                $res = $objItem->agregarSevCapa($_SESSION['datosSevCapa']);
                echo json_encode($res);
                break;

            case 'tomografia':
                $res = $objItem->agregarTomografia($_SESSION['datosTomografia']);
                echo json_encode($res);
                break;

            case 'tomografia_capa':
                $res = $objItem->agregarTomCapa($_SESSION['datosTomCapa']);
                echo json_encode($res);
                break;

            default:
                echo "Esta hoja excel no se pudo guardar";
                //print_r($_SESSION['codigos']);
                break;
        }

        exit;
        break;

    case 'resetearDatos':
        $_SESSION['codigos'] = NULL;
        unset($_SESSION['codigos']);
        //$_SESSION['controltransaccion'] = NULL;
        //unset($_SESSION['controltransaccion']);       
        $_SESSION['datosGenerales'] = NULL;
        unset($_SESSION['datosGenerales']);
        $_SESSION['datosEspecificos'] = NULL;
        unset($_SESSION['datosEspecificos']);        
        
        echo json_encode(array("res"=>true));
        exit();
        break;
        
    case 'codice':
        echo "es una mala llamada de un snippet";
        exit;
        break;

}