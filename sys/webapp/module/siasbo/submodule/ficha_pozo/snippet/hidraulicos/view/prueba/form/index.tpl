{include file="prueba/form/index.css.tpl"}

<form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST"  action="{$getModule}" id="form_prueba">
    <input type="hidden" name="item[pozoId]" id="bp_pozoId" value="{$pozoId}">

    <div class="modal-header">
        <h4 class="modal-title">Datos prueba de bombeo</h4>
    </div>

    <div class="modal-body">
        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Tipo de prueba</label>
                <div class="input-group">
                    <select class="form-control m-input select2" name="item[tipopruebaId]" id="tbp_tipopruebaId" data-msg="Campo requerido. Seleccione una opción.">
                        <option value="">Seleccione tipo prueba</option>
                        {html_options options=$cataobj.tipo_prueba selected=$item.tipopruebaId}
                    </select>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Fecha</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese fecha" type="text" name="item[fecha]" id="bp_fecha" value="{$item.fecha|date_format:'%d/%m/%Y'|escape:"html"}" maxlength="10" data-msg="Campo requerido. Ingrese 10 caracteres con formato dd/mm/aaaa como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Fecha de iniciación de las pruebas.">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
    
            <div class="col-lg-6">
                <label>Conductividad hidraúlica K (m/día)</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese conductividad hidraúlica" type="text" name="item[conductividad]" id="bp_conductividad" value="{$item.conductividad|escape:"html"}" min="0" max="999999" step="0.000001" data-msg="Campo requerido. Conductividad debe contener números, 6 enteros y 6 decimales como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Es la capacidad que tiene el flujo de agua para atravesar un medio.">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Transmisividad T (m2/d)</label>
                <div class="input-group" >
                    <input class="form-control m-input" placeholder="Ingrese transmisividad" type="text" name="item[transmisividad]" id="bp_transmisividad" value="{$item.transmisividad|escape:"html"}" min="0" max="999999" step="0.000001" data-msg="Campo requerido. Transmisividad debe contener números, 6 enteros y 6 decimales como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Es la capacidad que tiene un medio para transmitir agua.">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Coeficiente de almacenamiento S (adim)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[coeficiente]" id="bp_coeficiente" placeholder="Ingrese coeficiente de almacenamiento" value="{$item.coeficiente|escape:"html"}" min="0" max="99" step="0.000001" data-msg="Campo requerido. Coeficiente debe contener números, 2 enteros y 6 decimales como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Es un parámetro que indica el agua liberada cuando se disminuye la presión en el acuífero.">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Radio del cono de abatimiento (m)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[radio]" id="bp_radio" placeholder="Ingrese radio cono abatimiento" value="{$item.radio|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido. Radio debe contener números, 2 enteros y 2 decimales como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Es el cono que se forma cuando hay descarga de un acuífero y se describe en un área radial.">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Porosidad total m  (% de volumen)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[porosidad]" id="bp_porosidad" placeholder="Ingrese porosidad total m (% de volumen)" value="{$item.porosidad|escape:"html"}" min="0" max="99" step="0.00001" data-msg="Campo requerido. Porosidad debe contener números, entre el 0.00001 y 100 máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="La porosidad total esta expresado como el volumen de los huecos sobre el volumen total.">
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
                    <textarea class="form-control m-input" name="item[observaciones]" id="bp_observaciones" placeholder="Ingrese observaciones" rows="3" maxlength="150" data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">{$item.observaciones|escape:"html"}</textarea>
                </div>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="btn_modal_close">Cerrar</button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_prueba_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>
</form>

{include file="prueba/form/index.js.tpl"}