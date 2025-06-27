<?php
include './lib/phpexcel/Classes/PHPExcel/IOFactory.php';
include './lib/phpexcel/Classes/PHPExcel.php';
/**
 * User: henrytaby
 * Date: 3/5/2018
 * Time: 15:22
 */

class Subcatalogo extends Table {

    function __construct() {
        /**
         * Inicializamos todas las librerias y variables para el submodulo
         */
        $this->submodule_init_sbm();

    }

    public function conf_catalog_datos_general() {

        $this->addCatalogList($this->tabla["c_acuifero"],"acuifero","","","","","","");

    }
    function valoresRMCH(){
        return array(
            '5' => array(
                'item' => 1,
                'nombre' => 'Conductividad',
                'unidad' => 'µS/cm',
                'claseA' => array(
                    'min' => 0,
                    'max' => 140),
                'claseB' => array(
                    'min' => 140,
                    'max' => 300),
                'claseC' => array(
                    'min' => 300,
                    'max' => 500),
                'claseD' => array(
                    'min' => 500,
                    'max' => 1600)),
            '7' => array(
                'item' => 2,
                'nombre' => 'Oxigeno disuelto (c/O2 saturación)',
                'unidad' => '%',
                'claseA' => array(
                    'min' => 80,
                    'max' => 100),
                'claseB' => array(
                    'min' => 70,
                    'max' => 80),
                'claseC' => array(
                    'min' => 60,
                    'max' => 70),
                'claseD' => array(
                    'min' => 50,
                    'max' => 60)),
            '8' => array(
                'item' => 3,
                'nombre' => 'pH',
                'unidad' => '',
                'claseA' => array(
                    'min' => 6,
                    'max' => 8.5),
                'claseB' => array(
                    'min' => 8.5,
                    'max' => 9),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '27' => array(
                'item' => 4,
                'nombre' => 'Solidos disueltos totales',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 1000),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => 1000,
                    'max' => 1500),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '30' => array(
                'item' => 5,
                'nombre' => 'Solidos sedimentarios',
                'unidad' => 'mg/L|mL/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 10),
                'claseB' => array(
                    'min' => 10,
                    'max' => 30),
                'claseC' => array(
                    'min' => 30,
                    'max' => 50),
                'claseD' => array(
                    'min' => 50,
                    'max' => 100)),
            '31' => array(
                'item' => 5,
                'nombre' => 'Solidos sedimentarios',
                'unidad' => 'mg/L|mL/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 10),
                'claseB' => array(
                    'min' => 10,
                    'max' => 30),
                'claseC' => array(
                    'min' => 30,
                    'max' => 50),
                'claseD' => array(
                    'min' => 50,
                    'max' => 100)),
            '28' => array(
                'item' => 6,
                'nombre' => 'Sólidos suspendidos totales',
                'unidad' => '',
                'claseA' => array(
                    'min' => 0,
                    'max' => 1),
                'claseB' => array(
                    'min' => 1,
                    'max' => 10),
                'claseC' => array(
                    'min' => 10,
                    'max' => 100),
                'claseD' => array(
                    'min' => 100,
                    'max' => 200)),
            '11' => array(
                'item' => 7,
                'nombre' => 'Temperatura (diferencia con el c. receptor)',
                'unidad' => '°C',
                'claseA' => array(
                    'min' => -3,
                    'max' => 3),
                'claseB' => array(
                    'min' => -3,
                    'max' => 3),
                'claseC' => array(
                    'min' => -3,
                    'max' => 3),
                'claseD' => array(
                    'min' => -3,
                    'max' => 3)),
            '34' => array(
                'item' => 8,
                'nombre' => 'Turbidez',
                'unidad' => 'UNT',
                'claseA' => array(
                    'min' => 0,
                    'max' => 10),
                'claseB' => array(
                    'min' => 10,
                    'max' => 50),
                'claseC' => array(
                    'min' => 50,
                    'max' => 100),
                'claseD' => array(
                    'min' => 100,
                    'max' => 200)),
            '19' => array(
                'item' => 9,
                'nombre' => 'z_Color (c/Pt)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 10),
                'claseB' => array(
                    'min' => 10,
                    'max' => 50),
                'claseC' => array(
                    'min' => 50,
                    'max' => 100),
                'claseD' => array(
                    'min' => 100,
                    'max' => 200)),
            '35' => array(
                'item' => 11,
                'nombre' => 'Aluminio (c/Al)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.2),
                'claseB' => array(
                    'min' => 0.2,
                    'max' => 0.5),
                'claseC' => array(
                    'min' => 0.5,
                    'max' => 1),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '39' => array(
                'item' => 12,
                'nombre' => 'Antimonio (c/Sb)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.01),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '41' => array(
                'item' => 13,
                'nombre' => 'Arsenico total (c/As)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.05),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => 0.05,
                    'max' => 0.1)),
            '44' => array(
                'item' => 14,
                'nombre' => 'Bario (c/Ba)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 1),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => 1,
                    'max' => 2),
                'claseD' => array(
                    'min' => 2,
                    'max' => 5)),
            '46' => array(
                'item' => 15,
                'nombre' => 'Berilio (c/Be)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.001),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '48' => array(
                'item' => 16,
                'nombre' => 'Boro (c/B)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 1),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '54' => array(
                'item' => 17,
                'nombre' => 'Calcio (c/Ca)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 200),
                'claseB' => array(
                    'min' => 200,
                    'max' => 300),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => 300,
                    'max' => 400)),
            '52' => array(
                'item' => 18,
                'nombre' => 'Cadmio (c/Cd)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.005),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '61' => array(
                'item' => 19,
                'nombre' => 'Cobre (c/Cu)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.05),
                'claseB' => array(
                    'min' => 0.05,
                    'max' => 1),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '60' => array(
                'item' => 20,
                'nombre' => 'Cobalto (c/Co)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.1),
                'claseB' => array(
                    'min' => 0.1,
                    'max' => 0.2),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '65' => array(
                'item' => 21,
                'nombre' => 'Cromo Hexavalente (c/Cr6+)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.05),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '66' => array(
                'item' => 22,
                'nombre' => 'Conductividad',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.12),
                'claseB' => array(
                    'min' => 0.12,
                    'max' => 0.6),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => 0.6,
                    'max' => 1.1)),
            '67' => array(
                'item' => 23,
                'nombre' => 'Estaño (c/Sn)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 2),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '73' => array(
                'item' => 24,
                'nombre' => 'Hierro Soluble (c/Fe)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.3),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => 0.3,
                    'max' => 1),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '74' => array(
                'item' => 25,
                'nombre' => 'Litio (c/Li)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 2.5),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => 2.5,
                    'max' => 5)),
            '75' => array(
                'item' => 26,
                'nombre' => 'Magnesio (c/Mg)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 100),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => 100,
                    'max' => 150),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '76' => array(
                'item' => 27,
                'nombre' => 'Manganeso (c/Mn)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.5),
                'claseB' => array(
                    'min' => 0.5,
                    'max' => 1),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '78' => array(
                'item' => 28,
                'nombre' => 'Mercurio (c/Hg)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.001),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '81' => array(
                'item' => 29,
                'nombre' => 'Niquel (c/Ni)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.05),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => 0.05,
                    'max' => 0.5),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '87' => array(
                'item' => 30,
                'nombre' => 'Plata (c/Ag)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.05),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '88' => array(
                'item' => 31,
                'nombre' => 'Plomo (c/Pb)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.05),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => 0.05,
                    'max' => 0.1)),
            '91' => array(
                'item' => 32,
                'nombre' => 'Selenio (c/Se)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.01),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => 0.01,
                    'max' => 0.05)),
            '93' => array(
                'item' => 33,
                'nombre' => 'Sodio (c/Na)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 200),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '96' => array(
                'item' => 34,
                'nombre' => 'Uranio total (c/U)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.02),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '97' => array(
                'item' => 35,
                'nombre' => 'Vanadio (c/V)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.1),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '99' => array(
                'item' => 36,
                'nombre' => 'Zinc (c/Zn)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.2),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => 0.2,
                    'max' => 5),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '37' => array(
                'item' => 37,
                'nombre' => 'Amoniaco (c/NH3)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.05),
                'claseB' => array(
                    'min' => 0.05,
                    'max' => 1),
                'claseC' => array(
                    'min' => 1,
                    'max' => 2),
                'claseD' => array(
                    'min' => 2,
                    'max' => 4)),
            '56' => array(
                'item' => 38,
                'nombre' => 'Cianuros (c/CN)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.02),
                'claseB' => array(
                    'min' => 0.02,
                    'max' => 1),
                'claseC' => array(
                    'min' => 1,
                    'max' => 2),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '59' => array(
                'item' => 39,
                'nombre' => 'Cloruros (c/Cl)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 250),
                'claseB' => array(
                    'min' => 250,
                    'max' => 300),
                'claseC' => array(
                    'min' => 300,
                    'max' => 400),
                'claseD' => array(
                    'min' => 400,
                    'max' => 500)),
            '70' => array(
                'item' => 40,
                'nombre' => 'Fluoruros (c/F)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.6),
                'claseB' => array(
                    'min' => 0.6,
                    'max' => 0.7),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '71' => array(
                'item' => 41,
                'nombre' => 'Fosfato Total (c/PO43-)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.4),
                'claseB' => array(
                    'min' => 0.4,
                    'max' => 0.5),
                'claseC' => array(
                    'min' => 0.5,
                    'max' => 1),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '83' => array(
                'item' => 42,
                'nombre' => 'Nitrato (c/NO3-)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 20),
                'claseB' => array(
                    'min' => 20,
                    'max' => 50),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '84' => array(
                'item' => 43,
                'nombre' => 'Nitrito (c/N)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 1),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '85' => array(
                'item' => 44,
                'nombre' => 'Nitrogeno total (c/N)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 5),
                'claseB' => array(
                    'min' => 5,
                    'max' => 12),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '94' => array(
                'item' => 45,
                'nombre' => 'Sulfatos (c/SO4)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 300),
                'claseB' => array(
                    'min' => 300,
                    'max' => 400),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '95' => array(
                'item' => 46,
                'nombre' => 'Sulfuros (c/S)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.1),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => 0.1,
                    'max' => 0.5),
                'claseD' => array(
                    'min' => 0.5,
                    'max' => 1)),
            '108' => array(
                'item' => 47,
                'nombre' => 'Benceno (c/C6H6)',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 2),
                'claseB' => array(
                    'min' => 2,
                    'max' => 6),
                'claseC' => array(
                    'min' => 6,
                    'max' => 10),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '103' => array(
                'item' => 48,
                'nombre' => '1.2 Dicloroetano (C2H4Cl2)',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 10),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '102' => array(
                'item' => 49,
                'nombre' => '1.1 Dicloroetileno (C2H2Cl2)',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.3),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '121' => array(
                'item' => 50,
                'nombre' => 'Fenoles (c/C6H5OH)',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 1),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => 1,
                    'max' => 5),
                'claseD' => array(
                    'min' => 5,
                    'max' => 10)),
            '191' => array(
                'item' => 51,
                'nombre' => 'Pentaclorofenol',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 5),
                'claseB' => array(
                    'min' => 5,
                    'max' => 10),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '125' => array(
                'item' => 52,
                'nombre' => '1.1.1.2 Tetracloroetano',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 10),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '101' => array(
                'item' => 53,
                'nombre' => '1.1.1. Tricloroetano',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 30),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '126' => array(
                'item' => 54,
                'nombre' => 'Tetracloruro de Carbono',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 3),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '156' => array(
                'item' => 55,
                'nombre' => '2.4.6. Triclorofenol',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 10),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '20' => array(
                'item' => 57,
                'nombre' => 'DBO5 (c/O2)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 2),
                'claseB' => array(
                    'min' => 2,
                    'max' => 5),
                'claseC' => array(
                    'min' => 5,
                    'max' => 20),
                'claseD' => array(
                    'min' => 20,
                    'max' => 30)),
            '21' => array(
                'item' => 58,
                'nombre' => 'DQO  (c/O2)',
                'unidad' => 'mg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 5),
                'claseB' => array(
                    'min' => 5,
                    'max' => 10),
                'claseC' => array(
                    'min' => 10,
                    'max' => 40),
                'claseD' => array(
                    'min' => 40,
                    'max' => 60)),
            '161' => array(
                'item' => "61",
                'nombre' => 'Aldrin|Dieldrín',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.03),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '167' => array(
                'item' => 63,
                'nombre' => 'Clordano @',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.3),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '170' => array(
                'item' => 64,
                'nombre' => 'DDT @',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 1),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '175' => array(
                'item' => 65,
                'nombre' => 'Endrin @',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => '',
                    'max' => ''),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '174' => array(
                'item' => 66,
                'nombre' => 'Endosulfan @',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 70),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '178' => array(
                'item' => "67",
                'nombre' => 'Heptacloro|Heptacloripoxido @',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.1),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '181' => array(
                'item' => 69,
                'nombre' => 'Lindano (Gama-BHC) @',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 3),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '187' => array(
                'item' => 70,
                'nombre' => 'Metoxicloro',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 30),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '200' => array(
                'item' => 71,
                'nombre' => 'Toxafeno @',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.01),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => 0.01,
                    'max' => 0.05)),
            '171' => array(
                'item' => 72,
                'nombre' => 'Demetón',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.1),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '177' => array(
                'item' => 73,
                'nombre' => 'Gutión',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.01),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '182' => array(
                'item' => 74,
                'nombre' => 'Malatión',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 0.04),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '189' => array(
                'item' => 75,
                'nombre' => 'Paratión @',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => '',
                    'max' => ''),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '164' => array(
                'item' => 76,
                'nombre' => 'Carbaril',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => '',
                    'max' => ''),
                'claseB' => array(
                    'min' => 0,
                    'max' => 0.02),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '157' => array(
                'item' => 77,
                'nombre' => '2,4-D; Diclorofenoxiacético',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 100),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '155' => array(
                'item' => 79,
                'nombre' => '2,4,5 - T; Ácido 2,4,5 triclorofenoxiacético',
                'unidad' => 'µg/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 2),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => '')),
            '137' => array(
                'item' => 80,
                'nombre' => 'Colifecales',
                'unidad' => 'NMP/100 mL',
                'claseA' => array(
                    'min' => 0,
                    'max' => 5),
                'claseB' => array(
                    'min' => 5,
                    'max' => 200),
                'claseC' => array(
                    'min' => 200,
                    'max' => 1000),
                'claseD' => array(
                    'min' => 1000,
                    'max' => 5000)),
            '143' => array(
                'item' => 81,
                'nombre' => 'Parasitos',
                'unidad' => 'N/L',
                'claseA' => array(
                    'min' => 0,
                    'max' => 1),
                'claseB' => array(
                    'min' => '',
                    'max' => ''),
                'claseC' => array(
                    'min' => '',
                    'max' => ''),
                'claseD' => array(
                    'min' => '',
                    'max' => ''))
        );
    }

    function consultaFiltroCompuestosQuimicos($acuifero = null,$mes,$gestion = null){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $where = '';
        if($acuifero || $mes || $gestion){
            $where = "WHERE ";
        }
        if($acuifero){
            $where = $where."i.acuiferoId = $acuifero ";
        }
        if($mes){
            if($where !== "WHERE "){
                $where = $where." AND ";
            }
            $where= $where."MONTH(c.fecha_muestreo) = $mes";
        }
        if($gestion){
            if($where !== "WHERE "){
                $where = $where." AND ";
            }
            $where= $where."YEAR(c.fecha_muestreo) = $gestion";
        }

        $sql = "SELECT i.itemId, i.nombre AS pozo, c.fecha_muestreo, c.hora_muestreo , m.nombre, d.valor, m.itemId AS parametro,i.acuiferoId AS acuifero
            from item i
            inner join item_pozo_monitor_calidad c
            on c.pozoId = i.itemId
            inner join item_pozo_monitor_calidad_dato d
            on d.calidadId = c.itemId
            inner join catalogo_pozo_monitor_calidad_compuesto m
            on m.itemId = d.compuestoId
            $where AND d.compuestoId IN (8,27,37,54,59,70,71,75,83,93,94)";
        $res = $this->dbm->Execute($sql)->GetRows();
        return $res;
    }

    function consulta($acuifero = null,$mes,$gestion = null){
        $this->dbm->SetFetchMode(ADODB_FETCH_ASSOC);
        $where = '';
        if($acuifero || $mes || $gestion){
            $where = "WHERE ";
        }
        if($acuifero){
            $where = $where."i.acuiferoId = $acuifero ";
        }
        if($mes){
            if($where !== "WHERE "){
                $where = $where." AND ";
            }
            $where= $where."MONTH(c.fecha_muestreo) = $mes";
        }
        if($gestion){
            if($where !== "WHERE "){
                $where = $where." AND ";
            }
            $where= $where."YEAR(c.fecha_muestreo) = $gestion";
        }

        $sql = "SELECT i.itemId, i.nombre AS pozo, c.fecha_muestreo, c.hora_muestreo , m.nombre, d.valor, m.itemId AS parametro,i.acuiferoId AS acuifero
            from item i
            inner join item_pozo_monitor_calidad c
            on c.pozoId = i.itemId
            inner join item_pozo_monitor_calidad_dato d
            on d.calidadId = c.itemId
            inner join catalogo_pozo_monitor_calidad_compuesto m
            on m.itemId = d.compuestoId
            $where";
        $res = $this->dbm->Execute($sql)->GetRows();
        return $res;
    }

    function generarExcel($tabla,$fila,$normativa,$norBol){
        //colores para el fondo de las celdas
        $col_nulo    = 'D9D9D9';
        $col_critico = 'FF0000';
        $col_claseA  = '0099FF';
        $col_claseB  = '33CC33';
        $col_claseC  = 'FFFF00';
        $col_claseD  = 'FFC000';
        $colores = array('claseA' => $col_claseA,'nulo' => $col_nulo,'claseB' => $col_claseB,'claseC' => $col_claseC,'claseD' => $col_claseD );
        //aqui comienza en mapeo
        $documento = new PHPExcel();
        //imagen mmaya
        $imgMMAyA = new PHPExcel_Worksheet_Drawing();
        $imgMMAyA->setPath('./module/siasbo/img/mmaya.jpeg');
        $imgMMAyA->setCoordinates('T1');
        $imgMMAyA->setHeight(80);
        $imgMMAyA->setWorksheet($documento->getActiveSheet());
        //imagen bolivia
        $imgBolivia = new PHPExcel_Worksheet_Drawing();
        $imgBolivia->setPath('./module/siasbo/img/bolivia.jpeg');
        $imgBolivia->setCoordinates('L1');
        $imgBolivia->setHeight(80);
        $imgBolivia->setWorksheet($documento->getActiveSheet());
        // Establecer propiedades
        $documento->getProperties()
        ->setCreator("videotutoriales.es")
        ->setLastModifiedBy("only.amalgama")
        ->setTitle("Documento Excel")
        ->setSubject("Documento Excel")
        ->setDescription("crear archivos de Excel desde PHP.")
        ->setKeywords("Excel Office 2007 php")
        ->setCategory("Calidad");
        //atributos inicializacion(tabla de reglamento de contaminacion)
        $colPar  = 'L';
        $colUni  = 'M';
        $colPrim = 'N';
        $colNorma= 'A';
        $filIni  = 6;
        $filTit  = $filIni-1;
        $filTit  = $filTit.'';
        $filIni  = $filIni.'';
        $celPar  = $colPar.$filIni;
        $celUni  = $colUni.$filIni;
        $celIni  = $colPrim.$filIni;
        //ultima fila utilizada para el mapeo de las clases
        $cfu     = sizeof($normativa) +$filIni;

        //mapeo de las clases
        $documento->setActiveSheetIndex(0)
            ->setCellValue('B'.($filIni-1),'Clase "A"')
            ->setCellValue('D'.($filIni-1),'Clase "B"')
            ->setCellValue('F'.($filIni-1),'Clase "C"')
            ->setCellValue('H'.($filIni-1),'Clase "D"')
            ->setCellValue('A'.$filIni,"Nº")
            ->setCellValue('B'.$filIni,"Min")
            ->setCellValue('C'.$filIni,"Máx")
            ->setCellValue('D'.$filIni,"Min")
            ->setCellValue('E'.$filIni,"Máx")
            ->setCellValue('F'.$filIni,"Min")
            ->setCellValue('G'.$filIni,"Máx")
            ->setCellValue('H'.$filIni,"Min")
            ->setCellValue('I'.$filIni,"Máx")
            ->setCellValue('J'.($filIni-1),"FORMATO")
            ->setCellValue('K'.($filIni-1),"Cancerígeno");
            //coloca estilos
        $documento->getActiveSheet()->getStyle('A5:K5')->getFont()->setBold(true);
        $documento->getActiveSheet()->getStyle('B'.($filIni-1).':C'.$cfu)->getFill()->applyFromArray(array('type' => PHPExcel_Style_Fill::FILL_SOLID,'startcolor' => array('rgb' => $col_claseA)));
        $documento->getActiveSheet()->getStyle('D'.($filIni-1).':E'.$cfu)->getFill()->applyFromArray(array('type' => PHPExcel_Style_Fill::FILL_SOLID,'startcolor' => array('rgb' => $col_claseB)));
        $documento->getActiveSheet()->getStyle('F'.($filIni-1).':G'.$cfu)->getFill()->applyFromArray(array('type' => PHPExcel_Style_Fill::FILL_SOLID,'startcolor' => array('rgb' => $col_claseC)));
        $documento->getActiveSheet()->getStyle('H'.($filIni-1).':I'.$cfu)->getFill()->applyFromArray(array('type' => PHPExcel_Style_Fill::FILL_SOLID,'startcolor' => array('rgb' => $col_claseD)));

        $documento->getActiveSheet()->mergeCells('B'.($filIni-1).':C'.($filIni-1))->mergeCells('D'.($filIni-1).':E'.($filIni-1))->mergeCells('F'.($filIni-1).':G'.($filIni-1))->mergeCells('H'.($filIni-1).':I'.($filIni-1))->mergeCells('J'.($filIni-1).':J'.$filIni)->mergeCells('K'.($filIni-1).':K'.$filIni);
        $documento->getActiveSheet()->getStyle('B'.($filIni-1).':K'.($filIni-1))->getFont()->setBold(true);
        $documento->getActiveSheet()->getStyle('B'.($filIni-1).':I'.($filIni-1))->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        foreach(range('A','I') as $columnID) {  $documento->getActiveSheet()->getColumnDimension($columnID)->setAutoSize(true);
        }
        //mapeo de los datos de las clases
        $ultClase = $this->convertirArray($documento,$normativa,$colNorma.($filIni+1).'');
        $documento->getActiveSheet()->getStyle('J'.($filIni-1).':K'.($filIni-1))->getAlignment()->setWrapText(true);
        //colocar formato condicional a las celdas de la columna FORMATO
        $documento->getActiveSheet()->getStyle('J'.($filIni+1).':J'.$cfu)->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getStartColor()->setRGB($col_critico);
        for($i=$filIni+1;$i<=$cfu;$i++){
            $Festilos = $documento->getActiveSheet()->getStyle('J'.$i.'')->getConditionalStyles();
            $formatos = $this->condicionalesRMCH($i,$colores,'J'.$i.'');
            foreach ($formatos as $condicion) {
                array_push($Festilos, $condicion);
            }
            $documento->getActiveSheet()->getStyle('J'.$i.'')->setConditionalStyles($Festilos);
        }

        //TABLA REGLAMENTO DE CONTAMINACION
        $documento->setActiveSheetIndex(0)->setCellValue($celPar,"Parámetro")->setCellValue($celUni,"Unidad")->setCellValue($colPrim.$filTit,"SEGÚN REGLAMENTO EN MATERIA DE CONTAMINACIÓN HÍDRICA");
        $documento->getActiveSheet()->getStyle($celPar)->getFont()->setBold(true);
        $documento->getActiveSheet()->getStyle($celUni)->getFont()->setBold(true);
        //coloca los pozos
        $ult = $this->convertirArray($documento,$fila,$celIni);
        $ultimo = $ult['col'];
        $documento->getActiveSheet()->mergeCells($colPrim.$filTit.':'.$ultimo.$filTit);
        $documento->getActiveSheet()->getStyle($colPrim.$filTit.':'.$ultimo.$filTit)->getFont()->setBold(true);
        $documento->getActiveSheet()->getStyle($colPrim.$filTit.':'.$ultimo.$filTit)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $celda = $colPar.($ult['fil']+1).'';
        //llenado de los valores de los pozos
        $ult = $this->convertirArray($documento,$tabla,$celda);
        $documento->getActiveSheet()->getStyle($celPar.':'.$ultimo.$ult['fil'])->getBorders()->getAllBorders()->setBorderStyle(PHPExcel_Style_Border::BORDER_THIN);
        $documento->getActiveSheet()->getStyle($colPrim.($filIni+1).':'.$ultimo.$cfu)->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getStartColor()->setRGB($col_critico);
        //coloca formatos condicionales
        $col = $colPrim.'';
        for ($j = 0; $j< sizeof($fila); $j++) {
            for($i=$filIni+1;$i<=$cfu;$i++){
                $cel = $col.$i;
                $Festilos = $documento->getActiveSheet()->getStyle($cel)->getConditionalStyles();
                $formatos = $this->condicionalesRMCH($i,$colores,$cel);
                foreach ($formatos as $condicion) {
                    array_push($Festilos, $condicion);
                }
                $documento->getActiveSheet()->getStyle($cel)->setConditionalStyles($Festilos);
            }
            ++$col;
        }
        //Tamaños
        $documento->getActiveSheet()->getColumnDimension($colPar)->setAutoSize(true);
        $documento->getActiveSheet()->getColumnDimension($colUni)->setAutoSize(true);

        //atributos inicializacion(tabla de norma boliviana)
        $filIni  = $ult['fil']+4;
        $filTit  = $filIni-1;
        $filTit = $filTit.'';
        $filIni = $filIni.'';
        $celPar  = $colPar.$filIni;
        $celUni  = $colUni.$filIni;
        $celIni  = $colPrim.$filIni;
        //ultima fila utilizada para el mapeo de la normativa
        $cfu     = sizeof($normativa) +$filIni;

        //clase para norma boliviana
        $documento->setActiveSheetIndex(0)
            ->setCellValue('H'.$filIni.'',"Min")
            ->setCellValue('I'.$filIni.'',"Máx")
            ->setCellValue('J'.$filIni.'',"FORMATO");
        $documento->getActiveSheet()->getStyle('H'.$filIni.':J'.$filIni)->getFont()->setBold(true);
        //mapeo de los datos de la normativa boliviana
        $ultNorBol = $this->convertirArray($documento,$norBol,'H'.($filIni+1).'');
        $documento->getActiveSheet()->getStyle('J'.($filIni+1).':J'.$cfu)->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getStartColor()->setRGB($col_critico);
        $documento->getActiveSheet()->getStyle('H'.$filIni.':I'.$cfu)->getFill()->applyFromArray(array('type' => PHPExcel_Style_Fill::FILL_SOLID,'startcolor' => array('rgb' => $col_claseA)));
        //colocar formato condicional a las celdas de la columna FORMATO
        for($i=$filIni+1;$i<=$cfu;$i++){
            $Festilos = $documento->getActiveSheet()->getStyle('J'.$i.'')->getConditionalStyles();
            $formatos = $this->condicionalesNB512($i,$colores,'J'.$i.'');
            foreach ($formatos as $condicion) {
                array_push($Festilos, $condicion);
            }
            $documento->getActiveSheet()->getStyle('J'.$i.'')->setConditionalStyles($Festilos);
        }

        //TABLA NORMA BOLIVIANA
        $documento->setActiveSheetIndex(0)->setCellValue($celPar,"Parámetro")->setCellValue($celUni,"Unidad")->setCellValue($colPrim.$filTit,"SEGÚN NORMA BOLIVIANA 512");
        $documento->getActiveSheet()->getStyle($celPar)->getFont()->setBold(true);
        $documento->getActiveSheet()->getStyle($celUni)->getFont()->setBold(true);
        //coloca los pozos
        $ult = $this->convertirArray($documento,$fila,$celIni);
        $ultimo = $ult['col'];
        $documento->getActiveSheet()->mergeCells($colPrim.$filTit.':'.$ultimo.$filTit);
        $documento->getActiveSheet()->getStyle($colPrim.$filTit.':'.$ultimo.$filTit)->getFont()->setBold(true);
        $documento->getActiveSheet()->getStyle($colPrim.$filTit.':'.$ultimo.$filTit)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $celda = $colPar.($ult['fil']+1).'';
        $ult = $this->convertirArray($documento,$tabla,$celda);
        $documento->getActiveSheet()->getStyle($celPar.':'.$ultimo.$ult['fil'])->getBorders()->getAllBorders()->setBorderStyle(PHPExcel_Style_Border::BORDER_THIN);
        //coloca formatos condicionales
        $col = $colPrim.'';
        for ($j = 0; $j< sizeof($fila); $j++) {
            for($i=$filIni+1;$i<=$cfu;$i++){
                $Festilos = $documento->getActiveSheet()->getStyle($col.$i.'')->getConditionalStyles();
                $formatos = $this->condicionalesNB512($i,$colores,$col.$i.'');
                foreach ($formatos as $condicion) {
                    array_push($Festilos, $condicion);
                }
                $documento->getActiveSheet()->getStyle($col.$i.'')->setConditionalStyles($Festilos);
            }
            ++$col;
        }
        $documento->getActiveSheet()->getStyle($colPrim.($filIni+1).':'.$ultimo.$cfu)->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getStartColor()->setRGB($col_critico);
        //Tamaños
        $documento->getActiveSheet()->getColumnDimension($colPar)->setAutoSize(true);
        $documento->getActiveSheet()->getColumnDimension($colUni)->setAutoSize(true);
        // hasta aqui
        $documento->getActiveSheet()->setTitle('Calidad');
        // indicar que se envia un archivo de Excel.
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="calidad.xlsx"');
        header('Cache-Control: max-age=0');
         
        $writer = PHPExcel_IOFactory::createWriter($documento, 'Excel2007');
        $writer->save('php://output');
        exit;
    }

    //devuelve un array de formatos condicionales para las celdas 
    function condicionalesNB512($fila,$color,$celda){
        $nulo = new PHPExcel_Style_Conditional();
        $nulo->setConditionType(PHPExcel_Style_Conditional::CONDITION_EXPRESSION);
        $nulo->setOperatorType(PHPExcel_Style_Conditional::OPERATOR_EQUAL);
        $nulo->addCondition("=ISBLANK($celda)");  
        $nulo->getStyle()->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getStartColor()->setRGB($color['nulo']);
        $nulo->getStyle()->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getEndColor()->setRGB($color['nulo']);

        $con1 = new PHPExcel_Style_Conditional();
        $con1->setConditionType(PHPExcel_Style_Conditional::CONDITION_CELLIS);
        $con1->setOperatorType(PHPExcel_Style_Conditional::OPERATOR_BETWEEN);
        $con1->addCondition('H'.$fila)->addCondition('I'.$fila);
        $con1->getStyle()->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getStartColor()->setRGB($color['claseA']);
        $con1->getStyle()->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getEndColor()->setRGB($color['claseA']);
        return array('nulo' => $nulo,'claseA' => $con1);
    }

    //devuelve un array de formatos condicionales para las celdas 
    function condicionalesRMCH($fila,$color,$celda){
        $nulo = new PHPExcel_Style_Conditional();
        $nulo->setConditionType(PHPExcel_Style_Conditional::CONDITION_EXPRESSION);
        $nulo->setOperatorType(PHPExcel_Style_Conditional::OPERATOR_EQUAL);
        $nulo->addCondition("=ISBLANK($celda)");  
        $nulo->getStyle()->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getStartColor()->setRGB($color['nulo']);
        $nulo->getStyle()->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getEndColor()->setRGB($color['nulo']);

        $con1 = new PHPExcel_Style_Conditional();
        $con1->setConditionType(PHPExcel_Style_Conditional::CONDITION_CELLIS);
        $con1->setOperatorType(PHPExcel_Style_Conditional::OPERATOR_BETWEEN);
        $con1->addCondition('B'.$fila)->addCondition('C'.$fila);
        $con1->getStyle()->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getStartColor()->setRGB($color['claseA']);
        $con1->getStyle()->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getEndColor()->setRGB($color['claseA']);

        $con2 = new PHPExcel_Style_Conditional();
        $con2->setConditionType(PHPExcel_Style_Conditional::CONDITION_CELLIS);
        $con2->setOperatorType(PHPExcel_Style_Conditional::OPERATOR_BETWEEN);
        $con2->addCondition('D'.$fila);
        $con2->addCondition('E'.$fila);
        $con2->getStyle()->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getStartColor()->setRGB($color['claseB']);
        $con2->getStyle()->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getEndColor()->setRGB($color['claseB']);

        $con3 = new PHPExcel_Style_Conditional();
        $con3->setConditionType(PHPExcel_Style_Conditional::CONDITION_CELLIS);
        $con3->setOperatorType(PHPExcel_Style_Conditional::OPERATOR_BETWEEN);
        $con3->addCondition('F'.$fila);
        $con3->addCondition('G'.$fila);
        $con3->getStyle()->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getStartColor()->setRGB($color['claseC']);
        $con3->getStyle()->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getEndColor()->setRGB($color['claseC']);
        $con4 = new PHPExcel_Style_Conditional();
        $con4->setConditionType(PHPExcel_Style_Conditional::CONDITION_CELLIS);
        $con4->setOperatorType(PHPExcel_Style_Conditional::OPERATOR_BETWEEN);
        $con4->addCondition('H'.$fila);
        $con4->addCondition('I'.$fila);
        $con4->getStyle()->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getStartColor()->setRGB($color['claseD']);
        $con4->getStyle()->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getEndColor()->setRGB($color['claseD']);
        return array('nulo' => $nulo,'claseA' => $con1,'claseB' => $con2,'claseC' => $con3,'claseD' => $con4);
    }

    function convertirArray($doc,$array=null,$celdaIni='A1',$estilo=null){
        if(is_array($array)){
            if(!is_array(end($array))){
                $array = array($array);
            }
            $celdArray = PHPExcel_Cell::coordinateFromString($celdaIni);
            $iniCol = $celdArray[0];
            $iniFil = $celdArray[1];
            $finFil = $celdArray[1];
            foreach ($array as $fila) {
                $columna = $iniCol;
                $ultimo  = $iniCol;
                foreach ($fila as $celda) {
                    $doc->getActiveSheet()->setCellValue($columna.$iniFil, $celda);
                    $ultimo = $columna;
                    ++$columna;
                }
                $finFil = $iniFil;
                ++$iniFil;
            }
            return array('fil' => $finFil,'col'=>$ultimo);
        }
        else{
            throw new PHPExcel_Exception("No estas enviando un array en el segundo parametro de esta funcion");
        }
    }

}