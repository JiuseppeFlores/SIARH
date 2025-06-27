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

    function get_ficha($id) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT c.nombre AS epsa, 
        b.nombre AS fuente, 
        b.itemId AS fuente_id, 
        count(*) AS total 
        FROM item a, catalogo_tipo b, catalogo_pozo_general_epsas c  
        WHERE a.tipo=b.itemId 
        AND a.epsasId=c.itemId 
        AND a.tipo IN (1,3,4)
        AND a.epsasId=".(int) $id."
        GROUP BY a.tipo, a.epsasId 
        ORDER BY total DESC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_ficha_anio_perforacion($epsasId, $anio) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT c.nombre AS epsa, 
        b.nombre AS fuente, 
        b.itemId AS fuente_id, 
        count(*) AS total 
        FROM item a, catalogo_tipo b, catalogo_pozo_general_epsas c, item_pozo d
        WHERE a.tipo=b.itemId 
        AND a.epsasId=c.itemId 
        AND a.itemId=d.itemId 
        AND a.tipo=1 
        AND a.epsasId=".$epsasId."
        AND DATE_FORMAT(d.perforacion_fecha, '%Y')=".$anio."
        GROUP BY a.epsasId 
        ORDER BY total DESC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_ficha_profundidad_menor($epsasId, $valor) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT c.nombre AS epsa, 
        b.nombre AS fuente, 
        b.itemId AS fuente_id, 
        count(*) AS total 
        FROM item a, catalogo_tipo b, catalogo_pozo_general_epsas c, item_pozo d
        WHERE a.tipo=b.itemId 
        AND a.epsasId=c.itemId 
        AND a.itemId=d.itemId 
        AND a.tipo=1 
        AND d.perforacion_profundidad < ".$valor." 
        AND a.epsasId=".$epsasId."
        GROUP BY a.epsasId 
        ORDER BY total DESC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_ficha_profundidad_mayor($epsasId, $valor) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT c.nombre AS epsa, 
        b.nombre AS fuente, 
        b.itemId AS fuente_id, 
        count(*) AS total 
        FROM item a, catalogo_tipo b, catalogo_pozo_general_epsas c, item_pozo d
        WHERE a.tipo=b.itemId 
        AND a.epsasId=c.itemId 
        AND a.itemId=d.itemId 
        AND a.tipo=1 
        AND d.perforacion_profundidad > ".$valor." 
        AND a.epsasId=".$epsasId."
        GROUP BY a.epsasId 
        ORDER BY total DESC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_ficha_profundidad($epsasId, $desde, $hasta) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT c.nombre AS epsa, 
        b.nombre AS fuente, 
        b.itemId AS fuente_id, 
        count(*) AS total 
        FROM item a, catalogo_tipo b, catalogo_pozo_general_epsas c, item_pozo d
        WHERE a.tipo=b.itemId 
        AND a.epsasId=c.itemId 
        AND a.itemId=d.itemId 
        AND a.tipo=1 
        AND d.perforacion_profundidad >= ".$desde." 
        AND d.perforacion_profundidad <= ".$hasta." 
        AND a.epsasId=".$epsasId."
        GROUP BY a.epsasId 
        ORDER BY total DESC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_ficha_uso($epsasId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT t1.nombre, t2.epsa, t2.total
        FROM 
        (SELECT itemId, nombre AS nombre 
        FROM catalogo_pozo_usoagua) t1 
        LEFT JOIN 
        (SELECT c.nombre AS epsa, 
        e.itemId, 
        count(*) AS total 
        FROM item a, catalogo_tipo b, catalogo_pozo_general_epsas c, item_pozo d, catalogo_pozo_usoagua e 
        WHERE a.tipo=b.itemId 
        AND a.epsasId=c.itemId 
        AND a.itemId=d.itemId 
        AND a.tipo=1 
        AND a.epsasId=".$epsasId."
        AND FIND_IN_SET(e.itemId, d.usoaguaId) 
        GROUP BY a.epsasId) t2
        ON t1.itemId=t2.itemId 
        ORDER BY t2.total DESC, t1.nombre ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_ficha_proposito($epsasId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT t1.nombre, t2.epsa, t2.total
        FROM 
        (SELECT itemId, nombre AS nombre 
        FROM catalogo_pozo_proposito) t1 
        LEFT JOIN 
        (SELECT c.nombre AS epsa, 
        e.itemId, 
        count(*) AS total 
        FROM item a, catalogo_tipo b, catalogo_pozo_general_epsas c, item_pozo d, catalogo_pozo_proposito e 
        WHERE a.tipo=b.itemId 
        AND a.epsasId=c.itemId 
        AND a.itemId=d.itemId 
        AND a.tipo=1 
        AND a.epsasId=".$epsasId."
        AND FIND_IN_SET(e.itemId, d.propositoId) 
        GROUP BY a.epsasId) t2
        ON t1.itemId=t2.itemId 
        ORDER BY t2.total DESC, t1.nombre ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_puntos($tipo, $epsasId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.itemId, 
        a.codigo, 
        a.nombre, 
        a.tipo, 
        b.nombre AS tipoNombre, 
        a.longitudDec, 
        a.latitudDec 
        FROM item a, catalogo_tipo b
        WHERE a.tipo=b.itemId 
        AND (longitudDec BETWEEN -70 AND -55) 
        AND (latitudDec BETWEEN -24 AND -8) 
        AND a.tipo=".$tipo." 
        AND epsasId=".$epsasId."
        ORDER BY a.itemId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_puntos_anio_perforacion($epsasId, $anio) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
         $sql = "SELECT a.itemId, 
        a.codigo, 
        a.nombre, 
        a.tipo, 
        b.nombre AS tipoNombre, 
        a.longitudDec, 
        a.latitudDec 
        FROM item a, catalogo_tipo b, item_pozo c
        WHERE a.tipo=b.itemId 
        AND a.itemId=c.itemId 
        AND (a.longitudDec BETWEEN -70 AND -55) 
        AND (a.latitudDec BETWEEN -24 AND -8) 
        AND a.tipo=1 
        AND epsasId=".$epsasId." 
        AND DATE_FORMAT(c.perforacion_fecha, '%Y')=".$anio."
        ORDER BY a.itemId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_puntos_profundidad_menor($epsasId, $valor) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
         $sql = "SELECT a.itemId, 
        a.codigo, 
        a.nombre, 
        a.tipo, 
        b.nombre AS tipoNombre, 
        a.longitudDec, 
        a.latitudDec 
        FROM item a, catalogo_tipo b, item_pozo c
        WHERE a.tipo=b.itemId 
        AND a.itemId=c.itemId 
        AND (a.longitudDec BETWEEN -70 AND -55) 
        AND (a.latitudDec BETWEEN -24 AND -8) 
        AND a.tipo=1 
        AND c.perforacion_profundidad < ".$valor." 
        AND a.epsasId=".$epsasId." 
        ORDER BY a.itemId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_puntos_profundidad_mayor($epsasId, $valor) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
         $sql = "SELECT a.itemId, 
        a.codigo, 
        a.nombre, 
        a.tipo, 
        b.nombre AS tipoNombre, 
        a.longitudDec, 
        a.latitudDec 
        FROM item a, catalogo_tipo b, item_pozo c
        WHERE a.tipo=b.itemId 
        AND a.itemId=c.itemId 
        AND (a.longitudDec BETWEEN -70 AND -55) 
        AND (a.latitudDec BETWEEN -24 AND -8) 
        AND a.tipo=1 
        AND c.perforacion_profundidad > ".$valor." 
        AND a.epsasId=".$epsasId." 
        ORDER BY a.itemId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_puntos_profundidad($epsasId, $desde, $hasta) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
         $sql = "SELECT a.itemId, 
        a.codigo, 
        a.nombre, 
        a.tipo, 
        b.nombre AS tipoNombre, 
        a.longitudDec, 
        a.latitudDec 
        FROM item a, catalogo_tipo b, item_pozo c
        WHERE a.tipo=b.itemId 
        AND a.itemId=c.itemId 
        AND (a.longitudDec BETWEEN -70 AND -55) 
        AND (a.latitudDec BETWEEN -24 AND -8) 
        AND a.tipo=1 
        AND c.perforacion_profundidad >= ".$desde." 
        AND c.perforacion_profundidad <= ".$hasta." 
        AND a.epsasId=".$epsasId." 
        ORDER BY a.itemId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_puntos_uso($epsasId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
         $sql = "SELECT a.itemId, 
        a.codigo, 
        a.nombre, 
        a.tipo, 
        b.nombre AS tipoNombre, 
        a.longitudDec, 
        a.latitudDec 
        FROM item a, catalogo_tipo b, item_pozo c, catalogo_pozo_usoagua d 
        WHERE a.tipo=b.itemId 
        AND a.itemId=c.itemId 
        AND (a.longitudDec BETWEEN -70 AND -55) 
        AND (a.latitudDec BETWEEN -24 AND -8) 
        AND a.tipo=1  
        AND a.epsasId=".$epsasId." 
        AND FIND_IN_SET(d.itemId, c.usoaguaId) 
        ORDER BY a.itemId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_puntos_proposito($epsasId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
         $sql = "SELECT a.itemId, 
        a.codigo, 
        a.nombre, 
        a.tipo, 
        b.nombre AS tipoNombre, 
        a.longitudDec, 
        a.latitudDec 
        FROM item a, catalogo_tipo b, item_pozo c, catalogo_pozo_proposito d 
        WHERE a.tipo=b.itemId 
        AND a.itemId=c.itemId 
        AND (a.longitudDec BETWEEN -70 AND -55) 
        AND (a.latitudDec BETWEEN -24 AND -8) 
        AND a.tipo=1  
        AND a.epsasId=".$epsasId." 
        AND FIND_IN_SET(d.itemId, c.propositoId) 
        ORDER BY a.itemId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_coordenada_min_max_epsa_pozos($epsasId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
         $sql = "SELECT MIN(longitudDec) AS longitudMin, 
        MIN(latitudDec) AS latitudMin, 
        MAX(longitudDec) AS longitudMax, 
        MAX(latitudDec) AS latitudMax 
        FROM item 
        WHERE (longitudDec BETWEEN -70 AND -55) 
        AND (latitudDec BETWEEN -24 AND -8) 
        AND tipo=1 
        AND epsasId=".$epsasId."
        LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_caudal_pozos($id) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT SUM(b.caudal) AS total_caudal 
        FROM item a, item_pozo_monitor b 
        WHERE a.itemId=b.pozoId 
        AND a.tipo=1
        AND a.epsasId=".(int) $id."
        GROUP BY a.tipo LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_caudal_manantiales($id) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT SUM(b.caudal) AS total_caudal 
        FROM item a, manantial_monitoreo b 
        WHERE a.itemId=b.manantialId 
        AND a.tipo=3
        AND a.epsasId=".(int) $id."
        GROUP BY a.tipo LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_coordenada_min_max($epsasId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
         $sql = "SELECT MIN(longitudDec) AS longitudMin, 
        MIN(latitudDec) AS latitudMin, 
        MAX(longitudDec) AS longitudMax, 
        MAX(latitudDec) AS latitudMax 
        FROM item 
        WHERE (longitudDec BETWEEN -70 AND -55) 
        AND (latitudDec BETWEEN -24 AND -8) 
        AND epsasId=".$epsasId."
        LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_compuestos($epsasId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT e.itemId, 
        e.nombre AS epsa, 
        d.itemId AS pozoId, 
        d.codigo, 
        d.nombre, 
        GROUP_CONCAT(a.itemId) AS compuestos, 
        GROUP_CONCAT(b.valor) AS valor
        FROM catalogo_pozo_monitor_calidad_compuesto a, 
        item_pozo_monitor_calidad_dato b, 
        item_pozo_monitor_calidad c,
        item d,
        catalogo_pozo_general_epsas e
        WHERE a.itemId=b.compuestoId AND 
        b.calidadId=c.itemId AND
        c.pozoId=d.itemId AND 
        d.epsasId=e.itemId AND
        b.compuestoId in (54,75,90,93,59,47,94) AND
        e.itemId=".$epsasId."
        GROUP BY b.calidadId
        ORDER BY c.pozoId, b.calidadId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_caudal_caudalautorizado($epsasId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.nombre, b.nombre, 
        GROUP_CONCAT(c.fecha ORDER BY c.fecha) AS fechas,
        GROUP_CONCAT(c.caudal ORDER BY c.fecha) AS caudales,
        GROUP_CONCAT(c.caudalautorizado ORDER BY c.fecha) AS caudalautorizados 
        FROM catalogo_pozo_general_epsas a, item b, item_pozo_monitor c 
        WHERE a.itemId=b.epsasId AND b.itemId=c.pozoId AND a.itemId=".$epsasId."
        GROUP BY c.pozoId
        ORDER BY c.pozoId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }    

    function get_campanias($epsasId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT DATE_FORMAT(fecha_muestreo, '%m') AS mes, DATE_FORMAT(fecha_muestreo, '%Y') AS anio 
        FROM item a INNER JOIN item_pozo_monitor_isotopico b ON a.itemId = b.pozoId 
        WHERE a.epsasId = ".$epsasId."
        GROUP BY mes, anio
        ORDER BY anio, mes ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        $campanias = array();
        foreach ($datos as $clave => $valor) {
            $campanias[$valor['mes'].'-'.$valor['anio']] = $valor['mes'].'/'.$valor['anio'];
        }
        unset($datos);
        return $campanias;
    }

    function get_isotopicos($epsasId, $mes, $anio){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.nombre, b.nombre AS pozo, GROUP_CONCAT(d.valor ORDER BY d.valor) AS valor 
        FROM catalogo_pozo_general_epsas a, item b, item_pozo_monitor_isotopico c, item_pozo_monitor_isotopico_dato d 
        WHERE a.itemId=b.epsasId AND b.itemId=c.pozoId AND c.itemId=d.isotopicoId 
        AND d.isotocompuestoId IN (10, 12)
        AND DATE_FORMAT(c.fecha_muestreo, '%m')=".$mes." 
        AND DATE_FORMAT(c.fecha_muestreo, '%Y')=".$anio."
        AND a.itemId=".$epsasId."
        GROUP BY d.isotocompuestoId
        ORDER BY d.itemId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_geojson($fuenteInfo, $minMaxLonLat) {
        # Build GeoJSON feature collection array
        $coordenadasFuenteInfo = array(
           'type'      => 'FeatureCollection',
           'features'  => array()
        );
        foreach ($fuenteInfo as $clave => $valor) {
            $feature = array(
                'id' => $valor['itemId'],
                'type' => 'Feature', 
                'geometry' => array(
                    'type' => 'Point',
                    # Pass Longitude and Latitude Columns here
                    'coordinates' => array($valor['longitudDec'], $valor['latitudDec'])
                ),
                # Pass other attribute columns here
                'properties' => array(
                    'itemId' => $valor['itemId'],
                    'tipo' => $valor['tipo'],
                    'tipoNombre' => $valor['tipoNombre'],
                    'codigo' => $valor['codigo'],
                    'nombre' => $valor['nombre'],
                    'latitud' => $valor['latitudDec'],
                    'longitud' => $valor['longitudDec'],
                    'minMaxLonLat' => $minMaxLonLat
                    )
                );
            # Add feature arrays to feature collection array
            array_push($coordenadasFuenteInfo['features'], $feature);
        }
        return json_encode($coordenadasFuenteInfo, JSON_NUMERIC_CHECK);
    }

    /*function get_datos_pozos($epsasId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT t1.*, t2.*
        FROM 
        (SELECT a.itemId, a.codigo, a.nombre, a.latitud, a.longitud, a.latitudDec, a.longitudDec, 
        a.latitudUtm, a.longitudUtm, a.utmZona, a.altitud, 
        b.nombre AS departamento, c.nombre AS provincia, d.nombre AS municipio, 
        a.comunidadId, a.localidadId, a.comunidad, a.localidad, 
        e.nombre AS acuifero, a.epsasId, f.nombre AS macrocuenca, 
        g.nombre AS cuenca_estrategica 
        FROM item a, 
        vrhr_territorio.departamento b, 
        vrhr_territorio.provincia c, 
        vrhr_territorio.municipio d, 
        catalogo_acuifero e, 
        catalogo_cuenca f, 
        catalogo_cuenca_estrategica g 
        WHERE a.departamentoId=b.itemId 
        AND a.provinciaId=c.itemId 
        AND a.municipioId=d.itemId 
        AND a.acuiferoId=e.itemId 
        AND a.cuencaId=f.itemId 
        AND a.cuencaestrategicaId=g.itemId 
        AND a.tipo=1 
        AND a.epsasId=".$epsasId.") t1 
        LEFT JOIN 
        (SELECT b.itemId AS id, b.fuente_informacion, b.codigo AS codigo_doc, b.propietario, 
        b.observaciones, b.usoaguaId, b.propositoId, DATE_FORMAT(b.perforacion_fecha, '%d/%m/%Y') AS perforacion_fecha, 
        b.perforacion_pozoId, b.perforacion_tipoId, b.perforacion_metodoId, b.perforacion_profundidad, 
        b.perforacion_diametro, b.perforacion_diametro_final, b.perforacion_revestimientoId, 
        b.perforacion_excavacionId, b.perforacion_profundidadexcavada, b.perforacion_diametroexcavacion, 
        b.perforacion_nivelfreatico, b.perforacion_caudal, b.perforacion_observaciones, 
        b.constructivo_entubado, b.constructivo_entubado_diametro, b.constructivo_altura, b.constructivo_tuberiaId, 
        b.constructivo_diametro, b.constructivo_selloId, b.constructivo_observaciones, 
        DATE_FORMAT(b.electrico_fecha, '%d/%m/%Y') AS electrico_fecha, b.electrico_profundidad, b.electrico_parametroId, b.electrico_diagnostico, 
        b.electrico_observaciones, b.imple_profundidad, b.imple_tipoId, b.imple_caudal, 
        b.imple_horario_bombeo, b.imple_potencia, b.imple_observaciones
        FROM item a, item_pozo b
        WHERE a.itemId=b.itemId 
        AND a.tipo=1 
        AND a.epsasId=".$epsasId.") t2 
        ON t1.itemId=t2.id
        ORDER BY t1.itemId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }*/

    function get_datos_pozos($epsasId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT t1.*, t2.*
        FROM 
        (SELECT a.itemId, a.codigo, a.nombre, a.latitud, a.longitud, a.latitudDec, a.longitudDec, 
        a.latitudUtm, a.longitudUtm, a.utmZona, a.altitud, 
        b.nombre AS departamento, c.nombre AS provincia, d.nombre AS municipio, 
        a.comunidadId, a.localidadId, a.comunidad, a.localidad, 
        a.acuiferoId, a.epsasId, f.nombre AS macrocuenca, 
        a.cuencaestrategicaId 
        FROM item a, 
        vrhr_territorio.departamento b, 
        vrhr_territorio.provincia c, 
        vrhr_territorio.municipio d, 
        catalogo_cuenca f 
        WHERE a.departamentoId=b.itemId 
        AND a.provinciaId=c.itemId 
        AND a.municipioId=d.itemId 
        AND a.cuencaId=f.itemId 
        AND a.tipo=1 
        AND a.epsasId=".$epsasId.") t1 
        LEFT JOIN 
        (SELECT b.itemId AS id, b.fuente_informacion, b.codigo AS codigo_doc, b.propietario, 
        b.observaciones, b.usoaguaId, b.propositoId, DATE_FORMAT(b.perforacion_fecha, '%d/%m/%Y') AS perforacion_fecha, 
        b.perforacion_pozoId, b.perforacion_tipoId, b.perforacion_metodoId, b.perforacion_profundidad, 
        b.perforacion_diametro, b.perforacion_diametro_final, b.perforacion_revestimientoId, 
        b.perforacion_excavacionId, b.perforacion_profundidadexcavada, b.perforacion_diametroexcavacion, 
        b.perforacion_nivelfreatico, b.perforacion_caudal, b.perforacion_observaciones, 
        b.constructivo_entubado, b.constructivo_entubado_diametro, b.constructivo_altura, b.constructivo_tuberiaId, 
        b.constructivo_diametro, b.constructivo_selloId, b.constructivo_observaciones, 
        DATE_FORMAT(b.electrico_fecha, '%d/%m/%Y') AS electrico_fecha, b.electrico_profundidad, b.electrico_parametroId, b.electrico_diagnostico, 
        b.electrico_observaciones, b.imple_profundidad, b.imple_tipoId, b.imple_caudal, 
        b.imple_horario_bombeo, b.imple_potencia, b.imple_observaciones
        FROM item a, item_pozo b
        WHERE a.itemId=b.itemId 
        AND a.tipo=1 
        AND a.epsasId=".$epsasId.") t2 
        ON t1.itemId=t2.id
        ORDER BY t1.itemId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function crear_documento_excel($metadatos) {
        // Creación de documento y metadatos
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
        // Escritura de archivo
        $writer = new Xlsx($documentoHojaCalculo);

        // Guarda archivo en el servidor
        // $writer->save('test.xlsx');

        // Envia archivo para descarga
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="'.$nombreArchivo.'.xlsx"');
        header('Cache-Control: max-age=0');
        header('Expires: Fri, 11 Nov 2011 11:11:11 GMT');
        header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT');
        header('Cache-Control: cache, must-revalidate');
        header('Pragma: public');
        $writer->save('php://output');
    }

    function get_datos_pozos_excel($metadatos, $tituloDocumento, $epsasId) {
        // Creación de documento excel
        $documentoHojaCalculo = $this->crear_documento_excel($metadatos);
        // Consulta en la base de datos para obtener catálogos
        $catalogo_comunidad = $this->get_catalogo_comunidad();
        $catalogo_localidad = $this->get_catalogo_localidad();
        $catalogo_epsas = $this->get_catalogo_epsas();
        $catalogo_uso_agua = $this->get_catalogo_uso_agua();
        $catalogo_proposito = $this->get_catalogo_proposito();
        $catalogo_perforacion = $this->get_catalogo_perforacion();
        $catalogo_tipo_perforacion = $this->get_catalogo_tipo_perforacion();
        $catalogo_metodo_perforacion = $this->get_catalogo_metodo_perforacion();
        $catalogo_tipo_revestimiento = $this->get_catalogo_tipo_revestimiento();
        $catalogo_tipo_excavacion = $this->get_catalogo_tipo_excavacion();
        $catalogo_tipo_tuberia = $this->get_catalogo_tipo_tuberia();
        $catalogo_tipo_sello = $this->get_catalogo_tipo_sello();
        $catalogo_parametro = $this->get_catalogo_parametro();
        $catalogo_tipo_energia = $this->get_catalogo_tipo_energia();
        // Consulta en la base de datos para obtener datos de pozos
        $respuesta = $this->get_datos_pozos($epsasId);
        // Procesa datos en documento excel
        $hoja = $documentoHojaCalculo->getActiveSheet();
        $documentoHojaCalculo->getActiveSheet()->mergeCells('A1:BI1');
        $documentoHojaCalculo->getActiveSheet()->mergeCells('A2:W2');
        $documentoHojaCalculo->getActiveSheet()->mergeCells('X2:AC2');
        $documentoHojaCalculo->getActiveSheet()->mergeCells('AD2:AQ2');
        $documentoHojaCalculo->getActiveSheet()->mergeCells('AR2:AX2');
        $documentoHojaCalculo->getActiveSheet()->mergeCells('AY2:BC2');
        $documentoHojaCalculo->getActiveSheet()->mergeCells('BD2:BI2');

        $hoja->setTitle('POZOS');
        $hoja->setCellValue('A1', $tituloDocumento);
        $hoja->getStyle('A1')->getAlignment()->setHorizontal('left');
        $hoja->setCellValue('A2', 'DATOS GENERALES');
        $hoja->getStyle('A2')->getAlignment()->setHorizontal('left');
        $hoja->setCellValue('X2', 'DATOS ESPECÍFICOS');
        $hoja->getStyle('X2')->getAlignment()->setHorizontal('left');
        $hoja->setCellValue('AD2', 'DATOS DE PERFORACIÓN');
        $hoja->getStyle('AD2')->getAlignment()->setHorizontal('left');
        $hoja->setCellValue('AR2', 'DATOS CONSTRUCTIVOS');
        $hoja->getStyle('AR2')->getAlignment()->setHorizontal('left');
        $hoja->setCellValue('AY2', 'DATOS DE PERFILAJE ELÉCTRICO');
        $hoja->getStyle('AY2')->getAlignment()->setHorizontal('left');
        $hoja->setCellValue('BD2', 'DATOS DE IMPLEMENTACIÓN');
        $hoja->getStyle('BD2')->getAlignment()->setHorizontal('left');

        $contador = 3;
        $hoja->setCellValue('A'.$contador, 'ID');
        $hoja->setCellValue('B'.$contador, 'Código');
        $hoja->setCellValue('C'.$contador, 'Nombre');
        $hoja->setCellValue('D'.$contador, 'Latitud (Gra-Min-Seg)');
        $hoja->setCellValue('E'.$contador, 'Longitud (Gra-Min-Seg)');
        $hoja->setCellValue('F'.$contador, 'Lat. Decimal');
        $hoja->setCellValue('G'.$contador, 'Lon. Decimal');
        $hoja->setCellValue('H'.$contador, 'UTM Este');
        $hoja->setCellValue('I'.$contador, 'UTM Norte');
        $hoja->setCellValue('J'.$contador, 'Zona UTM');
        $hoja->setCellValue('K'.$contador, 'Altitud');
        $hoja->setCellValue('L'.$contador, 'Departamento');
        $hoja->setCellValue('M'.$contador, 'Provincia');
        $hoja->setCellValue('N'.$contador, 'Municipio');
        $hoja->setCellValue('O'.$contador, 'Comunidad');
        $hoja->setCellValue('P'.$contador, 'Localidad');
        $hoja->setCellValue('Q'.$contador, 'Descripción lugar');
        $hoja->setCellValue('R'.$contador, 'Área o acuífero');
        $hoja->setCellValue('S'.$contador, 'EPSA');
        $hoja->setCellValue('T'.$contador, 'EPSA no regularizada');
        $hoja->setCellValue('U'.$contador, 'Cooperativa');
        $hoja->setCellValue('V'.$contador, 'Macrocuenca');
        $hoja->setCellValue('W'.$contador, 'Cuenca estratégica');

        $hoja->setCellValue('X'.$contador, 'Fuente información');
        $hoja->setCellValue('Y'.$contador, 'Código documento');
        $hoja->setCellValue('Z'.$contador, 'Uso de agua');
        $hoja->setCellValue('AA'.$contador, 'Propósito');
        $hoja->setCellValue('AB'.$contador, 'Propietario');
        $hoja->setCellValue('AC'.$contador, 'Observaciones');

        $hoja->setCellValue('AD'.$contador, 'Fecha perforación');
        $hoja->setCellValue('AE'.$contador, 'Tipo de pozo');
        $hoja->setCellValue('AF'.$contador, 'Tipo perforación');
        $hoja->setCellValue('AG'.$contador, 'Método perforación');
        $hoja->setCellValue('AH'.$contador, 'Profundidad perforada (m)');
        $hoja->setCellValue('AI'.$contador, 'Diámetro perforación inicial (pulg)');
        $hoja->setCellValue('AJ'.$contador, 'Diámetro perforación final (pulg)');
        $hoja->setCellValue('AK'.$contador, 'Tipo revestimiento');
        $hoja->setCellValue('AL'.$contador, 'Tipo excavación');
        $hoja->setCellValue('AM'.$contador, 'Profundidad excavada (m)');
        $hoja->setCellValue('AN'.$contador, 'Diámetro excavación (pulg)');
        $hoja->setCellValue('AO'.$contador, 'Nivel freático (m)');
        $hoja->setCellValue('AP'.$contador, 'Caudal (l/s)');
        $hoja->setCellValue('AQ'.$contador, 'Observaciones');

        $hoja->setCellValue('AR'.$contador, 'Profundidad entubado (m)');
        $hoja->setCellValue('AS'.$contador, 'Diámetro entubado (pulg)');
        $hoja->setCellValue('AT'.$contador, 'Altura boca de pozo (m)');
        $hoja->setCellValue('AU'.$contador, 'Tipo tubería');
        $hoja->setCellValue('AV'.$contador, 'Diámetro grava (mm)');
        $hoja->setCellValue('AW'.$contador, 'Sello sanitario');
        $hoja->setCellValue('AX'.$contador, 'Observaciones');

        $hoja->setCellValue('AY'.$contador, 'Fecha');
        $hoja->setCellValue('AZ'.$contador, 'Profundidad total (m)');
        $hoja->setCellValue('BA'.$contador, 'Parámetros');
        $hoja->setCellValue('BB'.$contador, 'Diagnóstico');
        $hoja->setCellValue('BC'.$contador, 'Observaciones');

        $hoja->setCellValue('BD'.$contador, 'Profundidad bomba (m.b.b.p.)');
        $hoja->setCellValue('BE'.$contador, 'Tipo energía');
        $hoja->setCellValue('BF'.$contador, 'Caudal bombeo (l/s)');
        $hoja->setCellValue('BG'.$contador, 'Horario bombeo (horas/día)');
        $hoja->setCellValue('BH'.$contador, 'Potencia bomba (hp)');
        $hoja->setCellValue('BI'.$contador, 'Observaciones');

        $contador++;
        foreach ($respuesta as $clave => $valor) {
            // Datos generales
            $hoja->setCellValue('A'.$contador, $valor['itemId']);
            $hoja->setCellValue('B'.$contador, $valor['codigo']);
            $hoja->setCellValue('C'.$contador, $valor['nombre']);
            $hoja->setCellValue('D'.$contador, $valor['latitud']);
            $hoja->setCellValue('E'.$contador, $valor['longitud']);
            $hoja->setCellValue('F'.$contador, $valor['latitudDec']);
            $hoja->setCellValue('G'.$contador, $valor['longitudDec']);
            $hoja->setCellValue('H'.$contador, $valor['latitudUtm']);
            $hoja->setCellValue('I'.$contador, $valor['longitudUtm']);
            $hoja->setCellValue('J'.$contador, $valor['utmZona']);
            $hoja->setCellValue('K'.$contador, $valor['altitud']);
            $hoja->setCellValue('L'.$contador, $valor['departamento']);
            $hoja->setCellValue('M'.$contador, $valor['provincia']);
            $hoja->setCellValue('N'.$contador, $valor['municipio']);
            if ($valor['comunidadId'] != '') {
                $hoja->setCellValue('O'.$contador, $catalogo_comunidad[$valor['comunidadId']]);
            } else {
                $hoja->setCellValue('O'.$contador, $valor['comunidad']);
            }
            if ($valor['localidadId'] != '') {
                $hoja->setCellValue('P'.$contador, $catalogo_localidad[$valor['localidadId']]);
            } else {
                $hoja->setCellValue('P'.$contador, $valor['localidad']);
            }
            $hoja->setCellValue('Q'.$contador, $valor['descripcion']);
            $hoja->setCellValue('R'.$contador, $valor['acuifero']);
            $hoja->setCellValue('S'.$contador, $catalogo_epsas[$valor['epsasId']]);
            $hoja->setCellValue('T'.$contador, $valor['epsanoregularizadas']);
            $hoja->setCellValue('U'.$contador, $valor['cooperativas']);
            $hoja->setCellValue('V'.$contador, $valor['macrocuenca']);
            $hoja->setCellValue('W'.$contador, $valor['cuenca_estrategica']);
            // Datos específicos
            $hoja->setCellValue('X'.$contador, $valor['fuente_informacion']);
            $hoja->setCellValue('Y'.$contador, $valor['codigo_doc']);
            $uso_agua = explode(",", $valor['usoaguaId']);
            $uso_agua_limite = count($uso_agua);
            if ($uso_agua_limite > 0) {
                $uso_agua_texto = '';
                foreach ($uso_agua as $clave_aux => $valor_aux) {
                    $uso_agua_texto .= $catalogo_uso_agua[$valor_aux].', ';
                }
                $uso_agua_texto = rtrim($uso_agua_texto, ', ');
                $hoja->setCellValue('Z'.$contador, $uso_agua_texto);
            } else {
                $hoja->setCellValue('Z'.$contador, $catalogo_uso_agua[$valor['usoaguaId']]);
            }
            $proposito = explode(",", $valor['propositoId']);
            $proposito_limite = count($proposito);
            if ($proposito_limite > 0) {
                $proposito_texto = '';
                foreach ($proposito as $clave_aux => $valor_aux) {
                    $proposito_texto .= $catalogo_proposito[$valor_aux].', ';
                }
                $proposito_texto = rtrim($proposito_texto, ', ');
                $hoja->setCellValue('AA'.$contador, $proposito_texto);
            } else {
                $hoja->setCellValue('AA'.$contador, $catalogo_proposito[$valor['propositoId']]);
            }
            $hoja->setCellValue('AB'.$contador, $valor['propietario']);
            $hoja->setCellValue('AC'.$contador, $valor['observaciones']);
            // Datos de perforación
            $hoja->setCellValue('AD'.$contador, $valor['perforacion_fecha']);
            $hoja->setCellValue('AE'.$contador, $catalogo_perforacion[$valor['perforacion_pozoId']]);
            $hoja->setCellValue('AF'.$contador, $catalogo_tipo_perforacion[$valor['perforacion_tipoId']]);
            $hoja->setCellValue('AG'.$contador, $catalogo_metodo_perforacion[$valor['perforacion_metodoId']]);
            $hoja->setCellValue('AH'.$contador, $valor['perforacion_profundidad']);
            $hoja->setCellValue('AI'.$contador, $valor['perforacion_diametro']);
            $hoja->setCellValue('AJ'.$contador, $valor['perforacion_diametro_final']);
            $hoja->setCellValue('AK'.$contador, $catalogo_tipo_revestimiento[$valor['perforacion_revestimientoId']]);
            $hoja->setCellValue('AL'.$contador, $catalogo_tipo_excavacion[$valor['perforacion_excavacionId']]);
            $hoja->setCellValue('AM'.$contador, $valor['perforacion_profundidadexcavada']);
            $hoja->setCellValue('AN'.$contador, $valor['perforacion_diametroexcavacion']);
            $hoja->setCellValue('AO'.$contador, $valor['perforacion_nivelfreatico']);
            $hoja->setCellValue('AP'.$contador, $valor['perforacion_caudal']);
            $hoja->setCellValue('AQ'.$contador, $valor['perforacion_observaciones']);
            // Datos constructivos
            $hoja->setCellValue('AR'.$contador, $valor['constructivo_entubado']);
            $hoja->setCellValue('AS'.$contador, $valor['constructivo_entubado_diametro']);
            $hoja->setCellValue('AT'.$contador, $valor['constructivo_altura']);
            $hoja->setCellValue('AU'.$contador, $catalogo_tipo_tuberia[$valor['constructivo_tuberiaId']]);
            $hoja->setCellValue('AV'.$contador, $valor['constructivo_diametro']);
            $hoja->setCellValue('AW'.$contador, $catalogo_tipo_sello[$valor['constructivo_selloId']]);
            $hoja->setCellValue('AX'.$contador, $valor['constructivo_observaciones']);
            // Datos de perfilaje eléctrico
            $hoja->setCellValue('AY'.$contador, $valor['electrico_fecha']);
            $hoja->setCellValue('AZ'.$contador, $valor['electrico_profundidad']);
            $parametro = explode(",", $valor['parametroId']);
            $parametro_limite = count($parametro);
            if ($parametro_limite > 0) {
                $parametro_texto = '';
                foreach ($parametro as $clave_aux => $valor_aux) {
                    $parametro_texto .= $catalogo_parametro[$valor_aux].', ';
                }
                $parametro_texto = rtrim($parametro_texto, ', ');
                $hoja->setCellValue('BA'.$contador, $parametro_texto);
            } else {
                $hoja->setCellValue('BA'.$contador, $catalogo_parametro[$valor['parametroId']]);
            }
            $hoja->setCellValue('BB'.$contador, $valor['electrico_diagnostico']);
            $hoja->setCellValue('BC'.$contador, $valor['electrico_observaciones']);
            // Datos de implementación
            $hoja->setCellValue('BD'.$contador, $valor['imple_profundidad']);
            $hoja->setCellValue('BE'.$contador, $catalogo_tipo_energia[$valor['imple_tipoId']]);
            $hoja->setCellValue('BF'.$contador, $valor['imple_caudal']);
            $hoja->setCellValue('BG'.$contador, $valor['imple_horario_bombeo']);
            $hoja->setCellValue('BH'.$contador, $valor['imple_potencia']);
            $hoja->setCellValue('BI'.$contador, $valor['imple_observaciones']);
            $contador++;
        }
        unset($catalogo_comunidad);
        unset($catalogo_localidad);
        unset($catalogo_epsas);
        unset($catalogo_uso_agua);
        unset($catalogo_proposito);
        unset($catalogo_perforacion);
        unset($catalogo_tipo_perforacion);
        unset($catalogo_metodo_perforacion);
        unset($catalogo_tipo_revestimiento);
        unset($catalogo_tipo_excavacion);
        unset($catalogo_tipo_tuberia);
        unset($catalogo_tipo_sello);
        unset($catalogo_parametro);
        unset($catalogo_tipo_energia);

        $this->descargar_documento_excel($documentoHojaCalculo, 'pozos_epsa');
    }

    function get_archivo_csv($tituloDocumento, $nombreArchivo,$epsasId) {
        //Consulta a la base de datos
        $respuesta = $this->get_datos_pozos($epsasId);

        // Consulta a la base de datos para obtener catálogos
        $catalogo_comunidad = $this->get_catalogo_comunidad();
        $catalogo_localidad = $this->get_catalogo_localidad();
        $catalogo_acuiferos = $this->get_catalogo_acuiferos();
        $catalogo_epsas = $this->get_catalogo_epsas();
        $catalogo_cuencas_estrategicas = $this->get_catalogo_cuencas_estrategicas();
        $catalogo_uso_agua = $this->get_catalogo_uso_agua();
        $catalogo_uso_agua = $this->get_catalogo_uso_agua();
        $catalogo_proposito = $this->get_catalogo_proposito();
        $catalogo_perforacion = $this->get_catalogo_perforacion();
        $catalogo_tipo_perforacion = $this->get_catalogo_tipo_perforacion();
        $catalogo_metodo_perforacion = $this->get_catalogo_metodo_perforacion();
        $catalogo_tipo_revestimiento = $this->get_catalogo_tipo_revestimiento();
        $catalogo_tipo_excavacion = $this->get_catalogo_tipo_excavacion();
        $catalogo_tipo_tuberia = $this->get_catalogo_tipo_tuberia();
        $catalogo_tipo_sello = $this->get_catalogo_tipo_sello();
        $catalogo_parametro = $this->get_catalogo_parametro();
        $catalogo_tipo_energia = $this->get_catalogo_tipo_energia();
        // Consulta en la base de datos para obtener datos de pozos
        $etiquetasCabecera = array(
                'ID',
                'Código',
                'Nombre',
                'Latitud (Gra-Min-Seg)',
                'Longitud (Gra-Min-Seg)',
                'Lat. Decimal',
                'Lon. Decimal',
                'UTM Este',
                'UTM Norte',
                'Zona UTM',
                'Altitud',
                'Departamento',
                'Provincia',
                'Municipio',
                'Comunidad',
                'Localidad',
                'Descripción lugar',
                'Área o acuífero',
                'EPSA',
                'EPSA no regularizada',
                'Cooperativa',
                'Macrocuenca',
                'Cuenca estratégica',

                'Fuente información',
                'Código documento',
                'Uso de agua',
                'Propósito',
                'Propietario',
                'Observaciones',

                'Fecha perforación',
                'Tipo de pozo',
                'Tipo perforación',
                'Método perforación',
                'Profundidad perforada (m)',
                'Diámetro perforación inicial (pulg)',
                'Diámetro perforación final (pulg)',
                'Tipo revestimiento',
                'Tipo excavación',
                'Profundidad excavada (m)',
                'Diámetro excavación (pulg)',
                'Nivel freático (m)',
                'Caudal (l/s)',
                'Observaciones',

                'Profundidad entubado (m)',
                'Diámetro entubado (pulg)',
                'Altura boca de pozo (m)',
                'Tipo tubería',
                'Diámetro grava (mm)',
                'Sello sanitario',
                'Observaciones',

                'Fecha',
                'Profundidad total (m)',
                'Parámetros',
                'Diagnóstico',
                'Observaciones',

                'Profundidad bomba (m.b.b.p.)',
                'Tipo energía',
                'Caudal bombeo (l/s)',
                'Horario bombeo (horas/día)',
                'Potencia bomba (hp)',
                'Observaciones'
            );
        
        $limiteCategoria = count($etiquetasCabecera);
        $etiquetasCategoria = array();
        for ($i=0; $i < $limiteCategoria; $i++) { 
            $etiquetasCategoria[$i] = '';
        }
        $etiquetasCategoria[0] = 'DATOS GENERALES';
        $etiquetasCategoria[23] = 'DATOS ESPECÍFICOS';
        $etiquetasCategoria[29] = 'DATOS DE PERFORACIÓN';
        $etiquetasCategoria[43] = 'DATOS CONSTRUCTIVOS';
        $etiquetasCategoria[50] = 'DATOS DE PERFILAJE ELÉCTRICO';
        $etiquetasCategoria[55] = 'DATOS DE IMPLEMENTACIÓN';

        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename='.$nombreArchivo);
        $documentoCSV = fopen("php://output", "w");
        fprintf($documentoCSV, chr(0xEF).chr(0xBB).chr(0xBF));
        fputcsv($documentoCSV, array($tituloDocumento), ';');
        fputcsv($documentoCSV, $etiquetasCategoria, ';');
        fputcsv($documentoCSV, $etiquetasCabecera, ';');

        foreach ($respuesta as $clave => $valor) {
            $datos = array();
            // Datos generales
            $datos[] = $valor['itemId'];
            $datos[] = $valor['codigo'];
            $datos[] = $valor['nombre'];
            $datos[] = $valor['latitud'];
            $datos[] = $valor['longitud'];
            $datos[] = str_replace(".",",",$valor['latitudDec']);
            $datos[] = str_replace(".",",",$valor['longitudDec']);
            $datos[] = $valor['latitudUtm'];
            $datos[] = $valor['longitudUtm'];
            $datos[] = $valor['utmZona'];
            $datos[] = $valor['altitud'];
            $datos[] = $valor['departamento'];
            $datos[] = $valor['provincia'];
            $datos[] = $valor['municipio'];
            if ($valor['comunidadId'] != '') {
                 $datos[] = $catalogo_comunidad[$valor['comunidadId']];
            } else {
                 $datos[] = $valor['comunidad'];
            }
            if ($valor['localidadId'] != '') {
                 $datos[] = $catalogo_localidad[$valor['localidadId']];
            } else {
                 $datos[] = $valor['localidad'];
            }
             $datos[] = $valor['descripcion'];
             //$datos[] = $valor['acuifero'];
             $datos[] = $catalogo_acuiferos[$valor['acuiferoId']];
             $datos[] = $catalogo_epsas[$valor['epsasId']];
             $datos[] = $valor['epsanoregularizadas'];
             $datos[] = $valor['cooperativas'];
             $datos[] = $valor['macrocuenca'];
             //$datos[] = $valor['cuenca_estrategica'];
             $datos[] = $catalogo_cuencas_estrategicas[$valor['cuencaestrategicaId']];

            // Datos específicos
            $datos[] = $valor['fuente_informacion'];
            $datos[] = $valor['codigo_doc'];
            $uso_agua = explode(",", $valor['usoaguaId']);
            $uso_agua_limite = count($uso_agua);
            if ($uso_agua_limite > 0) {
                $uso_agua_texto = '';
                foreach ($uso_agua as $clave_aux => $valor_aux) {
                    $uso_agua_texto .= $catalogo_uso_agua[$valor_aux].', ';
                }
                $uso_agua_texto = rtrim($uso_agua_texto, ', ');
                $datos[] = $uso_agua_texto;
            } else {
                $datos[] = $catalogo_uso_agua[$valor['usoaguaId']];
            }
            $proposito = explode(",", $valor['propositoId']);
            $proposito_limite = count($proposito);
            if ($proposito_limite > 0) {
                $proposito_texto = '';
                foreach ($proposito as $clave_aux => $valor_aux) {
                    $proposito_texto .= $catalogo_proposito[$valor_aux].', ';
                }
                $proposito_texto = rtrim($proposito_texto, ', ');
                $datos[] = $proposito_texto;
            } else {
                $datos[] = $catalogo_proposito[$valor['propositoId']];
            }
            $datos[] = $valor['propietario'];
            $datos[] = $valor['observaciones'];

            // Datos de perforación
            $datos[] = $valor['perforacion_fecha'];
            $datos[] = $catalogo_perforacion[$valor['perforacion_pozoId']];
            $datos[] = $catalogo_tipo_perforacion[$valor['perforacion_tipoId']];
            $datos[] = $catalogo_metodo_perforacion[$valor['perforacion_metodoId']];
            $datos[] = $valor['perforacion_profundidad'];
            $datos[] = $valor['perforacion_diametro'];
            $datos[] = $valor['perforacion_diametro_final'];
            $datos[] = $catalogo_tipo_revestimiento[$valor['perforacion_revestimientoId']];
            $datos[] = $catalogo_tipo_excavacion[$valor['perforacion_excavacionId']];
            $datos[] = $valor['perforacion_profundidadexcavada'];
            $datos[] = $valor['perforacion_diametroexcavacion'];
            $datos[] = $valor['perforacion_nivelfreatico'];
            $datos[] = $valor['perforacion_caudal'];
            $datos[] = $valor['perforacion_observaciones'];

            // Datos constructivos
            $datos[] = $valor['constructivo_entubado'];
            $datos[] = $valor['constructivo_entubado_diametro'];
            $datos[] = $valor['constructivo_altura'];
            $datos[] = $catalogo_tipo_tuberia[$valor['constructivo_tuberiaId']];
            $datos[] = $valor['constructivo_diametro'];
            $datos[] = $catalogo_tipo_sello[$valor['constructivo_selloId']];
            $datos[] = $valor['constructivo_observaciones'];

            // Datos de perfilaje eléctrico
            $datos[] = $valor['electrico_fecha'];
            $datos[] = $valor['electrico_profundidad'];
            $parametro = explode(",", $valor['parametroId']);
            $parametro_limite = count($parametro);
            if ($parametro_limite > 0) {
                $parametro_texto = '';
                foreach ($parametro as $clave_aux => $valor_aux) {
                    $parametro_texto .= $catalogo_parametro[$valor_aux].', ';
                }
                $parametro_texto = rtrim($parametro_texto, ', ');
                $datos[] = $parametro_texto;
            } else {
                $datos[] = $catalogo_parametro[$valor['parametroId']];
            }
            $datos[] = $valor['electrico_diagnostico'];
            $datos[] = $valor['electrico_observaciones'];

            // Datos de implementación
            $datos[] = $valor['imple_profundidad'];
            $datos[] = $catalogo_tipo_energia[$valor['imple_tipoId']];
            $datos[] = $valor['imple_caudal'];
            $datos[] = $valor['imple_horario_bombeo'];
            $datos[] = $valor['imple_potencia'];
            $datos[] = $valor['imple_observaciones'];

            fputcsv($documentoCSV, $datos, ';');
        } 
        fclose($documentoCSV);
        unset($catalogo_comunidad);
        unset($catalogo_localidad);
        unset($catalogo_epsas);
        unset($catalogo_acuiferos);
        unset($catalogo_cuencas_estrategicas);
        unset($catalogo_uso_agua);
        unset($catalogo_proposito);
        unset($catalogo_perforacion);
        unset($catalogo_tipo_perforacion);
        unset($catalogo_metodo_perforacion);
        unset($catalogo_tipo_revestimiento);
        unset($catalogo_tipo_excavacion);
        unset($catalogo_tipo_tuberia);
        unset($catalogo_tipo_sello);
        unset($catalogo_parametro);
        unset($catalogo_tipo_energia);
        unset($respuesta);
        unset($datos);
    }

    function get_catalogo_comunidad() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM vrhr_territorio.comunidad";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_localidad() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM vrhr_territorio.localidad";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_epsas() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_pozo_general_epsas";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_acuiferos() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_acuifero";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_cuencas_estrategicas() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_cuenca_estrategica";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_uso_agua() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_pozo_usoagua";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_proposito() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_pozo_proposito";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_perforacion() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_pozo_perforacion";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_tipo_perforacion() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_pozo_perforacion_tipo";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_metodo_perforacion() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_pozo_perforacion_metodo";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_tipo_revestimiento() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_pozo_perforacion_revestimiento";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_tipo_excavacion() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_pozo_perforacion_excavacion";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_tipo_tuberia() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_pozo_constructivo_tuberia";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_tipo_sello() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_pozo_constructivo_sello";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_parametro() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_pozo_electrico_parametro";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_tipo_energia() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_pozo_implementacion_tipo";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }
}