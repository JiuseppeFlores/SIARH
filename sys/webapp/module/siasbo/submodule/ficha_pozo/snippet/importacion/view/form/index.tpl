{include file="form/index.css.tpl"}
<!-- action="{$getModule}" -->
<form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" id="form_importar">
    <input type="hidden" name="item[fichaId]" id="fichaId" value="{$pozoId}">

    <div class="modal-header">
        <h4 class="modal-title">Importar archivos</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>    
    </div>

    <div class="modal-body">        
        <div class="form-group m-form__group row" id="divPaso1">
            <div class="col-md-12">
                <label for="Name"><strong>PASO 1: </strong>Seleccione un archivo Excel 97-2003(.xls) o Excel 2007-Adelante(.xlsx)</label>
            </div>
            <div class="col-md-6">
                <input class="form-group col-md-12 btn btn-secondary btn-md" type="file" id="input_importar" name="input_importar" accept=".xls, .xlsx, .csv" placeholder="Seleccione un archivo">
            </div>
            <div class="col-md-6">
                <button type="button" class="form-group col-md-12 btn btn-primary mr-auto" id="btn_enviar">Enviar</button>
            </div>
        </div>

        <div class="form-group m-form__group row" id="divPaso2">
            <div class="col-md-12">
                <label for="Name"><strong>PASO 2: </strong>Seleccione una hoja Excel de la lista (Hojas del libro Excel)</label>
            </div>
            <div class="col-md-6">
                <select class="form-control" id="select_Hojas">
                    <option></option>
                </select>
            </div>
            <div class="col-md-6">
                <button type="button" class="form-group col-md-12 btn btn-primary mr-auto" id="btn_procesar">Procesar</button>
            </div>
        </div>

        <div class="form-group m-form__group row" id="divPaso3">
            <div class="col-md-12">
                <label for="Name"><strong>PASO 3: </strong>Guardar los datos de la hoja Excel procesados</label>
            </div>
            <div class="col-md-6">
                <div class="dropdown">
                  <button class="btn btn-secondary dropdown-toggle col-md-12" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Hojas Excel guardados</button>
                  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton" id="contenedor_lista_agregados">
                    <!-- <a class="dropdown-item" href="#">Action</a>
                    <a class="dropdown-item" href="#">Another action</a>
                    <a class="dropdown-item" href="#">Something else here</a> -->
                  </div>
                </div>
            </div>
            <div class="col-md-6">
                <button type="button" class="form-group col-md-12 btn btn-primary mr-auto" id="btn_guardar">Guardar</button>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="btn_modal_close">Cerrar</button>
        <!-- <button type="button" class="btn btn-primary btn-block-custom" id="btn_archivo_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button> -->
    </div>
    
</form>

{include file="form/index.js.tpl"}