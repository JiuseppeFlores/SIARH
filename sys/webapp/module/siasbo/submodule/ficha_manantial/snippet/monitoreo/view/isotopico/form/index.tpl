{include file="isotopico/form/index.css.tpl"}

<form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST"  action="{$getModule}"  id="form_isotopico">
    <input type="hidden" name="item[manantialId]" id="iso_manantialId" value="{$manantialId}">

    <div class="modal-header">
        <h4 class="modal-title">Datos isotópicos</h4>
        <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal"><i class="fa fa-times"></i></button>
    </div>

    <div class="modal-body">
        <div class="m-form__section m-form__section--first">
            <div class="m-form__heading">
                <h3 class="m-form__heading-title">Muestreo</h3>
            </div>

            <div class="m-form__seperator m-form__seperator--dashed"></div>

            <div class="form-group m-form__group row">
                <div class="col-lg-4">
                    <label>Fecha de muestreo</label>
                    <div class="input-group date">
                        <input class="form-control m-input" placeholder="Ingrese fecha" type="text" name="item[fecha_muestreo]" id="iso_fecha_muestreo" value="{$item.fecha_muestreo|date_format:'%d/%m/%Y'|escape:'html'}" maxlength="10" data-msg="Campo requerido. Ingrese 10 caracteres con formato dd/mm/aaaa como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <label>Hora de muestreo</label>
                    <div class="input-group date">
                        <input class="form-control m-input" placeholder="Ingrese hora" type="text" name="item[hora_muestreo]" id="iso_hora_muestreo" value="{$item.hora_muestreo|escape:'html'}" maxlength="8" data-msg="Campo requerido. Ingrese 8 caracteres con formato hh:mm como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <label>Época</label>
                    <div class="input-group">
                        <div class="input-group">
                            <select class="form-control m-input select2" name="item[epocaId]" id="iso_epocaId" data-msg="Campo requerido. Seleccione una opción.">
                                <option value="">Seleccione época</option>
                                {html_options options=$cataobj.epoca selected=$item.epocaId}
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Entidad que muestrea</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese entidad que muestrea" type="text" name="item[entidad]" id="iso_entidad" value="{$item.entidad|escape:'html'}" maxlength="100" data-msg="Campo requerido. Ingrese 100 caracteres como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <label>Código muestra campo</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese código muestra campo" type="text" name="item[codigo_muestra]" id="iso_codigo_muestra" value="{$item.codigo_muestra|escape:'html'}" maxlength="100" data-msg="Campo requerido. Ingrese 100 caracteres como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="m-form__section m-form__section--last">
            <div class="m-form__heading">
                <h3 class="m-form__heading-title">Laboratorio</h3>
            </div>

            <div class="m-form__seperator m-form__seperator--dashed"></div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Fecha de análisis</label>
                    <div class="input-group date">
                        <input class="form-control m-input" placeholder="Ingrese fecha de análisis" type="text" name="item[fecha_analisis]" id="iso_fecha_analisis" value="{$item.fecha_analisis|date_format:'%d/%m/%Y'|escape:'html'}" maxlength="10" data-msg="Campo requerido. Ingrese 10 caracteres con formato dd/mm/aaaa como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <label>Hora de análisis (hh:mm)</label>
                    <div class="input-group date">
                        <input class="form-control m-input" placeholder="Ingrese hora de análisis" type="text" name="item[hora_analisis]" id="iso_hora_analisis" value="{$item.hora_analisis|escape:'html'}" maxlength="8" data-msg="Campo requerido. Ingrese 8 caracteres con formato hh:mm como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Nombre de laboratorio</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese nombre de laboratorio" type="text" name="item[nombre_laboratorio]" id="iso_nombre_laboratorio" value="{$item.nombre_laboratorio|escape:'html'}" maxlength="100" data-msg="Campo requerido. Ingrese 100 caracteres como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <label>Código muestra laboratorio</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese código muestra laboratorio" type="text" name="item[codigo_laboratorio]" id="iso_codigo_laboratorio" value="{$item.codigo_laboratorio|escape:'html'}" maxlength="100" data-msg="Campo requerido. Ingrese 100 caracteres como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="m-form__section m-form__section--last">

            <div class="m-form__seperator m-form__seperator--dashed"></div>

            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Profundidad toma de muestra (m.b.b.p.)</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese profundidad toma muestra" type="text" name="item[profundidad]" id="iso_profundidad" value="{$item.profundidad|escape:'html'}" min="0" max="999" step="0.01" data-msg="Campo requerido. Profundidad debe contener números, 3 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="form-group m-form__group row">
                <div class="col-lg-12">
                    <label>Observaciones</label>
                    <div class="input-group m-input-icon m-input-icon--right" >
                        <textarea class="form-control m-input" name="item[observaciones]" id="iso_observaciones" placeholder="Ingrese observaciones" rows="3" maxlength="150" data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">{$item.observaciones|escape:'html'}</textarea>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="btn_modal_close">Cerrar</button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_isotopico_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
    </div>
</form>

{include file="isotopico/form/index.js.tpl"}