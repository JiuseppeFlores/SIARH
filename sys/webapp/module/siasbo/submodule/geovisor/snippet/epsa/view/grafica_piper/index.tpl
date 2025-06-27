{include file="grafica_piper/index.css.tpl"}
<!--begin::Gráfica de Piper -->
	<!-- <div class="modal-header">
        <h4 class="modal-title">Diagrama de Piper</h4>
    </div> -->

    <div class="modal-body text-center">
		<div style="overflow: auto;">
			<canvas id="grafico_piper" width="auto" height="auto" style="border: solid 0px #e5e5e5;"></canvas>
		</div>
    </div>

    <div class="modal-footer">
        <div class="m-btn-group m-btn-group--pill btn-group" role="group" aria-label="First group">
		    <button type="button" class="m-btn btn btn-secondary btn-sm" id="btn_piper_min"><i class="fa fa-search"></i>&nbsp;<strong>-</strong></button>
		    <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal" id="btn_modal_close">Cerrar</button>
			<button type="button" class="m-btn btn btn-secondary btn-sm" id="btn_piper_max"><i class="fa fa-search"></i>&nbsp;<strong>+</strong></button>
			<button type="button" class="m-btn btn btn-primary btn-sm" id="btn_guardar_grafica" onclick="javascript:GuardarGrafica()"><i class="fa fa-save"></i>&nbsp;Guardar</button>
		</div>
    </div>
<!--end::Gráfica de Piper -->
{include file="grafica_piper/index.js.tpl"}