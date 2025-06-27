{include file="vinculo_pozo/lista/lista.css.tpl"}
<div class="modal-header">
    <h4 class="modal-title">Lista de pozos vinculados</h4>
</div>

<div class="modal-body">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12 text-right">
                <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary btn-block-custom" onclick="javascript:get_form_tomografia_vinculo_pozo('', 'new');"><span><i class="fa fa-plus"></i><span>&nbsp;Nuevo vínculo con pozo</button>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12"><br/></div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <table class="table table-striped table-bordered table-hover table-checkable table-sm m-table m-table--head-bg-brand dataTable no-footer dtr-inline" id="lista_tomografia_vinculo_pozo">
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

{include file="vinculo_pozo/lista/lista.js.tpl"}