<?php
/**
 * Created by PhpStorm.
 * User: henrytaby
 * Date: 3/5/2018
 * Time: 15:27
 */

switch($accion) {
    /**
     * Página por defecto
     */
    default:
        /**
         * Cargamos catalogos necesarios
         */
        //print_struc($CFGm->tabla);exit;
        $grill_list = $objItem->get_grilla_list_sbm("index");
        $smarty->assign("grill_list", $grill_list);
        /**
         * usamos el template para mootools
         */
        $smarty->assign("subpage", $webm["index"]);
        $smarty->assign("subpage_js", $webm["index_js"]);
        break;
    /**
     * Creación de JSON
     */
    case 'getItemList':
        $res = $objItem->get_item_datatable_Rows("catalogos", "index");
        $core->print_json($res);
        break;

    case 'itemUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogos");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["item_index"]);
        $smarty->assign("subpage_js", $webm["item_index_js"]);
        break;

    case 'itemDelete':
        $res = $objItem->item_delete($id, "catalogos");
        $core->print_json($res);
        break;

    /**
     * catalogo_geofisica_dev_config
     **/
    case 'geofisicaDevConfig':
        $grill_list = $objItem->get_grilla_list_sbm("catalogo_index");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["geofisicaDevConfig_index"]);
        $smarty->assign("subpage_js", $webm["geofisicaDevConfig_index_js"]);
        break;

    case 'getGeofisicaDevConfigList':
        $res = $objItem->get_item_datatable_Rows("catalogo_geofisica_dev_config", "catalogo_index");
        $core->print_json($res);
        break;

    case 'geofisicaDevConfigUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogo_geofisica_dev_config");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["geofisicaDevConfig_item_index"]);
        $smarty->assign("subpage_js", $webm["geofisicaDevConfig_item_index_js"]);
        break;

    case 'geofisicaDevConfigDelete':
        $res = $objItem->item_delete($id, "catalogo_geofisica_dev_config");
        $core->print_json($res);
        break;

    /**
     * catalogo_geofisica_dev_lineabase
     **/
    case 'geofisicaDevLineabase':
        $grill_list = $objItem->get_grilla_list_sbm("catalogo_index");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["geofisicaDevLineabase_index"]);
        $smarty->assign("subpage_js", $webm["geofisicaDevLineabase_index_js"]);
        break;

    case 'getGeofisicaDevLineabaseList':
        $res = $objItem->get_item_datatable_Rows("catalogo_geofisica_dev_lineabase", "catalogo_index");
        $core->print_json($res);
        break;

    case 'geofisicaDevLineabaseUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogo_geofisica_dev_lineabase");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["geofisicaDevLineabase_item_index"]);
        $smarty->assign("subpage_js", $webm["geofisicaDevLineabase_item_index_js"]);
        break;

    case 'geofisicaDevLineabaseDelete':
        $res = $objItem->item_delete($id, "catalogo_geofisica_dev_lineabase");
        $core->print_json($res);
        break;

    /**
     * catalogo_geofisica_tomografia_config
     **/
    case 'geofisicaTomografiaConfig':
        $grill_list = $objItem->get_grilla_list_sbm("catalogo_index");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["geofisicaTomografiaConfig_index"]);
        $smarty->assign("subpage_js", $webm["geofisicaTomografiaConfig_index_js"]);
        break;

    case 'getGeofisicaTomografiaConfigList':
        $res = $objItem->get_item_datatable_Rows("catalogo_geofisica_tomografia_config", "catalogo_index");
        $core->print_json($res);
        break;

    case 'geofisicaTomografiaConfigUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogo_geofisica_tomografia_config");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["geofisicaTomografiaConfig_item_index"]);
        $smarty->assign("subpage_js", $webm["geofisicaTomografiaConfig_item_index_js"]);
        break;

    case 'geofisicaTomografiaConfigDelete':
        $res = $objItem->item_delete($id, "catalogo_geofisica_tomografia_config");
        $core->print_json($res);
        break;

    /**
     * catalogo_manantial_medio
     **/
    case 'medioSurgencia':
        $grill_list = $objItem->get_grilla_list_sbm("catalogo_index");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["medioSurgencia_index"]);
        $smarty->assign("subpage_js", $webm["medioSurgencia_index_js"]);
        break;

    case 'getMedioSurgenciaList':
        $res = $objItem->get_item_datatable_Rows("catalogo_manantial_medio", "catalogo_index");
        $core->print_json($res);
        break;

    case 'medioSurgenciaUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogo_manantial_medio");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["medioSurgencia_item_index"]);
        $smarty->assign("subpage_js", $webm["medioSurgencia_item_index_js"]);
        break;

    case 'medioSurgenciaDelete':
        $res = $objItem->item_delete($id, "catalogo_manantial_medio");
        $core->print_json($res);
        break;

    /**
     * catalogo_manantial_permanencia
     **/
    case 'tipoPermanencia':
        $grill_list = $objItem->get_grilla_list_sbm("catalogo_index");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["tipoPermanencia_index"]);
        $smarty->assign("subpage_js", $webm["tipoPermanencia_index_js"]);
        break;

    case 'getTipoPermanenciaList':
        $res = $objItem->get_item_datatable_Rows("catalogo_manantial_permanencia", "catalogo_index");
        $core->print_json($res);
        break;

    case 'tipoPermanenciaUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogo_manantial_permanencia");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["tipoPermanencia_item_index"]);
        $smarty->assign("subpage_js", $webm["tipoPermanencia_item_index_js"]);
        break;

    case 'tipoPermanenciaDelete':
        $res = $objItem->item_delete($id, "catalogo_manantial_permanencia");
        $core->print_json($res);
        break;

    /**
     * catalogo_manantial_tipo
     **/
    case 'tipoManantial':
        $grill_list = $objItem->get_grilla_list_sbm("catalogo_index");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["tipoManantial_index"]);
        $smarty->assign("subpage_js", $webm["tipoManantial_index_js"]);
        break;

    case 'getTipoManantialList':
        $res = $objItem->get_item_datatable_Rows("catalogo_manantial_tipo", "catalogo_index");
        $core->print_json($res);
        break;

    case 'tipoManantialUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogo_manantial_tipo");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["tipoManantial_item_index"]);
        $smarty->assign("subpage_js", $webm["tipoManantial_item_index_js"]);
        break;

    case 'tipoManantialDelete':
        $res = $objItem->item_delete($id, "catalogo_manantial_tipo");
        $core->print_json($res);
        break;

    /**
     * catalogo_manantial_usoagua
     **/
    case 'usoAguaManantial':
        $grill_list = $objItem->get_grilla_list_sbm("catalogo_index");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["usoAguaManantial_index"]);
        $smarty->assign("subpage_js", $webm["usoAguaManantial_index_js"]);
        break;

    case 'getUsoAguaManantialList':
        $res = $objItem->get_item_datatable_Rows("catalogo_manantial_usoagua", "catalogo_index");
        $core->print_json($res);
        break;

    case 'usoAguaManantialUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogo_manantial_usoagua");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["usoAguaManantial_item_index"]);
        $smarty->assign("subpage_js", $webm["usoAguaManantial_item_index_js"]);
        break;

    case 'usoAguaManantialDelete':
        $res = $objItem->item_delete($id, "catalogo_manantial_usoagua");
        $core->print_json($res);
        break;

    /**
     * catalogo_pozo_constructivo_rejillafiltro
     **/
    case 'tipoRejillaFiltro':
        $grill_list = $objItem->get_grilla_list_sbm("catalogo_index");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["tipoRejillaFiltro_index"]);
        $smarty->assign("subpage_js", $webm["tipoRejillaFiltro_index_js"]);
        break;

    case 'getTipoRejillaFiltroList':
        $res = $objItem->get_item_datatable_Rows("catalogo_pozo_constructivo_rejillafiltro", "catalogo_index");
        $core->print_json($res);
        break;

    case 'tipoRejillaFiltroUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogo_pozo_constructivo_rejillafiltro");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["tipoRejillaFiltro_item_index"]);
        $smarty->assign("subpage_js", $webm["tipoRejillaFiltro_item_index_js"]);
        break;

    case 'tipoRejillaFiltroDelete':
        $res = $objItem->item_delete($id, "catalogo_pozo_constructivo_rejillafiltro");
        $core->print_json($res);
        break;

    /**
     * catalogo_pozo_constructivo_sello
     **/
    case 'tipoSello':
        $grill_list = $objItem->get_grilla_list_sbm("catalogo_index");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["tipoSello_index"]);
        $smarty->assign("subpage_js", $webm["tipoSello_index_js"]);
        break;

    case 'getTipoSelloList':
        $res = $objItem->get_item_datatable_Rows("catalogo_pozo_constructivo_sello", "catalogo_index");
        $core->print_json($res);
        break;

    case 'tipoSelloUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogo_pozo_constructivo_sello");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["tipoSello_item_index"]);
        $smarty->assign("subpage_js", $webm["tipoSello_item_index_js"]);
        break;

    case 'tipoSelloDelete':
        $res = $objItem->item_delete($id, "catalogo_pozo_constructivo_sello");
        $core->print_json($res);
        break;

    /**
     * catalogo_pozo_constructivo_tuberia
     **/
    case 'tipoTuberia':
        $grill_list = $objItem->get_grilla_list_sbm("catalogo_index");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["tipoTuberia_index"]);
        $smarty->assign("subpage_js", $webm["tipoTuberia_index_js"]);
        break;

    case 'getTipoTuberiaList':
        $res = $objItem->get_item_datatable_Rows("catalogo_pozo_constructivo_tuberia", "catalogo_index");
        $core->print_json($res);
        break;

    case 'tipoTuberiaUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogo_pozo_constructivo_tuberia");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["tipoTuberia_item_index"]);
        $smarty->assign("subpage_js", $webm["tipoTuberia_item_index_js"]);
        break;

    case 'tipoTuberiaDelete':
        $res = $objItem->item_delete($id, "catalogo_pozo_constructivo_tuberia");
        $core->print_json($res);
        break;

    /**
     * catalogo_pozo_electrico_parametro
     **/
    case 'parametroElectrico':
        $grill_list = $objItem->get_grilla_list_sbm("catalogo_index");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["parametroElectrico_index"]);
        $smarty->assign("subpage_js", $webm["parametroElectrico_index_js"]);
        break;

    case 'getParametroElectricoList':
        $res = $objItem->get_item_datatable_Rows("catalogo_pozo_electrico_parametro", "catalogo_index");
        $core->print_json($res);
        break;

    case 'parametroElectricoUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogo_pozo_electrico_parametro");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["parametroElectrico_item_index"]);
        $smarty->assign("subpage_js", $webm["parametroElectrico_item_index_js"]);
        break;

    case 'parametroElectricoDelete':
        $res = $objItem->item_delete($id, "catalogo_pozo_electrico_parametro");
        $core->print_json($res);
        break;

    /**
     * catalogo_pozo_implementacion_tipo
     **/
    case 'tipoEnergia':
        $grill_list = $objItem->get_grilla_list_sbm("catalogo_index");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["tipoEnergia_index"]);
        $smarty->assign("subpage_js", $webm["tipoEnergia_index_js"]);
        break;

    case 'getTipoEnergiaList':
        $res = $objItem->get_item_datatable_Rows("catalogo_pozo_implementacion_tipo", "catalogo_index");
        $core->print_json($res);
        break;

    case 'tipoEnergiaUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogo_pozo_implementacion_tipo");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["tipoEnergia_item_index"]);
        $smarty->assign("subpage_js", $webm["tipoEnergia_item_index_js"]);
        break;

    case 'tipoEnergiaDelete':
        $res = $objItem->item_delete($id, "catalogo_pozo_implementacion_tipo");
        $core->print_json($res);
        break;

    /**
     * catalogo_pozo_perforacion
     **/
    case 'tipoPozo':
        $grill_list = $objItem->get_grilla_list_sbm("catalogo_index");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["tipoPozo_index"]);
        $smarty->assign("subpage_js", $webm["tipoPozo_index_js"]);
        break;

    case 'getTipoPozoList':
        $res = $objItem->get_item_datatable_Rows("catalogo_pozo_perforacion", "catalogo_index");
        $core->print_json($res);
        break;

    case 'tipoPozoUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogo_pozo_perforacion");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["tipoPozo_item_index"]);
        $smarty->assign("subpage_js", $webm["tipoPozo_item_index_js"]);
        break;

    case 'tipoPozoDelete':
        $res = $objItem->item_delete($id, "catalogo_pozo_perforacion");
        $core->print_json($res);
        break;

    /**
     * catalogo_pozo_perforacion_metodo
     **/
    case 'metodoPerforacion':
        $grill_list = $objItem->get_grilla_list_sbm("catalogo_index");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["metodoPerforacion_index"]);
        $smarty->assign("subpage_js", $webm["metodoPerforacion_index_js"]);
        break;

    case 'getMetodoPerforacionList':
        $res = $objItem->get_item_datatable_Rows("catalogo_pozo_perforacion_metodo", "catalogo_index");
        $core->print_json($res);
        break;

    case 'metodoPerforacionUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogo_pozo_perforacion_metodo");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["metodoPerforacion_item_index"]);
        $smarty->assign("subpage_js", $webm["metodoPerforacion_item_index_js"]);
        break;

    case 'metodoPerforacionDelete':
        $res = $objItem->item_delete($id, "catalogo_pozo_perforacion_metodo");
        $core->print_json($res);
        break;

    /**
     * catalogo_pozo_perforacion_tipo
     **/
    case 'tipoPerforacion':
        $grill_list = $objItem->get_grilla_list_sbm("catalogo_index");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["tipoPerforacion_index"]);
        $smarty->assign("subpage_js", $webm["tipoPerforacion_index_js"]);
        break;

    case 'getTipoPerforacionList':
        $res = $objItem->get_item_datatable_Rows("catalogo_pozo_perforacion_tipo", "catalogo_index");
        $core->print_json($res);
        break;

    case 'tipoPerforacionUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogo_pozo_perforacion_tipo");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["tipoPerforacion_item_index"]);
        $smarty->assign("subpage_js", $webm["tipoPerforacion_item_index_js"]);
        break;

    case 'tipoPerforacionDelete':
        $res = $objItem->item_delete($id, "catalogo_pozo_perforacion_tipo");
        $core->print_json($res);
        break;

    /**
     * catalogo_pozo_proposito
     **/
    case 'propositoPozo':
        $grill_list = $objItem->get_grilla_list_sbm("catalogo_index");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["propositoPozo_index"]);
        $smarty->assign("subpage_js", $webm["propositoPozo_index_js"]);
        break;

    case 'getPropositoPozoList':
        $res = $objItem->get_item_datatable_Rows("catalogo_pozo_proposito", "catalogo_index");
        $core->print_json($res);
        break;

    case 'propositoPozoUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogo_pozo_proposito");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["propositoPozo_item_index"]);
        $smarty->assign("subpage_js", $webm["propositoPozo_item_index_js"]);
        break;

    case 'propositoPozoDelete':
        $res = $objItem->item_delete($id, "catalogo_pozo_proposito");
        $core->print_json($res);
        break;

    /**
     * catalogo_pozo_usoagua
     **/
    case 'usoAguaPozo':
        $grill_list = $objItem->get_grilla_list_sbm("catalogo_index");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["usoAguaPozo_index"]);
        $smarty->assign("subpage_js", $webm["usoAguaPozo_index_js"]);
        break;

    case 'getUsoAguaPozoList':
        $res = $objItem->get_item_datatable_Rows("catalogo_pozo_usoagua", "catalogo_index");
        $core->print_json($res);
        break;

    case 'usoAguaPozoUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogo_pozo_usoagua");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["usoAguaPozo_item_index"]);
        $smarty->assign("subpage_js", $webm["usoAguaPozo_item_index_js"]);
        break;

    case 'usoAguaPozoDelete':
        $res = $objItem->item_delete($id, "catalogo_pozo_usoagua");
        $core->print_json($res);
        break;

    /**
     * catalogo_tipo
     **/
    case 'fuenteInformacion':
        $grill_list = $objItem->get_grilla_list_sbm("catalogo_index");
        $smarty->assign("grill_list", $grill_list);
        $smarty->assign("subpage", $webm["fuenteInformacion_index"]);
        $smarty->assign("subpage_js", $webm["fuenteInformacion_index_js"]);
        break;

    case 'getFuenteInformacionList':
        $res = $objItem->get_item_datatable_Rows("catalogo_tipo", "catalogo_index");
        $core->print_json($res);
        break;

    case 'fuenteInformacionUpdate':
        $smarty->assign("type", $type);
        $smarty->assign("id", $id);

        $menu_tab = $objItem->get_item_tab_sbm($type, "index");

        $smarty->assign("menu_tab", $menu_tab);
        $smarty->assign("menu_tab_active", "general");

        if ($type == "update") {
            $item = $objItem->get_item($id, "catalogo_tipo");
            $smarty->assign("item", $item);
        }
        $smarty->assign("subpage", $webm["fuenteInformacion_item_index"]);
        $smarty->assign("subpage_js", $webm["fuenteInformacion_item_index_js"]);
        break;

    case 'fuenteInformacionDelete':
        $res = $objItem->item_delete($id, "catalogo_tipo");
        $core->print_json($res);
        break;

    case 'codice':
        echo "es una mala llamada de un snippet";
        exit;
        break;
        
}