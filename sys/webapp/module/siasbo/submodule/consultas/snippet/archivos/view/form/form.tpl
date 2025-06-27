{include file="form/form.css.tpl"}

<form class="m-form m-form--fit m-form--label-align-right m-form--group-seperator-dashed" method="POST"  action="{$getModule}"  id="form_modal_interface_{$subcontrol}">
<input type="hidden" name="item_id" value="{$item_id}">
    <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Nuevo Archivo </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <div class="modal-body">
        <div class="form-group m-form__group row">
            <label for="recipient-name" class="form-control-label">Nombre / Titulo:</label>
            <input type="text" class="form-control m-input" placeholder="Ingrese el Nombre / Titulo, del archivo"
                   name="item[nombre]" name=""
                   value="{$item.nombre|escape:"html"}"
                   minlength="2"
                   required
                   >
        </div>

        <div class="form-group m-form__group row">
            <label for="recipient-name" class="form-control-label">Descripción:</label>
            <input type="text" class="form-control m-input" placeholder="Ingrese la descripción del archivo" name="item[descripcion]" name="" value="{$item.descripcion|escape:"html"}">
        </div>

        <div class="form-group m-form__group row">
            <label  for="recipient-name" class="form-control-label">Archivo</label>
            <input type="file" class="form-control m-input"
                   placeholder="Ingrese el archivo"
                   name="input_archivo"
                   id="input_archivo"
                   accept="application/pdf"
                   {if $type == 'new'}
                   minlength="2"
                   required
                   {/if}
                   name="" value="{$item.descripcion|escape:"html"}">
            <div><span class="m-form__help">
                    {if $type == 'update'}<span class="m--font-focus">SOLO si quiere actualizar el archivo, seleccione uno nuevo. </span>{/if}
                    Puede subir solo archivos en formato <strong>PDF</strong> (.pdf)
                    <br>
                    {if $type == 'update'}
                        <strong>Archivo:</strong> <span class="m--font-success">{$item.adjunto_nombre}</span>
                    {/if}

                </span>


            </div>

        </div>

    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
        <button type="button" class="btn btn-primary" id="form_modal_submit_{$subcontrol}">Guardar</button>
    </div>
</form>

{include file="form/form.js.tpl"}
