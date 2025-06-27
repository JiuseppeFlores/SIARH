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

    public function conf_catalog_datos_general() {
        
        $this->addCatalogList($this->tabla["c_manantial_tipo"],"tipo_manantial","","","","itemId","","");
        $this->addCatalogList($this->tabla["c_manantial_usoagua"],"usoagua_manantial","","","","itemId","","");
        $this->addCatalogList($this->tabla["c_manantial_medio"],"medio_surgencia","","","","itemId","","");
        $this->addCatalogList($this->tabla["c_manantial_permanencia"],"permanencia","","","","itemId","","");

    }
    
}