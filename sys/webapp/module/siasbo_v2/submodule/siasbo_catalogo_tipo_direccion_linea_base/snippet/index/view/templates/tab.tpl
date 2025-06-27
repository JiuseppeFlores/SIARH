<!--BEGIN::TAB-->
<div class="m-portlet m-portlet--mobile win-active" id="ventanaFormulario">
  <div class="m-portlet__head">
      <div class="m-portlet__head-tools">
          <ul class="nav nav-tabs m-tabs m-tabs-line m-tabs-line--left m-tabs-line--primary" role="tablist">
              {foreach from=$modeloTab item=row key=idx}
                  <li class="nav-item m-tabs__item">
                      <a class="nav-link m-tabs__link {if $row.active == 1}active{/if}"
                         data-toggle="tabajax"
                         data-target="#{$row.id_name}_pane"
                         id = "{$row.id_name}_tab"
                         href="#{$row.sub_control}_pane"
                         role="tab">
                          <i class="{$row.icon}"></i>&nbsp;{$row.label}
                      </a>
                  </li>
              {/foreach}
          </ul>
          <button type="button" class="tab-button-close" title="Cerrar" id="btnCerrarTab">
            <span aria-hidden="true">&times;</span>
          </button>
      </div>
  </div>
  <div class="tab-content">
      {foreach from=$modeloTab item=row key=idx}
      <div class="tab-pane {if $row.active == 1}active{/if}" id="{$row.id_name}_pane">
          {include file="`$templateDirModule`/templates/`$row.form`.tpl"}
      </div>
      {/foreach}
  </div>
</div>
<!--END::TAB-->