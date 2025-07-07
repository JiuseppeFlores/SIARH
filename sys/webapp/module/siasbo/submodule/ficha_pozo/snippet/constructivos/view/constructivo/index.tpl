{include file="constructivo/index.css.tpl"}
<!--begin::Portlet-->
<div class="m-portlet">
    <!--begin::Form-->
    <form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}"  id="form_constructivo" autocomplete="off">

        <input type="hidden" name="item[itemId]" id="itemId" value="{$pozoCod}">

        <div class="m-portlet__head">
            <div class="m-portlet__head-caption">
                <div class="m-portlet__head-title">
                    <h3 class="m-portlet__head-text">Datos constructivos</h3>
                </div>
            </div>
        </div>

        <div class="m-portlet__body">

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Profundidad del entubado (m)</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese profundidad del entubado" type="text" name="item[constructivo_entubado]" id="constructivo_entubado" value="{$item.constructivo_entubado|escape:"html"}" min="0" max="999" step="0.01" data-msg="Campo requerido: 3 enteros y 2 decimales">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Se deberá poner la profundidad total a la que se realizó el entubado que es menor a la profundidad de perforación."><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
        
                <div class="col-lg-6">
                    <label>Diámetro del entubado (pulg)</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese diámetro del entubado" type="text" name="item[constructivo_entubado_diametro]" id="constructivo_entubado_diametro" value="{$item.constructivo_entubado_diametro|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido: 2 enteros y 2 decimales">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="El diámetro de entubado debe ser menor al diámetro de perforación."><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div> 

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Altura de la boca de pozo (m)</label>
                    <div class="input-group">
                        <input class="form-control m-input" type="text" name="item[constructivo_altura]" id="constructivo_altura" placeholder="Ingrese altura de la boca de pozo" value="{$item.constructivo_altura|escape:"html"}" min="-999.99" max="999.99" step="0.01" data-msg="Campo requerido: 3 enteros y 2 decimales">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Conocido también como ADEME, se mide desde el nivel del suelo hasta la boca de la tubería que sobresale."><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <label>Tipo de tubería</label>
                    <div class="input-group" >
                        <select class="form-control m-input select2" name="item[constructivo_tuberiaId]" id="constructivo_tuberiaId" data-msg="Campo requerido: seleccione una opción">
                            <option value="">Seleccione tipo de tubería</option>
                            {html_options options=$cataobj.tipo_tuberia selected=$item.constructivo_tuberiaId}
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Diámetro de la grava (mm)</label>
                    <div class="input-group">
                        <input class="form-control m-input" type="text" name="item[constructivo_diametro]" id="constructivo_diametro" placeholder="Ingrese diámetro de la grava" value="{$item.constructivo_diametro|escape:"html"}" data-msg="Campo requerido: Ej: 1 a 4 mm">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="La grava es el material con el que se rellenará el pozo, el diámetro de la grava debe ser mayor a la longitud de la ranura del filtro."><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <label>Sello sanitario</label>
                    <div class="input-group" >
                        <select class="form-control m-input select2" name="item[constructivo_selloId]" id="constructivo_selloId" data-msg="Campo requerido: seleccione una opción">
                            <option value="" selected>Seleccione sello sanitario</option>
                            {html_options options=$cataobj.tipo_sello selected=$item.constructivo_selloId}
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-12">
                    <label>Observaciones</label>
                    <div class="input-group">
                        <textarea class="form-control m-input" name="item[constructivo_observaciones]" id="constructivo_observaciones" placeholder="Ingrese observaciones" rows="3" maxlength="150" data-msg="Un máximo de 150 caracteres">{$item.constructivo_observaciones|escape:"html"}</textarea>
                    </div>
                </div>
            </div>
        </div>
       

        <div class="m-portlet__foot m-portlet__no-border m-portlet__foot--fit">
            <div class="m-form__actions m-form__actions--solid">
                <div class="row">
                    <div class="col-lg-12">
                        {if $privFace.editar == 1}
                        <button type="button" class="btn btn-primary btn-block-custom" id="btn_constructivo_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
                        {/if}
                        {if $privFace.editar == 1}
                        <button type="button" class="btn btn-info btn-block-custom" style="float: right;" onclick="javascript:get_diseno({$pozoCod});"><i class="fa fa-plus"></i>&nbsp;Ver y Agregar Rejilla/filtro</button>
                        {/if}
                        <a href="{$getModule}" class="btn btn-secondary btn-block-custom"><i class="fa fa-arrow-left"></i>&nbsp;Volver</a>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <!--end::Form-->
</div>
<!--end::Portlet-->

{include file="constructivo/index.js.tpl"}