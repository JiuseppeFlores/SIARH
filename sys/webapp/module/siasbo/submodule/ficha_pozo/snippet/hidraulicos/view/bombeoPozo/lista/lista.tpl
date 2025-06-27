{include file="bombeoPozo/lista/lista.css.tpl"}

<div class="m-portlet m-portlet--mobile">
    {include file="bombeoPozo/lista/lista_titulo.tpl"}
    <div class="m-portlet__body">
        <!--begin: Search Form -->

        <!--begin: Datatable -->
        <table class="table table-striped table-bordered table-hover table-checkable table-sm m-table m-table--head-bg-brand m--hide" id="lista_bombeo_pozo">
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
</div>

<!--begin::Modal-->
<div class="modal fade" id="modal_window_bombeo" tabindex="-1" role="dialog"
     data-backdrop="static"
     data-keyboard="false"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content" id="modal_content_bombeo">

        </div>
    </div>
</div>
<!--end::Modal-->

{include file="bombeoPozo/lista/lista.js.tpl"}