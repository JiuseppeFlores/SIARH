<!--begin::Portlet-->
<div class="m-portlet">
    <!--begin::Form-->
    <form class="m-form" method="POST" action="{$getModule}" id="general_form">

        <div class="m-portlet__head">
            <div class="m-portlet__head-caption">
                <div class="m-portlet__head-title">
                    <h3 class="m-portlet__head-text">Datos Específicos</h3>
                </div>
            </div>
        </div>

        <div class="m-portlet__body">
            <div class="row">
                <div class="form-group col-lg-12">
                    <h5 class="line-separator">Fuente de Información</h5>
                </div>
            </div>

            <div class="row">
                <div class="form-group col-lg-6">
                    <!-- Código de manantial -->
                    <input class="form-control m-input" placeholder="Ingrese código de manantial" type="hidden" name="item[itemId]" id="itemId" value="{$itemId|escape:"html"}" {$privFace.input} readonly required>

                    <label class="control-label">Nombre de entidad</label>
                    <input class="form-control m-input" placeholder="Ingrese nombre de entidad" type="text" name="item[fuente]" id="fuente" value="{$item.fuente|escape:"html"}" {$privFace.input} required>
                </div>

                <div class="form-group col-lg-6">
                    <label class="control-label">Código de documento</label>
                    <input class="form-control m-input" placeholder="Ingrese código de documento" type="text" name="item[codigo]" id="codigo" value="{$item.codigo|escape:"html"}" {$privFace.input} required>
                </div>
            </div>

            <div class="row">
                <div class="form-group col-lg-12">
                    <h5 class="line-separator">Datos Complementarios</h5>
                </div>
            </div>
            
            <div class="row">
                <div class="form-group col-lg-6">
                    <label class="control-label">Tipo de manantial</label>
                    <select class="form-control" name="item[tipoId]" id="tipoId" data-placeholder="Seleccione tipo" {$privFace.input} required>
                        <option value="">Seleccione tipo de manantial</option>
                        {html_options options=$cataobj.tipo_manantial selected=$item.tipoId}
                    </select>
                </div>

                <div class="form-group col-lg-6">
                    <label class="control-label">Cantidad de ocurrencia</label>
                    <input class="form-control m-input" placeholder="Ingrese cantidad de ocurrencia" type="text" name="item[cantidad]" id="cantidad" value="{$item.cantidad|escape:"html"}" {$privFace.input} required>
                </div>
            </div>

            <div class="row">
                <div class="form-group col-lg-12">
                    <label>Uso de agua</label>
                    <div class="checkbox">
                        <div class="container-fluid">
                            {assign var="contador" value=1}
                            {foreach from=$cataobj.usoagua_manantial key=clave item=valor}
                            {if $contador == 1}
                            <div class="row">
                            {/if}
                                <div class="col-lg-6">
                                    <label class="m-checkbox">
                                        <input type="checkbox" value="{$clave|escape:"html"}" name="item[usoagua][]" id="usoagua[]" {if $clave == $usoaguaChecked.$clave} checked {/if}>&nbsp;{$valor|escape:"html"}
                                        <span></span>
                                    </label>
                                </div>
                            {if $contador == 2}
                            </div>
                            {assign var=contador value=0}
                            {/if}
                            {assign var=contador value=$contador+1}
                            {/foreach}
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="form-group col-lg-6">
                    <label class="control-label">Propiedad del agua</label>
                    <input class="form-control m-input" placeholder="Ingrese propiedad del agua" type="text" name="item[propiedad_agua]" id="propiedad_agua" value="{$item.propiedad_agua|escape:"html"}" {$privFace.input} required>
                </div>

                <div class="form-group col-lg-6">
                    <label class="control-label">Propiedad del terreno</label>
                    <input class="form-control" type="text" name="item[propiedad_terreno]" id="propiedad_terreno" placeholder="Ingrese propiedad del terreno" value="{$item.propiedad_terreno|escape:"html"}" {$privFace.input} required>
                </div>
            </div>

            <div class="row">
                <div class="form-group col-lg-6">
                    <label class="control-label">Administrador</label>
                    <input class="form-control" type="text" name="item[administrador]" id="administrador" placeholder="Ingrese administrador" value="{$item.administrador|escape:"html"}" {$privFace.input} required>
                </div>

                <div class="form-group col-lg-6">
                    <label class="control-label">Medio de surgencia</label>
                    <select class="form-control" name="item[medioId]" id="medioId" data-placeholder="Seleccione medio de surgencia" {$privFace.input} required>
                        <option value="">Seleccione medio de surgencia</option>
                        {html_options options=$cataobj.medio_surgencia selected=$item.medioId}
                    </select>
                </div>
            </div>

            <div class="row">
                <div class="form-group col-lg-6">
                    <label class="control-label">Permanencia</label>
                    <select class="form-control" name="item[permanenciaId]" id="permanenciaId" data-placeholder="Seleccione permanencia" {$privFace.input} required>
                        <option value="">Seleccione permanencia</option>
                        {html_options options=$cataobj.permanencia selected=$item.permanenciaId}
                    </select>
                </div>
            </div>

            <div class="row">
                <div class="form-group col-lg-12">
                    <label class="control-label">Observaciones</label>
                    <textarea class="form-control" name="item[observaciones]" id="observaciones" placeholder="Ingrese observaciones" rows="4">{$item.observaciones|escape:"html"}</textarea>
                </div>
            </div>

            <div class="row">
                <div class="form-group col-lg-12">
                    <h5 class="line-separator">Características Geológicas Asociadas</h5>
                </div>
            </div>

            <div class="row">
                <div class="form-group col-lg-6">
                    <label class="control-label">Edad</label>
                    <input class="form-control" type="text" name="item[edad]" id="edad" placeholder="Ingrese edad" value="{$item.edad|escape:"html"}" {$privFace.input} required>
                </div>
                <div class="form-group col-lg-6">
                    <label class="control-label">Litología</label>
                    <input class="form-control" type="text" name="item[litologia]" id="litologia" placeholder="Ingrese litología" value="{$item.litologia|escape:"html"}" {$privFace.input} required>
                </div>
            </div>

            <div class="row">
                <div class="form-group col-lg-6">
                    <label class="control-label">Estructura</label>
                    <input class="form-control" type="text" name="item[estructura]" id="estructura" placeholder="Ingrese estructura" value="{$item.estructura|escape:"html"}" {$privFace.input} required>
                </div>
            </div>
        </div>

        <div class="m-portlet__foot m-portlet__no-border m-portlet__foot--fit">
            <div class="m-form__actions m-form__actions--solid">
                <div class="row">
                    <div class="col-lg-6">
                        {if $privFace.editar == 1}
                        <button type="submit" class="btn btn-primary btn-block-custom" id="general_submit"><i class="fa fa-check"></i>&nbsp;Guardar</button>
                        {/if}
                        <button type="reset" class="btn btn-danger btn-block-custom">Cancelar</button>
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