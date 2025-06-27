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

        $this->addCatalogList($this->tabla["c_pozo_perforacion"],"tipopozo","","","","itemId","","");
        $this->addCatalogList($this->tabla["c_pozo_perforacion_tipo"],"tipoperforacion","","","","itemId","","");
        $this->addCatalogList($this->tabla["c_pozo_perforacion_metodo"],"metodoperforacion","","","","itemId","","");
        $this->addCatalogList($this->tabla["c_pozo_perforacion_revestimiento"],"tiporevestimiento","","","","itemId","","");
        $this->addCatalogList($this->tabla["c_pozo_perforacion_excavacion"],"tipoexcavacion","","","","itemId","","");

        // $this->addCatalogList($this->tabla["c_geofisica_dev_lineabase"],"lineabase","","","","","","");
        // $this->addCatalogList($this->tabla["o_departamento"],"departamento","","","","","","");
        // $this->addCatalogList($this->tabla["c_geofisica_tomografia_config"],"geo_tomo_config","","","","","","");

    }

}