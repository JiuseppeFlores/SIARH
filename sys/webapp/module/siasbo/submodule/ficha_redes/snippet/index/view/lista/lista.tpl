{include file="lista/lista.css.tpl"}

<div class="m-portlet m-portlet--mobile">
    {include file="lista/lista_titulo.tpl"}
    <div class="m-portlet__body">
        <!--begin: Search Form -->

        <!--begin: Datatable -->
        <table
            class="table table-striped table-bordered table-hover table-checkable table-sm m-table m-table--head-bg-brand m--hide"
            id="index_lista">
            <thead>
                <tr>
                    {foreach from=$grill_list item=row key=idx}
                        <th>{$row.label|escape:"html"}</th>
                    {/foreach}
                </tr>
            </thead>
            <thead class="marcador_estoy_aca" id="th_busqueda_especifica">
                <tr>
                    <td></td>
                    <td><input type="text" data-column="1" class="form-control form-control-sm search-input-text"
                            placeholder="Buscar" style="background-color:#ffffa0;"></td>
                    <td><input type="text" data-column="2" class="form-control form-control-sm search-input-text"
                            placeholder="Buscar" style="background-color:#ffffa0;"></td>
                    <td><input type="text" data-column="3" class="form-control form-control-sm search-input-text"
                            placeholder="Buscar" style="background-color:#ffffa0;"></td>
                    <td><input type="text" data-column="4" class="form-control form-control-sm search-input-text"
                            placeholder="Buscar" style="background-color:#ffffa0;"></td>
                    <td><input type="text" data-column="5" class="form-control form-control-sm search-input-text"
                            placeholder="Buscar" style="background-color:#ffffa0;"></td>
                    <td><input type="text" data-column="6" class="form-control form-control-sm search-input-text"
                            placeholder="Buscar" style="background-color:#ffffa0;"></td>
                    <td><input type="text" data-column="7" class="form-control form-control-sm search-input-text"
                            placeholder="Buscar" style="background-color:#ffffa0;"></td>
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

{include file="lista/lista_ventanas_modal.tpl"}