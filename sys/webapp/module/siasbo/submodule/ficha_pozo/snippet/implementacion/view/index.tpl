<!--begin::Portlet-->
<div class="m-portlet">
    <!--begin::Form-->
    <form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}" id="form_implementacion" autocomplete="off">

        <input type="hidden" name="item[itemId]" id="itemId" value="{$pozoCod}">

        <div class="m-portlet__head">
            <div class="m-portlet__head-caption">
                <div class="m-portlet__head-title">
                    <h3 class="m-portlet__head-text">Datos de implementación</h3>
                </div>
            </div>

        </div>

        <div class="m-portlet__body">

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Profundidad de la bomba (m.b.b.p.)</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese profundidad de la bomba" type="text" name="item[imple_profundidad]" id="imple_profundidad" value="{$item.imple_profundidad|escape:"html"}" min="0" max="999" step="0.01" data-msg="Campo requerido. Profundidad debe contener números, 3 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="tooltip" title="Es la profundidad a la que la bomba está dentro del pozo."><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
        
                <div class="col-lg-6">
                    <label>Tipo de energía</label>
                    <div class="input-group">
                        <select class="form-control m-input select2" name="item[imple_tipoId]" id="imple_tipoId" data-msg="Campo requerido. Seleccione una opción.">
                            <option value="">Seleccione tipo de energía</option>
                            {html_options options=$cataobj.tipoenergia selected=$item.imple_tipoId}
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Caudal de bombeo (l/s)</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese caudal de bombeo" type="text" name="item[imple_caudal]" id="imple_caudal" value="{$item.imple_caudal|escape:"html"}" min="0" max="999" step="0.01" data-msg="Campo requerido. Caudal debe contener números, 3 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="tooltip" title="Volumen de agua extraído en una unidad de tiempo por medios mecánicos o artificiales."><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
        
                <div class="col-lg-6">
                    <label>Horario de bombeo (horas/día)</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese horario de bombeo" type="text" name="item[imple_horario_bombeo]" id="imple_horario_bombeo" value="{$item.imple_horario_bombeo|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido. Horario debe contener numeros, 2 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="tooltip" title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Potencia de la bomba (HP)</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese potencia de la bomba" type="text" name="item[imple_potencia]" id="imple_potencia" value="{$item.imple_potencia|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido. Potencia debe contener números, 2 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="tooltip" title="Es la Capacidad que tiene la bomba de agua para brindar cierta cantidad de energía por unidad de tiempo."><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-12">
                    <label>Observaciones</label>
                    <div class="input-group">
                        <textarea class="form-control m-input" name="item[imple_observaciones]" id="imple_observaciones" placeholder="Ingrese observaciones" rows="3" maxlength="150" data-msg="Ingrese 150 caracteres como máximo.">{$item.imple_observaciones|escape:"html"}</textarea>
                    </div>
                </div>
            </div>

        </div>

        <div class="m-portlet__foot m-portlet__no-border m-portlet__foot--fit">
            <div class="m-form__actions m-form__actions--solid">
                <div class="row">
                    <div class="col-lg-12">
                        {if $privFace.editar == 1}
                        <button type="button" class="btn btn-primary btn-block-custom" id="btn_implementacion_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
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