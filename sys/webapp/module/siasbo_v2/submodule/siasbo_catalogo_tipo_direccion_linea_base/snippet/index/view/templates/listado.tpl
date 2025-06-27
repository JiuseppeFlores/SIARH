<!--BEGIN::GRID WINDOW-->
<div class="m-portlet m-portlet--mobile win-active" id="ventanaGrilla">
    <!--BEGIN::GRID TITLE-->
    <div class="m-portlet__head">
        <div class="m-portlet__head-caption">
            <div class="m-portlet__head-title">
                <h3 class="m-portlet__head-text">{$modeloEtiquetas.tituloGrilla}</h3>
            </div>
        </div>
        <div class="m-portlet__head-tools">
            <ul class="m-portlet__nav">
                <li class="m-portlet__nav-item">
                    <button type="button" class="btn btn-primary" id="btnNuevo" rel="new">
                        <span><i class="fa fa-plus"></i><span>&nbsp;Nuevo</span></span>
                    </button>
                </li>
                <li class="m-portlet__nav-item"></li>
            </ul>
        </div>
    </div>
    <!--END::GRID TITLE-->
    <!--BEGIN::GRID BODY-->
    <div class="m-portlet__body">
        <!--BEGIN::GRID SEARCH BAR-->
        {* {include file="lista/lista_busqueda.tpl"} *}
        <!--END::GRID SEARCH BAR-->
        <!--BEGIN::GRID-->
        <div class="table-responsive">
            <table class="table table-hover" id="gridMain">
                <thead>
                    <tr>
                        {foreach from=$modeloGrilla item=row key=idx}
                        <th >{$row.label|escape:"html"}</th>
                        {/foreach}
                    </tr>
                </thead>
                <tbody>
                </tbody>
                <tfoot>
                    <tr>
                        {foreach from=$modeloGrilla item=row key=idx}
                        <th >{$row.label|escape:"html"}</th>
                        {/foreach}
                    </tr>
                </tfoot>
            </table>
        </div>
        <!--END::GRID-->
    </div>
    <!--END::GRID BODY-->
</div>
<!--END::GRID WINDOW-->