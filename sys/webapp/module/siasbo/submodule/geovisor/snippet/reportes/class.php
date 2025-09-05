<?php
use PhpOffice\PhpWord\TemplateProcessor;

class Snippet extends Table {
    
    var $item_form;
    
    function __construct() {
        /**
         * Inicializamos todas las librerias y variables para el submodulo
         */
        $this->submodule_init_sbm();
    }

    function get_datos_pozo($pozoId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT t1.*, t2.* 
        FROM 
        (SELECT a.itemId, a.codigo, a.nombre, e.nombre AS acuifero, a.epsasId, 
        b.nombre AS departamento, c.nombre AS provincia, d.nombre AS municipio,
        a.comunidadId, a.localidadId, a.comunidad, a.localidad, 
        a.latitudUtm, a.longitudUtm, a.altitud 
        FROM item a, 
        vrhr_territorio.departamento b, 
        vrhr_territorio.provincia c, 
        vrhr_territorio.municipio d, 
        catalogo_acuifero e
        WHERE a.departamentoId=b.itemId 
        AND a.provinciaId=c.itemId 
        AND a.municipioId=d.itemId 
        AND a.acuiferoId=e.itemId 
        AND a.itemId=".$pozoId.") t1
        LEFT JOIN 
        (SELECT c.itemId, c.fuente_informacion, c.codigo AS codigo_info, c.usoaguaId, c.propositoId, 
        c.propietario, c.observaciones, DATE_FORMAT(c.perforacion_fecha, '%d/%m/%Y') AS perforacion_fecha, 
        c.perforacion_pozoId, c.perforacion_tipoId, c.perforacion_metodoId, c.perforacion_profundidad, 
        c.perforacion_diametro, c.constructivo_entubado, c.constructivo_entubado_diametro, 
        c.constructivo_altura, c.constructivo_diametro, c.constructivo_tuberiaId, c.constructivo_selloId, 
        c.electrico_fecha, c.electrico_profundidad, c.electrico_diagnostico, c.imple_profundidad, 
        c.imple_tipoId, c.imple_caudal, c.imple_horario_bombeo, c.imple_potencia  
        FROM item_pozo c
        WHERE c.itemId=".$pozoId."
        LIMIT 1) t2 
        ON t1.itemId=t2.itemId 
        LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_datos_pozo_diseno($pozoId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.itemId, b.nombre, a.abertura, a.profundidad_desde, a.profundidad_hasta 
        FROM item_pozo_constructivo_diseno a, 
        catalogo_pozo_constructivo_rejillafiltro b 
        WHERE a.rejillafiltroId=b.itemId 
        AND a.pozoId=".$pozoId." 
        ORDER BY a.itemId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_datos_pozo_litologia($pozoId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.itemId, c.nombre, c.imagen, a.profundidad_desde, a.profundidad_hasta 
                FROM item_pozo_litologica a
                LEFT JOIN catalogo_pozo_litologico_permeabilidad b ON a.permeabilidad = b.itemId 
                LEFT JOIN catalogo_pozo_litologico c ON a.litologiaId1 = c.itemId
                WHERE a.pozoId = $pozoId
                ORDER BY a.profundidad_desde ASC, a.profundidad_hasta ASC;";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_datos_pozo_hidraulica($pozoId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.itemId, b.nombre, a.conductividad, a.transmisividad, a.coeficiente, 
        a.radio, a.porosidad  
        FROM item_pozo_hidra a, 
        catalogo_pozo_hidra_tipo_prueba b 
        WHERE a.tipopruebaId=b.itemId 
        AND a.pozoId=".$pozoId." 
        ORDER BY a.itemId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_datos_pozo_hidraulico_tipo_bombeo($pozoId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT b.itemId, c.nombre, DATE_FORMAT(b.fecha, '%d/%m/%Y') AS fecha, b.nivel_estatico, b.nivel_dinamico, 
        b.duracion, b.profundidad, b.potencia, b.caudal 
        FROM item_pozo_hidra a, 
        item_pozo_hidra_bombeo b, 
        catalogo_pozo_hidra_tipo_bombeo c 
        WHERE a.itemId=b.pruebabombeoId 
        AND b.tipo=c.itemId 
        AND a.pozoId=".$pozoId." 
        ORDER BY a.itemId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_datos_pozo_hidraulico_recuperacion($pozoId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT c.itemId, DATE_FORMAT(c.fecha, '%d/%m/%Y') AS fecha, c.nivel_estatico, c.nivel_dinamico_final, 
        c.duracion 
        FROM item_pozo_hidra a, 
        item_pozo_hidra_bombeo b, 
        item_pozo_hidra_recuperacion c 
        WHERE a.itemId=b.pruebabombeoId 
        AND b.itemId=c.tipobombeoId 
        AND a.pozoId=".$pozoId." 
        ORDER BY c.itemId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_datos_pozo_monitoreo_cantidad($pozoId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.itemId, DATE_FORMAT(a.fecha, '%d/%m/%Y') AS fecha, a.caudal, 
                        a.nivel_freatico, a.nivel_dinamico, a.nivel_estatico, a.observaciones 
                FROM item_pozo_monitor a 
                WHERE a.pozoId = {$pozoId}
                ORDER BY a.itemId ASC;";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_datos_pozo_monitoreo_calidad($pozoId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.itemId, DATE_FORMAT(a.fecha_muestreo, '%d/%m/%Y') AS fecha_muestreo, 
        a.hora_muestreo, a.epocaId, a.entidad, a.codigo_muestra, DATE_FORMAT(a.fecha_analisis, '%d/%m/%Y') AS fecha_analisis, 
        a.hora_analisis, a.nombre_laboratorio, a.codigo_laboratorio, a.profundidad, a.observaciones   
        FROM item_pozo_monitor_calidad a 
        WHERE a.pozoId=".$pozoId." 
        ORDER BY a.itemId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_datos_pozo_monitoreo_calidad_dato($pozoId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.itemId, a.calidadId, c.nombre AS parametro, d.nombre AS compuesto, a.valor, a.observaciones
                FROM item_pozo_monitor_calidad_dato a
                LEFT JOIN item_pozo_monitor_calidad b ON a.calidadId = b.itemId
                LEFT JOIN catalogo_pozo_monitor_calidad_parametro c ON a.parametroId = c.itemId
                LEFT JOIN catalogo_pozo_monitor_calidad_compuesto d ON a.compuestoId = d.itemId
                WHERE b.pozoId = $pozoId
                ORDER BY a.itemId ASC;";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_ficha_pozo($pozoId, $nombre_archivo) {
        //Crear documento a partir de plantilla
        $plantilla = new TemplateProcessor('template/siasbo/ficha_pozo/template_pozo.docx');

        //Consulta información a la base de datos
        $datos_general = $this->get_datos_pozo($pozoId);
        $datos_diseno = $this->get_datos_pozo_diseno($pozoId);
        $datos_litologia = $this->get_datos_pozo_litologia($pozoId);
        $datos_hidraulica = $this->get_datos_pozo_hidraulica($pozoId);
        $datos_hidraulico_tipo_bombeo = $this->get_datos_pozo_hidraulico_tipo_bombeo($pozoId);
        $datos_hidraulico_recuperacion = $this->get_datos_pozo_hidraulico_recuperacion($pozoId);
        $datos_monitoreo_cantidad = $this->get_datos_pozo_monitoreo_cantidad($pozoId);
        $datos_monitoreo_calidad = $this->get_datos_pozo_monitoreo_calidad($pozoId);
        $datos_monitoreo_calidad_dato = $this->get_datos_pozo_monitoreo_calidad_dato($pozoId);

        //Consulta catálogos a la base de datos
        $catalogo_comunidad = $this->get_catalogo_comunidad();
        $catalogo_localidad = $this->get_catalogo_localidad();
        $catalogo_epsas = $this->get_catalogo_epsas();
        $catalogo_uso_agua = $this->get_catalogo_uso_agua();
        $catalogo_proposito = $this->get_catalogo_proposito();
        $catalogo_perforacion = $this->get_catalogo_perforacion();
        $catalogo_tipo_perforacion = $this->get_catalogo_tipo_perforacion();
        $catalogo_metodo_perforacion = $this->get_catalogo_metodo_perforacion();
        $catalogo_tipo_tuberia = $this->get_catalogo_tipo_tuberia();
        $catalogo_tipo_sello = $this->get_catalogo_tipo_sello();
        $catalogo_tipo_energia = $this->get_catalogo_tipo_energia();
        $catalogo_epoca = $this->get_catalogo_epoca();

        //Reemplaza variables de plantilla con datos
        $plantilla->setValue('field_nombre', $datos_general[0]['nombre']);
        $plantilla->setValue('field_codigo', $datos_general[0]['codigo']);
        $plantilla->setValue('field_acuifero', $datos_general[0]['acuifero']);
        $plantilla->setValue('field_epsa', $catalogo_epsas[$datos_general[0]['epsasId']]);
        $plantilla->setValue('field_depto', $datos_general[0]['departamento']);
        $plantilla->setValue('field_provincia', $datos_general[0]['provincia']);
        $plantilla->setValue('field_municipio', $datos_general[0]['municipio']);
        if ($datos_general[0]['comunidadId'] != '' && $datos_general[0]['comunidadId'] != 0) {
            $plantilla->setValue('field_comunidad', $catalogo_comunidad[$datos_general[0]['comunidadId']]);
        } else {
            $plantilla->setValue('field_comunidad', $datos_general[0]['comunidad']);
        }
        if ($datos_general[0]['localidadId'] != '' && $datos_general[0]['localidadId'] != 0) {
            $plantilla->setValue('field_localidad', $catalogo_comunidad[$datos_general[0]['localidadId']]);
        } else {
            $plantilla->setValue('field_localidad', $datos_general[0]['localidad']);
        }
        $plantilla->setValue('field_utm_este', $datos_general[0]['latitudUtm']);
        $plantilla->setValue('field_utm_norte', $datos_general[0]['longitudUtm']);
        $plantilla->setValue('field_altitud', $datos_general[0]['altitud']);
        
        //Datos específicos
        $plantilla->setValue('field_fuente_info', $datos_general[0]['fuente_informacion']);
        $plantilla->setValue('field_codigo_info', $datos_general[0]['codigo_info']);
        $datos_uso = explode(',', $datos_general[0]['usoaguaId']);
        $uso = '';
        foreach ($datos_uso as $clave => $valor) {
            $uso .= $catalogo_uso_agua[$valor].', ';
        }
        $plantilla->setValue('field_uso', rtrim($uso, ', '));
        $datos_proposito = explode(',', $datos_general[0]['propositoId']);
        $proposito = '';
        foreach ($datos_proposito as $clave => $valor) {
            $proposito .= $catalogo_proposito[$valor].', ';
        }
        $plantilla->setValue('field_proposito', rtrim($proposito, ', '));
        $plantilla->setValue('field_propietario', $datos_general[0]['propietario']);
        $plantilla->setValue('field_obs', $datos_general[0]['observaciones']);
        
        //Datos de perforación
        $plantilla->setValue('field_tipo', $catalogo_perforacion[$datos_general[0]['perforacion_pozoId']]);
        $plantilla->setValue('field_tipo_perfora', $catalogo_tipo_perforacion[$datos_general[0]['perforacion_tipoId']]);
        $plantilla->setValue('field_metodo_perfora', $catalogo_metodo_perforacion[$datos_general[0]['perforacion_metodoId']]);
        $plantilla->setValue('field_fecha_perfora', $datos_general[0]['perforacion_fecha']);
        $plantilla->setValue('field_profundidad_perfora', $datos_general[0]['perforacion_profundidad']);
        $plantilla->setValue('field_diametro_perfora', $datos_general[0]['perforacion_diametro']);
        
        //Datos constructivos
        $plantilla->setValue('field_profundidad_entubado', $datos_general[0]['constructivo_entubado']);
        $plantilla->setValue('field_diametro_entubado', $datos_general[0]['constructivo_entubado_diametro']);
        $plantilla->setValue('field_altura_boca_pozo', $datos_general[0]['constructivo_altura']);
        $plantilla->setValue('field_diametro_grava', $datos_general[0]['constructivo_diametro']);
        $plantilla->setValue('field_tipo_tuberia', $catalogo_tipo_tuberia[$datos_general[0]['constructivo_tuberiaId']]);
        $plantilla->setValue('field_sello_sanitario', $catalogo_tipo_sello[$datos_general[0]['constructivo_selloId']]);
        
        //Datos constructivos - diseño
        $diseno_rejillafiltro = array();
        $diseno_abertura = array();
        $diseno_profundidad_desde = array();
        $diseno_profundidad_hasta = array();
        foreach ($datos_diseno as $clave => $valor) {
            $diseno_rejillafiltro[] = $valor['nombre'];
            $diseno_abertura[] = $valor['abertura'];
            $diseno_profundidad_desde[] = $valor['profundidad_desde'];
            $diseno_profundidad_hasta[] = $valor['profundidad_hasta'];
        }
        $contador = 1;
        $tamanio = count($diseno_rejillafiltro);
        $plantilla->cloneRow('diseno.rejillafiltro', $tamanio);
        for ($i=0; $i < $tamanio; $i++) {
            $plantilla->setValue('diseno.rejillafiltro#'.$contador, htmlspecialchars($diseno_rejillafiltro[$i]));
            $plantilla->setValue('diseno.abertura#'.$contador, $diseno_abertura[$i]);
            $plantilla->setValue('diseno.profundidad_desde#'.$contador, $diseno_profundidad_desde[$i]);
            $plantilla->setValue('diseno.profundidad_hasta#'.$contador, $diseno_profundidad_hasta[$i]);
            $contador++;
        }
        
        //Datos de litología
        $litologia_profundidad_desde = array();
        $litologia_profundidad_hasta = array();
        $litologia_formacion = array();
        $litologia_imagen = array();
        foreach ($datos_litologia as $clave => $valor) {
            $litologia_profundidad_desde[] = $valor['profundidad_desde'];
            $litologia_profundidad_hasta[] = $valor['profundidad_hasta'];
            $litologia_formacion[] = $valor['nombre'];
            $litologia_imagen[] = $valor['imagen'];
        }
        $contador = 1;
        $tamanio = count($litologia_profundidad_desde);
        $plantilla->cloneRow('litologia.profundidad_desde', $tamanio);
        for ($i=0; $i < $tamanio; $i++) {
            $plantilla->setValue('litologia.profundidad_desde#'.$contador, $litologia_profundidad_desde[$i]);
            $plantilla->setValue('litologia.profundidad_hasta#'.$contador, $litologia_profundidad_hasta[$i]);
            $plantilla->setValue('litologia.formacion#'.$contador, htmlspecialchars($litologia_formacion[$i]));
            try{
                $plantilla->setImageValue('litologia.imagen#'.$contador, [
                    'path' => 'images/siasbo/textura/'.$litologia_imagen[$i],
                    'width' => 140,
                    'height' => 40,
                    'ratio' => true,
    
                ]);
            }catch(Exception $e){
                $plantilla->setValue('litologia.imagen#'.$contador, htmlspecialchars(''));
            }
            $contador++;
        }
        
        //Datos de perfilaje eléctrico
        $plantilla->setValue('field_electrico_fecha', $datos_general[0]['electrico_fecha']);
        $plantilla->setValue('field_electrico_profundidad', $datos_general[0]['electrico_profundidad']);
        $plantilla->setValue('field_electrico_diagnostico', $datos_general[0]['electrico_diagnostico']);
        
        //Datos de la prueba de bombeo
        $hidraulica_prueba = array();
        $hidraulica_conductividad = array();
        $hidraulica_transmisividad = array();
        $hidraulica_coeficiente = array();
        $hidraulica_radio = array();
        $hidraulica_porosidad = array();
        foreach ($datos_hidraulica as $clave => $valor) {
            $hidraulica_prueba[] = $valor['nombre'];
            $hidraulica_conductividad[] = $valor['conductividad'];
            $hidraulica_transmisividad[] = $valor['transmisividad'];
            $hidraulica_coeficiente[] = $valor['coeficiente'];
            $hidraulica_radio[] = $valor['radio'];
            $hidraulica_porosidad[] = $valor['porosidad'];
        }
        $contador = 1;
        $tamanio = count($hidraulica_conductividad);
        $plantilla->cloneRow('pb.prueba', $tamanio);
        for ($i=0; $i < $tamanio; $i++) {
            $plantilla->setValue('pb.prueba#'.$contador, htmlspecialchars($hidraulica_prueba[$i]));
            $plantilla->setValue('pb.conductivo#'.$contador, htmlspecialchars($hidraulica_conductividad[$i]));
            $plantilla->setValue('pb.transmisivo#'.$contador, htmlspecialchars($hidraulica_transmisividad[$i]));
            $plantilla->setValue('pb.coeficiente#'.$contador, htmlspecialchars($hidraulica_coeficiente[$i]));
            $plantilla->setValue('pb.radio#'.$contador, htmlspecialchars($hidraulica_radio[$i]));
            $plantilla->setValue('pb.porosidad#'.$contador, htmlspecialchars($hidraulica_porosidad[$i]));
            $contador++;
        }

        //Datos del tipo de bombeo
        $hidraulica_tipo = array();
        $hidraulica_fecha = array();
        $hidraulica_nivel_estatico = array();
        $hidraulica_nivel_dinamico = array();
        $hidraulica_duracion = array();
        $hidraulica_caudal = array();
        $hidraulica_profundidad = array();
        $hidraulica_potencia = array();
        foreach ($datos_hidraulico_tipo_bombeo as $clave => $valor) {
            $hidraulica_tipo[] = $valor['nombre'];
            $hidraulica_fecha[] = $valor['fecha'];
            $hidraulica_nivel_estatico[] = $valor['nivel_estatico'];
            $hidraulica_nivel_dinamico[] = $valor['nivel_dinamico'];
            $hidraulica_duracion[] = $valor['duracion'];
            $hidraulica_caudal[] = $valor['caudal'];
            $hidraulica_profundidad[] = $valor['profundidad'];
            $hidraulica_potencia[] = $valor['potencia'];
        }
        $contador = 1;
        $tamanio = count($hidraulica_tipo);
        $plantilla->cloneRow('tb.tipo', $tamanio);
        for ($i=0; $i < $tamanio; $i++) {
            $plantilla->setValue('tb.tipo#'.$contador, htmlspecialchars($hidraulica_tipo[$i]));
            $plantilla->setValue('tb.fecha#'.$contador, htmlspecialchars($hidraulica_fecha[$i]));
            $plantilla->setValue('tb.nivel_estatico#'.$contador, htmlspecialchars($hidraulica_nivel_estatico[$i]));
            $plantilla->setValue('tb.nivel_dinamico#'.$contador, htmlspecialchars($hidraulica_nivel_dinamico[$i]));
            $plantilla->setValue('tb.duracion#'.$contador, htmlspecialchars($this->segundos_tiempo($hidraulica_duracion[$i])));
            $plantilla->setValue('tb.caudal#'.$contador, htmlspecialchars($hidraulica_caudal[$i]));
            $plantilla->setValue('tb.profundidad#'.$contador, htmlspecialchars($hidraulica_profundidad[$i]));
            $plantilla->setValue('tb.potencia#'.$contador, htmlspecialchars($hidraulica_potencia[$i]));
            $contador++;
        }

        //Datos prueba de recuperación
        $hidraulico_fecha = array();
        $hidraulico_nivel_estatico = array();
        $hidraulico_nivel_dinamico = array();
        $hidraulico_duracion = array();
        foreach ($datos_hidraulico_recuperacion as $clave => $valor) {
            $hidraulico_fecha[] = $valor['fecha'];
            $hidraulico_nivel_estatico[] = $valor['nivel_estatico'];
            $hidraulico_nivel_dinamico[] = $valor['nivel_dinamico_final'];
            $hidraulico_duracion[] = $valor['duracion'];
        }
        $contador = 1;
        $tamanio = count($hidraulico_fecha);
        $plantilla->cloneRow('pr.fecha', $tamanio);
        for ($i=0; $i < $tamanio; $i++) {
            $plantilla->setValue('pr.fecha#'.$contador, htmlspecialchars($hidraulico_fecha[$i]));
            $plantilla->setValue('pr.nivel_estatico#'.$contador, htmlspecialchars($hidraulico_nivel_estatico[$i]));
            $plantilla->setValue('pr.nivel_dinamico#'.$contador, htmlspecialchars($hidraulico_nivel_dinamico[$i]));
            $plantilla->setValue('pr.duracion#'.$contador, htmlspecialchars($this->segundos_tiempo($hidraulico_duracion[$i])));
            $contador++;
        }

        //Datos de implementación
        $plantilla->setValue('field.imple_profundidad', $datos_general[0]['imple_profundidad']);
        $plantilla->setValue('field.imple_caudal', $datos_general[0]['imple_caudal']);
        $plantilla->setValue('field.imple_horario', $datos_general[0]['imple_horario_bombeo']);
        $plantilla->setValue('field.imple_potencia', $datos_general[0]['imple_potencia']);
        $plantilla->setValue('field.imple_tipo_energia', $catalogo_tipo_energia[$datos_general[0]['imple_tipoId']]);
        
        //Datos monitoreo de cantidad
        $monitoreo_cantidad_fecha = array();
        $monitoreo_cantidad_caudal = array();
        $monitoreo_cantidad_observacion = array();
        foreach ($datos_monitoreo_cantidad as $clave => $valor) {
            $monitoreo_cantidad_fecha[] = $valor['fecha'];
            $monitoreo_cantidad_nivel_freatico[] = $valor['nivel_freatico'];
            $monitoreo_cantidad_nivel_dinamico[] = $valor['nivel_dinamico'];
            $monitoreo_cantidad_nivel_estatico[] = $valor['nivel_estatico'];
            $monitoreo_cantidad_caudal[] = $valor['caudal'];
            $monitoreo_cantidad_observacion[] = $valor['observaciones'];
        }
        $contador = 1;
        $tamanio = count($monitoreo_cantidad_fecha);
        $plantilla->cloneRow('mc.fecha', $tamanio);
        for ($i=0; $i < $tamanio; $i++) {
            $plantilla->setValue('mc.fecha#'.$contador, htmlspecialchars($monitoreo_cantidad_fecha[$i]));
            $plantilla->setValue('mc.nivel_freatico#'.$contador, htmlspecialchars($monitoreo_cantidad_nivel_freatico[$i]));
            $plantilla->setValue('mc.nivel_dinamico#'.$contador, htmlspecialchars($monitoreo_cantidad_nivel_dinamico[$i]));
            $plantilla->setValue('mc.nivel_estatico#'.$contador, htmlspecialchars($monitoreo_cantidad_nivel_estatico[$i]));
            $plantilla->setValue('mc.caudal#'.$contador, htmlspecialchars($monitoreo_cantidad_caudal[$i]));
            $plantilla->setValue('mc.obs#'.$contador, htmlspecialchars($monitoreo_cantidad_observacion[$i]));
            $contador++;
        }

        //Datos monitoreo de calidad (muestreo y laboratorio)
        $monitoreo_calidad_fecha = array();
        $monitoreo_calidad_hora = array();
        $monitoreo_calidad_epoca = array();
        $monitoreo_calidad_entidad = array();
        $monitoreo_calidad_codigo = array();

        $monitoreo_calidad_fecha_analisis = array();
        $monitoreo_calidad_hora_analisis = array();
        $monitoreo_calidad_nombre_lab = array();
        $monitoreo_calidad_codigo_lab = array();
        $monitoreo_calidad_profundidad = array();
        $monitoreo_calidad_obs = array();
        $monitoreo_calidad_dato = array();

        foreach ($datos_monitoreo_calidad as $clave => $valor) {
            $monitoreo_calidad_fecha[] = $valor['fecha_muestreo'];
            $monitoreo_calidad_caudal[] = $valor['hora_muestreo'];
            $monitoreo_calidad_epoca[] = $valor['epocaId'];
            $monitoreo_calidad_entidad[] = $valor['entidad'];
            $monitoreo_calidad_codigo[] = $valor['codigo_muestra'];

            $monitoreo_calidad_fecha_analisis[] = $valor['fecha_analisis'];
            $monitoreo_calidad_hora_analisis[] = $valor['hora_analisis'];
            $monitoreo_calidad_nombre_lab[] = $valor['nombre_laboratorio'];
            $monitoreo_calidad_codigo_lab[] = $valor['codigo_laboratorio'];
            $monitoreo_calidad_profundidad[] = $valor['profundidad'];
            $monitoreo_calidad_obs[] = $valor['observaciones'];

            $monitoreo_calidad_dato_tipo = array();
            foreach($datos_monitoreo_calidad_dato as $dato){
                $id = $dato['calidadId'];
                if ($id == $valor['itemId']) {
                    $monitoreo_calidad_dato_tipo[] = $dato;
                }
            }
            $monitoreo_calidad_dato[] = $monitoreo_calidad_dato_tipo;
        }

        $contador = 1;
        $tamanio = count($monitoreo_calidad_fecha);
        $plantilla->cloneBlock('mcal.registros', $tamanio, true, true);
        for($i = 0 ; $i < $tamanio ; $i++){
            // Datos de muestreo
            $plantilla->setValue('mcal.fecha#'.$contador, htmlspecialchars($monitoreo_calidad_fecha[$i]));
            $plantilla->setValue('mcal.hora#'.$contador, htmlspecialchars($monitoreo_calidad_caudal[$i]));
            $plantilla->setValue('mcal.epoca#'.$contador, htmlspecialchars($catalogo_epoca[$monitoreo_calidad_epoca[$i]]));
            $plantilla->setValue('mcal.entidad#'.$contador, htmlspecialchars($monitoreo_calidad_entidad[$i]));
            $plantilla->setValue('mcal.codigo#'.$contador, htmlspecialchars($monitoreo_calidad_codigo[$i]));
            //Datos de laboratorio
            $plantilla->setValue('mcal.fecha_analisis#'.$contador, htmlspecialchars($monitoreo_calidad_fecha_analisis[$i]));
            $plantilla->setValue('mcal.hora_analisis#'.$contador, htmlspecialchars($monitoreo_calidad_hora_analisis[$i]));
            $plantilla->setValue('mcal.nombre_lab#'.$contador, htmlspecialchars($monitoreo_calidad_nombre_lab[$i]));
            $plantilla->setValue('mcal.codigo_lab#'.$contador, htmlspecialchars($monitoreo_calidad_codigo_lab[$i]));
            $plantilla->setValue('mcal.profundidad#'.$contador, htmlspecialchars($monitoreo_calidad_profundidad[$i]));
            $plantilla->setValue('mcal.obs#'.$contador, htmlspecialchars($monitoreo_calidad_obs[$i]));
            //Datos de parámetros
            $contadorj = 1;
            $tamanioj = count($monitoreo_calidad_dato[$i]);
            $plantilla->cloneRow('mcal.parametro#'.$contador, $tamanioj);
            for($j = 0 ; $j < $tamanioj ; $j++){
                $plantilla->setValue('mcal.parametro#'.$contador.'#'.$contadorj, htmlspecialchars($monitoreo_calidad_dato[$i][$j]['parametro']));
                $plantilla->setValue('mcal.compuesto#'.$contador.'#'.$contadorj, htmlspecialchars($monitoreo_calidad_dato[$i][$j]['compuesto']));
                $plantilla->setValue('mcal.valor#'.$contador.'#'.$contadorj, htmlspecialchars($monitoreo_calidad_dato[$i][$j]['valor']));
                $plantilla->setValue('mcal.observacion#'.$contador.'#'.$contadorj, htmlspecialchars($monitoreo_calidad_dato[$i][$j]['observaciones']));
                $contadorj++;
            }
            $contador++;
        }
        //Genera documento para su descarga
        //\PhpOffice\PhpWord\Settings::setPdfRendererPath('lib/tcpdf');
        //\PhpOffice\PhpWord\Settings::setPdfRendererName('TCPDF');
        //$plantilla->saveAs($nombre_archivo);
        /*$archivoTemporal = \PhpOffice\PhpWord\IOFactory::load('Ficha_1.docx');
        $xmlWriter = \PhpOffice\PhpWord\IOFactory::createWriter($archivoTemporal , 'PDF');
        $xmlWriter->save('Ficha_1.pdf', TRUE);*/
        header("Content-Description: File Transfer");
        header("Content-Disposition: attachment; filename=".$nombre_archivo); //." charset=iso-8859-1"
        header("Content-Type: application/vnd.openxmlformats-officedocument.wordprocessingml.document");
        header("Content-Transfer-Encoding: binary");
        header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
        header("Expires: 0");
        $plantilla->saveAs("php://output");
        echo file_get_contents($nombre_archivo);
        exit();
    }

    function get_datos_manantial($manantialId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT t1.*, t2.* 
        FROM 
        (SELECT a.itemId, a.codigo, a.nombre, a.epsasId, 
        b.nombre AS departamento, c.nombre AS provincia, d.nombre AS municipio,
        a.comunidadId, a.localidadId, a.comunidad, a.localidad, 
        a.latitudUtm, a.longitudUtm  
        FROM item a, 
        vrhr_territorio.departamento b, 
        vrhr_territorio.provincia c, 
        vrhr_territorio.municipio d 
        WHERE a.departamentoId=b.itemId 
        AND a.provinciaId=c.itemId 
        AND a.municipioId=d.itemId 
        AND a.itemId=".$manantialId.") t1
        LEFT JOIN 
        (SELECT c.itemId, c.fuente, c.codigo AS codigo_info, c.cantidad, c.propiedad_agua, 
        c.propiedad_terreno, c.administrador, c.observaciones, c.tipoId, c.permanenciaId, 
        c.usoaguaId, c.medioId, c.edad, c.litologia, c.estructura   
        FROM manantial c
        WHERE c.itemId=".$manantialId."
        LIMIT 1) t2 
        ON t1.itemId=t2.itemId 
        LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_datos_manantial_monitoreo_cantidad($manantialId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT DATE_FORMAT(fecha, '%d/%m/%Y') AS fecha, caudal, observaciones 
        FROM manantial_monitoreo 
        WHERE manantialId=".$manantialId." 
        ORDER BY itemId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_ficha_manantial($manantialId, $nombre_archivo) {
        //Crear documento a partir de plantilla
        $plantilla = new TemplateProcessor('template/siasbo/ficha_manantial/template_manantial.docx');

        //Consulta información a la base de datos
        $datos_general = $this->get_datos_manantial($manantialId);
        $datos_monitor_cantidad = $this->get_datos_manantial_monitoreo_cantidad($manantialId);

        //Consulta catálogos a la base de datos
        $catalogo_comunidad = $this->get_catalogo_comunidad();
        $catalogo_localidad = $this->get_catalogo_localidad();
        $catalogo_tipo_manantial = $this->get_catalogo_tipo_manantial();
        $catalogo_permanencia = $this->get_catalogo_permanencia();
        $catalogo_uso_agua = $this->get_catalogo_uso_agua_manantial();
        $catalogo_medio_surgencia = $this->get_catalogo_medio_surgencia();

        //Reemplaza variables de plantilla con datos
        $plantilla->setValue('field_nombre', $datos_general[0]['nombre']);
        $plantilla->setValue('field_codigo', $datos_general[0]['codigo']);
        $plantilla->setValue('field_depto', $datos_general[0]['departamento']);
        $plantilla->setValue('field_provincia', $datos_general[0]['provincia']);
        $plantilla->setValue('field_municipio', $datos_general[0]['municipio']);
        if ($datos_general[0]['comunidadId'] != '' && $datos_general[0]['comunidadId'] != 0) {
            $plantilla->setValue('field_comunidad', $catalogo_comunidad[$datos_general[0]['comunidadId']]);
        } else {
            $plantilla->setValue('field_comunidad', $datos_general[0]['comunidad']);
        }
        if ($datos_general[0]['localidadId'] != '' && $datos_general[0]['localidadId'] != 0) {
            $plantilla->setValue('field_localidad', $catalogo_comunidad[$datos_general[0]['localidadId']]);
        } else {
            $plantilla->setValue('field_localidad', $datos_general[0]['localidad']);
        }
        $plantilla->setValue('field_utm_este', $datos_general[0]['latitudUtm']);
        $plantilla->setValue('field_utm_norte', $datos_general[0]['longitudUtm']);

        $plantilla->setValue('field_fuente_info', $datos_general[0]['fuente']);
        $plantilla->setValue('field_codigo_info', $datos_general[0]['codigo_info']);
        $plantilla->setValue('field_cantidad', $datos_general[0]['cantidad']);
        $plantilla->setValue('field_propiedad_agua', $datos_general[0]['propiedad_agua']);
        $plantilla->setValue('field_propiedad_terreno', $datos_general[0]['propiedad_terreno']);
        $plantilla->setValue('field_administrador', $datos_general[0]['administrador']);
        $plantilla->setValue('field_obs', $datos_general[0]['observaciones']);
        $plantilla->setValue('field_tipo', $catalogo_tipo_manantial[$datos_general[0]['tipoId']]);
        $plantilla->setValue('field_permanencia', $catalogo_permanencia[$datos_general[0]['permanenciaId']]);
        $datos_uso = explode(',', $datos_general[0]['usoaguaId']);
        $uso = '';
        foreach ($datos_uso as $clave => $valor) {
            $uso .= $catalogo_uso_agua[$valor].', ';
        }
        $plantilla->setValue('field_uso_agua', rtrim($uso, ', '));
        $plantilla->setValue('field_medio', $catalogo_medio_surgencia[$datos_general[0]['medioId']]);
        $plantilla->setValue('field_edad', $datos_general[0]['edad']);
        $plantilla->setValue('field_litologia', $datos_general[0]['litologia']);
        $plantilla->setValue('field_estructura', $datos_general[0]['estructura']);

        $monitor_cantidad_fecha = array();
        $monitor_cantidad_caudal = array();
        $monitor_cantidad_obs = array();
        foreach ($datos_monitor_cantidad as $clave => $valor) {
            $monitor_cantidad_fecha[] = $valor['fecha'];
            $monitor_cantidad_caudal[] = $valor['caudal'];
            $monitor_cantidad_obs[] = $valor['observaciones'];
        }
        
        $contador = 1;
        $tamanio = count($monitor_cantidad_fecha);
        $plantilla->cloneRow('cantidad.fecha', $tamanio);
        for ($i=0; $i < $tamanio; $i++) {
            $plantilla->setValue('cantidad.fecha#'.$contador, htmlspecialchars($monitor_cantidad_fecha[$clave]));
            $plantilla->setValue('cantidad.caudal#'.$contador, htmlspecialchars($monitor_cantidad_caudal[$clave]));
            $plantilla->setValue('cantidad.obs#'.$contador, htmlspecialchars($monitor_cantidad_obs[$clave]));
            $contador++;
        }

        //Genera documento para su descarga
        header("Content-Description: File Transfer");
        header("Content-Disposition: attachment; filename=".$nombre_archivo); //." charset=iso-8859-1"
        header("Content-Type: application/vnd.openxmlformats-officedocument.wordprocessingml.document");
        header("Content-Transfer-Encoding: binary");
        header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
        header("Expires: 0");
        $plantilla->saveAs("php://output");
        echo file_get_contents($nombre_archivo);
        exit();
    }

    function get_datos_captacion_superficial($captacionId) {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT t1.*, t2.* 
        FROM 
        (SELECT a.itemId, a.codigo, a.nombre, a.epsasId, 
        b.nombre AS departamento, c.nombre AS provincia, d.nombre AS municipio,
        a.comunidadId, a.localidadId, a.comunidad, a.localidad, 
        a.latitudUtm, a.longitudUtm  
        FROM item a, 
        vrhr_territorio.departamento b, 
        vrhr_territorio.provincia c, 
        vrhr_territorio.municipio d 
        WHERE a.departamentoId=b.itemId 
        AND a.provinciaId=c.itemId 
        AND a.municipioId=d.itemId 
        AND a.itemId=".$captacionId.") t1
        LEFT JOIN 
        (SELECT c.itemId, c.fuente, c.codigo AS codigo_info, DATE_FORMAT(c.fechainicio, '%d/%m/%Y') AS fechainicio, c.conexionesagua, 
        c.coberturaagua, c.numero, c.caudal, c.almacenamiento, c.capacidad, c.aduccion, c.red, 
        c.area, c.captaobservacion 
        FROM item_captacion_superficial c
        WHERE c.itemId=".$captacionId."
        LIMIT 1) t2 
        ON t1.itemId=t2.itemId 
        LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_ficha_captacion_superficial($captacionId, $nombre_archivo) {
        //Crear documento a partir de plantilla
        $plantilla = new TemplateProcessor('template/siasbo/ficha_captacion/template_captacion.docx');

        //Consulta información a la base de datos
        $datos_general = $this->get_datos_captacion_superficial($captacionId);

        //Consulta catálogos a la base de datos
        $catalogo_comunidad = $this->get_catalogo_comunidad();
        $catalogo_localidad = $this->get_catalogo_localidad();

        //Reemplaza variables de plantilla con datos
        $plantilla->setValue('field_nombre', $datos_general[0]['nombre']);
        $plantilla->setValue('field_codigo', $datos_general[0]['codigo']);
        $plantilla->setValue('field_depto', $datos_general[0]['departamento']);
        $plantilla->setValue('field_provincia', $datos_general[0]['provincia']);
        $plantilla->setValue('field_municipio', $datos_general[0]['municipio']);
        if ($datos_general[0]['comunidadId'] != '' && $datos_general[0]['comunidadId'] != 0) {
            $plantilla->setValue('field_comunidad', $catalogo_comunidad[$datos_general[0]['comunidadId']]);
        } else {
            $plantilla->setValue('field_comunidad', $datos_general[0]['comunidad']);
        }
        if ($datos_general[0]['localidadId'] != '' && $datos_general[0]['localidadId'] != 0) {
            $plantilla->setValue('field_localidad', $catalogo_comunidad[$datos_general[0]['localidadId']]);
        } else {
            $plantilla->setValue('field_localidad', $datos_general[0]['localidad']);
        }
        $plantilla->setValue('field_utm_este', $datos_general[0]['latitudUtm']);
        $plantilla->setValue('field_utm_norte', $datos_general[0]['longitudUtm']);

        $plantilla->setValue('field_fuente_info', $datos_general[0]['fuente']);
        $plantilla->setValue('field_codigo_info', $datos_general[0]['codigo_info']);

        $plantilla->setValue('field_fecha', $datos_general[0]['fechainicio']);
        $plantilla->setValue('field_conexiones', $datos_general[0]['conexionesagua']);
        $plantilla->setValue('field_cobertura', $datos_general[0]['coberturaagua']);
        $plantilla->setValue('field_num_fuente', $datos_general[0]['numero']);
        $plantilla->setValue('field_caudal_fuente', $datos_general[0]['caudal']);
        $plantilla->setValue('field_tipo', $datos_general[0]['almacenamiento']);
        $plantilla->setValue('field_capacidad', $datos_general[0]['capacidad']);
        $plantilla->setValue('field_aduccion', $datos_general[0]['aduccion']);
        $plantilla->setValue('field_red', $datos_general[0]['red']);
        $plantilla->setValue('field_area', $datos_general[0]['area']);
        $plantilla->setValue('field_obs', $datos_general[0]['captaobservacion']);

        //Genera documento para su descarga
        header("Content-Description: File Transfer");
        header("Content-Disposition: attachment; filename=".$nombre_archivo." charset=iso-8859-1");
        header("Content-Type: application/vnd.openxmlformats-officedocument.wordprocessingml.document");
        header("Content-Transfer-Encoding: binary");
        header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
        header("Expires: 0");
        $plantilla->saveAs("php://output");
        echo file_get_contents($nombre_archivo);
        exit();
    }

    //Catálogos de pozo
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

    //Catálogos de manantial
    function get_catalogo_tipo_manantial() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_manantial_tipo";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_medio_surgencia() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_manantial_medio";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_permanencia() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_manantial_permanencia";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_uso_agua_manantial() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_manantial_usoagua";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    function get_catalogo_epoca() {
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT itemId, nombre
        FROM catalogo_epoca";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        $catalogo_datos = array();
        foreach ($datos as $clave => $valor) {
            $catalogo_datos[$valor['itemId']] = $valor['nombre'];
        }
        unset($datos);
        return $catalogo_datos;
    }

    //FICHA GEOFISICA SEV
    function get_fichageosev($pozoId, $nombre_archivo) {

        $plantilla = new TemplateProcessor('template/siasbo/ficha_geofisica/template_geofisica_sev.docx');

        $datos_general = $this->get_datos_generales($pozoId);
        $datos_sev = $this->get_datos_sev($pozoId);
        $valores[] = $datos_sev[0]['sev_configId'];
        if ($datos_sev[0]['sev_configId'] != "" && $datos_sev[0]['sev_configId'] != NULL){
            $datos_config = $this->get_datos_sev_configuracion($valores);
            $cont = count($datos_config);
        }
        if ($datos_sev[0]['sev_lineabaseId'] != "" && $datos_sev[0]['sev_lineabaseId'] != NULL){
            $datos_lineabase = $this->get_datos_sev_lineabase($datos_sev[0]['sev_lineabaseId']);
        }else{
            $datos_lineabase = "";
        }
        
        $plantilla->setValue('field_nombre', $datos_general[0]['nombre']);
        $plantilla->setValue('field_codigo', $datos_general[0]['codigo']);
        $plantilla->setValue('field_depto', $datos_general[0]['departamento']);
        $plantilla->setValue('field_provincia', $datos_general[0]['provincia']);
        $plantilla->setValue('field_municipio', $datos_general[0]['municipio']);
        if ($datos_general[0]['comunidadId'] != '' && $datos_general[0]['comunidadId'] != 0) {
            $plantilla->setValue('field_comunidad', $catalogo_comunidad[$datos_general[0]['comunidadId']]);
        } else {
            $plantilla->setValue('field_comunidad', $datos_general[0]['comunidad']);
        }
        if ($datos_general[0]['localidadId'] != '' && $datos_general[0]['localidadId'] != 0) {
            $plantilla->setValue('field_localidad', $catalogo_comunidad[$datos_general[0]['localidadId']]);
        } else {
            $plantilla->setValue('field_localidad', $datos_general[0]['localidad']);
        }
        $plantilla->setValue('field_utm_este', $datos_general[0]['latitudUtm']);
        $plantilla->setValue('field_utm_norte', $datos_general[0]['longitudUtm']);

        $plantilla->setValue('field_informacion', $datos_sev[0]['fuente']);
        $plantilla->setValue('field_estudio', $datos_sev[0]['codigo_sev']);
        $plantilla->setValue('field_fecha', $datos_sev[0]['fecha']);
        $plantilla->setValue('field_campania', $datos_sev[0]['campania']);
        $plantilla->setValue('field_software', $datos_sev[0]['software_utilizado']);
        $plantilla->setValue('field_equipo', $datos_sev[0]['equipo']);
        $plantilla->setValue('field_azimut', $datos_sev[0]['sev_azimut']);
        $plantilla->setValue('field_abmaximo', $datos_sev[0]['sev_abmax']);
        $plantilla->setValue('field_error', $datos_sev[0]['sev_error']);
        if ($datos_sev[0]['sev_configId'] != "" && $datos_sev[0]['sev_configId'] != NULL){
            for ($i=0; $i<=$cont-1 ; $i++){
                $valor = $valor.$datos_config[$i]['nombre'].", ";
            }

            $plantilla->setValue('field_config', $valor);
        }else{
            $plantilla->setValue('field_config', "");
        }
        $plantilla->setValue('field_direccion', $datos_lineabase);

        //\PhpOffice\PhpWord\Settings::setPdfRendererPath('lib/tcpdf');
        //\PhpOffice\PhpWord\Settings::setPdfRendererName('TCPDF');

        //$plantilla->saveAs($nombre_archivo);

        /*$archivoTemporal = \PhpOffice\PhpWord\IOFactory::load('Ficha_1.docx');
        $xmlWriter = \PhpOffice\PhpWord\IOFactory::createWriter($archivoTemporal , 'PDF');
        $xmlWriter->save('Ficha_1.pdf', TRUE);*/
        
        header("Content-Description: File Transfer");
        header("Content-Disposition: attachment; filename=".$nombre_archivo); //." charset=iso-8859-1"
        header("Content-Type: application/vnd.openxmlformats-officedocument.wordprocessingml.document");
        header("Content-Transfer-Encoding: binary");
        header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
        header("Expires: 0");
        $plantilla->saveAs("php://output");
        echo file_get_contents($nombre_archivo);
        exit();

        /*header("Content-Description: File Transfer");
        header('Content-Disposition: attachment; filename=".$nombre_archivo." charset=iso-8859-1');
        header('Content-Type: application/pdf');
        header('Content-Transfer-Encoding: binary');
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
        header('Expires: 0');
        echo file_get_contents($nombre_archivo);
        exit();*/
    }

    function get_datos_generales($pozoId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.itemId, a.codigo, a.nombre, 
        b.nombre AS departamento, c.nombre AS provincia, d.nombre AS municipio,
        a.comunidadId, a.localidadId, a.comunidad, a.localidad, 
        a.latitudUtm, a.longitudUtm  
        FROM item a, 
        vrhr_territorio.departamento b, 
        vrhr_territorio.provincia c, 
        vrhr_territorio.municipio d  
        WHERE a.departamentoId=b.itemId 
        AND a.provinciaId=c.itemId 
        AND a.municipioId=d.itemId 
        AND a.itemId=".$pozoId." 
        LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_datos_sev($pozoId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.itemId, a.fuente, a.codigo AS codigo_sev, DATE_FORMAT(a.fecha, '%d/%m/%Y') AS fecha, a.campania, 
        a.sev_lineabaseId, a.sev_azimut, a.sev_configId, a.sev_abmax, a.software_utilizado, a.equipo, a.sev_error 
        FROM item_geofisica a 
        WHERE a.geofisicaId=".$pozoId."
        LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_datos_sev_configuracion($datos){
        $indices = implode(",", $datos);
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.nombre  
        FROM catalogo_geofisica_dev_config a 
        WHERE a.itemId IN (".$indices.") ORDER BY a.itemId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_datos_sev_lineabase($datos){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.nombre  
        FROM catalogo_geofisica_dev_lineabase a 
        WHERE a.itemId=".$datos;
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    //FICHA GEOFISICA TOMOGRAFIA
    function get_fichageotomografia($pozoId, $nombre_archivo) {

        $plantilla = new TemplateProcessor('template/siasbo/ficha_geofisica/template_geofisica_tomografia.docx');

        $datos_general = $this->get_datos_generales($pozoId);
        $datos_tomografia = $this->get_datos_tomografia($pozoId);
        $valores[] = $datos_tomografia[0]['tomografia_configId'];
        if ($datos_tomografia[0]['tomografia_configId'] != "" && $datos_tomografia[0]['tomografia_configId'] != NULL){
            $datos_config = $this->get_datos_tomografia_configuracion($valores);
            $cont = count($datos_config);
        }        

        $plantilla->setValue('field_nombre', $datos_general[0]['nombre']);
        $plantilla->setValue('field_codigo', $datos_general[0]['codigo']);
        $plantilla->setValue('field_depto', $datos_general[0]['departamento']);
        $plantilla->setValue('field_provincia', $datos_general[0]['provincia']);
        $plantilla->setValue('field_municipio', $datos_general[0]['municipio']);
        if ($datos_general[0]['comunidadId'] != '' && $datos_general[0]['comunidadId'] != 0) {
            $plantilla->setValue('field_comunidad', $catalogo_comunidad[$datos_general[0]['comunidadId']]);
        } else {
            $plantilla->setValue('field_comunidad', $datos_general[0]['comunidad']);
        }
        if ($datos_general[0]['localidadId'] != '' && $datos_general[0]['localidadId'] != 0) {
            $plantilla->setValue('field_localidad', $catalogo_comunidad[$datos_general[0]['localidadId']]);
        } else {
            $plantilla->setValue('field_localidad', $datos_general[0]['localidad']);
        }
        $plantilla->setValue('field_utm_este', $datos_general[0]['latitudUtm']);
        $plantilla->setValue('field_utm_norte', $datos_general[0]['longitudUtm']);

        $plantilla->setValue('field_informacion', $datos_tomografia[0]['fuente']);
        $plantilla->setValue('field_estudio', $datos_tomografia[0]['codigo_sev']);
        $plantilla->setValue('field_fecha', $datos_tomografia[0]['fecha']);
        $plantilla->setValue('field_campania', $datos_tomografia[0]['campania']);
        $plantilla->setValue('field_software', $datos_tomografia[0]['software_utilizado']);
        $plantilla->setValue('field_equipo', $datos_tomografia[0]['equipo']);
        if ($datos_tomografia[0]['tomografia_configId'] != "" && $datos_tomografia[0]['tomografia_configId'] != NULL){
            for ($i=0; $i<=$cont-1 ; $i++){
                $valor = $valor.$datos_config[$i]['nombre'].", ";
            }

            $plantilla->setValue('field_config', $valor);
        }else{
            $plantilla->setValue('field_config', "");
        }       
        $plantilla->setValue('field_electrodos', $datos_tomografia[0]['tomografia_electrodos']);
        $plantilla->setValue('field_abertura', $datos_tomografia[0]['tomografia_abertura']);
        $plantilla->setValue('field_observaciones', $datos_tomografia[0]['observaciones']);

        //\PhpOffice\PhpWord\Settings::setPdfRendererPath('lib/tcpdf');
        //\PhpOffice\PhpWord\Settings::setPdfRendererName('TCPDF');

        //$plantilla->saveAs($nombre_archivo);

        /*$archivoTemporal = \PhpOffice\PhpWord\IOFactory::load('Ficha_1.docx');
        $xmlWriter = \PhpOffice\PhpWord\IOFactory::createWriter($archivoTemporal , 'PDF');
        $xmlWriter->save('Ficha_1.pdf', TRUE);*/
        
        header("Content-Description: File Transfer");
        header("Content-Disposition: attachment; filename=".$nombre_archivo); //." charset=iso-8859-1"
        header("Content-Type: application/vnd.openxmlformats-officedocument.wordprocessingml.document");
        header("Content-Transfer-Encoding: binary");
        header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
        header("Expires: 0");
        $plantilla->saveAs("php://output");
        echo file_get_contents($nombre_archivo);
        exit();

        /*header("Content-Description: File Transfer");
        header('Content-Disposition: attachment; filename=".$nombre_archivo." charset=iso-8859-1');
        header('Content-Type: application/pdf');
        header('Content-Transfer-Encoding: binary');
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
        header('Expires: 0');
        echo file_get_contents($nombre_archivo);
        exit();*/
    }

    function get_datos_tomografia($pozoId){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.itemId, a.fuente, a.codigo AS codigo_sev, DATE_FORMAT(a.fecha, '%d/%m/%Y') AS fecha, a.campania, 
        a.tomografia_configId, a.tomografia_electrodos, a.tomografia_abertura, a.software_utilizado, a.equipo, a.observaciones 
        FROM item_geofisica a 
        WHERE a.geofisicaId=".$pozoId." 
        LIMIT 1";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function get_datos_tomografia_configuracion($datos){
        $indices = implode(",", $datos);
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $sql = "SELECT a.nombre  
        FROM catalogo_geofisica_tomografia_config a 
        WHERE a.itemId IN (".$indices.") ORDER BY a.itemId ASC";
        $datos = $this->dbm->Execute($sql);
        $datos = $datos->GetRows();
        return $datos;
    }

    function segundos_tiempo($segundos) {
        $tiempo = NULL;
        $horas = floor($segundos / 3600);
        $minutos = floor(($segundos - ($horas * 3600)) / 60);
        $segs = $segundos - ($horas * 3600) - ($minutos * 60);
        $tiempo = $horas.'h '.$minutos.'m '.$segs.'s';
        return $tiempo;
    }
}