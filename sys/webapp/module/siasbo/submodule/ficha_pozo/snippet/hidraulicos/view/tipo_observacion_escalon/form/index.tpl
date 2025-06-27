{include file="tipo_observacion_escalon/form/index.css.tpl"}

<form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}" id="form_observa_escalon">
    <input type="hidden" name="item[observacionId]" id="tbp_observacionId" value="{$observacionId}">

    <div class="modal-header">
        <h4 class="modal-title">Datos escalón de observación</h4>
    </div>

    <div class="modal-body">
        <div class="form-group m-form__group row">
            <div class="col-lg-12">
                <label>Tiempo (horas-minutos-segundos)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[horas]" id="tbp_hora" placeholder="Horas" value="{$tiempo.horas|escape:"html"}" min="0" max="99" step="1" data-msg="Campo requerido. Horas debe contener números, 2 enteros como máximo.">&nbsp;
                    <input class="form-control m-input" type="text" name="item[minutos]" id="tbp_minuto" placeholder="Minutos" value="{$tiempo.minutos|escape:"html"}" min="0" max="59" step="1" data-msg="Campo requerido. Minutos debe contener números entre 0 y 59.">&nbsp;
                    <input class="form-control m-input" type="text" name="item[segundos]" id="tbp_segundo" placeholder="Segundos" value="{$tiempo.segundos|escape:"html"}" min="0" max="59.99" step="0.01" data-msg="Campo requerido. Segundos debe contener números entre 0 y 59.99 (2 decimales como máximo).">
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-12">
                <label>Nivel dinámico (m)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[nivel_dinamico]" id="tbp_nivel_dinamico" placeholder="Ingrese nivel dinámico" value="{$item.nivel_dinamico|escape:"html"}" min="0" max="999" step="0.01" data-msg="Campo requerido. Nivel dinámico debe contener números, 3 enteros y 2 decimales como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Es el descenso del nivel del agua que se mide cuando se inicia el bombeo.">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="modal-close">Cerrar</button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_observa_escalon_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>
</form>

{include file="tipo_observacion_escalon/form/index.js.tpl"}