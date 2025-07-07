{include file="form/index.css.tpl"}

<form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}"
    id="form_litologico" autocomplete="off">
    <!-- <input type="hidden" name="item[pozoId]" id="pozoId" value="{$pozoId}">
 --><input type="hidden" name="item[pozoId]" id="pozoId" value="{$pozoCod}">
    <!-- <input type="hidden" name="item[tipo]" id="tipo" value="1"> -->

    <div class="modal-header">
        <h4 class="modal-title">Registro de columna litológica</h4>
    </div>

    <div class="modal-body">

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Profundidad desde (m)</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese profundidad desde" type="text"
                        name="item[profundidad_desde]" id="profundidad_desde"
                        value="{$item.profundidad_desde|escape:"html"}" min="0" max="999" step="0.01"
                        data-msg="Campo requerido. Profundidad desde debe contener números, 3 enteros y 2 decimales como máximo">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="Es la profundidad menor a la que comienza la primera capa de litológica."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Profundidad hasta (m)</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese profundidad_hasta" type="text"
                        name="item[profundidad_hasta]" id="profundidad_hasta"
                        value="{$item.profundidad_hasta|escape:"html"}" min="0" max="999" step="0.01"
                        data-msg="Campo requerido. Profundidad hasta debe contener números, 3 enteros y 2 decimales como máximo">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="Es la profundidad mayor a la que termina la primera capa litológica."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Litología 1</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese litología 1" type="text"
                        name="item[litologia1]" id="litologia1" value="{$item.litologia1|escape:"html"}" maxlength="150"
                        data-msg="Campo requerido: maximo 150 caracteres">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá colocar la litología con mayor presencia en la capa litológica."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Porcentaje 1 (%)</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese porcentaje 1" type="text"
                        name="item[porcentaje1]" id="porcentaje1" value="{$item.porcentaje1|escape:"html"}" min="0"
                        max="100" step="0.01"
                        data-msg="Campo requerido. Procentaje 1 desde debe contener números, 3 enteros y 2 decimales como máximo">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá colocar el porcentaje de la capa Litológica 1."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Litología 2</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese litología 2" type="text"
                        name="item[litologia2]" id="litologia2" value="{$item.litologia2|escape:"html"}" maxlength="150"
                        data-msg="Campo requerido: maximo 150 caracteres">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá colocar la segunda litología con mayor presencia en la capa litológica."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Porcentaje 2 (%)</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese porcentaje 2" type="text"
                        name="item[porcentaje2]" id="porcentaje2" value="{$item.porcentaje2|escape:"html"}" min="0"
                        max="100" step="0.01"
                        data-msg="Campo requerido. Procentaje 2 desde debe contener números, 3 enteros y 2 decimales como máximo">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá colocar el porcentaje de la capa Litológica 2."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Litología 3</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese litología 3" type="text"
                        name="item[litologia3]" id="litologia3" value="{$item.litologia3|escape:"html"}" maxlength="150"
                        data-msg="Campo requerido: maximo 150 caracteres">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá colocar la tercera litología con mayor presencia en la capa litológica."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Porcentaje 3 (%)</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese porcentaje 3" type="text"
                        name="item[porcentaje3]" id="porcentaje3" value="{$item.porcentaje3|escape:"html"}" min="0"
                        max="100" step="0.01"
                        data-msg="Campo requerido. Procentaje 3 desde debe contener números, 3 enteros y 2 decimales como máximo">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá colocar el porcentaje de la capa Litológica 3."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Litología 4</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese litología 4" type="text"
                        name="item[litologia4]" id="litologia4" value="{$item.litologia4|escape:"html"}" maxlength="150"
                        data-msg="Campo requerido: maximo 150 caracteres">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá colocar la cuarta litología con mayor presencia en la capa litológica."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <label>Porcentaje 4 (%)</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese porcentaje 4" type="text"
                        name="item[porcentaje4]" id="porcentaje4" value="{$item.porcentaje4|escape:"html"}" min="0"
                        max="100" step="0.01"
                        data-msg="Campo requerido. Procentaje 4 desde debe contener números, 3 enteros y 2 decimales como máximo">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá colocar el porcentaje de la capa Litológica 4."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-6">
                <label>Permeabilidad estimada</label>
                <div class="input-group">
                    <select class="form-control m-input select2" name="item[permeabilidad]" id="permeabilidad"
                        data-msg="Campo requerido: seleccione una opción">
                        <option value="">Seleccione tipo de permeabilidad</option>
                        {html_options options=$cataobj.tipopermeabilidad selected=$item.permeabilidad}
                    </select>
                </div>
            </div>
        </div>

        <div class="form-group m-form__group row">
            <div class="col-lg-12">
                <label>Observaciones</label>
                <div class="input-group">
                    <textarea class="form-control m-input" name="item[observaciones]" id="observaciones"
                        placeholder="Ingrese observaciones" rows="3" maxlength="150"
                        data-msg="Ingrese 150 caracteres como máximo.">{$item.observaciones|escape:"html"}</textarea>
                </div>
            </div>
        </div>

        <div class="modal-footer">
            <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal"
                id="btn_modal_close">Cerrar</button>
            <button type="button" class="btn btn-primary btn-block-custom" id="btn_litologico_submit"><i
                    class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
        </div>
</form>

{include file="form/index.js.tpl"}