<!--begin::Portlet-->
<div class="m-portlet">
    <!--begin::Form-->
    <form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}" id="general_form">

        <div class="m-portlet__head">
            <div class="m-portlet__head-caption">
                <div class="m-portlet__head-title">
                    <h3 class="m-portlet__head-text">Catálogo compuestos de calidad</h3>
                </div>
            </div>
        </div>

        <div class="m-portlet__body">
            <div class="form-group m-form__group row">
                <div class="col-md-6">
                    <label>Nombre</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese nombre" type="text" name="item[nombre]" id="nombre" value="{$item.nombre|escape:"html"}" maxlength="100" required data-msg="Campo requerido. Ingrese 100 caracteres como máximo.">
                    </div>
                </div>

                <div class="col-md-6">
                    <label>Parámetro</label>
                    <select class="form-control m-input select2" name="item[calidadparametroId]" id="calidadparametroId" required data-msg="Campo requerido. Seleccione una opción.">
                        <option value="">Seleccione parámetro</option>
                        {html_options options=$cataobj.parametro selected=$item.calidadparametroId}
                    </select>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-md-6">
                    <label>Estado</label>
                    <select class="form-control m-input select2" name="item[activo]" id="activo" data-placeholder="Seleccione estado" required data-msg="Campo requerido. Seleccione una opción.">
                        <option value="">Seleccione estado</option>
                        <option value="1" {if $item.activo == '1'} selected {/if}>ACTIVO</option>
                        <option value="0" {if $item.activo == '0'} selected {/if}>INACTIVO</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="m-portlet__foot m-portlet__no-border m-portlet__foot--fit">
            <div class="m-form__actions m-form__actions--solid">
                <div class="row">
                    <div class="col-lg-6">
                        {if $privFace.editar == 1}
                        <button type="submit" class="btn btn-primary btn-block-custom" id="general_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'} Guardar {else} Modificar {/if}</button>
                        {/if}
                        <button type="button" class="btn btn-light btn-block-custom" id="general_volver">Volver</button>
                    </div>
                </div>
            </div>
        </div>

    </form>
    <!--end::Form-->
</div>
<!--end::Portlet-->

{include file="form/index.js.tpl"}
{include file="form/index.css.tpl"}