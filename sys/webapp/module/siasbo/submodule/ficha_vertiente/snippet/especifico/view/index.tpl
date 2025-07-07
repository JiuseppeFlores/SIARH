{include file="index.css.tpl"}

<!--begin::Portlet-->
<div class="m-portlet">
    <!--begin::Form-->
    <form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}"
        id="form_especifico">
        <!-- Código de captación -->
        <input type="hidden" name="item[itemId]" id="itemId" value="{$captacionId|escape:"html"}" required>

        <div class="m-portlet__head">
            <div class="m-portlet__head-caption">
                <div class="m-portlet__head-title">
                    <h3 class="m-portlet__head-text">Datos específicos</h3>
                </div>
            </div>
        </div>

        <div class="m-portlet__body">

            <div class="m-form__section m-form__section--first">
                <div class="m-form__heading">
                    <h3 class="m-form__heading-title">Fuente de información</h3>
                </div>

                <div class="m-form__seperator m-form__seperator--dashed"></div>

                <div class="form-group m-form__group row">
                    <div class="col-lg-6">
                        <label>Nombre de entidad</label>
                        <div class="input-group">
                            <input class="form-control m-input" placeholder="Ingrese nombre de entidad" type="text"
                                name="item[fuente]" id="fuente" value="{$item.fuente|escape:"html"}" required
                                data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">
                            <div class="input-group-append">
                                <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                                    data-original-title="Texto. Ej. Texto">
                                    <i class="flaticon-questions-circular-button"></i>
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <label>Código de documento</label>
                        <div class="input-group">
                            <input class="form-control m-input" placeholder="Ingrese código de documento" type="text"
                                name="item[codigo]" id="codigo" value="{$item.codigo|escape:"html"}" required
                                data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">
                            <div class="input-group-append">
                                <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                                    data-original-title="El usuario deberá poner el código del archivo y/o carpeta de donde se está sacando la información.">
                                    <i class="flaticon-questions-circular-button"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="m-form__section m-form__section--last">
                <div class="m-form__heading">
                    <h3 class="m-form__heading-title">Datos complementarios</h3>
                </div>

                <div class="m-form__seperator m-form__seperator--dashed"></div>

                <div class="form-group m-form__group row">
                    <div class="col-lg-6">
                        <label>Uso de agua</label>
                        <div class="checkbox">
                            <div class="container-fluid">
                                {assign var="contador" value=1}
                                {assign var="total" value=$cataobj.usoagua_captacion|@count}
                                {foreach from=$cataobj.usoagua_captacion key=clave item=valor}
                                    {if $contador == 1}
                                        <div class="row">
                                        {/if}
                                        <div class="col-lg-6">
                                            <label class="m-checkbox">
                                                <input type="checkbox" value="{$clave|escape:"html"}"
                                                    name="item[usoaguaId][]" id="usoaguaId[]"
                                                    {if $clave == $usoaguaChecked.$clave} checked {/if} required
                                                    data-msg="Campo requerido. Seleccione una o más opciones.">&nbsp;{$valor|escape:"html"}
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

                <div class="col-lg-6">
                    <label>Propósito de la captación</label>
                    <div class="checkbox">
                        <div class="container-fluid">
                            {assign var="contador" value=1}
                            {assign var="total" value=$cataobj.proposito_captacion|@count}
                            {foreach from=$cataobj.proposito_captacion key=clave item=valor}
                                {if $contador == 1}
                                    <div class="row">
                                    {/if}
                                    <div class="col-lg-6">
                                        <label class="m-checkbox">
                                            <input type="checkbox" value="{$clave|escape:"html"}" name="item[propositoId][]"
                                                id="propositoId[]" {if $clave == $propositoChecked.$clave} checked {/if}
                                                required
                                                data-msg="Campo requerido. Seleccione una o más opciones.">&nbsp;{$valor|escape:"html"}
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
                <label>Propietario</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese propietario" type="text"
                        name="item[propietario]" id="propietario" value="{$item.propietario|escape:"html"}"
                        maxlength="150" data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá colocar el nombre del dueño del pozo, este puede ser de una institución o privado.">
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
                    <textarea class="form-control m-input" name="item[observaciones]" id="observaciones"
                        placeholder="Ingrese observaciones" rows="4" maxlength="150"
                        data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">{$item.observaciones|escape:"html"}</textarea>
                </div>
            </div>
        </div>
</div>
</div>

<div class="m-portlet__foot m-portlet__no-border m-portlet__foot--fit">
    <div class="m-form__actions m-form__actions--solid">
        <div class="row">
            <div class="col-lg-6">
                {if $privFace.editar == 1}
                    <button type="button" class="btn btn-primary btn-block-custom" id="btn_especifico_submit"><i
                            class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
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