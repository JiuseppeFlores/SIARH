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

        <div class="form-group row">
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

        <div class="form-group row">
            <div class="col-lg-3">
                <label>Litología 1</label>
                <div class="input-group">
                    <div class="form-control m-input p-0">
                        <select class="select3" name="item[litologiaId1]" id="litologiaId1"
                            data-msg="Campo requerido: seleccione una opción">
                            <option value="">Seleccionar</option>
                            {html_options options=$cataobj.litologia selected=$item.litologiaId1}
                        </select>
                    </div>
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá seleccionar la litología con mayor presencia en la capa litológica."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
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
            <div class="col-lg-3">
                <label>Redondez 1</label>
                <div class="input-group">
                    <div class="form-control m-input p-0">
                        <select class="select3" name="item[redondezId1]" id="redondezId1"
                            data-msg="Campo requerido: seleccione una opción">
                            <option value="">Seleccionar</option>
                            {html_options options=$cataobj.tiporedondez selected=$item.redondezId1}
                        </select>
                    </div>
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá seleccionar la redondez de la litología 1."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-3">
                <label>Tamaño 1</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese tamaño 1" type="text"
                        name="item[tamano1]" id="tamano1" value="{$item.tamano1|escape:"html"}" maxlength="128"
                        data-msg="Campo requerido: maximo 128 caracteres">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá colocar un tamaño de la capa litologíca 1."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group row">
            <div class="col-lg-3">
                <label>Litología 2</label>
                <div class="input-group">
                    <div class="form-control m-input p-0">
                        <select class="select3" name="item[litologiaId2]" id="litologiaId2"
                            data-msg="Campo requerido: seleccione una opción">
                            <option value="">Seleccionar</option>
                            {html_options options=$cataobj.litologia selected=$item.litologiaId2}
                        </select>
                    </div>
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá seleccionar la segunda litología con mayor presencia en la capa litológica."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
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
            <div class="col-lg-3">
                <label>Redondez 2</label>
                <div class="input-group">
                    <div class="form-control m-input p-0">
                        <select class="form-control m-input select3" name="item[redondezId2]" id="redondezId2"
                            data-msg="Campo requerido: seleccione una opción">
                            <option value="">Seleccionar</option>
                            {html_options options=$cataobj.tiporedondez selected=$item.redondezId2}
                        </select>
                    </div>
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá seleccionar el tipo de redondez de la litología 2."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <label>Tamaño 2</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese tamaño 2" type="text"
                        name="item[tamano2]" id="tamano2" value="{$item.tamano2|escape:"html"}" maxlength="128"
                        data-msg="Campo requerido: maximo 128 caracteres">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá colocar un tamaño de la capa litologíca 2."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
            
        </div>

        <div class="form-group row">
            <div class="col-lg-3">
                <label>Litología 3</label>
                <div class="input-group">
                    <div class="form-control m-input p-0">
                        <select class="select3" name="item[litologiaId3]" id="litologiaId3"
                            data-msg="Campo requerido: seleccione una opción">
                            <option value="">Seleccionar</option>
                            {html_options options=$cataobj.litologia selected=$item.litologiaId3}
                        </select>
                    </div>
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá seleccionar la tercera litología con mayor presencia en la capa litológica."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
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
            <div class="col-lg-3">
                <label>Redondez 3</label>
                <div class="input-group">
                    <div class="form-control m-input p-0">
                        <select class="form-control m-input select2" name="item[redondezId3]" id="redondezId3"
                            data-msg="Campo requerido: seleccione una opción">
                            <option value="">Seleccionar</option>
                            {html_options options=$cataobj.tiporedondez selected=$item.redondezId3}
                        </select>
                    </div>
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá seleccionar el tipo de redondez de la litología 3."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <label>Tamaño 3</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese tamaño 3" type="text"
                        name="item[tamano3]" id="tamano3" value="{$item.tamano3|escape:"html"}" maxlength="128"
                        data-msg="Campo requerido: maximo 128 caracteres">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá colocar un tamaño de la capa litologíca 3."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
            
        </div>

        <div class="form-group row">
            <div class="col-lg-3">
                <label>Litología 4</label>
                <div class="input-group">
                    <div class="form-control m-input p-0">
                        <select class="select3" name="item[litologiaId4]" id="litologiaId4"
                            data-msg="Campo requerido: seleccione una opción">
                            <option value="">Seleccionar</option>
                            {html_options options=$cataobj.litologia selected=$item.litologiaId4}
                        </select>
                    </div>
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá seleccionar la cuarta litología con mayor presencia en la capa litológica."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
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
            <div class="col-lg-3">
                <label>Redondez 4</label>
                <div class="input-group">
                    <div class="form-control m-input p-0">
                        <select class="form-control m-input select2" name="item[redondezId4]" id="redondezId4"
                            data-msg="Campo requerido: seleccione una opción">
                            <option value="">Seleccionar</option>
                            {html_options options=$cataobj.tiporedondez selected=$item.redondezId4}
                        </select>
                    </div>
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá seleccionar la redondez de la litología 4."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <label>Tamaño 4</label>
                <div class="input-group">
                    <input class="form-control m-input" placeholder="Ingrese tamaño 4" type="text"
                        name="item[tamano4]" id="tamano4" value="{$item.tamano4|escape:"html"}" maxlength="128"
                        data-msg="Campo requerido: maximo 128 caracteres">
                    <div class="input-group-append">
                        <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                            data-original-title="El usuario deberá colocar un tamaño de la capa litologíca 4."><i
                                class="flaticon-questions-circular-button"></i>
                        </span>
                    </div>
                </div>
            </div>
            
        </div>

        <div class="form-group row">
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

        <div class="form-group row">
            <div class="col-lg-12">
                <label>Observaciones</label>
                <div class="input-group">
                    <textarea class="form-control m-input" name="item[observaciones]" id="observaciones"
                        placeholder="Ingrese observaciones" rows="3" maxlength="150"
                        data-msg="Ingrese 150 caracteres como máximo.">{$item.observaciones|escape:"html"}</textarea>
                </div>
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