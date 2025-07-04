<!--begin::Portlet-->
<div class="m-portlet">
    <!--begin::Form-->
    <form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}"  id="form_perfilajeelectrico" autocomplete="off">
        <input type="hidden" name="item[itemId]" id="itemId" value="{$pozoCod}">

        <div class="m-portlet__head">
            <div class="m-portlet__head-caption">
                <div class="m-portlet__head-title">
                    <h3 class="m-portlet__head-text">Datos de perfilaje eléctrico</h3>
                </div>
            </div>

        </div>

        <div class="m-portlet__body">

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Fecha</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese fecha" type="text" name="item[electrico_fecha]" id="electrico_fecha" value="{$item.electrico_fecha|date_format:'%d/%m/%Y'|escape:"html"}" data-msg="Campo requerido. Ingrese 10 caracteres con el formato dd/mm/aaaa.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Fecha a la que se está realizando el Perfilaje eléctrico."><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
        
                <div class="col-lg-6">
                    <label>Profundidad total (m)</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese profundidad total" type="text" name="item[electrico_profundidad]" id="electrico_profundidad" value="{$item.electrico_profundidad|escape:"html"}" min="0" max="999" step="0.01" data-msg="Campo requerido. Profundidad debe contener números, 3 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="La profundidad total a la que se llegó."><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-12">
                    <label>Parámetros</label>
                    <div class="checkbox">
                        <div class="container">
                            {assign var="contador" value=1}
                            {assign var="total" value=$cataobj.tipoparametro|@count}
                            {foreach from=$cataobj.tipoparametro key=clave item=valor}
                            {if $contador == 1}
                            <div class="row">
                            {/if}
                                <div class="col-lg-4">
                                    <label class="m-checkbox">
                                        <input type="checkbox" value="{$clave|escape:"html"}" name="item[electrico_parametroId][]" id="electrico_parametroId[]" {if $clave == $parametroChecked.$clave} checked {/if} data-msg="Campo requerido. Seleccione una o más opciones.">&nbsp;{$valor|escape:"html"}
                                        <span></span>
                                    </label>
                                </div>
                            {if $contador == 3}
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
                <div class="col-lg-12">
                    <label>Diagnóstico</label>
                    <div class="input-group">
                        <textarea class="form-control m-input" placeholder="Ingrese diagnóstico" type="text" name="item[electrico_diagnostico]" id="electrico_diagnostico" rows="4" maxlength="250" data-msg="Campo requerido. Ingrese 250 caracteres como máximo.">{$item.electrico_diagnostico|escape:"html"}</textarea>
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Se pondrá el diagnóstico del estudio realizado."><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">        
                <div class="col-lg-12">
                    <label>Observaciones</label>
                    <div class="input-group">
                        <textarea class="form-control m-input" placeholder="Ingrese observaciones" type="text" name="item[electrico_observaciones]" id="electrico_observaciones" rows="4" maxlength="150" data-msg="Ingrese 150 caracteres como máximo.">{$item.electrico_observaciones|escape:"html"}</textarea>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-12">
                    <label>Archivo</label>
                    <div class="custom-file">
                        <input type="file" class="form-control m-input custom-file-input" placeholder="Seleccione un archivo" name="archivo_adjunto" id="electrico_archivo_adjunto" {if $type == 'new'} minlength="2" required data-msg="Campo requerido. Seleccione un archivo." {/if} value="{$item.adjunto_nombre|escape:'html'}">
                        <label class="custom-file-label" for="archivo_adjunto">Seleccione un archivo</label>
                    </div>
                    {if $type == 'update'}
                    <p style="background-color: #e5e5e5; padding: 8px 16px;">
                        Archivo actual:&nbsp;{$item.adjunto_nombre}
                    </p>
                    {/if}
                </div>
            </div>
        </div>

        <div class="m-portlet__foot m-portlet__no-border m-portlet__foot--fit">
            <div class="m-form__actions m-form__actions--solid">
                <div class="row">
                    <div class="col-lg-12">
                        {if $privFace.editar == 1}
                        <button type="reset" class="btn btn-primary" id="btn_perfilajeelectrico_submit">{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
                        {/if}
                        <a href="{$getModule}" class="btn btn-secondary btn-block-custom" style="float: right;"><i class="fa fa-arrow-left"></i>&nbsp;Volver</a>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <!--end::Form-->
</div>
<!--end::Portlet-->

{include file="index.js.tpl"}
{include file="index.css.tpl"}