{include file="vinculo_pozo/form/index.css.tpl"}

<form class="m-form m-form--fit m-form--label-align-right" method="POST"  action="{$getModule}"  id="form_tomografia_vinculo_pozo">
    <input type="hidden" name="item[lineabaseId]" value="{$lineabaseId}">

    <div class="modal-header">
        <h4 class="modal-title">Datos vincular con pozo</h4>
    </div>

    <div class="modal-body">
        <div class="form-group m-form__group row">
            <div class="col-lg-12">
                <label>Pozo</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese código de pozo" type="number" name="itemVinculoPozo[pozoId]" id="vp_pozoId" value="{$item.pozoId|escape:"html"}" step="1" required data-msg="Campo requerido. Código de pozo debe contener números (sólo enteros).">
                    <div class="input-group-append">
                        <button class="btn btn-default" type="button" id="btn_buscar_pozo"><i class="fa fa-search"></i>&nbsp;Buscar</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-12">
                <label>Observaciones</label>
                <div class="input-group">
                    <textarea class="form-control" name="item[observaciones]" id="vp_observaciones" placeholder="Ingrese observaciones" rows="3" maxlength="150" data-msg="Ingrese 150 caracteres como máximo.">{$item.observaciones|escape:"html"}</textarea>
                </div>
            </div>             
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" onclick="show_modal_window_list_tomografia_vinculo_pozo()">Cerrar</button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_tomografia_vinculo_pozo_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>
</form>

{include file="vinculo_pozo/form/index.js.tpl"}
