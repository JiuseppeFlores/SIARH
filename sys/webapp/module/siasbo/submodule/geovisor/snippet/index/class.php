<?php
/**
 * Created by PhpStorm.
 * User: henrytaby
 * Date: 3/5/2018
 * Time: 15:23
 */
use PhpOffice\PhpWord\TemplateProcessor;

class Index extends Table {

    function __construct() {
        /**
         * Inicializamos todas las librerias y variables para el submodulo
         */
        $this->submodule_init_sbm();
    }

    function get_fuente_info($itemId, $tipo) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        switch ($tipo) {
            case '1':
                $sql = "SELECT 
                b.nombre AS acuifero,
                a.epsasId AS epsa,
                (
                SELECT GROUP_CONCAT(b1.nombre) AS proposito
                FROM item_pozo a1, catalogo_pozo_proposito b1
                WHERE  FIND_IN_SET(b1.itemId, a1.propositoId)
                AND a1.itemId=".$itemId." 
                LIMIT 1
                ) AS proposito,
                (
                SELECT GROUP_CONCAT(b1.nombre) AS usoagua
                FROM item_pozo a1, catalogo_pozo_usoagua b1
                WHERE  FIND_IN_SET(b1.itemId, a1.usoaguaId)
                AND a1.itemId=".$itemId." 
                LIMIT 1
                ) AS uso,
                (
                SELECT count(*)
                FROM item_pozo_monitor_calidad a1, item_pozo_monitor_calidad_dato b1
                WHERE a1.itemId=b1.calidadId
                AND a1.pozoId=".$itemId." 
                LIMIT 1
                ) AS calidad,
                (
                SELECT count(*)
                FROM item_pozo_monitor_isotopico a1, item_pozo_monitor_isotopico_dato b1
                WHERE a1.itemId=b1.isotopicoId
                AND a1.pozoId=".$itemId." 
                LIMIT 1
                ) AS isotopico 
                FROM item a, 
                catalogo_acuifero b
                WHERE a.acuiferoId=b.itemId  
                AND a.itemId=".$itemId." 
                LIMIT 1";
                break;

            case '3':
                $sql = "SELECT 
                b.nombre AS acuifero,
                a.epsasId AS epsa,
                (
                SELECT GROUP_CONCAT(b1.nombre) AS proposito
                FROM item_pozo a1, catalogo_pozo_proposito b1
                WHERE  FIND_IN_SET(b1.itemId, a1.propositoId)
                AND a1.itemId=".$itemId." 
                LIMIT 1
                ) AS proposito,
                (
                SELECT GROUP_CONCAT(b1.nombre) AS usoagua
                FROM item_pozo a1, catalogo_pozo_usoagua b1
                WHERE  FIND_IN_SET(b1.itemId, a1.usoaguaId)
                AND a1.itemId=".$itemId." 
                LIMIT 1
                ) AS uso
                FROM item a, 
                catalogo_acuifero b 
                WHERE a.acuiferoId=b.itemId 
                AND a.itemId=".$itemId." 
                LIMIT 1";
                break;
        }
    
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }

    function get_datos_diseno($itemId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT count(*) AS diseno
        FROM item_pozo a, item_pozo_constructivo_diseno b
        WHERE a.itemId=b.pozoId
        AND a.itemId=".$itemId." 
        LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_datos_litologia($itemId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT count(*) AS litologia
        FROM item_pozo_litologica
        WHERE pozoId=".$itemId." 
        LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_datos_caudal($itemId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT count(*) AS caudal
        FROM item_pozo_monitor
        WHERE caudal <> '' 
        AND pozoId=".$itemId." 
        LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_datos_abatimiento($itemId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT count(*) AS abatimiento
        FROM item_pozo_monitor
        WHERE nivel_estatico <> ''
        AND pozoId=".$itemId." 
        LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_datos_escalon($itemId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT count(*) AS escalon 
        FROM item_pozo_hidra b, item_pozo_hidra_bombeo c, item_pozo_hidra_bombeo_dato d 
        WHERE b.itemId=c.pruebabombeoId AND c.itemId=d.tipobombeoId AND b.pozoId = ".$itemId." 
        LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_datos_recuperacion($itemId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT count(*) AS recuperacion 
        FROM item_pozo_hidra b, item_pozo_hidra_bombeo c, item_pozo_hidra_recuperacion d, item_pozo_hidra_recuperacion_dato e 
        WHERE b.itemId=c.pruebabombeoId AND c.itemId=d.tipobombeoId AND d.itemId=e.recuperacionId AND b.pozoId = ".$itemId." 
        LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
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

    function get_reporte($id, $tipo, $reporte_file) {
        $parametros = array();
        $parametros['id'] = $id;

        $reporte_file = $reporte_file.".prpt";
        $nombre = "Ficha de pozo";
        $this->pentaho_get_report($reporte_file, $tipo, $nombre, $parametros);
    }

    function get_puntos_busqueda($dato_buscado) {
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
        AND a.tipo IN (1,2,3) 
        AND (a.codigo LIKE '%".$dato_buscado."%' OR a.nombre LIKE '%".$dato_buscado."%')
        ORDER BY a.itemId ASC 
        LIMIT 5";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_geojson($fuenteInfo) {
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
                    'longitud' => $valor['longitudDec']
                    )
                );
            # Add feature arrays to feature collection array
            array_push($coordenadasFuenteInfo['features'], $feature);
        }
        return json_encode($coordenadasFuenteInfo, JSON_NUMERIC_CHECK);
    }
}