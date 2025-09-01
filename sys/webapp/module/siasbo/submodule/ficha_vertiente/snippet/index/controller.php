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
        $itemIdSubmoduloPozo = 283;
        $res = $objItem->get_permisos($_SESSION[userv][usuario], $itemIdSubmoduloPozo);
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
                
                // $dep = $objItem->obtenerCatDepartamento();
                // $depine = $objItem->obtenerCatDepartamentoIne();
                // $pro = $objItem->obtenerCatProvincia();
                // $mun = $objItem->obtenerCatMunicipio();
                $com = $objItem->obtenerCatComunidad();
                $loc = $objItem->obtenerCatLocalidad();
                //$acu = $objItem->obtenerAcuifero();
                //$eps = $objItem->obtenerEpsas();
                // $cue = $objItem->obtenerCuenca();
                
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

                        //echo "Error en codigo: ".$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()."\n";

                        $datosGenerales[] = array(
                                                  4,
                                                  "0".$ubicacionMacrocuenca[0]['macroid']."-".$codigoinedepto[0]['codigo_ine']."-C",
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
                    $_SESSION['banderaSql'] = 1; //1=insert, 2=update
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

                $usoagua = $objItem->obtenerUsoAgua();
                $proposito = $objItem->obtenerProposito();

                // && $numColumnasEntero == 7
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){ //validar los datos de $_SESSION['datosGenerales'] si estan vacios
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                      if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){

                        $parusoagua = explode(",", trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(3, $i)->getFormattedValue()));
                        $parusoaguaid = "";

                        foreach($parusoagua as $key=>$valor){
                          $parusoaguaid = $parusoaguaid.$usoagua[trim($valor)].",";
                        }
                        $parusoaguaid = substr($parusoaguaid, 0, -1);

                        $parproposito = explode(",", trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(4, $i)->getFormattedValue()));
                        $parpropositoid = "";

                        foreach($parproposito as $key=>$valor){
                          $parpropositoid = $parpropositoid.$proposito[trim($valor)].",";
                        }
                        $parpropositoid = substr($parpropositoid, 0, -1);

                        $datosEspecificos[] = array(                                                  
                                                  $_SESSION['codigos'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(1, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(2, $i)->getFormattedValue(),
                                                  // $usoagua[trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(3, $i)->getFormattedValue())],
                                                  // $proposito[trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(4, $i)->getFormattedValue())],
                                                  $parusoaguaid,
                                                  $parpropositoid,
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(5, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(6, $i)->getFormattedValue(),
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

            case 'captacion':
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

                // echo "Filas: ".$numFilas."\n";
                // echo "Columnas: ".$numColumnasEntero."\n";    
                // echo "Bandera: ".$_SESSION['banderaSql'];

                $contadorfilas = 0;
                $datosCaptacion = [];

                // && $numColumnasEntero == 9
                if($numFilas>1 && count($_SESSION['datosGenerales'])>0 && $_SESSION['datosGenerales'] != ""){
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                        if (trim($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()) != ""){
                            $datosCaptacion[] = array(                                                  
                                                  $objItem->convertirFecha($objPHPExcel->getActiveSheet()->getCellByColumnAndRow(1, $i)->getFormattedValue()),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(2, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(3, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(4, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(5, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(6, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(7, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(8, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(9, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(10, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(11, $i)->getFormattedValue(),
                                                  $_SESSION['codigos'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],
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
                    
                    $_SESSION['datosCaptacion'] = $datosCaptacion;
                    //print_r($datosCaptacion);
                    if($contadorfilas == 0){
                      echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                    }else{
                      echo json_encode(array('res'=>true, 'numfilas'=>$contadorfilas));
                    } 
                }else{
                    echo json_encode(array('res'=>false, 'numfilas'=>$contadorfilas));
                }

                unset($datosCaptacion);
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
                exit;
                break;

            case 'especifico':
                $res = $objItem->agregarEspecifico($_SESSION['datosEspecificos']);
                echo json_encode($res);
                exit;
                break;            

            case 'captacion':
                $res = $objItem->agregarCaptacion($_SESSION['datosCaptacion']);
                echo json_encode($res);
                exit;
                break;                          

            default:
                echo "Esta hoja excel no se pudo guardar";
                //print_r($_SESSION['codigos']);
                exit();
                break;
        }

        exit();
    break;

    case 'getItemFuente':
        $datosSeguimiento = $subObjItem->get_datos_fuente($id);
        echo json_encode($datosSeguimiento);
        exit;
    break;

    case 'resetearDatos':
        $_SESSION['codigos'] = NULL;
        unset($_SESSION['codigos']);       
        $_SESSION['datosGenerales'] = NULL;
        unset($_SESSION['datosGenerales']);
        $_SESSION['datosEspecificos'] = NULL;
        unset($_SESSION['datosEspecificos']);        
        $_SESSION['datosCaptacion'] = NULL;
        unset($_SESSION['datosCaptacion']);              

        echo json_encode(array("res"=>true));
        exit;
    break;
        
    case 'codice':
        echo "es una mala llamada de un snippet";
        exit;
    break;

}