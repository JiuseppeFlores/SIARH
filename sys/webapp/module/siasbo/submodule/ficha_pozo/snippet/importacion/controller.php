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
        /**
         * Sacamos los datos de la grilla
         */
        $smarty->assign("pozoId", $id);
        $grill_list = $objItem->get_grilla_list_sbm("grilla_archivo");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage",$webm["sc_index"]);
        break;

    case 'getItemList':
        $respuesta = $subObjItem->get_item_datatable_Rows($pozoId);
        foreach ($respuesta['data'] as $clave => $valor) {
            $respuesta['data'][$clave]['fecha'] = date_format(date_create($valor['fecha']),"d/m/Y");
        }
        $core->print_json($respuesta);
        break;

    case 'itemUpdate':
        $smarty->assign("pozoId", $pozoId);
        $smarty->assign("id", $id);

        if($type=="update"){
            $item = $subObjItem->get_item($id);
            $smarty->assign("item",$item);
        }

        $smarty->assign("type", $type);
        $smarty->assign("subpage",$webm["form_sc_index"]);
        break;

    case 'itemupdatesql':
        $respuesta = $subObjItem->item_update($item, $itemId, "campos_archivo", $type, $item['fichaId'], $archivo_adjunto);
        $core->print_json($respuesta);
        break;

    case 'itemDelete':
        $res = $subObjItem->item_delete($id, $pozoId);
        $core->print_json($res);
        break;

    case 'itemDescarga':
        $subObjItem->get_file($id, $pozoId);
        break;

    //
    //Importar Archivos
    //
    case 'enviarArchivo':
        //print_r($_FILES['file-0']);
        include './lib/phpexcel/Classes/PHPExcel/IOFactory.php';
        $NombreArchivo = $_FILES['file-0']['tmp_name']; //'D://pozo.xlsx';
        $objPHPExcel = PHPExcel_IOFactory::load($NombreArchivo);
        //$objPHPExcel->setActiveSheetIndex(0);

        $nombreHojas = $objPHPExcel->getSheetNames();
        $verificacion = $subObjItem->verificarConfiguracion($nombreHojas);

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

                echo "Filas: ".$numFilas."\n";
                echo "Columnas: ".$numColumnasEntero."\n";
                $datosGenerales = [];
                
                if($numFilas>1 && $numColumnasEntero == 24){
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++) {
                        $datosGenerales[] = array(
                                                  1,
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(1, $i)->getFormattedValue(),
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
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(12, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(13, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(14, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(15, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(16, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(17, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(18, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(19, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(20, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(21, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(22, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(23, $i)->getFormattedValue(),
                                                  date("Y-m-d H:i:s"),
                                                  date("Y-m-d H:i:s"),
                                                  1,
                                                  1,
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()
                                                 ); 
                    }

                    // for ($i=2; $i<=$numFilas; $i++) {
                    //     for ($j=0; $j<=$numColumnasEntero-1; $j++){
                    //         //echo $objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue(); //."\n"; 
                    //         $datosGenerales[] = $objPHPExcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getFormattedValue();
                    //     } 
                    // }

                    session_start();
                    //$_SESSION['numfilas'] = $numFilas;
                    //$_SESSION['numcolumnas'] = $numColumnasEntero;
                    $_SESSION['datosGenerales'] = $datosGenerales;
                    $_SESSION['codigos'] = NULL;
                    print_r($datosGenerales);
                    //echo json_encode($datosGenerales);
                }else{
                    echo json_encode(array('res'=>false));
                }

                unset($datosGenerales);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);

                exit;
                break;

            case 'especifico':
                $objPHPExcel->setActiveSheetIndexByName($hoja);
                $sheet = $objPHPExcel->getActiveSheet();
                $numFilas = $sheet->getHighestRow();
                $numColumnas = $sheet->getHighestColumn();
                $numColumnasEntero = PHPExcel_Cell::columnIndexFromString($numColumnas);

                echo "Filas: ".$numFilas."\n";
                echo "Columnas: ".$numColumnasEntero."\n";              
                $datosEspecificos = [];
                
                if($numFilas>1 && $numColumnasEntero == 7){
                    //Cargamos todos los datos del archivo Excel a una matriz
                    for ($i=2; $i<=$numFilas; $i++){
                        $datosEspecificos[] = array(                                                  
                                                  $_SESSION['codigos'][$objPHPExcel->getActiveSheet()->getCellByColumnAndRow(0, $i)->getFormattedValue()],
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(1, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(2, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(3, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(4, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(5, $i)->getFormattedValue(),
                                                  $objPHPExcel->getActiveSheet()->getCellByColumnAndRow(6, $i)->getFormattedValue()
                                                 ); 
                    }

                    //session_start();
                    //$_SESSION['numfilas'] = $numFilas;
                    //$_SESSION['numcolumnas'] = $numColumnasEntero;
                    $_SESSION['datosEspecificos'] = $datosEspecificos;
                    //$_SESSION['codigos'] = NULL;
                    print_r($datosEspecificos);
                    //echo json_encode($datosEspecificos);
                }else{
                    echo json_encode(array('res'=>false));
                }

                unset($datosEspecificos);
                $objPHPExcel->disconnectWorksheets();
                unset($objPHPExcel);

                exit;
                break;

            case '1':
                break;

            case '1':
                break;

            case '1':
                break;

            case '1':
                break;

            case '1':
                break;

            case '1':
                break;

            case '1':
                break;

            case '1':
                break;

            case '1':
                break;

            case '1':
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
                $res = $subObjItem->agregarGeneral($_SESSION['datosGenerales']);
                //echo json_encode(array("res"=>$res));
                //echo json_encode($res);
                print_r($res);
                //echo $res;
                //print_r($_SESSION['codigos']);
                break;

            case 'especifico':
                $res = $subObjItem->agregarEspecifico($_SESSION['datosEspecificos']);
                //echo json_encode(array("res"=>$res));
                //echo json_encode($res);
                print_r($res);
                exit;
                break;

            case 'dato':
                break;

            case 'dato':
                break;

            case 'dato':
                break;

            case 'dato':
                break;

            case 'dato':
                break;

            case 'dato':
                break;

            case 'dato':
                break;

            case 'dato':
                break;

            case 'dato':
                break;

            case 'dato':
                break;

            default:
                echo "Esta hoja excel no se pudo guardar";
                //print_r($_SESSION['codigos']);
                exit();
                break;
        }



        exit();
        break;
}