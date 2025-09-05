{include file="form/index.css.tpl"}

<form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}" id="form_fuente" autocomplete="off">
    <input type="hidden" name="item[pozoId]" id="pozoId" value="{$pozoCod}">
    <input type="hidden" id="tipoIdRecuperado" value="{$datofuente.tipoFuenteId}">
    <input type="hidden" id="tipoFuenteDescripcion" value="{$datofuente.tipofuente}">

    <div class="modal-header">
        <h4 class="modal-title">Datos de {$datofuente.tipofuente}</h4>
        <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal"><i class="fa fa-times"></i></button>
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
                <label>Hora (hh:mm)</label>
                <div class="input-group m-input-icon m-input-icon--right" >
                    <input class="form-control m-input" placeholder="Ingrese hora" type="text" name="item[hora]" id="hora" value="{$item.hora|escape:"html"}" required>
                    <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                </div>
            </div>
        </div>

            <div class="form-group m-form__group row" style="{$div_uno_row}">
                <div class="col-lg-6" style="{$div_caudal}">
                    <label>Caudal</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese caudal de la fuente" type="text"
                            name="item[caudal]" id="caudal"
                            value="{$item.caudal|escape:"html"}" min="0" max="99" step="0.01"
                            data-msg="Campo requerido. Cobertura debe contener números, 2 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                                data-original-title="Texto. Ej. Texto"><i
                                    class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
        
                <div class="col-lg-6" style="{$div_tirante}">
                    <label>Tirante</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese el tirante" type="text" name="item[tirante]" id="tirante"
                        value="{$item.tirante|escape:"html"}">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="tooltip" title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row" style="{$div_dos_row}">        
                <div class="col-lg-6" style="{$div_flujo}">
                    <label>Temporalidad de Flujo</label>
                    <div class="input-group">

                        <select class="form-control m-input select2" name="item[flujo]" id="flujo"
                            data-msg="Campo requerido: seleccione una opción">
                            <option value="">Seleccione tipo de Flujo</option>
                            {html_options options=$cataobj.tipoflujo selected=$item.flujo}
                        </select>

                    </div>
                </div>
                <div class="col-lg-6" style="{$div_velocidad}">
                    <label>Velocidad</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese velocidad de la fuente" type="text"
                            name="item[velocidad]" id="velocidad" 
                            value="{$item.velocidad|escape:"html"}" min="0" max="99" step="0.01"
                            data-msg="Campo requerido. Cobertura debe contener números, 2 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                                data-original-title="Texto. Ej. Texto"><i
                                    class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row" style="{$div_tres_row}">
                <div class="col-lg-6" style="{$div_tipoId}">
                    <label>Turbiedad</label>
                    <div class="input-group">
                        <select class="form-control m-input select2" name="item[tipoId]" id="tipoId"
                            data-msg="Campo requerido: seleccione una opción">
                            <option value="">Seleccione tipo de Estado</option>
                            {html_options options=$cataobj.tipotipoagua selected=$item.tipoId}
                        </select>
                    </div>
                </div>
        
                <div class="col-lg-6" style="{$div_conexionSubterranea}">
                    <label>Conexion con agua subterranea</label>
                    <div class="input-group">
                        <select class="form-control m-input" name="item[conexionSubterranea]" id="conexionSubterranea" data-msg="Campo requerido: seleccione una opción">
                            <option value='SI' selected={$item.conexionSubterranea}>SI</option>
                            <option value='NO' selected={$item.conexionSubterranea}>NO</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row" style="{$div_cuatro_row}">
                <div class="col-lg-6" style="{$div_altura}">
                    <label>Altura del Agua (m)</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese el número de medidor" type="text" name="item[altura]" id="altura"
                        value="{$item.altura|escape:"html"}">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="tooltip" title="La altura debe ser expresada en metros(m)"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6" style="{$div_tipo}">
                    <label>Tipo</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese el tipo" type="text" name="item[tipo]" id="tipo"
                        value="{$item.tipo|escape:"html"}">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="tooltip" title="*********************3"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6" style="{$div_fechainstalacion}">
                    <label>Fecha de instalación</label>
                    <div class="input-group m-input-icon m-input-icon--right" >
                        <input class="form-control m-input" placeholder="Ingrese fecha" type="text" name="item[fechaInstalacion]" id="fechaInstalacion" value="{$item.fechaInstalacion|date_format:'%d/%m/%Y'|escape:"html"}">
                        <span class="m-input-icon__icon m-input-icon__icon--right" data-toggle="tooltip" title="Texto. Ej. Texto"><span><i class="flaticon-questions-circular-button"></i></span></span>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row" style="{$div_cinco_row}">
                <div class="col-lg-6" style="{$div_alturaAgua}">
                    <label>Altura del Agua (m)</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese la Altura del Agua" type="text" name="item[alturaAgua]" id="alturaAgua" 
                        value="{$item.alturaAgua|escape:"html"}">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="tooltip" title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6" style="{$div_alturaBorde}">
                    <label>Altura del Borde (m)</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese la Altura del Borde" type="text" name="item[alturaBorde]" id="alturaBorde"
                        value="{$item.alturaBorde|escape:"html"}">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="tooltip" title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row" style="{$div_seis_row}">
                <div class="col-lg-6" style="{$div_conexionesagua}">
                    <label>Conexiones agua potable</label>
                    <div class="input-group">
                        <select class="form-control m-input" name="item[conexionesagua]" id="conexionesagua" data-msg="Campo requerido: seleccione una opción">
                            <option value='SI' selected={$item.conexionesagua}>SI</option>
                            <option value='NO' selected={$item.conexionesagua}>NO</option>
                        </select>
                    </div>
                </div>

                <div class="col-lg-6" style="{$div_almacenamiento}">
                    <label>Tipo de almacenamiento</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese tipo de almacenamiento" type="text"
                            name="item[almacenamiento]" id="almacenamiento"
                            value="{$item.almacenamiento|escape:"html"}"
                            data-msg="Campo requerido. Ingrese 100 caracteres como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                                data-original-title="Texto. Ej. Texto"><i
                                    class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row" style="{$div_siete_row}">
                <div class="col-lg-6" style="{$div_coberturaagua}">
                    <label>Cobertura del servicio de agua</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese cobertura servicio agua" type="text"
                            name="item[coberturaagua]" id="coberturaagua"
                            value="{$item.coberturaagua|escape:"html"}" min="0" max="99" step="0.01"
                            data-msg="Campo requerido. Cobertura debe contener números, 2 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                                data-original-title="Texto. Ej. Texto"><i
                                    class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6" style="{$div_numero}">
                    <label>Número de fuentes</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese número de fuentes" type="text"
                            name="item[numero]" id="numero"
                            value="{$item.numero|escape:"html"}" min="0" max="99" step="0.01"
                            data-msg="Campo requerido. Número de fuentes debe contener números, 2 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                                data-original-title="Texto. Ej. Texto"><i
                                    class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row" style="{$div_ocho_row}">
                <div class="col-lg-6" style="{$div_capacidad}">
                    <label>Capacidad de almacenamiento</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese capacidad de almacenamiento"
                            type="text" name="item[capacidad]" id="capacidad"
                            value="{$item.capacidad|escape:"html"}" min="0" max="99" step="0.01"
                            data-msg="Campo requerido. Capacidad debe contener números, 2 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                                data-original-title="Texto. Ej. Texto"><i
                                    class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6" style="{$div_aduccion}">
                    <label>Aducción</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese aducción" type="text"
                            name="item[aduccion]" id="aduccion"
                            value="{$item.aduccion|escape:"html"}" data-msg="Campo requerido. Ingrese 100 caracteres como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                                data-original-title="Texto. Ej. Texto"><i
                                    class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row" style="{$div_nueve_row}">
                <div class="col-lg-6" style="{$div_red}">
                    <label>Red de distribución</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese red de distribución" type="text"
                            name="item[red]" id="red"
                            value="{$item.red|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido. Red debe contener números, 2 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                                data-original-title="Texto. Ej. Texto"><i
                                    class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6" style="{$div_area}">
                    <label>Área de servicio</label>
                    <div class="input-group">
                        <input class="form-control m-input" placeholder="Ingrese área de servicio" type="text"
                            name="item[area]" id="area"
                            value="{$item.area|escape:"html"}" min="0" max="99" step="0.01"
                            data-msg="Campo requerido. Área de servicio debe contener números, 2 enteros y 2 decimales como máximo.">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                                data-original-title="Texto. Ej. Texto"><i
                                    class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group m-form__group row">
                <div class="col-lg-12">
                    <label>Observaciones</label>
                    <div class="input-group">
                        <textarea class="form-control m-input" name="item[captaobservacion]" id="captaobservacion" placeholder="Ingrese observaciones" rows="3" maxlength="150" data-msg="Ingrese 150 caracteres como máximo.">{$item.captaobservacion|escape:"html"}</textarea>
                    </div>
                </div>
            </div>
    </div>

        <div class="modal-footer">
            <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="btn_modal_close">Cerrar</button>
            <button type="button" class="btn btn-primary btn-block-custom" id="btn_fuente_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
        </div>
</form>

{include file="form/index.js.tpl"}