<?php
class Snippet extends Table {
    
    var $item_form;
    
    function __construct() {
        /**
         * Inicializamos todas las librerias y variables para el submodulo
         */
        $this->submodule_init_sbm();
    }

    /*function get_datos_stiff($Id){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT
        a.nombre, c.compuestoId, c.valor  
        FROM item a, item_pozo_monitor_calidad b, item_pozo_monitor_calidad_dato c  
        WHERE a.itemId=b.pozoId AND b.itemId=c.calidadId AND a.itemId = $Id 
        ORDER BY c.itemId ASC";

        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }*/

    function get_datos_stiff($pozoId, $mes, $anio){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT 
        a.nombre, c.compuestoId, c.valor 
        FROM item a, item_pozo_monitor_calidad b, item_pozo_monitor_calidad_dato c 
        WHERE a.itemId=b.pozoId 
        AND b.itemId=c.calidadId 
        AND a.itemId=".$pozoId." 
        AND c.compuestoId IN (54,75,90,93,59,47,94) 
        AND DATE_FORMAT(b.fecha_muestreo, '%m')=".$mes." 
        AND DATE_FORMAT(b.fecha_muestreo, '%Y')=".$anio." 
        GROUP BY c.compuestoId 
        ORDER BY c.itemId ASC";

        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }

    function get_campanias($pozoId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT
        DATE_FORMAT(fecha_muestreo, '%m') AS mes,
        DATE_FORMAT(fecha_muestreo, '%Y') AS anio
        FROM item_pozo_monitor_calidad
        WHERE pozoId=".$pozoId."
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

    function get_datos_pozo($pozoId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT
        a.itemId,
        a.nombre,
        a.codigo,
        b.perforacion_pozoId AS tipo,
        b.perforacion_profundidad AS profundidad
        FROM item a, item_pozo b
        WHERE a.itemId = b.itemId AND a.itemId=".$pozoId."
        LIMIT 1";

        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }

    function get_datos_diseno($pozoId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT
        itemId,
        profundidad_desde AS desde,
        profundidad_hasta AS hasta
        FROM item_pozo_constructivo_diseno 
        WHERE pozoId=".$pozoId."
        ORDER BY desde, hasta ASC";

        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }

    function get_datos_litologia($Id){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);

        $sql = "SELECT
                    a.nombre, 
                    b.litologia1 AS litologia, b.profundidad_desde, b.profundidad_hasta, 
                    c.nombre AS litologia1, c.imagen AS imagen1, b.porcentaje1,
                    d.nombre AS litologia2, d.imagen AS imagen2, b.porcentaje2,
                    e.nombre AS litologia3, e.imagen AS imagen3, b.porcentaje3,
                    f.nombre AS litologia4, f.imagen AS imagen4, b.porcentaje4
                FROM item a, item_pozo_litologica b
                LEFT JOIN catalogo_pozo_litologico c ON b.litologiaId1 = c.itemId
                LEFT JOIN catalogo_pozo_litologico d ON b.litologiaId2 = d.itemId
                LEFT JOIN catalogo_pozo_litologico e ON b.litologiaId3 = e.itemId
                LEFT JOIN catalogo_pozo_litologico f ON b.litologiaId4 = f.itemId
                WHERE a.itemId=b.pozoId AND b.pozoId = $Id 
                ORDER BY b.profundidad_desde ASC, b.profundidad_hasta ASC";

        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }

    function get_datos_caudal($Id){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT
        a.nombre, b.fecha, b.caudal, b.caudalautorizado  
        FROM item a, item_pozo_monitor b 
        WHERE a.itemId=b.pozoId AND b.pozoId = $Id  
        ORDER BY b.itemId ASC";

        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }

    function get_datos_abatimiento($Id){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT
        a.nombre, b.fecha, b.nivel_estatico  
        FROM item a, item_pozo_monitor b  
        WHERE a.itemId=b.pozoId AND b.pozoId = $Id  
        ORDER BY b.itemId ASC";

        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }

    function get_datos_escalon($Id){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.nombre, c.tipo, c.nivel_estatico, d.tiempo, d.nivel_dinamico, d.etapa  
        FROM item a, item_pozo_hidra b, item_pozo_hidra_bombeo c, item_pozo_hidra_bombeo_dato d 
        WHERE a.itemId=b.pozoId AND b.itemId=c.pruebabombeoId AND c.itemId=d.tipobombeoId AND a.itemId = ".$Id." 
        ORDER BY d.itemId ASC";

        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }

    function get_datos_recuperacion($Id){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.nombre, d.nivel_estatico, e.tiempo, e.nivel_dinamico   
        FROM item a, item_pozo_hidra b, item_pozo_hidra_bombeo c, item_pozo_hidra_recuperacion d, item_pozo_hidra_recuperacion_dato e 
        WHERE a.itemId=b.pozoId AND b.itemId=c.pruebabombeoId AND c.itemId=d.tipobombeoId AND d.itemId=e.recuperacionId 
        AND a.itemId= ".$Id." 
        ORDER BY e.itemId ASC";

        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();

        return $datos;
    }
}