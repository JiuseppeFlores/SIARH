{include file="index.css.tpl"}

<!--begin::Portlet-->
<div class="m-portlet">
    <!--begin::Form-->
    <form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}"
        id="general_form">

        <input type="hidden" name="item[tipo]" id="tipo" value="4" required>

        <div class="m-portlet__head">
            <div class="m-portlet__head-caption">
                <div class="m-portlet__head-title">
                    <h3 class="m-portlet__head-text">Datos generales</h3>
                </div>
            </div>
        </div>

        <div class="m-portlet__body">

            <div class="m-form__section m-form__section--first">
                <div class="m-form__heading">
                    <h3 class="m-form__heading-title">Identificación</h3>
                </div>

                <div class="m-form__seperator m-form__seperator--dashed"></div>

                <div class="form-group m-form__group row">
                    <div class="col-lg-6">
                        <label>Código de captación superficial</label>
                        <div class="input-group">
                            <input class="form-control m-input" placeholder="Ingrese código de captación superficial"
                                type="text" name="item[codigo]" id="codigo" value="{$item.codigo|escape:"html"}"
                                maxlength="150" data-msg="Campo requerido. Ingrese 150 caracteres como máximo."
                                {if $type == 'new'}disabled{/if} readonly>
                            <div class="input-group-append">
                                <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                                    data-original-title="El sistema automáticamente pondrá el código correlativo que corresponde.">
                                    <i class="flaticon-questions-circular-button"></i>
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <label>Nombre de captación superficial</label>
                        <div class="input-group">
                            <input class="form-control m-input" placeholder="Ingrese nombre de captación superficial"
                                type="text" name="item[nombre]" id="nombre" value="{$item.nombre|escape:"html"}"
                                maxlength="150" required
                                data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">
                            <div class="input-group-append">
                                <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                                    data-original-title="El dueño y/o institución deberá colocar el nombre de dicha captación."><i
                                        class="flaticon-questions-circular-button"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="m-form__section m-form__section--last">
                <div class="m-form__heading">
                    <h3 class="m-form__heading-title">Ubicación geográfica</h3>
                </div>

                <div class="m-form__seperator m-form__seperator--dashed"></div>

                <div class="form-group m-form__group row">
                    <div class="col-lg-12">
                        <label>Ingresar coordenadas en grados, minutos y segundos:</label>
                        <div class="input-group">
                            <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                <label class="btn btn-warning">
                                    <input autocomplete="off" type="radio" name="ubicacion" id="lat_lon"
                                        value="lat_lon"><i class="fa fa-map-marker-alt"></i>&nbsp;&nbsp;Latitud Sud y
                                    Longitud Oeste
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-group m-form__group row ">
                    <div class="col-lg-6">
                        <label>Latitud sud (grados, minutos, segundos)</label>
                        <div class="input-group">
                            <input class="form-control m-input" type="number" name="item[lat_gra]" id="lat_gra"
                                placeholder="Grados" value="{$latitud.0|escape:"html"}" min="8" max="24" step="1"
                                required data-msg="Campo requerido. Los grados deben ser números entre 8 y 24.">
                            <input class="form-control m-input" type="number" name="item[lat_min]" id="lat_min"
                                placeholder="Minutos" value="{$latitud.1|escape:"html"}" min="0" max="59" step="1"
                                required data-msg="Campo requerido. Los minutos deben ser números entre 0 y 59.">
                            <input class="form-control m-input" type="number" name="item[lat_seg]" id="lat_seg"
                                placeholder="Segundos" value="{$latitud.2|escape:"html"}" min="0" max="59.999"
                                step="0.001" required
                                data-msg="Campo requerido. Los segundos deben ser números entre 0 y 59.999 (3 decimales como máximo).">
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <label>Latitud sud decimal</label>
                        <div class="input-group">
                            <input class="form-control m-input" type="number" name="item[latitudDec]" id="latitudDec"
                                placeholder="Ingrese latitud sud decimal" value="{$item.latitudDec|escape:"html"}"
                                required data-msg="Campo requerido. Ingrese sólo números." readonly>
                            <div class="input-group-append">
                                <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                                    data-original-title="Texto. Ej. Texto"><i
                                        class="flaticon-questions-circular-button"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-group m-form__group row ">
                    <div class="col-lg-6">
                        <label>Longitud oeste (grados, minutos, segundos)</label>
                        <div class="input-group">
                            <input class="form-control m-input" type="number" name="item[lon_gra]" id="lon_gra"
                                placeholder="Grados" value="{$longitud.0|escape:"html"}" min="55" max="70" step="1"
                                required data-msg="Campo requerido. Los grados deben ser números entre 55 y 70.">
                            <input class="form-control m-input" type="number" name="item[lon_min]" id="lon_min"
                                placeholder="Minutos" value="{$longitud.1|escape:"html"}" min="0" max="59" step="1"
                                required data-msg="Campo requerido. Los minutos deben ser números entre 0 y 59.">
                            <input class="form-control m-input" type="number" name="item[lon_seg]" id="lon_seg"
                                placeholder="Segundos" value="{$longitud.2|escape:"html"}" min="0" max="59.999"
                                step="0.001" required
                                data-msg="Campo requerido. Los segundos deben ser números entre 0 y 59.999 (3 decimales como máximo).">
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <label>Longitud oeste decimal</label>
                        <div class="input-group">
                            <input class="form-control m-input" type="number" name="item[longitudDec]" id="longitudDec"
                                placeholder="Ingrese longitud oeste decimal" value="{$item.longitudDec|escape:"html"}"
                                required data-msg="Campo requerido. Ingrese sólo números." readonly>
                            <div class="input-group-append">
                                <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                                    data-original-title="Texto. Ej. Texto">
                                    <i class="flaticon-questions-circular-button"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-group m-form__group row">
                    <div class="col-lg-12">
                        <label>Ingresar coordenadas en UTM (WGS84):</label>
                        <div class="input-group">
                            <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                <label class="btn btn-warning">
                                    <input autocomplete="off" type="radio" name="ubicacion" id="utm" value="utm"><i
                                        class="fa fa-map-marker-alt"></i>&nbsp;&nbsp;UTM Este (X) y UTM Norte (Y)
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-group m-form__group row ">
                    <div class="col-lg-6">
                        <label>UTM este (X)</label>
                        <div class="input-group">
                            <input class="form-control m-input" type="number" name="item[latitudUtm]" id="latitudUtm"
                                placeholder="Ingrese utm este (X)" value="{$item.latitudUtm|escape:"html"}" min="0"
                                max="999999" step="0.001" required
                                data-msg="Campo requerido. UTM este (X) debe contener números, 6 enteros y 3 decimales como máximo.">
                            <div class="input-group-append">
                                <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                                    data-original-title="El usuario podrá poner la coordenada UTM de la captación y el sistema automáticamente hará el cálculo en grados y decimales y/o viceversa.">
                                    <i class="flaticon-questions-circular-button"></i>
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <label>UTM norte (Y)</label>
                        <div class="input-group">
                            <input class="form-control m-input" type="number" name="item[longitudUtm]" id="longitudUtm"
                                placeholder="Ingrese utm norte (Y)" value="{$item.longitudUtm|escape:"html"}" min="0"
                                max="9999999" step="0.001" required
                                data-msg="Campo requerido. UTM norte (Y) debe contener números, 7 enteros y 3 decimales como máximo.">
                            <div class="input-group-append">
                                <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                                    data-original-title="El usuario podrá poner la coordenada UTM de la captación y el sistema automáticamente hará el cálculo en grados y decimales y/o viceversa.">
                                    <i class="flaticon-questions-circular-button"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-group m-form__group row ">
                    <div class="col-lg-6">
                        <label>Zona</label>
                        <div class="input-group">
                            <select class="form-control m-input select2" name="item[utmZona]" id="utmZona" required
                                data-msg="Campo requerido. Seleccione una zona.">
                                <option value="">Seleccione zona</option>
                                <option value="19K" {if $item.utmZona == '19K'} selected {/if}>19</option>
                                <option value="20K" {if $item.utmZona == '20K'} selected {/if}>20</option>
                                <option value="21K" {if $item.utmZona == '21K'} selected {/if}>21</option>
                            </select>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <label>Altitud (m)</label>
                        <div class="input-group">
                            <input class="form-control m-input" type="number" name="item[altitud]" id="altitud"
                                maxlength="60" placeholder="Ingrese altitud" value="{$item.altitud|escape:"html"}"
                                min="0" max="9999" step="0.01"
                                data-msg="Campo requerido. Altitud debe contener números, 4 enteros y 2 decimales como máximo.">
                            <div class="input-group-append">
                                <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title=""
                                    data-original-title="Altitud expresada en metros sobre el nivel del mar.">
                                    <i class="flaticon-questions-circular-button"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="m-form__section m-form__section--last">

                <div class="m-form__heading">
                    <h3 class="m-form__heading-title">Ubicación política</h3>
                </div>

                <div class="m-form__seperator m-form__seperator--dashed"></div>

                <div class="form-group m-form__group row">
                    <div class="col-lg-6">
                        <label>Departamento</label>
                        <div class="input-group">
                            <select class="form-control m-input select2" name="item[departamentoId]" id="departamentoId"
                                required data-msg="Campo requerido. Seleccione una opción.">
                                <option value="">--Seleccione una opción--</option>
                                {html_options options=$cataobj.departamento selected=$item.departamentoId}
                            </select>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <label>Provincia</label>
                        <div class="input-group">
                            <select class="form-control m-input select2" name="item[provinciaId]" id="provinciaId"
                                required data-msg="Campo requerido. Seleccione una opción.">
                                <option value="">--Seleccione una opción--</option>
                                {if $type == 'update'} {html_options options=$provincia selected=$item.provinciaId}
                                {/if}
                            </select>
                        </div>
                    </div>
                </div>

                <div class="form-group m-form__group row ">
                    <div class="col-lg-6">
                        <label>Municipio</label>
                        <div class="input-group">
                            <select class="form-control m-input select2" name="item[municipioId]" id="municipioId"
                                required data-msg="Campo requerido. Seleccione una opción.">
                                <option value="">--Seleccione una opción--</option>
                                {if $type == 'update'} {html_options options=$municipio selected=$item.municipioId}
                                {/if}
                            </select>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <label>Comunidad</label>
                        <div class="input-group">
                            <select class="form-control m-input select2" name="item[comunidadId]" id="comunidadId"
                                data-msg="Campo requerido. Seleccione una opción.">
                                <option value="">--Seleccione una opción--</option>
                                {if $type == 'update'} {html_options options=$comunidad selected=$item.comunidadId}
                                {/if}
                            </select>
                        </div>
                    </div>
                </div>

                <div class="form-group m-form__group row ">
                    <div class="col-lg-6">
                        <label>Localidad</label>
                        <div class="input-group">
                            <select class="form-control m-input select2" name="item[localidadId]" id="localidadId"
                                data-msg="Campo requerido. Seleccione una opción.">
                                <option value="">--Seleccione una opción--</option>
                                {if $type == 'update'} {html_options options=$localidad selected=$item.localidadId}
                                {/if}
                            </select>
                        </div>
                    </div>
                </div>

                <div class="form-group m-form__group row ">
                    <div class="col-lg-6">
                        <label>Comunidad</label>
                        <div class="input-group">
                            <input class="form-control m-input" type="text" name="item[comunidad]" id="comunidad"
                                placeholder="Ingrese comunidad" value="{$item.comunidad|escape:"html"}" maxlength="150"
                                data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <label>Localidad</label>
                        <div class="input-group">
                            <input class="form-control m-input" type="text" name="item[localidad]" id="localidad"
                                placeholder="Ingrese localidad" value="{$item.localidad|escape:"html"}" maxlength="150"
                                data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">
                        </div>
                    </div>
                </div>

                <div class="form-group m-form__group row ">
                    <div class="col-lg-12">
                        <label>Descripción del lugar</label>
                        <div class="input-group m-input-icon m-input-icon--right">
                            <textarea class="form-control m-input" name="item[descripcion]" id="descripcion"
                                placeholder="Ingrese descripción del lugar" rows="4" maxlength="500"
                                data-msg="Campo requerido. Ingrese 500 caracteres como máximo.">{$item.descripcion|escape:"html"}</textarea>
                        </div>
                    </div>
                </div>

                <div class="form-group m-form__group row ">
                    <div class="col-lg-6">
                        <label>Cuenca</label>
                        <select class="form-control m-input select2" name="item[cuencaId]" id="cuencaId" required
                            data-msg="Campo requerido. Seleccione una opción.">
                            <option value="">--Seleccione una opción--</option>
                            {html_options options=$cataobj.cuenca selected=$item.cuencaId}
                        </select>
                    </div>

                    <div class="col-lg-6">
                        <label>Estado</label>
                        <div class="input-group">
                            {if $type == 'new'}
                                <input class="form-control m-input" type="text" name="item[estado]" id="estado"
                                    placeholder="Ingrese estado" value="Registrado" readonly="false" maxlength="150"
                                data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">{else}<input
                                    class="form-control m-input" type="text" name="item[estado]" id="estado"
                                    placeholder="Ingrese estado" value="{$item.estado|escape:"html"}" readonly="false"
                                maxlength="150" data-msg="Campo requerido. Ingrese 150 caracteres como máximo.">{/if}
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="m-portlet__foot m-portlet__no-border m-portlet__foot--fit">
            <div class="m-form__actions m-form__actions--solid">
                <div class="row">
                    <div class="col-lg-12">
                        {if $privFace.editar == 1}
                            <button type="button" class="btn btn-primary btn-block-custom" id="general_submit"><i
                                    class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
                        {/if}
                        <button type="button" class="btn btn-warning btn-block-custom" id="general_observado"><i
                                class="fa fa-check"></i>&nbsp;Observado</button>
                        <button type="button" class="btn btn-success btn-block-custom" id="general_revisado"><i
                                class="fa fa-check"></i>&nbsp;Revisado</button>
                        <a href="{$getModule}" class="btn btn-secondary btn-block-custom" style="float: right;"><i
                                class="fa fa-arrow-left"></i>&nbsp;Volver</a>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <!--end::Form-->

</div>
<!--end::Portlet-->

<!--begin::Geovisor-->
{include file="geovisor/index.tpl"}
<!--end::Geovisor-->

{include file="index.js.tpl"}