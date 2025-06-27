<?php
/**
 * User: henrytaby
 * Date: 3/5/2018
 * Time: 15:22
 */

class Subcatalogo extends Table{

    function __construct(){
        /**
         * Inicializamos todas las librerias y variables para el submodulo
         */
        $this->submodule_init_sbm();

    }
    public function conf_catalog_datos_general(){

        $this->addCatalogList($this->tabla["c_pozo_hidra_tipo_prueba"],"tipo_prueba","","","","itemId","","");
        $this->addCatalogList($this->tabla["c_pozo_hidra_tipo_bombeo"],"tipo_bombeo","","","","itemId","","");

    }

}