{include file="cantidad/form/index.css.tpl"}

<form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}" id="form_cantidad">
    <input type="hidden" name="item[manantialId]" value="{$manantialId}" required>

    <div class="modal-header">
        <h4 class="modal-title">Datos de cantidad</h4>
    </div>

    <div class="modal-body">        
        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Fecha</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese fecha" type="text" name="item[fecha]" id="cant_fecha" value="{$item.fecha|date_format:'%d/%m/%Y'|escape:"html"}" maxlength="10" data-msg="Campo requerido. Ingrese 10 caracteres como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Caudal (l/s)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[caudal]" id="cant_caudal" placeholder="Ingrese caudal" value="{$item.caudal|escape:"html"}" min="0" max="9999" step="0.01" data-msg="Campo requerido. Caudal debe contener números, 3 enteros y 2 decimales como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
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
                    <textarea class="form-control m-input" name="item[observaciones]" id="cant_observaciones" placeholder="Ingrese observaciones" rows="4" maxlength="150" data-msg="Campo requerido. Ingrese 10 caracteres como máximo.">{$item.observaciones|escape:"html"}</textarea>
                </div>              
            </div>             
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="btn_modal_close">Cerrar</button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_monitor_cantidad_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>
</form>

{include file="cantidad/form/index.js.tpl"}