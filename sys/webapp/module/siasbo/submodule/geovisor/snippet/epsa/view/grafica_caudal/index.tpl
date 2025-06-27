{include file="grafica_caudal/index.css.tpl"}
<!--begin::Gráfica de Caudal -->
	<!-- <div class="modal-header">
        <h4 class="modal-title">Diagrama de Piper</h4>
    </div> -->

    <div class="modal-body text-center">
		<div style="overflow: auto;">
			<canvas id="grafico_caudal" width="auto" height="auto" style="border: solid 1px #e5e5e5;"></canvas>
		</div>
    </div>

    <div class="modal-footer">
        <div class="m-btn-group m-btn-group--pill btn-group" role="group" aria-label="First group">
		    <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal" id="btn_modal_close">Cerrar</button>
        	<button type="button" class="btn btn-primary btn-block-custom btn-sm" id="btn_guardar_grafica" onclick="javascript:GuardarGrafica()"><i class="fa fa-save"></i>&nbsp;Guardar imagen</button>
		</div>		
    </div>
<!--end::Gráfica de Caudal -->
{include file="grafica_caudal/index.js.tpl"}