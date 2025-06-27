<?php

include './lib/phpexcel/Classes/PHPExcel/IOFactory.php';
/**
 * Created by PhpStorm.
 * User: henrytaby
 * Date: 3/5/2018
 * Time: 15:23
 */

class Index extends Table {

    function __construct()
    {
        /**
         * Inicializamos todas las librerias y variables para el submodulo
         */
        $this->submodule_init_sbm();
    }

    /** Get excel file*/
    function getExcelFile($item,$userprint){
        global $core, $_REQUEST,$CFG,$dbm,$module,$smoduleName;
        $dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        //print_struc($item);exit;
        $objReader = PHPExcel_IOFactory::createReader('Excel2007');
        try {
            $sql = $this->getSQlForm($item);
            $ocultar = $item;
            //echo "<pre>".$sql."<pre/>";exit;
            $info = $dbm->Execute($sql);
            $item = $info->GetRows();
            $this->objExcel = $objReader->load("./module/$module/submodule/$smoduleName/snippet/index/view/reporte/normativa.xlsx");
        } catch (Exception $e) {
            die ($e->getMessage());
        }

        /**
         * Titulo y filtros superior
         */
        //$c = 2;
        //$this->setTitle($c);
        //$c = $c +1;
        $c = 4;
        //$this->setData($c,$item,$ocultar,$userprint);

        $alignArray = array('alignment' => array(
                                'horizontal'    => PHPExcel_Style_Alignment::HORIZONTAL_JUSTIFY,
                                'vertical'      => PHPExcel_Style_Alignment::VERTICAL_TOP,
                                'wrap'          => true
                             ));
        // Set active sheet index to the first sheet, so Excel opens this as the first sheet
        //$this->objExcel->setActiveSheetIndex(0);
        // Redirect output to a client�s web browser (Excel2007)
        $nameFile = "Reporte Segun Normativa ".date("Ymd-His");
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="'.$nameFile.'.xlsx"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($this->objExcel, 'Excel2007');
        $objWriter->save('php://output');
    }

    function getSQlForm($item){
        $sql = "select * from mmaya_siasbo.item";
        return $sql;
    }

    function setData($c,$item,$ocultar,$userprint){
        global $core, $objCatalog,$CFG;
        //$condicional = $objCatalog->getCondicional();
        /**
         * Sacamos array de tipo de proyecto
         */
        //$tipoProyecto = $objCatalog->getTipoProyecto();
        /**
         * Recogemos lista de columnas
         */
        $col = $this->getCol();

        if($CFG->snir)
        $aux="SNIR ";
        else
        $aux="SIRH ";
        /**
         *
         */
        $c2 = $c +1;
        //verificar velocidad
        $hojaActiva = $this->objExcel->getActiveSheet();
        /*$opcion = $objCatalog->getArrayCondicion();
        $estado = $objCatalog->getArrayEstado();
        //Datos adicionales
        $departamento = $objCatalog->getDep();
        $municipio = $objCatalog->getMun();
         $provincia = $objCatalog->getProv();
         $situacion = $objCatalog->getCatalogSituacion();
         $estadoPresa = $objCatalog->getCatalogEstadoPresa();
         $usoEmbalse = $objCatalog->getCatalogUsoEmbalse();
         $tipoPresa = $objCatalog->getCatalogTipoPresa();
         $cuencaPrincipal = $objCatalog->getCatalogCuencaPrincipal();
         $tipovertedero = $objCatalog->getCatalogVertedero();
         $cuencaNivel5 = $objCatalog->getNivel5();
         $condicion = $objCatalog->getListCondicion();*/
        //$listestado = $objCatalog->getEstadoOption();
        //$listfunc = $objCatalog->getFuncionamientoOption();
        //$financiador = $objCatalog->getFinanciadorOption();
       // $banco = $objCatalog->getBancoOpt();

        $i=0;
        foreach($item as $row){
            /**
             * Iniciamos las columnas
             */
            $p = 0;

            /*
            Otras datos*/

            $c = $c +1;//fila4
            $types = PHPExcel_Cell_DataType::TYPE_STRING;

            $hojaActiva
                    ->setCellValue('E2', $aux.$userprint["username"]." ".date("d/m/Y  H:i:s") );
            $hojaActiva
                    ->getStyle("E2")->getFont()->setSize(10);

            $hojaActiva

                    ->setCellValue($col[$p++].$c, ($i + 1) )//n~
                    ->setCellValue($col[$p++].$c, $departamento[$row["departamentoId"]] )
                    ->setCellValue($col[$p++].$c, utf8_encode($municipio[$row["municipioId"]]))//Gestion

                    ->setCellValue($col[$p++].$c, utf8_encode($row["nombre"]) )//Empresa o persona contratista
                    ->setCellValue($col[$p++].$c, $estadoPresa[$row["estadoId"]] )//Objeto del contrato
                    ->setCellValue($col[$p++].$c, ($condicion[$row["activo"]]))
                    ->setCellValue($col[$p++].$c, $row["latitud"])//Monto del contrato
                    ->setCellValue($col[$p++].$c, $row["longitud"])
                    ->setCellValue($col[$p++].$c, $row["altitud"])

                    ->setCellValue($col[$p++].$c, utf8_encode($row["rio"]))
                    ->setCellValue($col[$p++].$c, $cuencaNivel5[$row["nivel5Id"]])

                    ->setCellValue($col[$p++].$c, $row["cuenca_area"])
                    ->setCellValue($col[$p++].$c, $row["coronamiento_cota"])
                    ->setCellValue($col[$p++].$c, utf8_encode($row["material"]))

                    ->setCellValue($col[$p++].$c, $row["cuenca_volumen"])
                    ->setCellValue($col[$p++].$c, $row["cuenca_capacidad"] )
                    ->setCellValue($col[$p++].$c, $usoEmbalse[$row["usoId"]] )

                    ->setCellValue($col[$p++].$c, $tipoPresa[$row["tipoId"]] )
                    ->setCellValue($col[$p++].$c,$row["altura"])
                    ->setCellValue($col[$p++].$c,$row["coronamiento_longitud"])
                    ->setCellValue($col[$p++].$c,$row["coronamiento_ancho"])

                    ->setCellValue($col[$p++].$c, $tipovertedero[$row["excedenciaId"]] )
                    ->setCellValue($col[$p++].$c,utf8_encode($row["excedencia_posicion"]))
                    ->setCellValue($col[$p++].$c,$row["excedencia_caudal"])
                    ->setCellValue($col[$p++].$c,$row["excedencia_retorno"]);


                    //->setCellValue($col[$p++].$c, utf8_encode($row["representanteLegal"]) )//Nombre representante legal



                    /*
                    ->setCellValue($col[$p++].$c, $row["diasHastaInicio"])
                    ->setCellValue($col[$p++].$c, $row["fechaInicio"])
                    ->setCellValue($col[$p++].$c, $row["fechaFin"])
                    */



                          /*
                    ->setCellValue($col[$p++].$c, $row["contraloria_fechaRegistro"])
                    ->setCellValue($col[$p++].$c, $row["contraloria_fechaLimiteRegistro"])
                    */


             $i++;
             if(($c%2) != 0){
        $hojaActiva->getStyle($col[0].$c.':Y'.$c)->getFill()->applyFromArray(array('type' => PHPExcel_Style_Fill::FILL_SOLID,'startcolor' => array('rgb' =>'E5E5E5')));
        }
        }//END FOR

        $ocultos =$ocultar["listCheckbox"];
        $ocultosArray = explode(" ", $ocultos);

        foreach ( $ocultosArray as $chBx){
            if($chBx != ''){
        $hojaActiva->getColumnDimension($chBx)->setVisible(false);
        }
       }
        /**
         * Aplicamos bordes de celdas a toda la informaci�n
         */
        $styleArray = $this->styleCelData();

        $hojaActiva->getStyle('A'.$c2.':Y'.$c)->applyFromArray($styleArray);
        /**
         * Aplicamos Formato de numeros
         */

        /**
         * Formato
         */
        $hojaActiva->getStyle('T'.$c2.':T'.$c)->getAlignment()->setWrapText(true);
        $hojaActiva->getStyle('D'.$c2.':E'.$c)->getAlignment()->setWrapText(true);

        $this->objExcel->getProperties()->setCreator($aux);
        $this->objExcel->getProperties()->setLastModifiedBy("");
        $this->objExcel->getProperties()->setTitle("Reporte Presas");
        $this->objExcel->getProperties()->setSubject("");
        $this->objExcel->getProperties()->setDescription($aux.$userprint["username"]." ".date("d/m/Y  H:i:s"));
        $this->objExcel->getProperties()->setCategory("");
        $this->objExcel->getProperties()->setKeywords($aux);
    }

    /**
     * Inicializamos un arreglo de columnas para crear nuestro Excel
     */
    function getCol(){
        $cols = array();

        for ($i=65;$i<=90;$i++) {
            $cols[] = chr($i);
        }
        for ($i=65;$i<=90;$i++) {
            $cols[] = "A".chr($i);
        }
        for ($i=65;$i<=90;$i++) {
            $cols[] = "B".chr($i);
        }        for ($i=65;$i<=90;$i++) {
            $cols[] = "C".chr($i);
        }        for ($i=65;$i<=90;$i++) {
            $cols[] = "D".chr($i);
        }        for ($i=65;$i<=90;$i++) {
            $cols[] = "E".chr($i);
        }        for ($i=65;$i<=90;$i++) {
            $cols[] = "F".chr($i);
        }        for ($i=65;$i<=90;$i++) {
            $cols[] = "G".chr($i);
        }        for ($i=65;$i<=90;$i++) {
            $cols[] = "H".chr($i);
        }        for ($i=65;$i<=90;$i++) {
            $cols[] = "I".chr($i);
        }        for ($i=65;$i<=90;$i++) {
            $cols[] = "J".chr($i);
        }        for ($i=65;$i<=90;$i++) {
            $cols[] = "K".chr($i);
        }        for ($i=65;$i<=90;$i++) {
            $cols[] = "L".chr($i);
        }        for ($i=65;$i<=90;$i++) {
            $cols[] = "M".chr($i);
        }        for ($i=65;$i<=90;$i++) {
            $cols[] = "N".chr($i);
        }       for ($i=65;$i<=90;$i++) {
            $cols[] = "O".chr($i);
        }        for ($i=65;$i<=90;$i++) {
            $cols[] = "P".chr($i);
        }        for ($i=65;$i<=90;$i++) {
            $cols[] = "Q".chr($i);
        }        for ($i=65;$i<=90;$i++) {
            $cols[] = "R".chr($i);
        }
        return $cols;
    }

    function styleCelData(){
        $styleArray = array(
           'borders' => array(
              'allborders' => array(
                 'style' => PHPExcel_Style_Border::BORDER_THIN,
                 'color' => array('argb' => '141414'),
              ),
           ),
           'alignment' => array(
                'vertical' => PHPExcel_Style_Alignment::VERTICAL_TOP,
            ),
        );
        return $styleArray;
    }

    
}