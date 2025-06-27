{include file="capa/lista/lista.css.tpl"}

<div class="modal-header">
    <h4 class="modal-title">Lista datos de capas</h4>
</div>

<div class="modal-body">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12 text-right">
                <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal" id="btn_close_modal_capa">Cerrar</button>
                <button type="button" class="btn btn-primary btn-block-custom" onclick="javascript:get_form_tomografia_capa('', 'new');"><span><i class="fa fa-plus"></i><span>&nbsp;Nueva capa</button>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12"><br/></div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <table class="table table-striped table-bordered table-hover table-checkable table-sm m-table m-table--head-bg-brand dataTable no-footer dtr-inline" id="lista_capa">
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

{include file="capa/lista/lista.js.tpl"}