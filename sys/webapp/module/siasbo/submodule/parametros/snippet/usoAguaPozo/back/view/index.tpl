<!--begin::Portlet-->
<div class="m-portlet">
    <!--begin::Form-->
    <form class="m-form" method="POST" action="{$getModule}" id="general_form">

        <div class="m-portlet__head">
            <div class="m-portlet__head-caption">
                <div class="m-portlet__head-title">
                    <h3 class="m-portlet__head-text">Catálogo Usos de Agua de Pozo</h3>
                </div>
            </div>

        </div>

        <div class="m-portlet__body">
            <div class="row">
                <div class="form-group col-md-6">
                    <label class="control-label">Nombre</label>
                    <input class="form-control m-input" placeholder="Ingrese nombre" type="text" name="item[nombre]" id="nombre" value="{$item.nombre|escape:"html"}" maxlength="100" {$privFace.input} required autofocus/>
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
                        <a class="btn btn-secondary btn-block-custom" href="{$getModule}&accion=usoAguaPozo" ><i class="fa fa-arrow-left"></i>&nbsp;Volver</a>
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