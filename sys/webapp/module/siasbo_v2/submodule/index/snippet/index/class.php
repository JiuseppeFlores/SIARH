<?php
/**
 * Created by PhpStorm.
 * User: henrytaby
 * Date: 3/5/2018
 * Time: 15:23
 */

/**
 * Modified by SublimeText 2.
 * User: Edwin Callisaya Bautista
 * Date: 01/07/2018
 * Time: 09:00
 */

class Index extends Table {

    function __construct() {
        $this->submodule_init_sbm();
    }

    public function get_all_rows() {
        
        $resultado = [
            1 => [
                'nombre' => 'CATÁLOGO TIPOS DE MANANTIAL',
                'ruta' => 'siasbo_catalogo_tipo_manantial'
            ],
            [
                'nombre' => 'CATÁLOGO TIPOS DE SURGENCIA EN MANANTIAL',
                'ruta' => 'siasbo_catalogo_tipo_surgencia_manantial'
            ],
            [
                'nombre' => 'CATÁLOGO PERMANENCIA DE MANANTIAL',
                'ruta' => 'siasbo_catalogo_manantial_permanencia'
            ],
            [
                'nombre' => 'CATÁLOGO USO DE AGUA',
                'ruta' => 'siasbo_catalogo_uso_agua'
            ],
            [
                'nombre' => 'CATÁLOGO PROPÓSITO DE POZO',
                'ruta' => 'siasbo_catalogo_proposito_pozo'
            ],
            [
                'nombre' => 'CATÁLOGO TIPOS DE ENERGÍA',
                'ruta' => 'siasbo_catalogo_energia_tipo'
            ],
            [
                'nombre' => 'CATÁLOGO ESTADOS DE PERMEABILIDAD',
                'ruta' => 'siasbo_catalogo_estado_permeabilidad'
            ],
            [
                'nombre' => 'CATÁLOGO TIPOS DE REJILLA',
                'ruta' => 'siasbo_catalogo_tipo_rejilla'
            ],
            [
                'nombre' => 'CATÁLOGO TIPOS DE SELLO SANITARIO ',
                'ruta' => 'siasbo_catalogo_tipo_sello_sanitario'
            ],
            [
                'nombre' => 'CATÁLOGO TIPOS DE TUBERÍA',
                'ruta' => 'siasbo_catalogo_tipo_tuberia'
            ],
            [
                'nombre' => 'CATÁLOGO MÉTODOS DE PERFORACIÓN',
                'ruta' => 'siasbo_catalogo_metodo_perforacion'
            ],
            [
                'nombre' => 'CATÁLOGO TIPOS DE PRUEBA DE BOMBEO',
                'ruta' => 'siasbo_catalogo_tipo_prueba_bombeo'
            ],
            [
                'nombre' => 'CATÁLOGO TIPOS DE POZO',
                'ruta' => 'siasbo_catalogo_tipo_pozo'
            ],
            [
                'nombre' => 'CATÁLOGO TIPOS DE PERFORACIÓN',
                'ruta' => 'siasbo_catalogo_tipo_perforacion'
            ],
            [
                'nombre' => 'CATÁLOGO TIPOS DE PARÁMETRO',
                'ruta' => 'siasbo_catalogo_tipo_parametros'
            ],
            [
                'nombre' => 'CATÁLOGO TIPOS DE DIRECCIÓN DE LINEA BASE',
                'ruta' => 'siasbo_catalogo_tipo_linea_base'
            ],
            [
                'nombre' => 'CATÁLOGO TIPOS DE CONFIGURACIÓN',
                'ruta' => 'siasbo_catalogo_tipo_configuracion'
            ],
            [
                'nombre' => 'CATÁLOGO ÉPOCA',
                'ruta' => 'siasbo_catalogo_epoca'
            ]            
        ];

        return $resultado;
    }

}