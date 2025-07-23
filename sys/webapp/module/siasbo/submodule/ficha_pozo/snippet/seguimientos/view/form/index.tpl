{include file="form/index.css.tpl"}

<form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}" id="form_seguimiento" autocomplete="off">
    <input type="hidden" name="item[pozoId]" id="pozoId" value="{$pozoCod}">

    <div class="modal-header">
        <h4 class="modal-title">Datos de seguimiento operativo</h4>
    </div>

    <div class="modal-body">

        <div class="form-group m-form__group row ">
            <div class="col-lg-6">
                <label>Fecha</label>
                <div class="input-group m-input-icon m-input-icon--right" >
                    <input class="form-control m-input" placeholder="Ingrese fecha" type="text" name="item[fecha]" id="fecha" value="{$item.fecha|date_format:'%d/%m/%Y'|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
    
            <div class="col-lg-6">
                <label>Hora (hh:mm)</label>
                <div class="input-group m-input-icon m-input-icon--right" >
                    <input class="form-control m-input" placeholder="Ingrese hora" type="text" name="item[hora]" id="hora" value="{$item.hora|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Estado operativo</label>
                    <div class="input-group">
                        {* <input class="form-control m-input" placeholder="Ingresar estado" type="text" name="item[estadoOperativo]" id="estadoOperativo" value="{$item.estadoOperativo|escape:"html"}">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="tooltip" title="*********************1"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div> *}
                        <select class="form-control m-input select2" name="item[estadoOperativo]" id="estadoOperativo"
                            data-msg="Campo requerido: seleccione una opción">
                            <option value="">Seleccione tipo de Estado</option>
                            {html_options options=$cataobj.tipoestado selected=$item.estadoOperativo}
                        </select>
                    </div>
                </div>
        
                <div class="col-lg-6">
                    <label>Proveedor de energia</label>
                    <div class="input-group">
                        {* <input class="form-control m-input" placeholder="Ingresar proveedor" type="text" name="item[proveedorEnergia]" id="proveedorEnergia" value="{$item.proveedorEnergia|escape:"html"}">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="tooltip" title="*********************2"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div> *}
                        <select class="form-control m-input select2" name="item[proveedorEnergia]" id="proveedorEnergia"
                            data-msg="Campo requerido: seleccione una opción">
                            <option value="">Seleccione tipo de proveedor</option>
                            {html_options options=$cataobj.tipoenergia selected=$item.proveedorEnergia}
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Número de medidor</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese el número de medidor" type="text" name="item[numeroMedidor]" id="numeroMedidor" value="{$item.numeroMedidor|escape:"html"}">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="tooltip" title="*********************3"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
        
                <div class="col-lg-6">
                    <label>Medidor operativo</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese el medidor operativo" type="text" name="item[medidorOperativo]" id="medidorOperativo" value="{$item.medidorOperativo|escape:"html"}">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="tooltip" title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Señal GPRS</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese la señal GPRS" type="text" name="item[indicadorGprs]" id="indicadorGprs" value="{$item.indicadorGprs|escape:"html"}">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="tooltip" title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-12">
                    <label>Observaciones</label>
                    <div class="input-group">
                        <textarea class="form-control m-input" name="item[observaciones]" id="observaciones" placeholder="Ingrese observaciones" rows="3" maxlength="150" data-msg="Ingrese 150 caracteres como máximo.">{$item.observaciones|escape:"html"}</textarea>
                    </div>
                </div>
            </div>


        {* <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Permeabilidad estimada</label>
                <div class="input-group">
                    <select class="form-control m-input select2" name="item[permeabilidad]" id="permeabilidad"
                        data-msg="Campo requerido: seleccione una opción">
                        <option value="">Seleccione tipo de permeabilidad</option>
                        {html_options options=$cataobj.tipopermeabilidad selected=$item.permeabilidad}
                    </select>
                </div>
            </div>
        </div> *}

        <div class="modal-footer">
            <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="btn_modal_close">Cerrar</button>
            <button type="button" class="btn btn-primary btn-block-custom" id="btn_seguimiento_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
        </div>
</form>

{include file="form/index.js.tpl"}