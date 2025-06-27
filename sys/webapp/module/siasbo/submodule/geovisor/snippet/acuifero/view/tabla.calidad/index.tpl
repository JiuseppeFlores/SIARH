{include file="tabla.calidad/index.css.tpl"}
<div class="modal-header">
    <h4 class="modal-title">Reporte de calidad</h4>
</div>
<div class="modal-body text-center">
    <div class="m-portlet__body">
        <div class="row">
            <div class="col-lg-12">
                <div class="table-responsive">
                    <table class="table table-bordered m-table m-table--border-primary m-table--head-bg-primary table-sm">
                        <thead>
                            <tr>
                                <th colspan="12">SEGÚN REGLAMENTO EN MATERIA DE CONTAMINACIÓN HÍDRICA</th>
                            </tr>
                            <tr>
                                <th>CÓDIGO POZO</th>
                                <th>pH</th>
                                <th>Sólidos disueltos totales</th>
                                <th>Amoniaco (c/NH3)</th>
                                <th>Calcio</th>
                                <th>Cloruros (c/Cl)</th>
                                <th>Fluoruros (c/F)</th>
                                <th>Fosfato Total (c/PO43-)</th>
                                <th>Magnesio (c/Mg)</th>
                                <th>Nitrato (c/NO3-)</th>
                                <th>Sodio (c/Na)</th>
                                <th>Sulfatos (c/SO42-)</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$tablaDatosCalidad item=row key=idx}
                            <tr>
                                <td>{$row.0|escape:"html"}</td>
                                <td class="{$row.8css|escape:'html'}">{$row.8|escape:"html"}</td>
                                <td class="{$row.27css|escape:'html'}">{$row.27|escape:"html"}</td>
                                <td class="{$row.37css|escape:'html'}">{$row.37|escape:"html"}</td>
                                <td class="{$row.54css|escape:'html'}">{$row.54|escape:"html"}</td>
                                <td class="{$row.59css|escape:'html'}">{$row.59|escape:"html"}</td>
                                <td class="{$row.70css|escape:'html'}">{$row.70|escape:"html"}</td>
                                <td class="{$row.71css|escape:'html'}">{$row.71|escape:"html"}</td>
                                <td class="{$row.75css|escape:'html'}">{$row.75|escape:"html"}</td>
                                <td class="{$row.83css|escape:'html'}">{$row.83|escape:"html"}</td>
                                <td class="{$row.93css|escape:'html'}">{$row.93|escape:"html"}</td>
                                <td class="{$row.94css|escape:'html'}">{$row.94|escape:"html"}</td>
                            </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btn_modal_close">Cerrar</button>
</div>
{include file="tabla.calidad/index.js.tpl"}