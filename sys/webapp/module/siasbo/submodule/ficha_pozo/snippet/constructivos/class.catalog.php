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

        $this->addCatalogList($this->tabla["c_pozo_constructivo_tuberia"],"tipo_tuberia","","","","itemId","","");
        $this->addCatalogList($this->tabla["c_pozo_constructivo_sello"],"tipo_sello","","","","itemId","","");
        $this->addCatalogList($this->tabla["c_pozo_constructivo_rejillafiltro"],"tipo_rejillafiltro","","","","itemId","","");

        
    }

}