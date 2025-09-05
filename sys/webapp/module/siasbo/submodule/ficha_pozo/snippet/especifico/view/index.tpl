{include file="index.css.tpl"}

<!--begin::Portlet-->
<div class="m-portlet">
    <!--begin::Form-->
    <form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}"  id="form_especifico" autocomplete="off">
        
        <input type="hidden" name="item[itemId]" id="itemId" value="{$pozoCod}">

        <div class="m-portlet__head">
            <div class="m-portlet__head-caption">
                <div class="m-portlet__head-title">
                    <h3 class="m-portlet__head-text">Datos específicos</h3>
                </div>
            </div>
        </div>

        <div class="m-portlet__body">

            <div class="m-form__section m-form__section--first">

                <div class="form-group m-form__group row">
                    <div class="col-lg-6">
                        <label>Fuente de información</label>
                        <div class="input-group" >
                        	<!-- Poner atributo 'required' antes de 'title' -->
                            <input class="form-control m-input" placeholder="Ingrese fuente de información" type="text" name="item[fuente_informacion]" id="fuente_informacion" value="{$item.fuente_informacion|escape:"html"}" maxlength="200" title="Campo requerido: máximo 200 caracteres">
                            <div class="input-group-append">
                                <span class="input-group-text" data-toggle="m-tooltip" title="El usuario pondrá la fuente de información de donde se está sacando todos los datos."><i class="flaticon-questions-circular-button"></i>
                                </span>
                            </div>
                        </div>                        
                    </div>
            
                    <div class="col-lg-6">
                        <label>Código de documento</label>
                        <div class="input-group" >
                            <input class="form-control m-input" placeholder="Ingrese código de documento" type="text" name="item[codigo]" id="codigo" value="{$item.codigo|escape:"html"}" maxlength="150" title="Campo requerido: máximo 150 caracteres">
                            <div class="input-group-append">
                                <span class="input-group-text" data-toggle="m-tooltip" title="El usuario deberá poner el código del archivo y/o carpeta de donde se está sacando la información."><i class="flaticon-questions-circular-button"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Uso de agua</label>
                    <div class="checkbox">
                        <div class="container">
                            {assign var="contador" value=1}
                            {assign var="total" value=$cataobj.usoagua_pozo|@count}
                            {foreach from=$cataobj.usoagua_pozo key=clave item=valor}
                            {if $contador == 1}
                            <div class="row">
                            {/if}
                                <div class="col-lg-6">
                                    <label class="m-checkbox">
                                        <input type="checkbox" value="{$clave|escape:"html"}" name="item[usoaguaId][]" id="usoaguaId[]" {if $clave == $usoaguaChecked.$clave} checked {/if} title="Campo requerido: seleccion una opción">&nbsp;{$valor|escape:"html"}
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

                    <div class="row">
                        <label>Propósito de pozo</label>
                        <div class="col-lg-12" >
                            <div class="checkbox">
                                <div class="container">
                                    {assign var="contador" value=1}
                                    {assign var="total" value=$cataobj.proposito_pozo|@count}
                                    {foreach from=$cataobj.proposito_pozo key=clave item=valor}
                                    {if $contador == 1}
                                    <div class="row">
                                    {/if}
                                        <div class="col-lg-6">
                                            <label class="m-checkbox">
                                                <input type="checkbox" value="{$clave|escape:"html"}" name="item[propositoId][]" id="propositoId[]" {if $clave == $propositoChecked.$clave} checked {/if} title="Campo requerido: seleccione una opción">&nbsp;{$valor|escape:"html"}
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

                    <div class="row" id="caso_red_monitoreo">
                        <label>Redes de Monitoreo</label>
                        <div class="input-group" >
                            <select class="form-control m-input select2" name="item[redMonitoreoId]" id="redMonitoreoId" data-msg="Campo requerido: seleccione una opción">
                                <option value="">Seleccione red de Monitoreo</option>
                                {html_options options=$cataobj.listaRedMonitoreo selected=$item.redMonitoreoId}
                            </select>
                        </div>  
                    </div>

                </div>
            </div>         

            <div class="form-group m-form__group row">
                <div class="col-lg-12">
                    <label>Propietario</label>
                    <div class="input-group">
                        <input class="form-control m-input" type="text" name="item[propietario]" id="propietario" placeholder="Ingrese propietario" value="{$item.propietario|escape:"html"}" maxlength="150" title="Campo requerido: máximo 150 caracteres">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" title="El usuario deberá colocar el nombre del dueño del pozo, este puede ser de una institución o privado."><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-12">
                    <label>Observaciones</label>
                    <div class="input-group">
                        <textarea class="form-control m-input" name="item[observaciones]" id="observaciones" placeholder="Ingrese observaciones" rows="3" maxlength="150" title="Un máximo de 150 caracteres">{$item.observaciones|escape:"html"}</textarea>
                    </div>
                </div>
            </div>
        </div>

        <div class="m-portlet__foot m-portlet__no-border m-portlet__foot--fit">
            <div class="m-form__actions m-form__actions--solid">
                <div class="row">
                    <div class="col-lg-12">
                        {if $privFace.editar == 1}
                        <button type="submit" class="btn btn-primary btn-block-custom" id="btn_especifico_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
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