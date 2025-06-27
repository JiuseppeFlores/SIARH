{include file="cantidad/form/index.css.tpl"}

<form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}" id="form_cantidad">
<input type="hidden" name="item[pozoId]" id="pozoId" value="{$pozoId}">

    <div class="modal-header">
        <h4 class="modal-title">Agregar monitoreo de cantidad</h4>
    </div>

    <div class="modal-body">        
        <div class="form-group m-form__group row ">
            <div class="col-lg-4">
                <label>Fecha</label>
                <div class="input-group date" >
                    <input class="form-control m-input" placeholder="Ingrese fecha" type="text" name="item[fecha]" id="cant_fecha" value="{$item.fecha|date_format:'%d/%m/%Y'|escape:"html"}" maxlength="10" data-msg="Campo requerido. Ingrese 10 caracteres con formato dd/mm/aaaa como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Colocar fecha de inicio del monitoreo."><i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
    
            <div class="col-lg-4">
                <label>Hora</label>
                <div class="input-group date" >
                    <input class="form-control m-input" placeholder="Ingrese hora" type="text" name="item[hora]" id="cant_hora" value="{$item.hora|escape:"html"}" maxlength="8" data-msg="Campo requerido. Ingrese 8 caracteres con formato hh:mm como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="La hora que se inicia el monitoreo."><i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <label>Época</label>
                <div class="input-group" >
                    <select class="form-control m-input select2" name="item[epocaId]" id="cant_epocaId" {$privFace.input} data-msg="Campo requerido. Seleccione una opción.">
                        <option value="">Seleccione época</option>
                        {html_options options=$cataobj.epoca selected=$item.epocaId}
                    </select>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Punto de referencia para medición nivel de agua</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[puntoreferencia]" id="cant_puntoreferencia" placeholder="Ingrese punto de referencia" value="{$item.puntoreferencia|escape:"html"}" maxlength="150" data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <!-- Elevación del punto de referencia (m) -->
                <label>ADEME</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[elevacion]" id="cant_elevacion" placeholder="Ingrese ADEME" value="{$item.elevacion|escape:"html"}" min="-9999" max="9999" step="0.01" data-msg="Campo requerido. Elevación debe contener números, 4 enteros y 2 decimales como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Nivel freático (m.b.b.p.)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[nivel_freatico]" id="cant_nivel_freatico" placeholder="Ingrese nivel freático" value="{$item.nivel_freatico|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido. Nivel freático debe contener números, 2 enteros y 2 decimales como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Es la distancia a la que se encuentra el agua desde la superficie del terreno."><i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-6">
                <label>Nivel dinámico (m.b.b.p.)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[nivel_dinamico]" id="cant_nivel_dinamico" placeholder="Ingrese nivel dinámico" value="{$item.nivel_dinamico|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido. Nivel dinámico debe contener números, 2 enteros y 2 decimales como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Es el descenso del nivel del agua que se mide cuando se inicia el bombeo."><i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Nivel estático (m.b.b.p.)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[nivel_estatico]" id="cant_nivel_estatico" placeholder="Ingrese nivel estático" value="{$item.nivel_estatico|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido. Nivel estático debe contener números, 2 enteros y 2 decimales como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Es el nivel en que se encuentra el agua cuando no se ha iniciado extracción de agua."><i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Caudal (l/s)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[caudal]" id="cant_caudal" placeholder="Ingrese caudal" value="{$item.caudal|escape:"html"}" min="0" max="999" step="0.01" data-msg="Campo requerido. Caudal debe contener números, 3 enteros y 2 decimales como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Se refiere a la cantidad de fluido, medido en volumen, que se mueve en una unidad de tiempo."><i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Caudal autorizado (l/s)</label>
                <div class="input-group">
                    <input class="form-control m-input" type="text" name="item[caudalautorizado]" id="cant_caudal_autorizado" placeholder="Ingrese caudal autorizado" value="{$item.caudalautorizado|escape:"html"}" min="0" max="999" step="0.01" data-msg="Campo requerido. Caudal debe contener números, 3 enteros y 2 decimales como máximo.">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Es el consumo autorizado, que es legítimo."><i class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-12">
                <label>Observaciones</label>
                <div class="input-group">
                    <textarea class="form-control m-input" name="item[observaciones]" id="cant_observaciones" placeholder="Ingrese observaciones" rows="3" maxlength="150" data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">{$item.observaciones|escape:"html"}</textarea>
                </div>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="btn_modal_close">Cerrar</button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_monitor_cantidad_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>
</form>

{include file="cantidad/form/index.js.tpl"}