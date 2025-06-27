{include file="form.consulta/index.css.tpl"}
<div class="m-portlet__body">
    <div class="row">
        <div class="col-lg-8">
            <div class="m-radio-inline">
                <label class="m-radio">
                <input type="radio" name="rdb_tipo" value="c1" checked>&nbsp;Nivel nacional
                <span></span>
                </label>
                <label class="m-radio">
                <input type="radio" name="rdb_tipo" value="c2">&nbsp;Nivel departamental
                <span></span>
                </label>
                <label class="m-radio">
                <input type="radio" name="rdb_tipo" value="c3">&nbsp;Nivel municipal
                <span></span>
                </label>
            </div>
            <br>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-6">
            <select class="form-control select2" style="width: 100%;" name="deptoId" id="deptoId" required data-msg="Campo requerido. Seleccione una opción.">
                <option value="">--Seleccione un departamento--</option>
                {html_options options=$cataobj.departamento selected=''}
            </select>
            <br>
            <br>
        </div>
        <div class="col-lg-6">
            <select class="form-control select2" style="width: 100%;" name="municipioId" id="municipioId" required data-msg="Campo requerido. Seleccione una opción.">
                <option value="">--Seleccione un municipio--</option>
                {html_options options=$cataobj.municipio selected=''}
            </select>
            <br>
            <br>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-8">
            <div class="alert m-alert m-alert--default" role="alert">
                Consulta pozos con datos constructivos.
            </div>
        </div>
        <div class="col-lg-4">
            <button type="button" class="btn btn-outline-primary btn-sm" id="btn_pozo_diseno">Consultar</button>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-8">
            <div class="alert m-alert m-alert--default" role="alert">
                Consulta pozos con datos litológicos.
            </div>
        </div>
        <div class="col-lg-4">
            <button type="button" class="btn btn-outline-primary btn-sm" id="btn_pozo_litologia">Consultar</button>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-8">
            <div class="alert m-alert m-alert--default" role="alert">
                Consulta pozos con datos de perfilaje eléctrico.
            </div>
        </div>
        <div class="col-lg-4">
            <button type="button" class="btn btn-outline-primary btn-sm" id="btn_pozo_electrico">Consultar</button>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-8">
            <div class="alert m-alert m-alert--default" role="alert">
                Consulta pozos con datos hidráulicos (escalones).
            </div>
        </div>
        <div class="col-lg-4">
            <button type="button" class="btn btn-outline-primary btn-sm" id="btn_pozo_hidraulico_escalon">Consultar</button>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-8">
            <div class="alert m-alert m-alert--default" role="alert">
                Consulta pozos con datos hidráulicos (prueba de recuperación).
            </div>
        </div>
        <div class="col-lg-4">
            <button type="button" class="btn btn-outline-primary btn-sm" id="btn_pozo_hidraulico_recuperacion">Consultar</button>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-8">
            <div class="alert m-alert m-alert--default" role="alert">
                Consulta pozos con datos hidráulicos (prueba de observación).
            </div>
        </div>
        <div class="col-lg-4">
            <button type="button" class="btn btn-outline-primary btn-sm" id="btn_pozo_hidraulico_observacion">Consultar</button>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-8">
            <div class="alert m-alert m-alert--default" role="alert">
                Consulta pozos con datos de implementación.
            </div>
        </div>
        <div class="col-lg-4">
            <button type="button" class="btn btn-outline-primary btn-sm" id="btn_pozo_implementacion">Consultar</button>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-8">
            <div class="alert m-alert m-alert--default" role="alert">
                Consulta pozos con datos de monitoreo de cantidad.
            </div>
        </div>
        <div class="col-lg-4">
            <button type="button" class="btn btn-outline-primary btn-sm" id="btn_pozo_monitor_cantidad">Consultar</button>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-8">
            <div class="alert m-alert m-alert--default" role="alert">
                Consulta pozos con datos de monitoreo de calidad.
            </div>
        </div>
        <div class="col-lg-4">
            <button type="button" class="btn btn-outline-primary btn-sm" id="btn_pozo_monitor_calidad">Consultar</button>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-8">
            <div class="alert m-alert m-alert--default" role="alert">
                Consulta pozos con datos de monitoreo isotópico.
            </div>
        </div>
        <div class="col-lg-4">
            <button type="button" class="btn btn-outline-primary btn-sm" id="btn_pozo_monitor_isotopico">Consultar</button>
        </div>
    </div>
</div>
{include file="form.consulta/index.js.tpl"}