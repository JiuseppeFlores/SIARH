<?php
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

class Snippet extends Table {
    
    var $item_form;
    
    function __construct() {
        /**
         * Inicializamos todas las librerias y variables para el submodulo
         */
        $this->submodule_init_sbm();
    }

    /*function get_acuifero_datos_calidad($acuiferoId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.itemId, a.codigo, a.nombre, UPPER(f.nombre) AS acuifero, 
        d.itemId AS parametroId, d.nombre AS parametro, 
        e.itemId AS compuestoId, e.nombre AS compuesto, c.valor  
        FROM item a, 
        item_pozo_monitor_calidad b, 
        item_pozo_monitor_calidad_dato c, 
        catalogo_pozo_monitor_calidad_parametro d, 
        catalogo_pozo_monitor_calidad_compuesto e, 
        catalogo_acuifero f 
        WHERE a.itemId=b.pozoId 
        AND b.itemId=c.calidadId 
        AND c.parametroId=d.itemId 
        AND c.compuestoId=e.itemId 
        AND a.acuiferoId=f.itemId 
        AND a.tipo=1 
        AND a.acuiferoId=".$acuiferoId." 
        GROUP BY a.itemId, c.compuestoId 
        ORDER BY a.itemId, c.compuestoId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }*/

    function get_acuifero_datos_calidad_campania($acuiferoId, $mes, $anio) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.itemId, a.codigo, a.nombre, UPPER(f.nombre) AS acuifero, 
        d.itemId AS parametroId, d.nombre AS parametro, 
        e.itemId AS compuestoId, e.nombre AS compuesto, c.valor 
        FROM item a, 
        item_pozo_monitor_calidad b, 
        item_pozo_monitor_calidad_dato c, 
        catalogo_pozo_monitor_calidad_parametro d, 
        catalogo_pozo_monitor_calidad_compuesto e, 
        catalogo_acuifero f 
        WHERE a.itemId=b.pozoId 
        AND b.itemId=c.calidadId 
        AND c.parametroId=d.itemId 
        AND c.compuestoId=e.itemId 
        AND a.acuiferoId=f.itemId 
        AND a.tipo=1 
        AND a.acuiferoId=".$acuiferoId." 
        AND DATE_FORMAT(b.fecha_muestreo, '%m')=".$mes." 
        AND DATE_FORMAT(b.fecha_muestreo, '%Y')=".$anio."  
        ORDER BY a.itemId, c.compuestoId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_epsa_datos_calidad($epsaId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.itemId, a.codigo, a.nombre, UPPER(f.nombre) AS epsa, 
        d.itemId AS parametroId, d.nombre AS parametro, 
        e.itemId AS compuestoId, e.nombre AS compuesto, c.valor 
        FROM item a, 
        item_pozo_monitor_calidad b, 
        item_pozo_monitor_calidad_dato c, 
        catalogo_pozo_monitor_calidad_parametro d, 
        catalogo_pozo_monitor_calidad_compuesto e, 
        catalogo_pozo_general_epsas f 
        WHERE a.itemId=b.pozoId 
        AND b.itemId=c.calidadId 
        AND c.parametroId=d.itemId 
        AND c.compuestoId=e.itemId 
        AND a.epsasId=f.itemId 
        AND a.tipo=1 
        AND a.epsasId=".$epsaId." 
        GROUP BY a.itemId, c.compuestoId 
        ORDER BY a.itemId, c.compuestoId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function crear_documento_excel($metadatos) {
        //Creación de documento y metadatos
        $documentoHojaCalculo = new Spreadsheet();
        $documentoHojaCalculo->getProperties()
        ->setCreator('Sistemas - MMAyA')
        ->setLastModifiedBy('Sistemas - MMAyA')
        ->setTitle($metadatos['titulo'])
        ->setSubject($metadatos['asunto'])
        ->setDescription($metadatos['descripcion'])
        ->setKeywords($metadatos['palabras_clave'])
        ->setCategory($metadatos['categoria']);

        return $documentoHojaCalculo;
    }

    function descargar_documento_excel($documentoHojaCalculo, $nombreArchivo) {
        //Escritura de archivo
        $writer = new Xlsx($documentoHojaCalculo);

        //Envia archivo para descarga
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="'.$nombreArchivo.'.xlsx"');
        header('Cache-Control: max-age=0');
        header('Expires: Fri, 11 Nov 2011 11:11:11 GMT');
        header('Last-Modified: '.gmdate('D, d M Y H:i:s').' GMT');
        header('Cache-Control: cache, must-revalidate');
        header('Pragma: public');
        $writer->save('php://output');
    }

    function get_acuifero_datos_pozos_excel($metadatos, $tituloDocumento, $nombreArchivo, $acuiferoId, $mes, $anio) {
        // Consulta en la base de datos para obtener datos de pozos
        $resultado = $this->get_acuifero_datos_calidad_campania($acuiferoId, $mes, $anio);

        if (empty($resultado)) {
            echo "<center><b><font color='red' face='arial'>No existen datos de calidad.</font></b></center>";
            exit();
        }

        $etiquetasCalidad = array();
        $datosCalidad = array();
        foreach ($resultado as $clave => $valor) {
           $datosCalidad[$valor['itemId']][$valor['compuestoId']] = array(
                'nombre_pozo' => $valor['nombre'],
                'compuestoId' => $valor['compuestoId'],
                'valor' => $valor['valor'],
                'clase' => $this->get_rango_calidad($valor['compuestoId'], $valor['valor'])
            );
            $etiquetasCalidad[$valor['compuestoId']] = $valor['compuesto'];
        }
        $cantidadColumnas = count($etiquetasCalidad) + 2;
        $columnas = $this->get_generar_columnas($cantidadColumnas);
        $etiquetasColumnaNombre = array();
        $etiquetasColumnaDato = array();
        $contador = 2;
        foreach ($etiquetasCalidad as $clave => $valor) {
            $etiquetasColumnaNombre[$contador] = $etiquetasCalidad[$clave];
            $etiquetasColumnaDatos[$clave] = $columnas[$contador];
            $contador++;
        }

        //Creación de documento excel
        $documentoHojaCalculo = $this->crear_documento_excel($metadatos);

        // Procesa datos en documento excel
        $hoja = $documentoHojaCalculo->getActiveSheet();
        $documentoHojaCalculo->getActiveSheet()->mergeCells('A1:'.$columnas[$cantidadColumnas-1].'1');

        //Define cabeceras de columna
        $tituloDocumento = $tituloDocumento.' - '.$resultado[0]['acuifero'].' - CAMPAÑA '.$mes.'/'.$anio;
        $hoja->setTitle('REPORTE CALIDAD RMCH');
        $hoja->setCellValue('A1', $tituloDocumento);
        $hoja->getStyle('A1')->getAlignment()->setHorizontal('left');
        $hoja->setCellValue('A2', 'N°');
        $hoja->getStyle('A2')->getAlignment()->setHorizontal('center');
        $hoja->setCellValue('B2', 'Pozo');
        $hoja->getStyle('B2')->getAlignment()->setHorizontal('center');
        $limiteColumnas = count($columnas);
        for ($i=2; $i < $limiteColumnas; $i++) { 
            $hoja->setCellValue($columnas[$i].'2', $etiquetasColumnaNombre[$i]);
            $hoja->getStyle($columnas[$i].'2')->getAlignment()->setHorizontal('center');
        }

        //Asigna datos de la consulta a la base de datos
        $limiteFilas = count($datosCalidad);
        $contador = 3;
        $correlativo = 1;
        foreach ($datosCalidad as $clave => $valor) {
            foreach ($valor as $claveAux => $valorAux) {
                $hoja->setCellValue('A'.$contador, $correlativo);
                $hoja->getStyle('A'.$contador)->getAlignment()->setHorizontal('center');
                $hoja->setCellValue('B'.$contador, $valorAux['nombre_pozo']);
                $hoja->getStyle('B'.$contador)->getAlignment()->setHorizontal('left');
                $hoja->setCellValue($etiquetasColumnaDatos[$valorAux['compuestoId']].$contador, $valorAux['valor']);
                $hoja->getStyle($etiquetasColumnaDatos[$valorAux['compuestoId']].$contador)->getAlignment()->setHorizontal('center');
                if ($valorAux['valor'] != NULL && $valorAux['valor'] != '') {
                    $hoja->getStyle($etiquetasColumnaDatos[$valorAux['compuestoId']].$contador)->getFill()->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)->getStartColor()->setARGB($valorAux['clase']);
                }
            }
            $contador++;
            $correlativo++;
        }

        $clasificacion = $this->get_colores_calidad();
        $contador++;
        $documentoHojaCalculo->getActiveSheet()->mergeCells('A'.$contador.':'.'B'.$contador);
        $hoja->setCellValue('A'.$contador, 'CLASIFICACIÓN');
        $hoja->getStyle('A'.$contador)->getAlignment()->setHorizontal('center');
        $contador++;
        $documentoHojaCalculo->getActiveSheet()->mergeCells('A'.$contador.':'.'B'.$contador);
        $hoja->setCellValue('A'.$contador, 'CLASE A');
        $hoja->getStyle('A'.$contador)->getAlignment()->setHorizontal('center');
        $hoja->getStyle('A'.$contador)->getFill()->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)->getStartColor()->setARGB($clasificacion['clase-a']);
        $contador++;
        $documentoHojaCalculo->getActiveSheet()->mergeCells('A'.$contador.':'.'B'.$contador);
        $hoja->setCellValue('A'.$contador, 'CLASE B');
        $hoja->getStyle('A'.$contador)->getAlignment()->setHorizontal('center');
        $hoja->getStyle('A'.$contador)->getFill()->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)->getStartColor()->setARGB($clasificacion['clase-b']);
        $contador++;
        $documentoHojaCalculo->getActiveSheet()->mergeCells('A'.$contador.':'.'B'.$contador);
        $hoja->setCellValue('A'.$contador, 'CLASE C');
        $hoja->getStyle('A'.$contador)->getAlignment()->setHorizontal('center');
        $hoja->getStyle('A'.$contador)->getFill()->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)->getStartColor()->setARGB($clasificacion['clase-c']);
        $contador++;
        $documentoHojaCalculo->getActiveSheet()->mergeCells('A'.$contador.':'.'B'.$contador);
        $hoja->setCellValue('A'.$contador, 'CLASE D');
        $hoja->getStyle('A'.$contador)->getAlignment()->setHorizontal('center');
        $hoja->getStyle('A'.$contador)->getFill()->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)->getStartColor()->setARGB($clasificacion['clase-d']);
        $contador++;
        $documentoHojaCalculo->getActiveSheet()->mergeCells('A'.$contador.':'.'B'.$contador);
        $hoja->setCellValue('A'.$contador, 'CLASE CRÍTICA');
        $hoja->getStyle('A'.$contador)->getAlignment()->setHorizontal('center');
        $hoja->getStyle('A'.$contador)->getFill()->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)->getStartColor()->setARGB($clasificacion['clase-critica']);

        unset($resultado);
        unset($etiquetasCalidad);
        unset($datosCalidad);
        unset($columnas);
        unset($etiquetasColumnaNombre);
        unset($etiquetasColumnaDatos);

        //Descarga de archivo excel
        $this->descargar_documento_excel($documentoHojaCalculo, $nombreArchivo);
    }

    function get_epsa_datos_pozos_excel($metadatos, $tituloDocumento, $nombreArchivo, $epsaId) {
        // Consulta en la base de datos para obtener datos de pozos
        $resultado = $this->get_epsa_datos_calidad($epsaId);

        if (empty($resultado)) {
            echo "<center><b><font color='red' face='arial'>No existen datos de calidad.</font></b></center>";
            exit();
        }

        $etiquetasCalidad = array();
        $datosCalidad = array();
        foreach ($resultado as $clave => $valor) {
           $datosCalidad[$valor['itemId']][$valor['compuestoId']] = array(
                'nombre_pozo' => $valor['nombre'],
                'compuestoId' => $valor['compuestoId'],
                'valor' => $valor['valor'],
                'clase' => $this->get_rango_calidad($valor['compuestoId'], $valor['valor'])
            );
            $etiquetasCalidad[$valor['compuestoId']] = $valor['compuesto'];
        }
        $cantidadColumnas = count($etiquetasCalidad) + 2;
        $columnas = $this->get_generar_columnas($cantidadColumnas);
        $etiquetasColumnaNombre = array();
        $etiquetasColumnaDato = array();
        $contador = 2;
        foreach ($etiquetasCalidad as $clave => $valor) {
            $etiquetasColumnaNombre[$contador] = $etiquetasCalidad[$clave];
            $etiquetasColumnaDatos[$clave] = $columnas[$contador];
            $contador++;
        }

        //Creación de documento excel
        $documentoHojaCalculo = $this->crear_documento_excel($metadatos);

        // Procesa datos en documento excel
        $hoja = $documentoHojaCalculo->getActiveSheet();
        $documentoHojaCalculo->getActiveSheet()->mergeCells('A1:'.$columnas[$cantidadColumnas-1].'1');

        //Define cabeceras de columna
        $hoja->setTitle('REPORTE CALIDAD RMCH');
        $hoja->setCellValue('A1', $tituloDocumento.' - '.$resultado[0]['epsa']);
        $hoja->getStyle('A1')->getAlignment()->setHorizontal('center');
        $hoja->setCellValue('A2', 'N°');
        $hoja->getStyle('A2')->getAlignment()->setHorizontal('center');
        // $hoja->getStyle('A2')->getBorders()->getTop()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
        // $hoja->getStyle('A2')->getBorders()->getBottom()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
        // $hoja->getStyle('A2')->getBorders()->getLeft()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
        // $hoja->getStyle('A2')->getBorders()->getRight()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
        // $hoja->getStyle('A2')->getFill()->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)->getStartColor()->setARGB('ffe3e3e3'); 
        $hoja->setCellValue('B2', 'Pozo');
        $hoja->getStyle('B2')->getAlignment()->setHorizontal('center');
        // $hoja->getStyle('B2')->getBorders()->getTop()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
        // $hoja->getStyle('B2')->getBorders()->getBottom()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
        // $hoja->getStyle('B2')->getBorders()->getLeft()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
        // $hoja->getStyle('B2')->getBorders()->getRight()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
        // $hoja->getStyle('B2')->getFill()->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)->getStartColor()->setARGB('ffe3e3e3');
        $limiteColumnas = count($columnas);
        for ($i=2; $i < $limiteColumnas; $i++) { 
            $hoja->setCellValue($columnas[$i].'2', $etiquetasColumnaNombre[$i]);
            $hoja->getStyle($columnas[$i].'2')->getAlignment()->setHorizontal('center');
            // $hoja->getStyle($columnas[$i].'2')->getBorders()->getTop()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
            // $hoja->getStyle($columnas[$i].'2')->getBorders()->getBottom()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
            // $hoja->getStyle($columnas[$i].'2')->getBorders()->getLeft()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
            // $hoja->getStyle($columnas[$i].'2')->getBorders()->getRight()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
            // $hoja->getStyle($columnas[$i].'2')->getFill()->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)->getStartColor()->setARGB('ffe3e3e3');
        }

        //Asigna datos de la consulta a la base de datos
        $limiteFilas = count($datosCalidad);
        $contador = 3;
        $correlativo = 1;
        foreach ($datosCalidad as $clave => $valor) {
            foreach ($valor as $claveAux => $valorAux) {
                $hoja->setCellValue('A'.$contador, $correlativo);
                $hoja->getStyle('A'.$contador)->getAlignment()->setHorizontal('center');
                // $hoja->getStyle('A'.$contador)->getBorders()->getTop()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
                // $hoja->getStyle('A'.$contador)->getBorders()->getBottom()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
                // $hoja->getStyle('A'.$contador)->getBorders()->getLeft()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
                // $hoja->getStyle('A'.$contador)->getBorders()->getRight()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
                $hoja->setCellValue('B'.$contador, $valorAux['nombre_pozo']);
                $hoja->getStyle('B'.$contador)->getAlignment()->setHorizontal('left');
                // $hoja->getStyle('B'.$contador)->getBorders()->getTop()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
                // $hoja->getStyle('B'.$contador)->getBorders()->getBottom()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
                // $hoja->getStyle('B'.$contador)->getBorders()->getLeft()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
                // $hoja->getStyle('B'.$contador)->getBorders()->getRight()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
                $hoja->setCellValue($etiquetasColumnaDatos[$valorAux['compuestoId']].$contador, $valorAux['valor']);
                $hoja->getStyle($etiquetasColumnaDatos[$valorAux['compuestoId']].$contador)->getAlignment()->setHorizontal('center');
                // $hoja->getStyle($etiquetasColumnaDatos[$valorAux['compuestoId']].$contador)->getBorders()->getTop()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
                // $hoja->getStyle($etiquetasColumnaDatos[$valorAux['compuestoId']].$contador)->getBorders()->getBottom()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
                // $hoja->getStyle($etiquetasColumnaDatos[$valorAux['compuestoId']].$contador)->getBorders()->getLeft()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
                // $hoja->getStyle($etiquetasColumnaDatos[$valorAux['compuestoId']].$contador)->getBorders()->getRight()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
                if ($valorAux['valor'] != NULL && $valorAux['valor'] != '') {
                    $hoja->getStyle($etiquetasColumnaDatos[$valorAux['compuestoId']].$contador)->getFill()->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)->getStartColor()->setARGB($valorAux['clase']); 
                }
            }
            $contador++;
            $correlativo++;
        }

        $clasificacion = $this->get_colores_calidad();
        $contador++;
        $documentoHojaCalculo->getActiveSheet()->mergeCells('A'.$contador.':'.'B'.$contador);
        $hoja->setCellValue('A'.$contador, 'CLASIFICACIÓN');
        $hoja->getStyle('A'.$contador)->getAlignment()->setHorizontal('center');
        $contador++;
        $documentoHojaCalculo->getActiveSheet()->mergeCells('A'.$contador.':'.'B'.$contador);
        $hoja->setCellValue('A'.$contador, 'CLASE A');
        $hoja->getStyle('A'.$contador)->getAlignment()->setHorizontal('center');
        $hoja->getStyle('A'.$contador)->getFill()->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)->getStartColor()->setARGB($clasificacion['clase-a']);
        $contador++;
        $documentoHojaCalculo->getActiveSheet()->mergeCells('A'.$contador.':'.'B'.$contador);
        $hoja->setCellValue('A'.$contador, 'CLASE B');
        $hoja->getStyle('A'.$contador)->getAlignment()->setHorizontal('center');
        $hoja->getStyle('A'.$contador)->getFill()->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)->getStartColor()->setARGB($clasificacion['clase-b']);
        $contador++;
        $documentoHojaCalculo->getActiveSheet()->mergeCells('A'.$contador.':'.'B'.$contador);
        $hoja->setCellValue('A'.$contador, 'CLASE C');
        $hoja->getStyle('A'.$contador)->getAlignment()->setHorizontal('center');
        $hoja->getStyle('A'.$contador)->getFill()->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)->getStartColor()->setARGB($clasificacion['clase-c']);
        $contador++;
        $documentoHojaCalculo->getActiveSheet()->mergeCells('A'.$contador.':'.'B'.$contador);
        $hoja->setCellValue('A'.$contador, 'CLASE D');
        $hoja->getStyle('A'.$contador)->getAlignment()->setHorizontal('center');
        $hoja->getStyle('A'.$contador)->getFill()->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)->getStartColor()->setARGB($clasificacion['clase-d']);
        $contador++;
        $documentoHojaCalculo->getActiveSheet()->mergeCells('A'.$contador.':'.'B'.$contador);
        $hoja->setCellValue('A'.$contador, 'CLASE CRÍTICA');
        $hoja->getStyle('A'.$contador)->getAlignment()->setHorizontal('center');
        $hoja->getStyle('A'.$contador)->getFill()->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)->getStartColor()->setARGB($clasificacion['clase-critica']);

        unset($resultado);
        unset($etiquetasCalidad);
        unset($datosCalidad);
        unset($columnas);
        unset($etiquetasColumnaNombre);
        unset($etiquetasColumnaDatos);

        //Descarga de archivo excel
        $this->descargar_documento_excel($documentoHojaCalculo, $nombreArchivo);
    }

    function get_colores_calidad() {
        return array(
            'clase-a' => 'FFBBDFF7',
            'clase-b' => 'FF8AFF8A',
            'clase-c' => 'FFFFFF70',
            'clase-d' => 'FFEC8FFF',
            'clase-critica' => 'FFFF7070',
            'clase-defecto' => '00FFFFFF'
        );
    }

    function get_rango_calidad($compuestoId, $valor) {
        $clasificacion = $this->get_colores_calidad();
        if ($valor == NULL || $valor == '') {
            return $clasificacion['clase-defecto'];
        }
        $valor = $valor;
        switch ($compuestoId) {
            //PARÁMETROS BÁSICOS
            //Conductividad eléctrica
            case 4:
                if ($valor>=0 && $valor<=140) { return $clasificacion['clase-a']; } 
                elseif ($valor>140 && $valor<=300) { return $clasificacion['clase-b']; } 
                elseif ($valor>300 && $valor<=500) { return $clasificacion['clase-c']; } 
                elseif ($valor>500 && $valor<=1600) { return $clasificacion['clase-d']; } 
                elseif ($valor>1600) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Oxígeno disuelto
            case 7:
                if ($valor>80) { return $clasificacion['clase-a']; } 
                elseif ($valor>=70 && $valor<=80) { return $clasificacion['clase-b']; } 
                elseif ($valor>=60 && $valor<70) { return $clasificacion['clase-c']; } 
                elseif ($valor>=50 && $valor<60) { return $clasificacion['clase-d']; } 
                elseif ($valor<50) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //pH
            case 8:
                if ($valor>=6 && $valor<=8.5) { return $clasificacion['clase-a']; } 
                elseif ($valor>8.5 && $valor<=9) { return $clasificacion['clase-b']; } 
                elseif ($valor<6 || $valor>9) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Sólidos disueltos
            case 27:
                if ($valor>=0 && $valor<=1000) { return $clasificacion['clase-a']; } 
                elseif ($valor>1000 && $valor<=1500) { return $clasificacion['clase-c']; } 
                elseif ($valor>1500) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Sólidos sedimentales
            case 30:
                if ($valor>=0 && $valor<10) { return $clasificacion['clase-a']; } 
                elseif ($valor>=10 && $valor<30) { return $clasificacion['clase-b']; } 
                elseif ($valor>=30 && $valor<50) { return $clasificacion['clase-c']; } 
                elseif ($valor>=50 && $valor<100) { return $clasificacion['clase-d']; } 
                elseif ($valor>=100) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Sólios en suspensión
            case 28:
                if ($valor>=0 && $valor<=1) { return $clasificacion['clase-a']; } 
                elseif ($valor>1 && $valor<=10) { return $clasificacion['clase-b']; } 
                elseif ($valor>10 && $valor<=100) { return $clasificacion['clase-c']; } 
                elseif ($valor>100 && $valor<=200) { return $clasificacion['clase-d']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Temperatura
            case 11:
                if ($valor<=-3 && $valor<=3) { return $clasificacion['clase-a']; } 
                elseif ($valor<=-3 && $valor<=3) { return $clasificacion['clase-b']; } 
                elseif ($valor<=-3 && $valor<=3) { return $clasificacion['clase-c']; } 
                elseif ($valor<=-3 && $valor<=3) { return $clasificacion['clase-d']; } 
                elseif ($valor>-3 || $valor>3) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Turbidez
            case 34:
                if ($valor>=0 && $valor<10) { return $clasificacion['clase-a']; } 
                elseif ($valor>=10 && $valor<50) { return $clasificacion['clase-b']; } 
                elseif ($valor>=50 && $valor<100) { return $clasificacion['clase-c']; } 
                elseif ($valor>=100 && $valor<200) { return $clasificacion['clase-d']; } 
                elseif ($valor>=200) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Color
            case 19:
                if ($valor>=0 && $valor<10) { return $clasificacion['clase-a']; } 
                elseif ($valor>=10 && $valor<50) { return $clasificacion['clase-b']; } 
                elseif ($valor>=50 && $valor<100) { return $clasificacion['clase-c']; } 
                elseif ($valor>=100 && $valor<200) { return $clasificacion['clase-d']; } 
                elseif ($valor>=200) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //CONSTITUYENTES INORGÁNICOS METÁLICOS 
            //Aluminio
            case 35:
                if ($valor>=0 && $valor<=0.2) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.2 && $valor<=0.5) { return $clasificacion['clase-b']; } 
                elseif ($valor>0.5 && $valor<=1) { return $clasificacion['clase-c']; } 
                elseif ($valor>1) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Antimonio
            case 39:
                if ($valor>=0 && $valor<=0.01) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.01) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Arsénico
            case 41:
                if ($valor>=0 && $valor<=0.2) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.2 && $valor<=0.5) { return $clasificacion['clase-b']; } 
                elseif ($valor>0.5 && $valor<=1) { return $clasificacion['clase-c']; } 
                elseif ($valor>1) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Bario
            case 44:
                if ($valor>=0 && $valor<=1) { return $clasificacion['clase-a']; } 
                elseif ($valor>1 && $valor<=2) { return $clasificacion['clase-c']; } 
                elseif ($valor>2 && $valor<=5) { return $clasificacion['clase-d']; } 
                elseif ($valor>5) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Berilio
            case 46:
                if ($valor>=0 && $valor<=0.001) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.001 && $valor) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Boro
            case 48:
                if ($valor>=0 && $valor<=1) { return $clasificacion['clase-a']; } 
                elseif ($valor>1) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Calcio
            case 54:
                if ($valor>=0 && $valor<=200) { return $clasificacion['clase-a']; } 
                elseif ($valor>200 && $valor<=300) { return $clasificacion['clase-b']; } 
                elseif ($valor>300 && $valor<=400) { return $clasificacion['clase-d']; } 
                elseif ($valor>400) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Cadmio
            case 52:
                if ($valor>=0 && $valor<=0.005) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.005) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Cobre
            case 61:
                if ($valor>=0 && $valor<=0.05) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.05 && $valor<=1) { return $clasificacion['clase-b']; } 
                elseif ($valor>1) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Cobalto
            case 60:
                if ($valor>=0 && $valor<=0.1) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.1 && $valor<=0.2) { return $clasificacion['clase-b']; } 
                elseif ($valor>0.2) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Cromo hexavalente
            case 65:
                if ($valor>=0 && $valor<=0.05) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.05) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Cromo trivalente
            case 66:
                if ($valor>=0 && $valor<=0.12) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.12 && $valor<=0.6) { return $clasificacion['clase-b']; } 
                elseif ($valor>0.6 && $valor<=1.1) { return $clasificacion['clase-d']; } 
                elseif ($valor>1.1) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Estaño
            case 67:
                if ($valor>=0 && $valor<=2) { return $clasificacion['clase-a']; }  
                elseif ($valor>2) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Hierro soluble
            case 73:
                if ($valor>=0 && $valor<=0.3) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.3 && $valor<=1) { return $clasificacion['clase-c']; } 
                elseif ($valor>1) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Litio
            case 74:
                if ($valor>=0 && $valor<=2.5) { return $clasificacion['clase-a']; } 
                elseif ($valor>2.5 && $valor<=5) { return $clasificacion['clase-d']; } 
                elseif ($valor>5) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Magnesio
            case 75:
                if ($valor>=0 && $valor<=100) { return $clasificacion['clase-a']; } 
                elseif ($valor>100 && $valor<=150) { return $clasificacion['clase-c']; } 
                elseif ($valor>150) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Manganeso
            case 76:
                if ($valor>=0 && $valor<=0.5) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.5 && $valor<=1) { return $clasificacion['clase-b']; } 
                elseif ($valor>1) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Mercurio
            case 78:
                if ($valor>=0 && $valor<=0.001) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.001) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Niquel
            case 81:
                if ($valor>=0 && $valor<=0.05) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.05 && $valor<=0.5) { return $clasificacion['clase-c']; } 
                elseif ($valor>0.5) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Plata
            case 87:
                if ($valor>=0 && $valor<=0.05) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.05) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Plomo
            case 88:
                if ($valor>=0 && $valor<=0.05) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.05 && $valor<=0.1) { return $clasificacion['clase-d']; } 
                elseif ($valor>0.1) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Selenio
            case 91:
                if ($valor>=0 && $valor<=0.01) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.01 && $valor<=0.05) { return $clasificacion['clase-d']; } 
                elseif ($valor>0.05) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Sodio
            case 93:
                if ($valor>=0 && $valor<=200) { return $clasificacion['clase-a']; } 
                elseif ($valor>200) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Uranio total
            case 96:
                if ($valor>=0 && $valor<=0.02) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.02) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Vanadio
            case 97:
                if ($valor>=0 && $valor<=0.1) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.1) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Zinc
            case 99:
                if ($valor>=0 && $valor<=0.2) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.2 && $valor<=5) { return $clasificacion['clase-c']; } 
                elseif ($valor>5) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //CONSTITUYENTES INORGÁNICOS NO METÁLICOS
            //Amoniaco
            case 37:
                if ($valor>=0 && $valor<=0.05) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.05 && $valor<=1) { return $clasificacion['clase-b']; } 
                elseif ($valor>1 && $valor<=2) { return $clasificacion['clase-c']; } 
                elseif ($valor>2 && $valor<=4) { return $clasificacion['clase-d']; } 
                elseif ($valor>4) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Cianuro
            case 56:
                if ($valor>=0 && $valor<=0.02) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.02 && $valor<=0.1) { return $clasificacion['clase-b']; } 
                elseif ($valor>0.1 && $valor<=0.2) { return $clasificacion['clase-c']; } 
                elseif ($valor>0.2) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Cloruro
            case 59:
                if ($valor>=0 && $valor<=250) { return $clasificacion['clase-a']; } 
                elseif ($valor>250 && $valor<=300) { return $clasificacion['clase-b']; } 
                elseif ($valor>300 && $valor<=400) { return $clasificacion['clase-c']; } 
                elseif ($valor>400 && $valor<=500) { return $clasificacion['clase-d']; } 
                elseif ($valor>500) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Fluoruro
            case 70:
                if ($valor>=0 && $valor<=0.6) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.6 && $valor<=1.7) { return $clasificacion['clase-b']; } 
                elseif ($valor>1.7) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Fosfato
            case 71:
                if ($valor>=0 && $valor<=0.4) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.4 && $valor<=0.5) { return $clasificacion['clase-b']; } 
                elseif ($valor>0.5 && $valor<=1) { return $clasificacion['clase-c']; } 
                elseif ($valor>1) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Nitrato
            case 83:
                if ($valor>=0 && $valor<=20) { return $clasificacion['clase-a']; } 
                elseif ($valor>20 && $valor<=50) { return $clasificacion['clase-b']; } 
                elseif ($valor>50) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Nitrito
            case 84:
                if ($valor>=0 && $valor<1) { return $clasificacion['clase-a']; } 
                elseif ($valor==1) { return $clasificacion['clase-b']; } 
                elseif ($valor>1) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Nitrógeno
            case 85:
                if ($valor>=0 && $valor<=5) { return $clasificacion['clase-a']; } 
                elseif ($valor>5 && $valor<=12) { return $clasificacion['clase-b']; } 
                elseif ($valor>12) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Sulfato
            case 94:
                if ($valor>=0 && $valor<=300) { return $clasificacion['clase-a']; } 
                elseif ($valor>300 && $valor<=400) { return $clasificacion['clase-b']; } 
                elseif ($valor>400) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Sulfuro
            case 95:
                if ($valor>=0 && $valor<=0.1) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.1 && $valor<=0.5) { return $clasificacion['clase-c']; } 
                elseif ($valor>0.5 && $valor<=1) { return $clasificacion['clase-d']; } 
                elseif ($valor>1) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //CONSTITUYENTES ORGÁNICOS
            //Benceno
            case 108:
                if ($valor>=0 && $valor<=2) { return $clasificacion['clase-a']; } 
                elseif ($valor>2 && $valor<=6) { return $clasificacion['clase-b']; } 
                elseif ($valor>6 && $valor<=10) { return $clasificacion['clase-c']; } 
                elseif ($valor>10) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Dicloroetano
            case 103:
                if ($valor>=0 && $valor<=10) { return $clasificacion['clase-a']; } 
                elseif ($valor>10) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Dicloroetileno
            case 102:
                if ($valor>=0 && $valor<=0.3) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.3) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Fenol
            case 121:
                if ($valor>=0 && $valor<=1) { return $clasificacion['clase-a']; } 
                elseif ($valor>1 && $valor<=5) { return $clasificacion['clase-c']; } 
                elseif ($valor>5 && $valor<=10) { return $clasificacion['clase-d']; } 
                elseif ($valor>10) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Pentaclorofenol
            case 191:
                if ($valor>=0 && $valor<=5) { return $clasificacion['clase-a']; } 
                elseif ($valor>5 && $valor<=10) { return $clasificacion['clase-b']; } 
                elseif ($valor>10) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Tetracloroetano
            case 125:
                if ($valor>=0 && $valor<=10) { return $clasificacion['clase-a']; } 
                elseif ($valor>10) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Tricloroetano
            case 101:
                if ($valor>=0 && $valor<=30) { return $clasificacion['clase-a']; } 
                elseif ($valor>30) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Tetracloruro de carbono
            case 126:
                if ($valor>=0 && $valor<=3) { return $clasificacion['clase-a']; } 
                elseif ($valor>3) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Triclorofenol
            case 156:
                if ($valor>=0 && $valor<=10) { return $clasificacion['clase-a']; } 
                elseif ($valor>10) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //CONSTITUYENTES ORGÁNICOS AGREGADOS
            //DBO5
            case 20:
                if ($valor>=0 && $valor<2) { return $clasificacion['clase-a']; } 
                elseif ($valor>=2 && $valor<5) { return $clasificacion['clase-b']; } 
                elseif ($valor>=5 && $valor<20) { return $clasificacion['clase-c']; } 
                elseif ($valor>=20 && $valor<30) { return $clasificacion['clase-d']; } 
                elseif ($valor>=30) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //DQO
            case 21:
                if ($valor>=0 && $valor<5) { return $clasificacion['clase-a']; } 
                elseif ($valor>=5 && $valor<10) { return $clasificacion['clase-b']; } 
                elseif ($valor>=10 && $valor<40) { return $clasificacion['clase-c']; } 
                elseif ($valor>=40 && $valor<60) { return $clasificacion['clase-d']; } 
                elseif ($valor>=60) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //CONSTITUYENTES PLAGUICIDAS
            //Aldrin/Dieldrin
            case 161:
                if ($valor>=0 && $valor<=0.03) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.03) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Clordano
            case 167:
                if ($valor>=0 && $valor<=0.3) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.3) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //DDT
            case 170:
                if ($valor>=0 && $valor<=1) { return $clasificacion['clase-a']; } 
                elseif ($valor>1) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Endrin
            case 175:
                if ($valor>0) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Endosulfan
            case 174:
                if ($valor>=0 && $valor<=70) { return $clasificacion['clase-a']; } 
                elseif ($valor>70) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Heptacloro/Heptacloripoxido
            case 178:
                if ($valor>=0 && $valor<=0.1) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.1) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Lindano
            case 181:
                if ($valor>=0 && $valor<=3) { return $clasificacion['clase-a']; } 
                elseif ($valor>3) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Metoxicloro
            case 187:
                if ($valor>=0 && $valor<=30) { return $clasificacion['clase-a']; } 
                elseif ($valor>30) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Toxafeno
            case 200:
                if ($valor>=0 && $valor<=0.01) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.01 && $valor<=0.05) { return $clasificacion['clase-d']; } 
                elseif ($valor>0.05) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Demetón
            case 171:
                if ($valor>=0 && $valor<=0.1) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.1) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Gutión
            case 177:
                if ($valor>=0 && $valor<=0.01) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.01) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Malatión
            case 182:
                if ($valor>=0 && $valor<=0.04) { return $clasificacion['clase-a']; } 
                elseif ($valor>0.04) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Carbaril
            case 164:
                if ($valor==0) { return $clasificacion['clase-a']; } 
                elseif ($valor>0 && $valor<=0.02) { return $clasificacion['clase-b']; } 
                elseif ($valor>0.02) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //2,4-D; Diclorofenoxiacético
            case 157:
                if ($valor>=0 && $valor<=100) { return $clasificacion['clase-a']; } 
                elseif ($valor>100) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //2,4,5-TP; Ácido 2(2,4,5 triclorofenoxi) propiónico
            case 156:
                if ($valor>=0 && $valor<=10) { return $clasificacion['clase-a']; } 
                elseif ($valor>10) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //2,4,5 - T; Ácido 2,4,5 triclorofenoxiacético
            case 155:
                if ($valor>=0 && $valor<=2) { return $clasificacion['clase-a']; } 
                elseif ($valor>2) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //CONSTITUYENTES MICROBIOLÓGICOS
            //Colifecales
            case 135:
                if ($valor>=0 && $valor<5) { return $clasificacion['clase-a']; } 
                elseif ($valor>=5 && $valor<200) { return $clasificacion['clase-b']; } 
                elseif ($valor>=200 && $valor<1000) { return $clasificacion['clase-c']; } 
                elseif ($valor>=1000 && $valor<5000) { return $clasificacion['clase-d']; } 
                elseif ($valor>=5000) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;
            
            //Parásitos
            case 143:
                if ($valor>=0 && $valor<1) { return $clasificacion['clase-a']; } 
                elseif ($valor>=1) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;

            //Color por defecto
            default:
                return $clasificacion['clase-defecto'];
                break;

            //XXX
            /*case XXX:
                if ($valor>=XXX && $valor<=XXX) { return $clasificacion['clase-a']; } 
                elseif ($valor>XXX && $valor<=XXX) { return $clasificacion['clase-b']; } 
                elseif ($valor>XXX && $valor<=XXX) { return $clasificacion['clase-c']; } 
                elseif ($valor>XXX && $valor<=XXX) { return $clasificacion['clase-d']; } 
                elseif ($valor>XXX) { return $clasificacion['clase-critica']; } 
                else { return $clasificacion['clase-defecto']; }
                break;*/
        }
    }

    function get_generar_columnas($cantidadColumnas) {
        $columnasBase = array(
            1 => 'A', 2 => 'B', 3 => 'C', 4 => 'D', 5 => 'E',
            6 => 'F', 7 => 'G', 8 => 'H', 9 => 'I', 10 => 'J',
            11 => 'K', 12 => 'L', 13 => 'M', 14 => 'N', 15 => 'O',
            16 => 'P', 17 => 'Q', 18 => 'R', 19 => 'S', 20 => 'T',
            21 => 'U', 22 => 'V', 23 => 'W', 24=> 'X', 25 => 'Y',
            26 => 'Z'
        );
        $columnas = array();
        for ($i=1; $i <= 26; $i++) {
            $columnas[] = $columnasBase[$i];
        }
        if ($cantidadColumnas > 26) {
            $cantidadColumnas = $cantidadColumnas - 26;
            $contador = 1;
            for ($i=1; $i <= $cantidadColumnas; $i++) { 
                $columnas[] = $columnasBase[$contador].$columnasBase[$i];
                if ($i == 26) {
                    $contador++;
                    $cantidadColumnas = $cantidadColumnas - $i;
                    $i = 0;
                }
            }
        }
        return $columnas;
    }

}