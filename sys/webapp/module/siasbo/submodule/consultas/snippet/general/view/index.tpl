<!--begin::Portlet-->
<div class="m-portlet">
    <!--begin::Form-->
    <form class="m-form m-form--fit m-form--label-align-right m-form--group-seperator-dashed" method="POST" action="{$getModule}"  id="general_form">

        <div class="m-portlet__head">
            <div class="m-portlet__head-caption">
                <div class="m-portlet__head-title">
                    <h3 class="m-portlet__head-text"> Datos Generales</h3>
                </div>
            </div>

        </div>

        <div class="m-portlet__body">




            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Nombre:</label>
                    <div class="m-input-icon m-input-icon--right">
                        <input class="form-control m-input" placeholder="Ingrese nombre del pozo" type="text" name="item[nombre]" value="{$item.nombre|escape:"html"}" {$privFace.input}>
                        <span class="m-input-icon__icon m-input-icon__icon--right"><span><i class="flaticon-imac"></i></span></span>
                    </div>
                </div>
                <div class="col-lg-6">
                    <label>Codigo:</label>
                    <div class="m-input-icon m-input-icon--right">
                        <input class="form-control m-input" placeholder="Ingrese Codigo" type="text" name="item[codigo]" value="{$item.codigo|escape:"html"}" {$privFace.input}>
                        <span class="m-input-icon__icon m-input-icon__icon--right"><span><i class="flaticon-imac"></i></span></span>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">

                <div class="col-lg-6">
                    <label>Departamento:</label>
                    <div class="m-input-icon m-input-icon--right">
                        <select class="form-control m-select2 select2_general" name="item[departamentoId]" data-placeholder="Elija una Categoría" {$privFace.input}>
                            <option></option>
                            {html_options options=$cataobj.departamento selected=$item.departamentoId}
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Comunidad:</label>
                    <div class="m-input-icon m-input-icon--right">
                        <input class="form-control m-input" placeholder="Ingrese nombre del pozo" type="text" name="item[comunidad]" value="{$item.comunidad|escape:"html"}" {$privFace.input}>
                        <span class="m-input-icon__icon m-input-icon__icon--right"><span><i class="flaticon-imac"></i></span></span>
                    </div>
                </div>
                <div class="col-lg-6">
                    <label>Localidad:</label>
                    <div class="m-input-icon m-input-icon--right">
                        <input class="form-control m-input" placeholder="Ingrese Codigo" type="text" name="item[localidad]" value="{$item.localidad|escape:"html"}" {$privFace.input}>
                        <span class="m-input-icon__icon m-input-icon__icon--right"><span><i class="flaticon-imac"></i></span></span>
                    </div>
                </div>
            </div>




        </div>

        <div class="m-portlet__foot m-portlet__no-border m-portlet__foot--fit">
            <div class="m-form__actions m-form__actions--solid">
                <div class="row">
                    <div class="col-lg-6">
                        {if $privFace.editar == 1}
                        <button type="reset" class="btn btn-primary" id="general_submit">Guardar Cambios</button>
                        {/if}
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