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
        $res = $objItem->get_permisos($_SESSION[userv][usuario], $perpozo);
        //$core->print_json($res);
        echo json_encode($res);
        //print_r($res);
        //echo json_encode(array("crear"=>"0", "editar"=>"1", "eliminar"=>"1"));
        //echo $_SESSION[userv][usuario]." - ".$perpozo;
        exit();
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
        exit();
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

                // echo "Filas: ".$numFilas."\n";
                // echo "Columnas: ".$numColumnasEntero."\n";

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
                                                  3,
                                                  "0".$ubicacionMacrocuenca[0]['macroid']."-".$codigoinedepto[0]['codigo_ine']."-M",
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

                    session_start();
                    $_SESSION['datosGenerales'] = $datosGenerales; //Array contiene informacion de la hoja GENERAL
                    //$_SESSION['codigos'] = NULL; //Array contiene inormacion de los Id's autoincrementales y codigo sirh
                    //$_SESSION['controltransaccion'] = [];
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
                      
                exit();
                break;

            case 'especifico':
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
                $datosEspecificos = [];

                $tipman = $objItem->obtenerTipoManantial();
                $usoagua = $objItem->obtenerUsoAgua();
                $medsur = $objItem->obtenerMedioSurgencia();
                $per = $objItem->obtenerPermanencia();

                // && $numColumnasEntero == 7
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){ //validar los datos de $_SESSION['datosGenerales'] si estan vacios
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){
                        $datosEspecificos[] = array(                                                  
                                                  $_SESSION['codigos'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(1, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(2, $i)->getFormattedValue(),
                                                  $tipman[$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(3, $i)->getFormattedValue()],
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(4, $i)->getFormattedValue(),
                                                  $usoagua[trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(5, $i)->getFormattedValue())],
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(6, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(7, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(8, $i)->getFormattedValue(),
                                                  $medsur[trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(9, $i)->getFormattedValue())],
                                                  $per[$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(10, $i)->getFormattedValue()],
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(11, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(12, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(13, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(14, $i)->getFormattedValue(),
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
                    $_SESSION['datosEspecificos'] = $datosEspecificos;
                    //$_SESSION['codigos'] = NULL;
                    //print_r($datosEspecificos);
                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    }
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosEspecificos);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);
                      
                exit();
                break;            

            case 'monitoreo_cantidad': //Falta desde aqui
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

                // echo "Filas: ".$numFilas."\n";
                // echo "Columnas: ".$numColumnasEntero."\n"; 
                // echo "Bandera: ".$_SESSION['banderaSql']; 

                $contadorfilas = 0;            
                $datosMonitoreoCantidad = [];

                $cantipepo = $objItem->obtenerTipoEpoca();

                //print_r($objItem->obtenerTipoEpoca());
                
                // && $numColumnasEntero == 12
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){
                        $datosMonitoreoCantidad[] = array(
                                                  $_SESSION['codigos'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],                                                                                              
                                                  $objItem->convertirFecha($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(1, $i)->getFormattedValue()),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(2, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(3, $i)->getFormattedValue(),
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
                    $_SESSION['datosMonitoreoCantidad'] = $datosMonitoreoCantidad;
                    //$_SESSION['codigos'] = NULL;
                    //print_r($datosMonitoreoCantidad);
                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    }
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosMonitoreoCantidad);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);

                exit();
                break;

            case 'monitoreo_calidad':
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

                // echo "Filas: ".$numFilas."\n";
                // echo "Columnas: ".$numColumnasEntero."\n"; 
                // echo "Bandera: ".$_SESSION['banderaSql']; 

                $contadorfilas = 0;            
                $datosMonitoreoCalidad = [];

                $caltipepo = $objItem->obtenerTipoEpoca();

                //print_r($objItem->obtenerTipoEpoca());
                
                // && $numColumnasEntero == 12
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){
                        $datosMonitoreoCalidad[] = array(
                                                  $_SESSION['codigos'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],                                                                                              
                                                  $objItem->convertirFecha($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(1, $i)->getFormattedValue()),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(2, $i)->getFormattedValue(),
                                                  $caltipepo[trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(3, $i)->getFormattedValue())],
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(4, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(5, $i)->getFormattedValue(),
                                                  $objItem->convertirFecha($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(6, $i)->getFormattedValue()),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(7, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(8, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(9, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(10, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(11, $i)->getFormattedValue(),
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
                    $_SESSION['datosMonitoreoCalidad'] = $datosMonitoreoCalidad;
                    //$_SESSION['codigos'] = NULL;
                    //print_r($datosMonitoreoCalidad);
                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    }
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosMonitoreoCalidad);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);

                exit();
                break;

            //Segunda forma
            // case 'monitoreo_calidad':
            //     $objPHPExcel->setActiveSheetIndexByName($hoja);
            //     $sheet = $objPHPExcel->getActiveSheet();
            //     $numFilas = $sheet->getHighestRow();
            //     $numColumnas = $sheet->getHighestColumn();
            //     $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

            //     echo "Filas: ".$numFilas."\n";
            //     echo "Columnas: ".$numColumnasEntero."\n"; 
            //     echo "Bandera: ".$_SESSION['banderaSql'];             
            //     $datosMonitoreoCalidad = [];

            //     $caltipepo = $objItem->obtenerTipoEpoca();

            //     print_r($objItem->obtenerTipoEpoca());
                
            //     // && $numColumnasEntero == 12
            //     if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){
            //         //Cargamos todos los datos del archivo Excel a una matriz
            //         for ($i=2; $i<=$numFilas; $i++){
            //             $datosMonitoreoCalidad[] = array(
            //                                       $_SESSION['codigos'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],                                                                                              
            //                                       $objItem->convertirFecha($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(2, $i)->getFormattedValue()),
            //                                       $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(3, $i)->getFormattedValue(),
            //                                       $caltipepo[trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(4, $i)->getFormattedValue())],
            //                                       $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(5, $i)->getFormattedValue(),
            //                                       $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(6, $i)->getFormattedValue(),
            //                                       $objItem->convertirFecha($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(7, $i)->getFormattedValue()),
            //                                       $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(8, $i)->getFormattedValue(),
            //                                       $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(9, $i)->getFormattedValue(),
            //                                       $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(10, $i)->getFormattedValue(),
            //                                       $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(11, $i)->getFormattedValue(),
            //                                       $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(12, $i)->getFormattedValue(),
            //                                       date("Y-m-d H:i:s"),
            //                                       date("Y-m-d H:i:s"),
            //                                       1,
            //                                       1,
            //                                       $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(1, $i)->getFormattedValue()
            //                                      ); 
            //         }

            //         //session_start();
            //         //$_SESSION['numfilas'] = $numFilas;
            //         //$_SESSION['numcolumnas'] = $numColumnasEntero;
            //         $_SESSION['datosMonitoreoCalidad'] = $datosMonitoreoCalidad;
            //         //$_SESSION['codigos'] = NULL;
            //         print_r($datosMonitoreoCalidad);
            //         //echo json_encode($datosMonitoreoCalidad);
            //     }else{
            //         echo json_encode(array('res'=>false));
            //     }

            //     unset($datosMonitoreoCalidad);
            //     $objPHPExcel->disconnectWorksheets();
            //     unset($objPHPExcel);

            //     exit();
            //     break;

            case 'mc_campo':
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

                // echo "Filas: ".$numFilas."\n";
                // echo "Columnas: ".$numColumnasEntero."\n"; 
                // echo "Bandera: ".$_SESSION['banderaSql']; 

                $contadorfilas = 0;            
                $datosMonCalCampo = [];

                //print_r($_SESSION['codigomoncal']);
                
                // && $numColumnasEntero == 14
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){
                        for ($j=1; $j<=12; $j++){ //$numColumnasEntero-2
                            if ($objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue() != "") {
                                $datosMonCalCampo[] = array(
                                                  $_SESSION['codigomoncal'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],                                                                                              
                                                  1,
                                                  $objItem->obtenerIdCampo($j),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(13, $i)->getFormattedValue(), //$numColumnasEntero-1
                                                  date("Y-m-d H:i:s"),
                                                  date("Y-m-d H:i:s"),
                                                  $_SESSION[userv][itemId],
                                                  $_SESSION[userv][itemId]                                                   
                                                 );
                            }                             
                        }

                        $contadorfilas++;
                      }else{
                        break;
                      }                                                
                    }

                    //session_start();
                    //$_SESSION['numfilas'] = $numFilas;
                    //$_SESSION['numcolumnas'] = $numColumnasEntero;
                    $_SESSION['datosMonCalCampo'] = $datosMonCalCampo;
                    //$_SESSION['codigos'] = NULL;
                    //print_r($datosMonCalCampo);
                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    }
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosMonCalCampo);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);

                exit();
                break;

            case 'mc_basicos':
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

                // echo "Filas: ".$numFilas."\n";
                // echo "Columnas: ".$numColumnasEntero."\n"; 
                // echo "Bandera: ".$_SESSION['banderaSql'];

                $contadorfilas = 0;            
                $datosMonCalBasicos = [];

                //print_r($_SESSION['codigomoncal']);
                
                // && $numColumnasEntero == 24
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){
                        for ($j=1; $j<=22; $j++){ //$numColumnasEntero-2
                            if ($objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue() != "") {
                                $datosMonCalBasicos[] = array(
                                                  $_SESSION['codigomoncal'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],                                                                                              
                                                  2,
                                                  $objItem->obtenerIdBasicos($j),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(23, $i)->getFormattedValue(), //$numColumnasEntero-1
                                                  date("Y-m-d H:i:s"),
                                                  date("Y-m-d H:i:s"),
                                                  $_SESSION[userv][itemId],
                                                  $_SESSION[userv][itemId]
                                                 );   
                            }                             
                        }

                        $contadorfilas++;
                      }else{
                        break;
                      }                                                
                    }

                    //session_start();
                    //$_SESSION['numfilas'] = $numFilas;
                    //$_SESSION['numcolumnas'] = $numColumnasEntero;
                    $_SESSION['datosMonCalBasicos'] = $datosMonCalBasicos;
                    //$_SESSION['codigos'] = NULL;
                    //print_r($datosMonCalBasicos);
                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    }
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosMonCalBasicos);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);

                exit();
                break;

            case 'mc_inorganicos':
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

                // echo "Filas: ".$numFilas."\n";
                // echo "Columnas: ".$numColumnasEntero."\n"; 
                // echo "Bandera: ".$_SESSION['banderaSql'];

                $contadorfilas = 0;
                $datosMonCalInorganicos = [];

                //print_r($_SESSION['codigomoncal']);
                
                // && $numColumnasEntero == 68
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){
                        for ($j=1; $j<=66; $j++){ //$numColumnasEntero-2
                            if ($objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue() != "") {
                                $datosMonCalInorganicos[] = array(
                                                  $_SESSION['codigomoncal'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],                                                                                              
                                                  3,
                                                  $objItem->obtenerIdInorganicos($j),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(67, $i)->getFormattedValue(), //$numColumnasEntero-1
                                                  date("Y-m-d H:i:s"),
                                                  date("Y-m-d H:i:s"),
                                                  $_SESSION[userv][itemId],
                                                  $_SESSION[userv][itemId]
                                                 );   
                            }                             
                        }

                        $contadorfilas++;
                      }else{
                        break;
                      }                                                
                    }

                    //session_start();
                    //$_SESSION['numfilas'] = $numFilas;
                    //$_SESSION['numcolumnas'] = $numColumnasEntero;
                    $_SESSION['datosMonCalInorganicos'] = $datosMonCalInorganicos;
                    //$_SESSION['codigos'] = NULL;
                    //print_r($datosMonCalInorganicos);
                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    }
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosMonCalInorganicos);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);

                exit();
                break;

            case 'mc_organicos':
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

                // echo "Filas: ".$numFilas."\n";
                // echo "Columnas: ".$numColumnasEntero."\n"; 
                // echo "Bandera: ".$_SESSION['banderaSql'];

                $contadorfilas = 0;
                $datosMonCalOrganicos = [];

                //print_r($_SESSION['codigomoncal']);
                
                // && $numColumnasEntero == 33
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){
                        for ($j=1; $j<=31; $j++){ //$numColumnasEntero-2
                            if ($objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue() != "") {
                                $datosMonCalOrganicos[] = array(
                                                  $_SESSION['codigomoncal'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],                                                                                              
                                                  4,
                                                  $objItem->obtenerIdOrganicos($j),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(32, $i)->getFormattedValue(), //$numColumnasEntero-1
                                                  date("Y-m-d H:i:s"),
                                                  date("Y-m-d H:i:s"),
                                                  $_SESSION[userv][itemId],
                                                  $_SESSION[userv][itemId]
                                                 );   
                            }                             
                        }

                        $contadorfilas++;
                      }else{
                        break;
                      }
                                                
                    }

                    //session_start();
                    //$_SESSION['numfilas'] = $numFilas;
                    //$_SESSION['numcolumnas'] = $numColumnasEntero;
                    $_SESSION['datosMonCalOrganicos'] = $datosMonCalOrganicos;
                    //$_SESSION['codigos'] = NULL;
                    //print_r($datosMonCalOrganicos);
                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    }
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosMonCalOrganicos);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);

                exit();
                break;

            case 'mc_microorganismos':
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

                // echo "Filas: ".$numFilas."\n";
                // echo "Columnas: ".$numColumnasEntero."\n"; 
                // echo "Bandera: ".$_SESSION['banderaSql'];

                $contadorfilas = 0;            
                $datosMonCalMicro = [];

                //print_r($_SESSION['codigomoncal']);
                
                // && $numColumnasEntero == 15
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){
                        for ($j=1; $j<=13; $j++){ //$numColumnasEntero-2
                            if ($objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue() != "") {
                                $datosMonCalMicro[] = array(
                                                  $_SESSION['codigomoncal'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],                                                                                              
                                                  5,
                                                  $objItem->obtenerIdMicroorganismos($j),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(14, $i)->getFormattedValue(), //$numColumnasEntero-1
                                                  date("Y-m-d H:i:s"),
                                                  date("Y-m-d H:i:s"),
                                                  $_SESSION[userv][itemId],
                                                  $_SESSION[userv][itemId]
                                                 );   
                            }                             
                        }

                        $contadorfilas++;
                      }else{
                        break;
                      }                                                
                    }

                    //session_start();
                    //$_SESSION['numfilas'] = $numFilas;
                    //$_SESSION['numcolumnas'] = $numColumnasEntero;
                    $_SESSION['datosMonCalMicro'] = $datosMonCalMicro;
                    //$_SESSION['codigos'] = NULL;
                    //print_r($datosMonCalMicro);
                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    }
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosMonCalMicro);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);

                exit();
                break;

            case 'mc_plaguicidas':
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

                // echo "Filas: ".$numFilas."\n";
                // echo "Columnas: ".$numColumnasEntero."\n"; 
                // echo "Bandera: ".$_SESSION['banderaSql'];

                $contadorfilas = 0;          
                $datosMonCalPlaguicidas = [];

                //print_r($_SESSION['codigomoncal']);
                
                // && $numColumnasEntero == 59
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){
                        for ($j=1; $j<=57; $j++){ //$numColumnasEntero-2
                            if ($objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue() != "") {
                                $datosMonCalPlaguicidas[] = array(
                                                  $_SESSION['codigomoncal'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],                                                                                              
                                                  6,
                                                  $objItem->obtenerIdPlaguicidas($j),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(58, $i)->getFormattedValue(), //$numColumnasEntero-1
                                                  date("Y-m-d H:i:s"),
                                                  date("Y-m-d H:i:s"),
                                                  $_SESSION[userv][itemId],
                                                  $_SESSION[userv][itemId]
                                                 );   
                            }                             
                        }

                        $contadorfilas++;
                      }else{
                        break;
                      }                                                
                    }

                    //session_start();
                    //$_SESSION['numfilas'] = $numFilas;
                    //$_SESSION['numcolumnas'] = $numColumnasEntero;
                    $_SESSION['datosMonCalPlaguicidas'] = $datosMonCalPlaguicidas;
                    //$_SESSION['codigos'] = NULL;
                    //print_r($datosMonCalPlaguicidas);
                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    }
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosMonCalPlaguicidas);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);

                exit();
                break;

            case 'monitoreo_isotopico':
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

                // echo "Filas: ".$numFilas."\n";
                // echo "Columnas: ".$numColumnasEntero."\n"; 
                // echo "Bandera: ".$_SESSION['banderaSql'];

                $contadorfilas = 0;          
                $datosMonitoreoIsotopico = [];

                $caltipepo = $objItem->obtenerTipoEpoca();

                //print_r($objItem->obtenerTipoEpoca());
                
                // && $numColumnasEntero == 12
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){
                        $datosMonitoreoIsotopico[] = array(
                                                  $_SESSION['codigos'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],                                                                                              
                                                  $objItem->convertirFecha($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(1, $i)->getFormattedValue()),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(2, $i)->getFormattedValue(),
                                                  $caltipepo[trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(3, $i)->getFormattedValue())],
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(4, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(5, $i)->getFormattedValue(),
                                                  $objItem->convertirFecha($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(6, $i)->getFormattedValue()),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(7, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(8, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(9, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(10, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(11, $i)->getFormattedValue(),
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
                    $_SESSION['datosMonitoreoIsotopico'] = $datosMonitoreoIsotopico;
                    //$_SESSION['codigos'] = NULL;
                    //print_r($datosMonitoreoIsotopico);
                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    }
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosMonitoreoIsotopico);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);

                exit();
                break;

            case 'mi_radioactividad':
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

                // echo "Filas: ".$numFilas."\n";
                // echo "Columnas: ".$numColumnasEntero."\n"; 
                // echo "Bandera: ".$_SESSION['banderaSql'];

                $contadorfilas = 0;
                $datosMonIsoRad = [];

                //print_r($_SESSION['codigomoniso']);
                
                // && $numColumnasEntero == 4
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){
                        for ($j=1; $j<=2; $j++){ //$numColumnasEntero-2
                            if ($objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue() != "") {
                                $datosMonIsoRad[] = array(
                                                  $_SESSION['codigomoniso'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],                                                                                              
                                                  1,
                                                  $objItem->obtenerIdRadioActividad($j),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(3, $i)->getFormattedValue(), //$numColumnasEntero-1
                                                  date("Y-m-d H:i:s"),
                                                  date("Y-m-d H:i:s"),
                                                  $_SESSION[userv][itemId],
                                                  $_SESSION[userv][itemId]
                                                 );   
                            }                             
                        }

                        $contadorfilas++;
                      }else{
                        break;
                      }                                                
                    }

                    //session_start();
                    //$_SESSION['numfilas'] = $numFilas;
                    //$_SESSION['numcolumnas'] = $numColumnasEntero;
                    $_SESSION['datosMonIsoRad'] = $datosMonIsoRad;
                    //$_SESSION['codigos'] = NULL;
                    //print_r($datosMonIsoRad);
                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    }
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosMonIsoRad);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);

                exit();
                break;

            case 'mi_isotopos':
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

                // echo "Filas: ".$numFilas."\n";
                // echo "Columnas: ".$numColumnasEntero."\n"; 
                // echo "Bandera: ".$_SESSION['banderaSql'];

                $contadorfilas = 0;
                $datosMonIsoIso = [];

                //print_r($_SESSION['codigomoniso']);
                
                // && $numColumnasEntero == 15
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){
                        for ($j=1; $j<=13; $j++){ //$numColumnasEntero-2
                            if ($objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue() != "") {
                                $datosMonIsoIso[] = array(
                                                  $_SESSION['codigomoniso'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],                                                                                              
                                                  2,
                                                  $objItem->obtenerIdIsotopos($j),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(14, $i)->getFormattedValue(), //$numColumnasEntero-1
                                                  date("Y-m-d H:i:s"),
                                                  date("Y-m-d H:i:s"),
                                                  $_SESSION[userv][itemId],
                                                  $_SESSION[userv][itemId]
                                                 );   
                            }                             
                        }

                        $contadorfilas++;
                      }else{
                        break;
                      }                                                
                    }

                    //session_start();
                    //$_SESSION['numfilas'] = $numFilas;
                    //$_SESSION['numcolumnas'] = $numColumnasEntero;
                    $_SESSION['datosMonIsoIso'] = $datosMonIsoIso;
                    //$_SESSION['codigos'] = NULL;
                    //print_r($datosMonIsoIso);
                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    }
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosMonIsoIso);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);

                exit();
                break;

            case 'mi_otros':
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

                // echo "Filas: ".$numFilas."\n";
                // echo "Columnas: ".$numColumnasEntero."\n"; 
                // echo "Bandera: ".$_SESSION['banderaSql'];

                $contadorfilas = 0;
                $datosMonIsoOtr = [];

                //print_r($_SESSION['codigomoniso']);
                
                // && $numColumnasEntero == 4
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){
                        for ($j=1; $j<=2; $j++){ //$numColumnasEntero-2
                            if ($objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue() != "") {
                                $datosMonIsoOtr[] = array(
                                                  $_SESSION['codigomoniso'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],                                                                                              
                                                  3,
                                                  $objItem->obtenerIdOtros($j),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(3, $i)->getFormattedValue(), //$numColumnasEntero-1
                                                  date("Y-m-d H:i:s"),
                                                  date("Y-m-d H:i:s"),
                                                  $_SESSION[userv][itemId],
                                                  $_SESSION[userv][itemId]
                                                 );   
                            }                             
                        }

                        $contadorfilas++;
                      }else{
                        break;
                      }                                                
                    }

                    //session_start();
                    //$_SESSION['numfilas'] = $numFilas;
                    //$_SESSION['numcolumnas'] = $numColumnasEntero;
                    $_SESSION['datosMonIsoOtr'] = $datosMonIsoOtr;
                    //$_SESSION['codigos'] = NULL;
                    //print_r($datosMonIsoOtr);
                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    }
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosMonIsoOtr);
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

        switch (strtolower($hoja)){
            case 'general':
                $res = $objItem->agregarGeneral($_SESSION['datosGenerales']);
                //echo json_encode(array("res"=>$res));
                echo json_encode($res);
                //print_r($res);
                break;

            case 'especifico':
                $res = $objItem->agregarEspecifico($_SESSION['datosEspecificos']);
                echo json_encode($res);
                break;            

            case 'monitoreo_cantidad':
                $res = $objItem->agregarMonitoreoCantidad($_SESSION['datosMonitoreoCantidad']);
                echo json_encode($res);
                break;

            case 'monitoreo_calidad':
                $res = $objItem->agregarMonitoreoCalidad($_SESSION['datosMonitoreoCalidad']);
                echo json_encode($res);
                break;

            case 'mc_campo':
                $res = $objItem->agregarMonCalCampo($_SESSION['datosMonCalCampo']);
                echo json_encode($res);
                break;

            case 'mc_basicos':
                $res = $objItem->agregarMonCalCampo($_SESSION['datosMonCalBasicos']);
                echo json_encode($res);
                break;

            case 'mc_inorganicos':
                $res = $objItem->agregarMonCalCampo($_SESSION['datosMonCalInorganicos']);
                echo json_encode($res);
                break;

            case 'mc_organicos':
                $res = $objItem->agregarMonCalCampo($_SESSION['datosMonCalOrganicos']);
                echo json_encode($res);
                break;

            case 'mc_microorganismos':
                $res = $objItem->agregarMonCalCampo($_SESSION['datosMonCalMicro']);
                echo json_encode($res);
                break;

            case 'mc_plaguicidas':
                $res = $objItem->agregarMonCalCampo($_SESSION['datosMonCalPlaguicidas']);
                echo json_encode($res);
                break;

            case 'monitoreo_isotopico':
                $res = $objItem->agregarMonitoreoIsotopico($_SESSION['datosMonitoreoIsotopico']);
                echo json_encode($res);
                break;

            case 'mi_radioactividad':
                $res = $objItem->agregarMonIsoCampo($_SESSION['datosMonIsoRad']);
                echo json_encode($res);
                break;

            case 'mi_isotopos':
                $res = $objItem->agregarMonIsoCampo($_SESSION['datosMonIsoIso']);
                echo json_encode($res);
                break;

            case 'mi_otros':
                $res = $objItem->agregarMonIsoCampo($_SESSION['datosMonIsoOtr']);
                echo json_encode($res);
                break;              

            default:
                echo "Esta hoja excel no se pudo guardar";
                //print_r($_SESSION['codigos']);
                exit();
                break;
        }

        exit();
        break;

    case 'resetearDatos':
        $_SESSION['codigos'] = NULL;
        unset($_SESSION['codigos']);       
        $_SESSION['datosGenerales'] = NULL;
        unset($_SESSION['datosGenerales']);
        $_SESSION['datosEspecificos'] = NULL;
        unset($_SESSION['datosEspecificos']);        
        $_SESSION['datosMonitoreoCantidad'] = NULL;
        unset($_SESSION['datosMonitoreoCantidad']);
        $_SESSION['datosMonitoreoCalidad'] = NULL;
        unset($_SESSION['datosMonitoreoCalidad']);
        $_SESSION['codigomoncal'] = NULL;
        unset($_SESSION['codigomoncal']);
        $_SESSION['datosMonCalCampo'] = NULL;
        unset($_SESSION['datosMonCalCampo']);
        $_SESSION['datosMonCalBasicos'] = NULL;
        unset($_SESSION['datosMonCalBasicos']);
        $_SESSION['datosMonCalInorganicos'] = NULL;
        unset($_SESSION['datosMonCalInorganicos']);
        $_SESSION['datosMonCalOrganicos'] = NULL;
        unset($_SESSION['datosMonCalOrganicos']);
        $_SESSION['datosMonCalMicro'] = NULL;
        unset($_SESSION['datosMonCalMicro']);
        $_SESSION['datosMonCalPlaguicidas'] = NULL;
        unset($_SESSION['datosMonCalPlaguicidas']);
        $_SESSION['datosMonitoreoIsotopico'] = NULL;
        unset($_SESSION['datosMonitoreoIsotopico']);
        $_SESSION['codigomoniso'] = NULL;       
        unset($_SESSION['codigomoniso']);
        $_SESSION['datosMonIsoRad'] = NULL;
        unset($_SESSION['datosMonIsoRad']);
        $_SESSION['datosMonIsoIso'] = NULL;
        unset($_SESSION['datosMonIsoIso']);
        $_SESSION['datosMonIsoOtr'] = NULL;        
        unset($_SESSION['datosMonIsoOtr']);        

        echo json_encode(array("res"=>true));
        exit();
        break;
        
    case 'codice':
        echo "es una mala llamada de un snippet";
        exit;
        break;

}