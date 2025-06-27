{include file="tipoBombeoPozo/form/index.css.tpl"}

<form class="m-form m-form--fit m-form--label-align-right" method="POST"  action="{$getModule}"  id="form_tipo_bombeo_pozo">
<input type="hidden" name="item[pruebabombeoId]" id="tbp_pruebabombeoId" value="{$pruebabombeoId}">

    <div class="modal-header">
        <h4 class="modal-title">Prueba continua/escalonada</h4>
    </div>

    <div class="modal-body">        
        <div class="form-group m-form__group row ">
            <div class="col-lg-6">
                <label>Tipo de prueba de bombeo</label>
                <div class="input-group m-input-icon m-input-icon--right" >
                    <select class="form-control" name="item[tipo]" id="tbp_tipo">
                        <option value="" selected>Seleccione tipo prueba bombeo</option>
                        {html_options options=$cataobj.tipo_pruebabombeo selected=$item.tipo}
                    </select>
                    <div class="input-group-append"><span class="input-group-text" data-toggle="tooltip" title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i></span></div>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Fecha</label>
                <div class="input-group m-input-icon m-input-icon--right" >
                    <input class="form-control m-input" placeholder="Ingrese fecha" type="text" name="item[fecha]" id="tbp_fecha" value="{$item.fecha|date_format:'%d/%m/%Y'|escape:"html"}">
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Nivel estático (m)</label>
                <div class="input-group m-input-icon m-input-icon--right" >
                    <input class="form-control m-input" placeholder="Ingrese nivel estático" type="text" name="item[nivel_estatico]" id="tbp_nivel_estatico" value="{$item.nivel_estatico|escape:"html"}">
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Nivel dinámico final (m)</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input class="form-control" type="text" name="item[nivel_dinamico]" id="tbp_nivel_dinamico" placeholder="Ingrese nivel dinámico final" value="{$item.nivel_dinamico|escape:"html"}">
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Duración total (horas-minutos-segundos)</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input type="text" name="item[hora]" id="tbp_hora" class="form-control" placeholder="Horas" value="{$duracion.0|escape:"html"}" {$privFace.input}>&nbsp;
                    <input type="text" name="item[minuto]" id="tbp_minuto" class="form-control" placeholder="Minutos" value="{$duracion.1|escape:"html"}" {$privFace.input}>&nbsp;
                    <input type="text" name="item[segundo]" id="tbp_segundo" class="form-control" placeholder="Segundos" value="{$duracion.2|escape:"html"}" {$privFace.input}>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Profundidad de la bomba (m.b.b.p.)</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input class="form-control" type="text" name="item[profundidad]" id="tbp_profundidad" placeholder="Ingrese profundidad bomba" value="{$item.profundidad|escape:"html"}">
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

         <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Potencia (HP)</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input class="form-control" type="text" name="item[potencia]" id="tbp_potencia" placeholder="Ingrese potencia" value="{$item.potencia|escape:"html"}">
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Caudal (l/s)</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input class="form-control" type="text" name="item[caudal]" id="tbp_caudal" placeholder="Ingrese caudal" value="{$item.caudal|escape:"html"}">
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-12">
                <label>Observaciones</label>
                <div class="input-group">
                    <textarea class="form-control" name="item[observaciones]" id="tbp_observaciones" placeholder="Ingrese observaciones" rows="3">{$item.observaciones|escape:"html"}</textarea>
                </div>
            </div>
        </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="modal-close">Cerrar</button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_tipo_bombeo_pozo_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>
</form>

{include file="tipoBombeoPozo/form/index.js.tpl"}