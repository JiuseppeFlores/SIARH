{include file="calidad/lista/lista.css.tpl"}

<!-- <div class="m-portlet m-portlet--mobile"> -->
    {include file="calidad/lista/lista_titulo.tpl"}
    <div class="m-portlet__body">
        <!--begin: Search Form -->
        <!--begin: Datatable -->
        <table class="table table-striped table-bordered table-hover table-checkable table-sm m-table m-table--head-bg-brand m--hide" id="lista_calidad">
            <thead>
            <tr>
                {foreach from=$grill_list item=row key=idx}
                    <th >{$row.label|escape:"html"}</th>
                {/foreach}
            </tr>
            </thead>
            <!-- <tfoot>
            <tr>
                {foreach from=$grill_list item=row key=idx}
                    <th >{$row.label|escape:"html"}</th>
                {/foreach}
            </tr>
            </tfoot> -->
        </table>
    </div>
<!-- </div> -->

{include file="calidad/lista/lista.js.tpl"}
