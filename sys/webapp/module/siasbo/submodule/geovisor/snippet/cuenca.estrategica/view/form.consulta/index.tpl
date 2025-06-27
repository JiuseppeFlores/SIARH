{include file="form.consulta/index.css.tpl"}
<div class="m-portlet__body">
    <div class="row">
        <div class="col-lg-6">
            <div class="alert m-alert m-alert--default" role="alert">
                Consulta por cuenca estratégica.
            </div>
        </div>
        <div class="col-lg-6">
            <select class="form-control select2" style="width: 100%;" name="cuencaEstrategicaId" id="cuencaEstrategicaId" required data-msg="Campo requerido. Seleccione una opción.">
                <option value="">--Seleccione una opción--</option>
                {html_options options=$cataobj.cuenca_estrategica selected=''}
            </select>
        </div>
    </div>

    <div class="form-group m-form__group row">
        <div class="col-lg-6">
            <div class="alert m-alert m-alert--default" role="alert">
                Consulta de pozos por año de perforación.
            </div>
        </div>
        <div class="col-lg-6">
            <select class="form-control select2" style="width: 100%;" name="anio_perforacion" id="anio_perforacion" required data-msg="Campo requerido. Seleccione una opción.">
                <option value="">--Seleccione una opción--</option>
            </select>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-6">
            <div class="alert m-alert m-alert--default" role="alert">
                Consulta de pozos por profundidad perforada.
            </div>
        </div>
        <div class="col-lg-6">
            <select class="form-control select2" style="width: 100%;" name="profundidad_perforacion" id="profundidad_perforacion" required data-msg="Campo requerido. Seleccione una opción.">
                <option value="">--Seleccione una opción--</option>
                <option value="1">Menor a 30 metros</option>
                <option value="2">Entre 30 y 60 metros</option>
                <option value="3">Entre 60 y 100 metros</option>
                <option value="4">Entre 100 y 200 metros</option>
                <option value="5">Entre 200 y 300 metros</option>
                <option value="6">Mayor a 300 metros</option>
            </select>
        </div>
    </div>

    <div class="form-group m-form__group row">
        <div class="col-lg-6">
            <div class="alert m-alert m-alert--default" role="alert">
                Consulta de pozos por usos.
            </div>
        </div>
        <div class="col-lg-6">
            <button type="button" class="btn btn-outline-primary btn-sm" id="btn_uso_pozo">Consultar usos</button>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-6">
            <div class="alert m-alert m-alert--default" role="alert">
                Consulta de pozos por propósitos.
            </div>
        </div>
        <div class="col-lg-6">
            <button type="button" class="btn btn-outline-primary btn-sm" id="btn_proposito_pozo">Consultar propósitos</button>
        </div>
    </div>
</div>
{include file="form.consulta/index.js.tpl"}