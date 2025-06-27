{include file="recupera_observa/lista_pozo/lista.css.tpl"}
<div class="modal-header">
    <h4 class="modal-title">Lista de pozos</h4>
</div>

<div class="modal-body">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <table class="table table-striped table-bordered table-hover table-checkable table-sm m-table m-table--head-bg-brand dataTable no-footer dtr-inline" id="lista_pozo">
                    <thead>
                    <tr>
                        {foreach from=$grill_list item=row key=idx}
                            <th >{$row.label|escape:"html"}</th>
                        {/foreach}
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal-footer">
    <button class="btn btn-default" id="btn_cerrar_pozo">Cerrar</button>
</div>

{include file="recupera_observa/lista_pozo/lista.js.tpl"}