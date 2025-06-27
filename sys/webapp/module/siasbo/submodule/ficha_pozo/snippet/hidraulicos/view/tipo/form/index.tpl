{include file="tipo/form/index.css.tpl"}

<form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST"  action="{$getModule}"  id="form_tipo">
    <input type="hidden" name="item[pruebabombeoId]" id="tbp_pruebabombeoId" value="{$pruebaId}">

    <div class="modal-header">
        <h4 class="modal-title">Prueba continua/escalonada</h4>
    </div>

    <div class="modal-body">        
        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Tipo de bombeo</label>
                <div class="input-group">
                    <select class="form-control m-input select2" name="item[tipo]" id="tbp_tipo" data-msg="Campo requerido. Seleccione una opción.">
                        <option value="">Seleccione tipo bombeo</option>
                        {html_options options=$cataobj.tipo_bombeo selected=$item.tipo}
                    </select>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Fecha</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese fecha" type="text" name="item[fecha]" id="tbp_fecha" value="{$item.fecha|date_format:'%d/%m/%Y'|escape:"html"}" maxlength="10" data-msg="Campo requerido. Ingrese 10 caracteres con formato dd/mm/aaaa como máximo.">
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Nivel estático (m.b.b.p.)</label>
                <div class="input-group">
                    <input class="form-control m-input m-input" placeholder="Ingrese nivel estático" type="text" name="item[nivel_estatico]" id="tbp_nivel_estatico" value="{$item.nivel_estatico|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido. Nivel estático debe contener números, 2 enteros y 2 decimales como máximo.">
                    <!-- <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" >
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div> -->
                </div>
            </div>

            <div class="col-lg-6">
                <label>Nivel dinámico final (m.b.b.p.)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[nivel_dinamico]" id="tbp_nivel_dinamico" placeholder="Ingrese nivel dinámico final" value="{$item.nivel_dinamico|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido. Nivel dinámico debe contener números, 2 enteros y 2 decimales como máximo.">
                    <!-- <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div> -->
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Duración total (horas-minutos-segundos)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[horas]" id="tbp_horas" placeholder="Horas" value="{$tiempo.horas|escape:"html"}" min="0" max="99" step="1" data-msg="Campo requerido. Horas debe contener números, 2 enteros como máximo.">&nbsp;
                    <input class="form-control m-input" type="text" name="item[minutos]" id="tbp_minutos" placeholder="Minutos" value="{$tiempo.minutos|escape:"html"}" min="0" max="59" step="1" data-msg="Campo requerido. Minutos debe contener números entre 0 y 59.">&nbsp;
                    <input class="form-control m-input" type="text" name="item[segundos]" id="tbp_segundos" placeholder="Segundos" value="{$tiempo.segundos|escape:"html"}" min="0" max="59.99" step="0.01" data-msg="Campo requerido. Segundos debe contener números entre 0 y 59.99 (2 decimales como máximo).">
                </div>
            </div>

            <div class="col-lg-6">
                <label>Profundidad de la bomba (m.b.b.p.)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[profundidad]" id="tbp_profundidad" placeholder="Ingrese profundidad bomba" value="{$item.profundidad|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido. Profundidad bomba debe contener números, 2 enteros y 2 decimales como máximo.">
                    <!-- <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div> -->
                </div>
            </div>
        </div>

         <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Potencia (HP)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[potencia]" id="tbp_potencia" placeholder="Ingrese potencia" value="{$item.potencia|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido. Potencia bomba debe contener números, 2 enteros y 2 decimales como máximo.">
                    <!-- <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div> -->
                </div>
            </div>

            <div class="col-lg-6" id="campo_caudal">
                <label>Caudal (l/s)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[caudal]" id="tbp_caudal" placeholder="Ingrese caudal" value="{$item.caudal|escape:"html"}" min="0" max="999" step="0.01" data-msg="Campo requerido. Caudal bomba debe contener números, 3 enteros y 2 decimales como máximo.">
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
                    <textarea class="form-control m-input" name="item[observaciones]" id="tbp_observaciones" placeholder="Ingrese observaciones" rows="3" maxlength="150" data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">{$item.observaciones|escape:"html"}</textarea>
                </div>
            </div>
        </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="btn_modal_close">Cerrar</button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_tipo_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>
</form>

{include file="tipo/form/index.js.tpl"}