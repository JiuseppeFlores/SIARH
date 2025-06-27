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

        $this->addCatalogList($this->tabla["o_departamento"],"departamento","","","","itemId","","");
        $this->addCatalogList($this->tabla["c_cuenca"],"cuenca","","","","itemId","","");
        /*$this->addCatalogList($this->tabla["o_provincia"],"provincia","","","","","","");
        $this->addCatalogList($this->tabla["o_municipio"],"municipio","","","","","","");
        $this->addCatalogList($this->tabla["o_comunidad"],"comunidad","","","","","","");
        $this->addCatalogList($this->tabla["o_localidad"],"localidad","","","","","","");
        $this->addCatalogList($this->tabla["c_geofisica_tomografia_config"],"geo_tomo_config","","","","","","");*/

    }
    

}