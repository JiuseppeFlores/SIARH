{include file="grafica_columnalitologica/index.css.tpl"}
<!--begin::Gráfica de Stiff -->
    <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Columna Litológica</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
    </div>

    <div class="modal-body">
		<div class="modal-body pre-scrollable" id="contenedor" style="overflow: auto;">
            <!-- width="auto" height="auto" style="border: solid 1px #e5e5e5;" -->
			<canvas id="lienzo"></canvas>
		</div>
    </div>

    <div class="modal-footer">
        <div class="m-btn-group m-btn-group--pill btn-group" role="group" aria-label="First group">
		    <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal" id="btn_modal_close">Cerrar</button>
        	<button type="button" class="btn btn-primary btn-block-custom btn-sm" id="btn_guardar_grafica" onclick="javascript:GuardarGrafica()"><i class="fa fa-save"></i>&nbsp;Guardar imagen</button>
		</div>		
    </div>
<!--end::Gráfica de Stiff -->
{include file="grafica_columnalitologica/index.js.tpl"}