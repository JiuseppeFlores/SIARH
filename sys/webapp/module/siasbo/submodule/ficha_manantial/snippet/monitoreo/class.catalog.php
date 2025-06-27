<?php
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

    public function conf_catalog_datos_general(){

        $this->addCatalogList($this->tabla["c_epoca"],"epoca","","","","itemId","","");
        $this->addCatalogList($this->tabla["c_pozo_monitor_calidad_parametro"],"calidad_parametro","","","","itemId","","");
        $this->addCatalogList($this->tabla["c_pozo_monitor_calidad_compuesto"],"calidad_compuesto","","","","itemId","","");
        $this->addCatalogList($this->tabla["c_pozo_monitor_isotopico_parametro"],"isotopico_parametro","","","","itemId","","");
        $this->addCatalogList($this->tabla["c_pozo_monitor_isotopico_compuesto"],"isotopico_compuesto","","","","itemId","","");

    }
    
}