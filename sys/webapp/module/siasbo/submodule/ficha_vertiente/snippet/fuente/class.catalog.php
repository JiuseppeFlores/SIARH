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
        // var_dump("Configurando catalogos de datos generales",$this->tabla);
        $this->addCatalogList($this->tabla["c_fuente_tipo_agua"],"tipotipoagua","","","","itemId","","");
        $this->addCatalogList($this->tabla["c_tipo_fuente_superficial"],"tipoFuente","","","","itemId","","");
        $this->addCatalogList($this->tabla["c_fuente_tipo_agua_flujo"],"tipoflujo","","","","itemId","","");
        // $this->addCatalogList($this->tabla["c_pozo_proveedor_energia"],"tipoenergia","","","","itemId","","");
        // $this->addCatalogList($this->tabla["c_pozo_litologico_permeabilidad"],"tipopermeabilidad","","","","itemId","","");

    }

}