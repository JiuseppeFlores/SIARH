{include file="monitorcalidad/form/index.css.tpl"}

<form class="m-form m-form--fit m-form--label-align-right" method="POST"  action="{$getModule}"  id="form_monitor_calidad">

<input type="hidden" name="item[pozoId]" id="pozoId" value="{$pozoId}">
<!-- <input type="hidden" name="item[tipobombeoId]" id="bp_tipobombeoId" value="1"> -->

    <div class="modal-header">
        <h4 class="modal-title">Agregar monitoreo de calidad</h4>
    </div>

    <div class="modal-body">        
        <div class="form-group m-form__group row ">
            <div class="col-lg-6">
                <label>Fecha de muestreo</label>
                <div class="input-group m-input-icon m-input-icon--right" >
                    <input class="form-control m-input" placeholder="Ingrese fecha de muestreo" type="text" name="item[fecha_muestreo]" id="fecha_muestreo" value="{$item.fecha_muestreo|date_format:'%d/%m/%Y'|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
    
            <div class="col-lg-6">
                <label>Hora de muestreo (hh:mm)</label>
                <div class="input-group m-input-icon m-input-icon--right" >
                    <input class="form-control m-input" placeholder="Ingrese hora" type="text" name="item[hora_muestreo]" id="hora_muestreo" value="{$item.hora_muestreo|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Época</label>
                <div class="input-group">
                    <select class="form-control m-input select2" name="item[epocaId]" id="epocaId" {$privFace.input} >
                        <option value="">Seleccione época</option>
                        {html_options options=$cataobj.tipoepoca selected=$item.epocaId}
                    </select>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Entidad que muestrea</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input class="form-control" type="text" name="item[entidad]" id="entidad" placeholder="Ingrese punto de referencia" value="{$item.entidad|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Codigo de la muestra en campo</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input class="form-control" type="text" name="item[codigo_muestra]" id="codigo_muestra" placeholder="Ingrese elevación" value="{$item.codigo_muestra|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row ">
            <div class="col-lg-6">
                <label>Fecha de análisis</label>
                <div class="input-group m-input-icon m-input-icon--right" >
                    <input class="form-control m-input" placeholder="Ingrese fecha de análisis" type="text" name="item[fecha_analisis]" id="fecha_analisis" value="{$item.fecha_analisis|date_format:'%d/%m/%Y'|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
    
            <div class="col-lg-6">
                <label>Hora de análisis (hh:mm)</label>
                <div class="input-group m-input-icon m-input-icon--right" >
                    <input class="form-control m-input" placeholder="Ingrese hora de análisis" type="text" name="item[hora_analisis]" id="hora_analisis" value="{$item.hora_analisis|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Nombre del laboratorio</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input class="form-control" type="text" name="item[nombre_laboratorio]" id="nombre_laboratorio" placeholder="Ingrese nombre laboratorio" value="{$item.nombre_laboratorio|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Codigo de la muestra en laboratorio</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input class="form-control" type="text" name="item[codigo_laboratorio]" id="codigo_laboratorio" placeholder="Ingrese codigo de la muestra en laboratorio" value="{$item.codigo_laboratorio|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Profundidad toma de muestra</label>
                <div class="input-group m-input-icon m-input-icon--right">
                    <input class="form-control" type="text" name="item[profundidad]" id="profundidad" placeholder="Ingrese profundidad toma de muestra" value="{$item.profundidad|escape:"html"}" required>
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
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_monitor_calidad_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>
</form>

{include file="monitorcalidad/form/index.js.tpl"}