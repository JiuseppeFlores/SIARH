<?
/**
 * configuración de los temas
 */
$templateDir = "../.".$path_sbm_snippet_index."view/";
$smarty->assign("templateDirModule",$templateDir);
/**
 * Item Principal Proyecto adm. directa
 **/
$webm["index"] = "index.tpl";
$webm["index_js"] = "index.js.tpl";

/**
 * catalogo_geofisica_dev_config
 **/
$webm["geofisicaDevConfig_index"] = "geofisicaDevConfig_index.tpl";
$webm["geofisicaDevConfig_index_js"] = "geofisicaDevConfig_index.js.tpl";

/**
 * catalogo_geofisica_dev_lineabase
 **/
$webm["geofisicaDevLineabase_index"] = "geofisicaDevLineabase_index.tpl";
$webm["geofisicaDevLineabase_index_js"] = "geofisicaDevLineabase_index.js.tpl";

/**
 * catalogo_geofisica_tomografia_config
 **/
$webm["geofisicaTomografiaConfig_index"] = "geofisicaTomografiaConfig_index.tpl";
$webm["geofisicaTomografiaConfig_index_js"] = "geofisicaTomografiaConfig_index.js.tpl";

/**
 * catalogo_manantial_medio
 **/
$webm["medioSurgencia_index"] = "medioSurgencia_index.tpl";
$webm["medioSurgencia_index_js"] = "medioSurgencia_index.js.tpl";

/**
 * catalogo_manantial_permanencia
 **/
$webm["tipoPermanencia_index"] = "tipoPermanencia_index.tpl";
$webm["tipoPermanencia_index_js"] = "tipoPermanencia_index.js.tpl";

/**
 * catalogo_manantial_tipo
 **/
$webm["tipoManantial_index"] = "tipoManantial_index.tpl";
$webm["tipoManantial_index_js"] = "tipoManantial_index.js.tpl";

/**
 * catalogo_manantial_usoagua
 **/
$webm["usoAguaManantial_index"] = "usoAguaManantial_index.tpl";
$webm["usoAguaManantial_index_js"] = "usoAguaManantial_index.js.tpl";

/**
 * catalogo_pozo_constructivo_rejillafiltro
 **/
$webm["tipoRejillaFiltro_index"] = "tipoRejillaFiltro_index.tpl";
$webm["tipoRejillaFiltro_index_js"] = "tipoRejillaFiltro_index.js.tpl";

/**
 * catalogo_pozo_constructivo_sello
 **/
$webm["tipoSello_index"] = "tipoSello_index.tpl";
$webm["tipoSello_index_js"] = "tipoSello_index.js.tpl";

/**
 * catalogo_pozo_constructivo_tuberia
 **/
$webm["tipoTuberia_index"] = "tipoTuberia_index.tpl";
$webm["tipoTuberia_index_js"] = "tipoTuberia_index.js.tpl";

/**
 * catalogo_pozo_electrico_parametro
 **/
$webm["parametroElectrico_index"] = "parametroElectrico_index.tpl";
$webm["parametroElectrico_index_js"] = "parametroElectrico_index.js.tpl";

/**
 * catalogo_pozo_implementacion_tipo
 **/
$webm["tipoEnergia_index"] = "tipoEnergia_index.tpl";
$webm["tipoEnergia_index_js"] = "tipoEnergia_index.js.tpl";

/**
 * catalogo_pozo_perforacion
 **/
$webm["tipoPozo_index"] = "tipoPozo_index.tpl";
$webm["tipoPozo_index_js"] = "tipoPozo_index.js.tpl";

/**
 * catalogo_pozo_perforacion_metodo
 **/
$webm["metodoPerforacion_index"] = "metodoPerforacion_index.tpl";
$webm["metodoPerforacion_index_js"] = "metodoPerforacion_index.js.tpl";

/**
 * catalogo_pozo_perforacion_tipo
 **/
$webm["tipoPerforacion_index"] = "tipoPerforacion_index.tpl";
$webm["tipoPerforacion_index_js"] = "tipoPerforacion_index.js.tpl";

/**
 * catalogo_pozo_proposito
 **/
$webm["propositoPozo_index"] = "propositoPozo_index.tpl";
$webm["propositoPozo_index_js"] = "propositoPozo_index.js.tpl";

/**
 * catalogo_pozo_usoagua
 **/
$webm["usoAguaPozo_index"] = "usoAguaPozo_index.tpl";
$webm["usoAguaPozo_index_js"] = "usoAguaPozo_index.js.tpl";

/**
 * catalogo_tipo
 **/
$webm["fuenteInformacion_index"] = "fuenteInformacion_index.tpl";
$webm["fuenteInformacion_index_js"] = "fuenteInformacion_index.js.tpl";
/*------------------------------------------------------------------------------*/
/**
 * Construcción del formularios y otros
 */
$template_folder = "item/";
$webm["item_index"] = $template_folder."index.tpl";
$webm["item_index_js"] = $template_folder."index.js.tpl";

/**
 * catalogo_geofisica_dev_config
 **/
$template_folder = "geofisicaDevConfig_item/";
$webm["geofisicaDevConfig_item_index"] = $template_folder."index.tpl";
$webm["geofisicaDevConfig_item_index_js"] = $template_folder."index.js.tpl";

/**
 * catalogo_geofisica_dev_lineabase
 **/
$template_folder = "geofisicaDevLineabase_item/";
$webm["geofisicaDevLineabase_item_index"] = $template_folder."index.tpl";
$webm["geofisicaDevLineabase_item_index_js"] = $template_folder."index.js.tpl";

/**
 * catalogo_geofisica_tomografia_config
 **/
$template_folder = "geofisicaTomografiaConfig_item/";
$webm["geofisicaTomografiaConfig_item_index"] = $template_folder."index.tpl";
$webm["geofisicaTomografiaConfig_item_index_js"] = $template_folder."index.js.tpl";

/**
 * catalogo_manantial_medio
 **/
$template_folder = "medioSurgencia_item/";
$webm["medioSurgencia_item_index"] = $template_folder."index.tpl";
$webm["medioSurgencia_item_index_js"] = $template_folder."index.js.tpl";

/**
 * catalogo_manantial_permanencia
 **/
$template_folder = "tipoPermanencia_item/";
$webm["tipoPermanencia_item_index"] = $template_folder."index.tpl";
$webm["tipoPermanencia_item_index_js"] = $template_folder."index.js.tpl";

/**
 * catalogo_manantial_tipo
 **/
$template_folder = "tipoManantial_item/";
$webm["tipoManantial_item_index"] = $template_folder."index.tpl";
$webm["tipoManantial_item_index_js"] = $template_folder."index.js.tpl";

/**
 * catalogo_manantial_usoagua
 **/
$template_folder = "usoAguaManantial_item/";
$webm["usoAguaManantial_item_index"] = $template_folder."index.tpl";
$webm["usoAguaManantial_item_index_js"] = $template_folder."index.js.tpl";

/**
 * catalogo_pozo_constructivo_rejillafiltro
 **/
$template_folder = "tipoRejillaFiltro_item/";
$webm["tipoRejillaFiltro_item_index"] = $template_folder."index.tpl";
$webm["tipoRejillaFiltro_item_index_js"] = $template_folder."index.js.tpl";

/**
 * catalogo_pozo_constructivo_sello
 **/
$template_folder = "tipoSello_item/";
$webm["tipoSello_item_index"] = $template_folder."index.tpl";
$webm["tipoSello_item_index_js"] = $template_folder."index.js.tpl";

/**
 * catalogo_pozo_constructivo_tuberia
 **/
$template_folder = "tipoTuberia_item/";
$webm["tipoTuberia_item_index"] = $template_folder."index.tpl";
$webm["tipoTuberia_item_index_js"] = $template_folder."index.js.tpl";

/**
 * catalogo_pozo_electrico_parametro
 **/
$template_folder = "parametroElectrico_item/";
$webm["parametroElectrico_item_index"] = $template_folder."index.tpl";
$webm["parametroElectrico_item_index_js"] = $template_folder."index.js.tpl";

/**
 * catalogo_pozo_implementacion_tipo
 **/
$template_folder = "tipoEnergia_item/";
$webm["tipoEnergia_item_index"] = $template_folder."index.tpl";
$webm["tipoEnergia_item_index_js"] = $template_folder."index.js.tpl";

/**
 * catalogo_pozo_perforacion
 **/
$template_folder = "tipoPozo_item/";
$webm["tipoPozo_item_index"] = $template_folder."index.tpl";
$webm["tipoPozo_item_index_js"] = $template_folder."index.js.tpl";

/**
 * catalogo_pozo_perforacion_metodo
 **/
$template_folder = "metodoPerforacion_item/";
$webm["metodoPerforacion_item_index"] = $template_folder."index.tpl";
$webm["metodoPerforacion_item_index_js"] = $template_folder."index.js.tpl";

/**
 * catalogo_pozo_perforacion_tipo
 **/
$template_folder = "tipoPerforacion_item/";
$webm["tipoPerforacion_item_index"] = $template_folder."index.tpl";
$webm["tipoPerforacion_item_index_js"] = $template_folder."index.js.tpl";

/**
 * catalogo_pozo_proposito
 **/
$template_folder = "propositoPozo_item/";
$webm["propositoPozo_item_index"] = $template_folder."index.tpl";
$webm["propositoPozo_item_index_js"] = $template_folder."index.js.tpl";

/**
 * catalogo_pozo_usoagua
 **/
$template_folder = "usoAguaPozo_item/";
$webm["usoAguaPozo_item_index"] = $template_folder."index.tpl";
$webm["usoAguaPozo_item_index_js"] = $template_folder."index.js.tpl";

/**
 * catalogo_tipo
 **/
$template_folder = "fuenteInformacion_item/";
$webm["fuenteInformacion_item_index"] = $template_folder."index.tpl";
$webm["fuenteInformacion_item_index_js"] = $template_folder."index.js.tpl";