{include file="diseno/form/index.css.tpl"}

<form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}" id="form_diseno">
    <input type="hidden" name="item[pozoId]" value="{$pozoId}">
    
    <div class="modal-header">
        <h4 class="modal-title">Datos de diseño</h4>
    </div>

    <div class="modal-body">
        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Profundidad desde (m)</label>
                <div class="input-group" >
                    <input class="form-control m-input" placeholder="Ingrese profundidad desde" type="text" name="item[profundidad_desde]" id="profundidad_desde" value="{$item.profundidad_desde|escape:"html"}" min="0" max="999" step="0.01" data-msg="Campo requerido. Profundidad desde debe contener números, 3 enteros y 2 decimales como máximo">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Es la profundidad menor a la que comienza la primera rejilla."><i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Profundidad hasta (m)</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese profundidad hasta" type="text" name="item[profundidad_hasta]" id="profundidad_hasta" value="{$item.profundidad_hasta|escape:"html"}" min="0" max="999" step="0.01" data-msg="Campo requerido. Profundidad hasta debe contener números, 3 enteros y 2 decimales como máximo">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Es la profundidad mayor a la que termina la primera rejilla."><i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row ">
            <div class="col-lg-6">
                <label>Tipo de rejilla/filtro</label>
                <div class="input-group" >
                    <select class="form-control m-input select2" name="item[rejillafiltroId]" id="rejillafiltroId" data-msg="Campo requerido. Seleccione una opción.">
                        <option value="">Seleccione tipo de rejilla/filtro</option>
                        {html_options options=$cataobj.tipo_rejillafiltro selected=$item.rejillafiltroId}
                    </select>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Abertura de rejilla/filtro (mm)</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese abertura de rejilla/filtro" type="text" name="item[abertura]" id="abertura" value="{$item.abertura|escape:"html"}" min="0" max="9" step="0.01" data-msg="Campo requerido. Abertura debe contener números, 1 entero y 2 decimales como máximo">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Es la abertura de la ranura de los filtros, medido en (mm)."><i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-12">
                <label>Observaciones</label>
                <div class="input-group">
                    <textarea class="form-control m-input" name="item[observaciones]" id="observaciones" placeholder="Ingrese observaciones" rows="3" maxlength="150" data-msg="Campo requerido. Ingrese máximo 150 caracteres">{$item.observaciones|escape:"html"}</textarea>
                </div>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <!-- <button type="reset" class="btn btn-danger btn-block-custom">Cancelar</button> -->
        <button type="button" class="btn btn-secondary btn-block-custom" onclick="show_modal_window_list_diseno()">Cerrar</button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_diseno_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>

</form>

{include file="diseno/form/index.js.tpl"}