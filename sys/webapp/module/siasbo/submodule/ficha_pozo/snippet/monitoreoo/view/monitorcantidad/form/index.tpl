{include file="monitorcantidad/form/index.css.tpl"}

<form class="m-form m-form--fit m-form--label-align-right" method="POST"  action="{$getModule}"  id="form_bombeo_pozo">
<input type="hidden" name="item[pozoId]" id="pozoId" value="{$pozoId}">
<input type="hidden" name="item[tipobombeoId]" id="tipobombeoId" value="1">

    <div class="modal-header">
        <h4 class="modal-title">Agregar monitoreo de cantidad</h4>
    </div>

    <div class="modal-body">        
        <div class="form-group m-form__group row ">
            <div class="col-lg-6">
                <label>Fecha</label>
                <div class="input-group m-input-icon m-input-icon--right" >
                    <input class="form-control m-input" placeholder="Ingrese fecha" type="text" name="item[fecha]" id="fecha" value="{$item.fecha|date_format:'%d/%m/%Y'|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
    
            <div class="col-lg-6">
                <label>Hora</label>
                <div class="input-group m-input-icon m-input-icon--right" >
                    <input class="form-control m-input" placeholder="Ingrese hora" type="text" name="item[hora]" id="hora" value="{$item.hora|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Época</label>
                <div class="input-group m-input-icon m-input-icon--right" >
                    <select class="form-control" name="item[epocaId]" id="epocaId" {$privFace.input} >
                        <option value="">Seleccione época</option>
                        {html_options options=$cataobj.tipoepoca selected=$item.epocaId}
                    </select>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Punto de referencia para medición del nivel de agua</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input class="form-control" type="text" name="item[puntoreferencia]" id="puntoreferencia" placeholder="Ingrese punto de referencia" value="{$item.puntoreferencia|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Elevación del punto de referencia</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input class="form-control" type="text" name="item[elevacion]" id="elevacion" placeholder="Ingrese elevación" value="{$item.elevacion|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Nivel freático</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input class="form-control" type="text" name="item[nivel_freatico]" id="nivel_freatico" placeholder="Ingrese nivel freático" value="{$item.nivel_freatico|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Nivel dinámico</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input class="form-control" type="text" name="item[nivel_dinamico]" id="nivel_dinamico" placeholder="Ingrese nivel dinámico" value="{$item.nivel_dinamico|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Nivel sstático</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input class="form-control" type="text" name="item[nivel_estatico]" id="nivel_estatico" placeholder="Ingrese nivel estático" value="{$item.nivel_estatico|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Caudal</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input class="form-control" type="text" name="item[caudal]" id="caudal" placeholder="Ingrese caudal" value="{$item.caudal|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-12">
                <label>Observaciones</label>
                <div class="input-group">
                    <textarea class="form-control" name="item[observaciones]" id="observaciones" placeholder="Ingrese observaciones" rows="3">{$item.observaciones|escape:"html"}</textarea>
                </div>
            </div>
        </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="modal-close">Cerrar</button>
        <!-- <button type="reset" class="btn btn-danger btn-block-custom">Cancelar</button> -->
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_monitor_cantidad_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>
</form>

{include file="monitorcantidad/form/index.js.tpl"}