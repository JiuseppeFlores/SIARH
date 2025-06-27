{include file="tipo_escalon/form/index.css.tpl"}

<form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}" id="form_escalon">
    <input type="hidden" name="item[tipobombeoId]" id="tbp_tipobombeoId" value="{$tipoId}">

    <div class="modal-header">
        <h4 class="modal-title">Datos de escalón</h4>
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
        {if $tipobombeo == '1'}
        <div class="form-group m-form__group row">
            <div class="col-lg-12">
                <label>Caudal (l/s)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[caudal]" id="tbp_caudal" placeholder="Ingrese caudal" value="{$item.caudal|escape:"html"}" min="0" max="999" step="0.01" data-msg="Campo requerido. Caudal debe contener números, 3 enteros y 2 decimales como máximo.">
                    <!-- <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div> -->
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-12">
                <label>Etapa (adm)</label>
                <div class="input-group">
                    <select class="form-control m-input select2" name="item[etapa]" id="etapa" data-msg="Campo requerido. Seleccione una opción.">
                    <option value="">Seleccione etapa</option>
                    <!-- <option value="1" {if $item.activo == '1'} selected {/if}>ACTIVO</option>
                    <option value="0" {if $item.activo == '0'} selected {/if}>INACTIVO</option>  -->
                    <option value="1" {if $item.etapa == '1'} selected {/if}>Etapa 1</option>
                    <option value="2" {if $item.etapa == '2'} selected {/if}>Etapa 2</option>
                    <option value="3" {if $item.etapa == '3'} selected {/if}>Etapa 3</option>
                    <option value="4" {if $item.etapa == '4'} selected {/if}>Etapa 4</option>
                    <option value="5" {if $item.etapa == '5'} selected {/if}>Etapa 5</option>
                </select>
                </div>
            </div>
        </div>
        {/if}





    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="btn_modal_close">Cerrar</button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_escalon_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>
</form>

{include file="tipo_escalon/form/index.js.tpl"}