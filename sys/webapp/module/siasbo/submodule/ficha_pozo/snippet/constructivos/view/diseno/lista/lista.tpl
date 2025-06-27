{include file="diseno/lista/lista.css.tpl"}

<div class="modal-header">
    <h4 class="modal-title">Lista datos de diseño</h4>
</div>

<div class="modal-body">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12 text-right">
                <button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal">Cerrar</button>
                {if $tipoPerforacion == 1}
                <button type="button" class="btn btn-secondary btn-block-custom" onclick="javascript:graficar_diseno();"><span><i class="fa fa-chart-area"></i><span>&nbsp;Graficar</button>
                {/if}
                <button type="button" class="btn btn-primary btn-block-custom" id="btn_rejilla_submit" onclick="javascript:get_form_diseno('', 'new');"><span><i class="fa fa-plus"></i><span>&nbsp;Nueva Rejilla/Filtro</button>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12"><br/></div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <table class="table table-striped table-bordered table-hover table-checkable table-sm m-table m-table--head-bg-brand m--hide" id="lista_diseno">
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

{include file="diseno/lista/lista.js.tpl"}