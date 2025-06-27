<!--BEGIN::GRID WINDOW-->
<div class="m-portlet m-portlet--mobile" id="ventanaGrilla">
    <!--BEGIN::GRID TITLE-->
    <div class="m-portlet__head">
        <div class="m-portlet__head-caption">
            <div class="m-portlet__head-title">
                <h3 class="m-portlet__head-text"><i class="fa fa-book"></i>&nbsp;{$modeloEtiquetas.tituloGrilla}</h3>
            </div>
        </div>
    </div>
    <!--END::GRID TITLE-->
    <!--BEGIN::GRID BODY-->
    <div class="m-portlet__body">
        <!--BEGIN::GRID-->
        <div class="table-responsive">
            <table class="table table-hover" id="gridMain">
                <thead>
                    <tr>
                        <th>N°</th>
                        <th>Nombre de catálogo</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$modeloDatos item=row key=idx}
                    <tr>
                        <td>{$idx}</td>
                        <td>{$row.nombre|escape:"html"}</td>
                        <td>
                            <a href="index.php?module=siasbo_v2&smodule={$row.ruta}" target="_blank" class="btn btn-primary btn-sm" title="Ir a catálogo">
                                <i class="fa fa-arrow-circle-right"></i>&nbsp;Ingresar
                            </a>
                        </td>
                        
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
        <!--END::GRID-->
    </div>
    <!--END::GRID BODY-->
</div>
<!--END::GRID WINDOW-->