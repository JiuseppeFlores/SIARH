{include file="form/index.css.tpl"}

<form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}" id="form_archivo">
    <input type="hidden" name="item[fichaId]" id="fichaId" value="{$captacionId}">

    <div class="modal-header">
        <h4 class="modal-title">Datos de archivo adjunto</h4>
    </div>

    <div class="modal-body">        
        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Fecha</label>
                <input class="form-control m-input" placeholder="Ingrese fecha" type="text" name="item[fecha]" id="adj_fecha" value="{$item.fecha|date_format:'%d/%m/%Y'|escape:"html"}" maxlength="10" required data-msg="Campo requerido. Ingrese 10 caracteres con formato dd/mm/aaaa como máximo.">
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Diagnóstico</label>
                <textarea class="form-control m-input" name="item[diagnostico]" id="adj_diagnostico" placeholder="Ingrese diagnóstico" rows="4" maxlength="150" required data-msg="Campo requerido. Ingrese 200 caracteres como máximo.">{$item.diagnostico|escape:"html"}</textarea>
            </div>

            <div class="col-lg-6">
                <label>Descripción</label>
                <textarea class="form-control m-input" name="item[descripcion]" id="adj_descripcion" placeholder="Ingrese descripción" rows="4" maxlength="150" required data-msg="Campo requerido. Ingrese 200 caracteres como máximo.">{$item.descripcion|escape:"html"}</textarea>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-12">
                <label>Archivo</label>
                <div class="custom-file">
                    <input type="file" class="form-control m-input custom-file-input" placeholder="Seleccione un archivo" name="archivo_adjunto" id="adj_archivo_adjunto" {if $type == 'new'} minlength="2" required data-msg="Campo requerido. Seleccione un archivo." {/if} value="{$item.adjunto_nombre|escape:'html'}">
                    <label class="custom-file-label" for="archivo_adjunto">Seleccione un archivo</label>
                </div>
                {if $type == 'update'}
                <p style="background-color: #e5e5e5; padding: 7px;">
                    <strong>Archivo actual:</strong>&nbsp;{$item.adjunto_nombre}
                </p>
                {/if}
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="btn_modal_close">Cerrar</button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_archivo_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>
</form>

{include file="form/index.js.tpl"}