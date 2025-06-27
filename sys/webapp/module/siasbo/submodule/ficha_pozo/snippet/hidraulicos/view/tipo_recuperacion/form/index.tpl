{include file="tipo_recuperacion/form/index.css.tpl"}

<form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST"  action="{$getModule}"  id="form_recuperacion">
    <input type="hidden" name="item[tipobombeoId]" id="pr_tipobombeoId" value="{$tipoId}">

    <div class="modal-header">
        <h4 class="modal-title">Prueba de recuperación</h4>
    </div>

    <div class="modal-body">        
        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Fecha</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese fecha" type="text" name="item[fecha]" id="pr_fecha" value="{$item.fecha|date_format:'%d/%m/%Y'|escape:"html"}" maxlength="10" data-msg="Campo requerido. Ingrese 10 caracteres con formato dd/mm/aaaa como máximo.">
                </div>
            </div>
            
            <div class="col-lg-6">
                <label>Nivel estático (m)</label>
                <div class="input-group">
                    <input class="form-control m-input m-input" placeholder="Ingrese nivel estático" type="text" name="item[nivel_estatico]" id="pr_nivel_estatico" value="{$item.nivel_estatico|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido. Nivel estático debe contener números, 2 enteros y 2 decimales como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Es el nivel en que se encuentra el agua cuando no se ha iniciado extracción de agua.">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Nivel dinámico final (m)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[nivel_dinamico_final]" id="pr_nivel_dinamico_final" placeholder="Ingrese nivel dinámico final" value="{$item.nivel_dinamico_final|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido. Nivel dinámico debe contener números, 2 enteros y 2 decimales como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Es el ascenso del nivel del agua que se mide cuando se inicia la prueba de recuperación.">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Duración total (horas-minutos-segundos)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[horas]" id="pr_horas" placeholder="Horas" value="{$duracion.horas|escape:"html"}" min="0" max="99" step="1" data-msg="Campo requerido. Horas debe contener números, 2 enteros como máximo.">&nbsp;
                    <input class="form-control m-input" type="text" name="item[minutos]" id="pr_minutos" placeholder="Minutos" value="{$duracion.minutos|escape:"html"}" min="0" max="59" step="1" data-msg="Campo requerido. Minutos debe contener números entre 0 y 59.">&nbsp;
                    <input class="form-control m-input" type="text" name="item[segundos]" id="pr_segundos" placeholder="Segundos" value="{$duracion.segundos|escape:"html"}" min="0" max="59.99" step="0.01" data-msg="Campo requerido. Segundos debe contener números entre 0 y 59.99 (2 decimales como máximo).">
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-12">
                <label>Observaciones</label>
                <div class="input-group">
                    <textarea class="form-control m-input" name="item[observaciones]" id="pr_observaciones" placeholder="Ingrese observaciones" rows="3" maxlength="150" data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">{$item.observaciones|escape:"html"}</textarea>
                </div>
            </div>
        </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="modal-close">Cerrar</button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_recuperacion_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>
</form>

{include file="tipo_recuperacion/form/index.js.tpl"}