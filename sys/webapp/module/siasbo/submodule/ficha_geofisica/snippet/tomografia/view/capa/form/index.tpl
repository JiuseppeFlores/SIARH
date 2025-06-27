{include file="capa/form/index.css.tpl"}

<form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}" id="form_tomografia_capa">
    <input type="hidden" name="item[geofisicaId]" value="{$geofisicaId}">
    
    <div class="modal-header">
        <h4 class="modal-title">Datos de capa</h4>
    </div>

    <div class="modal-body">
        <div class="form-group m-form__group row">
            <div class="col-lg-4">
                <label>Profundidad desde (m)</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Profundidad desde" type="text" name="item[profundidad_desde]" id="capa_profundidad_desde" value="{$item.profundidad_desde|escape:"html"}" min="0" max="999" step="0.01" required data-msg="Campo requerido. Profundidad desde debe contener números, 3 enteros y 2 decimales como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <label>Profundidad hasta (m)</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Profundidad hasta" type="text" name="item[profundidad_hasta]" id="capa_profundidad_hasta" value="{$item.profundidad_hasta|escape:"html"}" min="0" max="999" step="0.01" required data-msg="Campo requerido. Profundidad hasta debe contener números, 3 enteros y 2 decimales como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <label>Resistividad (ohmio*m)</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Resistividad" type="text" name="item[resistividad]" id="capa_resistividad" value="{$item.resistividad|escape:"html"}" min="0" max="999999" step="0.01" required data-msg="Campo requerido. Resistividad debe contener números, 6 enteros y 2 decimales como máximo.">
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
                <label>Litología</label>
                <div class="input-group">
                    <textarea class="form-control" name="item[litologia]" id="capa_litologia" placeholder="Ingrese litología" rows="3" maxlength="150" required data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">{$item.litologia|escape:"html"}</textarea>
                </div>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" onclick="show_modal_window_list_tomografia_capa()">Cerrar</button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_tomografia_capa_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>

</form>

{include file="capa/form/index.js.tpl"}