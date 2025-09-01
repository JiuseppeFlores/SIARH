{include file="sev/form/index.css.tpl"}

<form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST"  action="{$getModule}" id="form_sev">
    <input type="hidden" name="item[geofisicaId]" id="geofisicaId" value="{$geofisicaId}" required>
    <input type="hidden" name="item[tipo]" id="tipo" value="1" required>

    <div class="modal-header">
        <h4 class="modal-title">Datos línea SEV</h4>
    </div>

    <div class="modal-body">
        
        <div class="m-form__section m-form__section--first">
            <div class="m-form__heading">
                <h3 class="m-form__heading-title">Fuente de información</h3>
            </div>

            <div class="m-form__seperator m-form__seperator--dashed"></div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Nombre de entidad</label>
                    <div class="input-group" >
                        <input class="form-control m-input" placeholder="Ingrese nombre de entidad" type="text" name="item[fuente]" id="fuente" value="{$item.fuente|escape:"html"}" maxlength="150" required data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                                <i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
        
                <div class="col-lg-6">
                    <label>Código de documento</label>
                    <div class="input-group" >
                        <input class="form-control m-input" placeholder="Ingrese código de documento" type="text" name="item[codigo]" id="codigo" value="{$item.codigo|escape:"html"}" maxlength="100" required data-msg="Campo requerido. Ingrese 100 caracteres como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                                <i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="m-form__section m-form__section--last">

            <div class="m-form__seperator m-form__seperator--dashed"></div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Fecha</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese fecha" type="text" name="item[fecha]" id="fecha" value="{$item.fecha|escape:"html"}" maxlength="10" required data-msg="Campo requerido. Ingrese 10 caracteres con formato dd/mm/aaaa.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                                <i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <label>Nombre de campaña</label>
                    <div class="input-group">
                        <input class="form-control" type="text" name="item[campania]" id="caudal" placeholder="Ingrese nombre campaña" value="{$item.campania|escape:"html"}" maxlength="150" required data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                                <i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>UTM este (X)</label>
                    <div class="input-group">
                        <input class="form-control m-input" type="text" name="item[latitudUtm]" id="latitudUtmSev" placeholder="Ingrese utm este (X)" value="{$item.latitudUtm|escape:"html"}" min="0" max="999999" step="0.001" required data-msg="Campo requerido. UTM este (X) debe contener números, 6 enteros y 3 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                                <i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <label>UTM norte (Y)</label>
                    <div class="input-group">
                        <input class="form-control m-input" type="text" name="item[longitudUtm]" id="longitudUtmSev" placeholder="Ingrese utm norte (Y)" value="{$item.longitudUtm|escape:"html"}" min="0" max="9999999" step="0.001" required data-msg="Campo requerido. UTM norte (Y) debe contener números, 7 enteros y 3 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                                <i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Zona</label>
                    <div class="input-group">
                        <select class="form-control m-input select2" name="item[utmZona]" id="utmZona" required data-msg="Campo requerido. Seleccione una opción.">
                            <option value="">Seleccione zona</option>
                            <option value="19K" {if $item.utmZona == '19K'} selected {/if}>19</option>
                            <option value="20K" {if $item.utmZona == '20K'} selected {/if}>20</option>
                            <option value="21K" {if $item.utmZona == '21K'} selected {/if}>21</option>
                        </select>
                    </div>
                </div>

                <div class="col-lg-6">
                    <label>Dirección línea base</label>
                    <div class="input-group">
                        <select class="form-control m-input select2" name="item[sev_lineabaseId]" id="sev_lineabaseId" required data-msg="Campo requerido. Seleccione una opción.">
                            <option value="">Seleccione línea base</option>
                            {html_options options=$cataobj.devlineabase selected=$item.sev_lineabaseId}
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Azimut línea base</label>
                    <div class="input-group">
                        <input class="form-control m-input" type="text" name="item[sev_azimut]" id="sev_azimut" placeholder="Ingrese azimut línea base" value="{$item.sev_azimut|escape:"html"}" min="0" max="999" step="0.01" required data-msg="Campo requerido. Azimut línea base debe contener números, 3 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                                <i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-12">
                    <label>Configuración</label>
                    <div class="checkbox">
                        <div class="container">
                            {assign var="contador" value=1}
                            {assign var="total" value=$cataobj.devconfig|@count}
                            {foreach from=$cataobj.devconfig key=clave item=valor}
                            {if $contador == 1}
                            <div class="row">
                            {/if}
                                <div class="col-lg-6">
                                    <label class="m-checkbox">
                                        <input type="checkbox" value="{$clave|escape:"html"}" name="item[configuracionId][]" id="configuracionId[]" {if $clave == $opcionChecked.$clave} checked {/if} required data-msg="Campo requerido. Seleccione una o más opciones.">&nbsp;{$valor|escape:"html"}
                                        <span></span>
                                    </label>
                                </div>
                            {if $contador == 2}
                            </div>
                            {assign var=contador value=0}
                            {/if}
                            {assign var=contador value=$contador+1}
                            {/foreach}
                            {if $total mod 2 == 1}
                            </div>
                            {/if}
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>AB/2 máximo (m)</label>
                    <div class="input-group">
                        <input class="form-control" type="text" name="item[sev_abmax]" id="sev_abmax" placeholder="Ingrese AB/2 máximo" value="{$item.sev_abmax|escape:"html"}" min="0" max="99" step="0.01" required data-msg="Campo requerido. AB/2 máximo debe contener números, 2 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                                <i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <label>MN máximo (m)</label>
                    <div class="input-group">
                        <input class="form-control" type="text" name="item[sev_mnmax]" id="sev_mnmax" placeholder="Ingrese MN máximo" value="{$item.sev_mnmax|escape:"html"}" min="0" max="99" step="0.01" required data-msg="Campo requerido. MN máximo debe contener números, 2 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                                <i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Software utilizado</label>
                    <div class="input-group">
                        <input class="form-control" type="text" name="item[software_utilizado]" id="software_utilizado" placeholder="Ingrese software utilizado" value="{$item.software_utilizado|escape:"html"}" maxlength="150" required data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                                <i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <label>Equipo utilizado</label>
                    <div class="input-group">
                        <input class="form-control m-input" type="text" name="item[equipo]" id="equipo" placeholder="Ingrese equipo utilizado" value="{$item.equipo|escape:"html"}" maxlength="150" required data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                                <i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Porcentaje de error (%)</label>
                    <div class="input-group">
                        <input class="form-control m-input" type="text" name="item[sev_error]" id="sev_error" placeholder="Ingrese porcentaje de error" value="{$item.sev_error|escape:"html"}" min="0" max="100" step="0.01" required data-msg="Campo requerido. Porcentaje de error debe contener números, 3 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                                <i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-12">
                    <label>Observaciones</label>
                    <div class="input-group">
                        <textarea class="form-control m-input" name="item[observaciones]" id="observaciones" placeholder="Ingrese observaciones" rows="3" maxlength="150" data-msg="Ingrese 150 caracteres como máximo.">{$item.observaciones|escape:"html"}</textarea>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="modal-close">Cerrar</button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_sev_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>
</form>

{include file="sev/form/index.js.tpl"}