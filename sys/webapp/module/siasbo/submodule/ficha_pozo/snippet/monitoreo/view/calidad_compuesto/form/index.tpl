{include file="calidad_compuesto/form/index.css.tpl"}

<form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST"  action="{$getModule}"  id="form_calidad_compuesto">
    <input type="hidden" name="item[calidadId]" id="calcom_calidadId" value="{$calidadId}">

    <div class="modal-header">
        <h4 class="modal-title">Datos de compuesto de calidad</h4>
    </div>

    <div class="modal-body">
        <div class="form-group m-form__group row">
            <div class="col-lg-12">
                <label>Parámetro</label>
                <div class="input-group">
                    <select class="form-control m-input select2" name="item[parametroId]" id="calcom_parametroId" data-msg="Campo requerido. Seleccione un parámetro.">
                        <option value="">Seleccione parámetro</option>
                        {html_options options=$cataobj.calidad_parametro selected=$item.parametroId}
                    </select>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-12">
                <label>Compuesto</label>
                <div class="input-group">
                    <select class="form-control m-input select2" name="item[compuestoId]" id="calcom_compuestoId" data-msg="Campo requerido. Seleccione un compuesto.">
                        <option value="">Seleccione compuesto</option>
                        {if $type == 'update'} {html_options options=$calidad_compuesto selected=$item.compuestoId} {/if}
                    </select>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-12">
                <label>Valor compuesto</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese valor compuesto" type="text" name="item[valor]" id="calcom_valor" value="{$item.valor|escape:"html"}" min="0" max="999" step="0.000001" data-msg="Campo requerido. Valor debe contener números, 3 enteros y 6 decimales como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Se pondrá el valor que el laboratorio dio del compuesto a ser seleccionado."><i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row ">
            <div class="col-lg-12">
                <label>Observaciones</label>
                <div class="input-group m-input-icon m-input-icon--right" >
                    <textarea class="form-control m-input" name="item[observaciones]" id="calcom_observaciones" placeholder="Ingrese observaciones" rows="3" maxlength="150" data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">{$item.observaciones|escape:"html"}</textarea>
                </div>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="btn_modal_close">Cerrar</button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_calidad_compuesto_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>
</form>

{include file="calidad_compuesto/form/index.js.tpl"}