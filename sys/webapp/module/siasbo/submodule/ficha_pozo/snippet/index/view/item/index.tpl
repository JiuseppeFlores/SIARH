{if ($item.itemId != 0 && $item.itemId != "" && $type == "update") || $type == "new"}

    {if $type == 'update'}
    <div class="m-alert m-alert--icon m-alert--air m-alert--square alert alert-dismissible m--margin-bottom-30" role="alert">
        <div class="m-alert__icon ">
            <i class="la la-thumb-tack m--font-primary"></i>
        </div>
        <div class="m-alert__text">
            <strong>FICHA ID: <span class="m--font-primary">{$item.itemId}</span></strong>
            &nbsp;&nbsp;|&nbsp;&nbsp;
            <strong>CÓDIGO:&nbsp;</strong>{$item.codigo}&nbsp;&nbsp;|&nbsp;&nbsp;
            <strong>NOMBRE:&nbsp;</strong>{$item.nombre}
        </div>
    </div>
    {/if}

    <div class="m-portlet m-portlet--tabs">

        <div class="m-portlet__head">
            <div class="m-portlet__head-tools">

                <ul class="nav nav-tabs m-tabs-line m-tabs-line--primary m-tabs-line--2x" role="tablist">
                {assign var="contador" value=1}
                {foreach from=$menu_tab item=row key=idx}
                    {if $contador < 7}
                    <li class="nav-item m-tabs__item">
                        <a class="nav-link m-tabs__link {if $row.active == 1}active{/if}"
                           data-toggle="tabajax"
                           data-target="#{$row.id_name}_pane"
                           id = "{$row.id_name}_tab"
                           href="{$getModule}&accion={$row.sub_control}_index&type={$type}&id={$id}"
                           role="tab">
                            <i class="{$row.icon}"></i> {$row.label}
                        </a>
                    </li>
                    {elseif $contador == 7}
                    <li class="nav-item dropdown m-tabs__item">
                        <a class="nav-link m-tabs__link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-cog"></i> Opciones</a>
                        <div class="dropdown-menu" x-placement="top-start" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 1px, 0px);">
                        <a class="dropdown-item"
                           data-toggle="tabajax"
                           data-target="#{$row.id_name}_pane"
                           id = "{$row.id_name}_tab"
                           href="{$getModule}&accion={$row.sub_control}_index&type={$type}&id={$id}"
                           role="tab">
                            <i class="{$row.icon}"></i> {$row.label}
                        </a>
                    {else}
                        <a class="dropdown-item"
                           data-toggle="tabajax"
                           data-target="#{$row.id_name}_pane"
                           id = "{$row.id_name}_tab"
                           href="{$getModule}&accion={$row.sub_control}_index&type={$type}&id={$id}"
                           role="tab">
                            <i class="{$row.icon}"></i> {$row.label}
                        </a>
                    {/if}
                    {assign var=contador value=$contador+1}
                {/foreach}
                        {if $type == 'update'}
                        </div>
                        {/if}
                    </li>
                </ul>

            </div>
        </div>

        <div class="tab-content">
            {foreach from=$menu_tab item=row key=idx}
                <div class="tab-pane {if $row.active == 1}active{/if}" id="{$row.id_name}_pane"></div>
            {/foreach}
        </div>

    </div>
{else}
    {include file="$frontend_error_01"}
{/if}