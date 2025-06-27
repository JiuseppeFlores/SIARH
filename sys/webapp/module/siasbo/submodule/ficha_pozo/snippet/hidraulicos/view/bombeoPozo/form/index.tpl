{include file="bombeoPozo/form/index.css.tpl"}

<form class="m-form m-form--fit m-form--label-align-right" method="POST"  action="{$getModule}"  id="form_bombeo_pozo">
<input type="hidden" name="item[pozoId]" id="bp_pozoId" value="{$pozoId}">
<input type="hidden" name="item[tipobombeoId]" id="bp_tipobombeoId" value="1">

    <div class="modal-header">
        <h4 class="modal-title">Prueba de bombeo en pozo</h4>
    </div>

    <div class="modal-body">        
        <div class="form-group m-form__group row ">
            <div class="col-lg-6">
                <label>Fecha</label>
                <div class="input-group m-input-icon m-input-icon--right" >
                    <input class="form-control m-input" placeholder="Ingrese fecha" type="text" name="item[fecha]" id="bp_fecha" value="{$item.fecha|date_format:'%d/%m/%Y'|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
    
            <div class="col-lg-6">
                <label>Conductividad hidraúlica K (m/día)</label>
                <div class="input-group m-input-icon m-input-icon--right" >
                    <input class="form-control m-input" placeholder="Ingrese conductividad hidraúlica" type="text" name="item[conductividad]" id="bp_conductividad" value="{$item.conductividad|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Transmisividad T (m2/d)</label>
                <div class="input-group m-input-icon m-input-icon--right" >
                    <input class="form-control m-input" placeholder="Ingrese transmisividad" type="text" name="item[transmisividad]" id="bp_transmisividad" value="{$item.transmisividad|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Coeficiente de almacenamiento S (adim)</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input class="form-control" type="text" name="item[coeficiente]" id="bp_coeficiente" placeholder="Ingrese coeficiente de almacenamiento" value="{$item.coeficiente|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Radio del cono de abatimiento (m)</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input class="form-control" type="text" name="item[radio]" id="bp_radio" placeholder="Ingrese radio cono abatimiento" value="{$item.radio|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Porosidad total m (% de volumen)</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input class="form-control" type="text" name="item[porosidad]" id="bp_porosidad" placeholder="Ingrese porosidad total m (% de volumen)" value="{$item.porosidad|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-12">
                <label>Observaciones</label>
                <div class="input-group">
                    <textarea class="form-control" name="item[observaciones]" id="bp_observaciones" placeholder="Ingrese observaciones" rows="3">{$item.observaciones|escape:"html"}</textarea>
                </div>
            </div>
        </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="modal-close">Cerrar</button>
        <!-- <button type="reset" class="btn btn-danger btn-block-custom">Cancelar</button> -->
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_bombeo_pozo_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>
</form>

{include file="bombeoPozo/form/index.js.tpl"}