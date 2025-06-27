{include file="index.css.tpl"}

<!--begin::Portlet-->
<div class="m-portlet">
    <!--begin::Form-->
    <form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}" id="form_captacion">
        <!-- Código de captación -->
        <input type="hidden" name="item[itemId]" id="itemId" value="{$captacionId|escape:"html"}" required>

        <div class="m-portlet__head">
            <div class="m-portlet__head-caption">
                <div class="m-portlet__head-title">
                    <h3 class="m-portlet__head-text">Datos de captación</h3>
                </div>
            </div>
        </div>

        <div class="m-portlet__body">
            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Fecha de muestreo</label>
                    <div class="input-group date">
                        <input class="form-control m-input" placeholder="Ingrese fecha" type="text" name="item[fechainicio]" id="cdc_fechainicio" value="{$item.fechainicio|date_format:'%d/%m/%Y'|escape:"html"}" maxlength="10" required data-msg="Campo requerido. Ingrese 10 caracteres con formato dd/mm/aaaa como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
        
                <div class="col-lg-6">
                    <label>Conexiones de agua potable</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese conexiones agua potable" type="text" name="item[conexionesagua]" id="cdc_conexionesagua" value="{$item.conexionesagua|escape:"html"}" min="0" max="99" step="0.01" required data-msg="Campo requerido. Conexiones debe contener números, 2 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Cobertura del servicio de agua</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese cobertura servicio agua" type="text" name="item[coberturaagua]" id="cdc_coberturaagua" value="{$item.coberturaagua|escape:"html"}" min="0" max="99" step="0.01" required data-msg="Campo requerido. Cobertura debe contener números, 2 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
        
                <div class="col-lg-6">
                    <label>Número de fuentes</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese número de fuentes" type="text" name="item[numero]" id="cdc_numero" value="{$item.numero|escape:"html"}" min="0" max="99" step="0.01" required data-msg="Campo requerido. Número de fuentes debe contener números, 2 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Caudal de la fuente</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese caudal de la fuente" type="text" name="item[caudal]" id="cdc_caudal" value="{$item.caudal|escape:"html"}" min="0" max="99" step="0.01" required data-msg="Campo requerido. Cobertura debe contener números, 2 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
        
                <div class="col-lg-6">
                    <label>Tipo de almacenamiento</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese tipo de almacenamiento" type="text" name="item[almacenamiento]" id="cdc_almacenamiento" value="{$item.almacenamiento|escape:"html"}" required data-msg="Campo requerido. Ingrese 100 caracteres como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Capacidad de almacenamiento</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese capacidad de almacenamiento" type="text" name="item[capacidad]" id="cdc_capacidad" value="{$item.capacidad|escape:"html"}" min="0" max="99" step="0.01" required data-msg="Campo requerido. Capacidad debe contener números, 2 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
        
                <div class="col-lg-6">
                    <label>Aducción</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese aducción" type="text" name="item[aduccion]" id="cdc_aduccion" value="{$item.aduccion|escape:"html"}" required data-msg="Campo requerido. Ingrese 100 caracteres como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Red de distribución</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese red de distribución" type="text" name="item[red]" id="cdc_red" value="{$item.red|escape:"html"}" min="0" max="99" step="0.01" required data-msg="Campo requerido. Red debe contener números, 2 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
        
                <div class="col-lg-6">
                    <label>Área de servicio</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese área de servicio" type="text" name="item[area]" id="cdc_area" value="{$item.area|escape:"html"}" min="0" max="99" step="0.01" required data-msg="Campo requerido. Área de servicio debe contener números, 2 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-12">
                    <label>Observaciones</label>
                    <div class="input-group m-input-icon m-input-icon--right" >
                        <textarea class="form-control m-input" name="item[captaobservacion]" id="cdc_captaobservacion" placeholder="Ingrese observaciones" rows="3" maxlength="150" data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">{$item.captaobservacion|escape:"html"}</textarea>
                    </div>
                </div>
            </div>
        </div>

        <div class="m-portlet__foot m-portlet__no-border m-portlet__foot--fit">
            <div class="m-form__actions m-form__actions--solid">
                <div class="row">
                    <div class="col-lg-6">
                        {if $privFace.editar == 1}
                        <button type="button" class="btn btn-primary btn-block-custom" id="btn_captacion_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
                        {/if}
                        <!-- <button type="reset" class="btn btn-danger btn-block-custom">Cancelar</button> -->
                    </div>
                </div>
            </div>
        </div>
    </form>
    <!--end::Form-->
</div>
<!--end::Portlet-->

{include file="index.js.tpl"}