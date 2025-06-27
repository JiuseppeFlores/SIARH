{include file="tipo_observacion/form/index.css.tpl"}

<form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST"  action="{$getModule}"  id="form_observacion">
    <input type="hidden" name="item[tipobombeoId]" id="po_tipobombeoId" value="{$tipoId}">

    <div class="modal-header">
        <h4 class="modal-title">Pozo de observacion</h4>
    </div>

    <div class="modal-body">        
        <div class="form-group m-form__group row">
            <div class="col-lg-4">
                <label>Fecha</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese fecha" type="text" name="item[fecha]" id="po_fecha" value="{$item.fecha|date_format:'%d/%m/%Y'|escape:"html"}" maxlength="10" data-msg="Campo requerido. Ingrese 10 caracteres con formato dd/mm/aaaa.">
                </div>
            </div>

            <div class="col-lg-8">
                <label>Código de pozo</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese código de pozo" type="number" name="item[pozoId]" id="po_nombre" value="{$item.pozoId|escape:"html"}" data-msg="Campo requerido. Código de pozo debe contener números (sólo enteros).">
                    <div class="input-group-append">
                        <button class="btn btn-default" type="button" id="btn_buscar_pozo"><i class="fa fa-search"></i>&nbsp;Buscar</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row ">
            <div class="col-lg-4">
                <label>UTM este (X)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[utm_este]" id="po_utm_este" placeholder="Ingrese utm este" value="{$item.utm_este|escape:"html"}" min="0" max="999999" step="0.001" data-msg="Campo requerido. UTM este (X) debe contener números, 6 enteros y 3 decimales como máximo.">
                    <!-- <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div> -->
                </div>
            </div>
    
            <div class="col-lg-4">
                <label>UTM norte (Y)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[utm_norte]" id="po_utm_norte" placeholder="Ingrese utm norte" value="{$item.utm_norte|escape:"html"}" min="0" max="9999999" step="0.001" data-msg="Campo requerido. UTM norte (Y) debe contener números, 7 enteros y 3 decimales como máximo.">
                    <!-- <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div> -->
                </div>
            </div>

            <div class="col-lg-4">
                <label>Zona</label>
                <div class="input-group">
                    <select class="form-control m-input select2" name="item[zona]" id="po_zona" data-msg="Campo requerido. Seleccione una zona.">
                        <option value="">Seleccione zona</option>
                        <option value="19K" {if $item.zona == '19K'} selected {/if}>19</option>
                        <option value="20K" {if $item.zona == '20K'} selected {/if}>20</option>
                        <option value="21K" {if $item.zona == '21K'} selected {/if}>21</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-4">
                <label>Nivel estático (m)</label>
                <div class="input-group">
                    <input class="form-control m-input m-input" placeholder="Ingrese nivel estático" type="text" name="item[nivel_estatico]" id="po_nivel_estatico" value="{$item.nivel_estatico|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido. Nivel estático debe contener números, 2 enteros y 2 decimales como máximo.">
                    <!-- <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div> -->
                </div>
            </div>

            <div class="col-lg-4">
                <label>Nivel dinámico final (m)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[nivel_dinamico]" id="po_nivel_dinamico" placeholder="Ingrese nivel dinámico final" value="{$item.nivel_dinamico|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido. Nivel dinámico debe contener números, 2 enteros y 2 decimales como máximo.">
                    <!-- <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto">
                            <i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div> -->
                </div>
            </div>

            <div class="col-lg-4">
                <label>Duración total (hrs.-min.-seg.)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[horas]" id="po_horas" placeholder="Hrs." value="{$duracion.horas|escape:"html"}" min="0" max="99" step="1" data-msg="Campo requerido. Horas debe contener números, 2 enteros como máximo.">&nbsp;
                    <input class="form-control m-input" type="text" name="item[minutos]" id="po_minutos" placeholder="Min." value="{$duracion.minutos|escape:"html"}" min="0" max="59" step="1" data-msg="Campo requerido. Minutos debe contener números entre 0 y 59.">&nbsp;
                    <input class="form-control m-input" type="text" name="item[segundos]" id="po_segundos" placeholder="Seg." value="{$duracion.segundos|escape:"html"}" min="0" max="59.99" step="0.01" data-msg="Campo requerido. Segundos debe contener números entre 0 y 59.99 (2 decimales como máximo).">
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-12">
                <label>Observaciones</label>
                <div class="input-group">
                    <textarea class="form-control m-input" name="item[observaciones]" id="po_observaciones" placeholder="Ingrese observaciones" rows="3" maxlength="150" data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">{$item.observaciones|escape:"html"}</textarea>
                </div>
            </div>
        </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="modal-close">Cerrar</button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_observacion_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>
</form>

{include file="tipo_observacion/form/index.js.tpl"}