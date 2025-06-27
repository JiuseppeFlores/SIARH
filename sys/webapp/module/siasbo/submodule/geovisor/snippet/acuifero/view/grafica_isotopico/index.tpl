{include file="grafica_isotopico/index.css.tpl"}
<!--begin::Gráfica de Isotopico -->
	<!-- <div class="modal-header">
        <h4 class="modal-title">Diagrama de Piper</h4>
    </div> -->

    <!-- <div class="modal-body text-center">
		<div style="overflow: auto;">
			<canvas id="grafico_isotopico" width="auto" height="auto" style="border: solid 1px #e5e5e5;"></canvas>
		</div>
    </div> -->

    <div class="modal-body" id="modal_isotopico">
        <div class="form-group m-form__group row">
          <label for="example-text-input" class="col-2 col-form-label">Campaña</label>
          <div class="col-4">
            <select class="form-control select2" style="width: 100%;" name="campaniaIsotopicoId" id="campaniaIsotopicoId" required data-msg="Campo requerido. Seleccione campaña.">
                <option value="">Seleccione campaña</option>
                <!-- {html_options options=$campanias selected=''} -->
            </select>
          </div>
        </div>
        <br>
        <div class="modal-body pre-scrollable" id="contenedor" style="overflow: auto;">            
            <canvas id="grafico_isotopico" width="700" height="300" style="border: solid 1px #e5e5e5;"></canvas>
        </div>
    </div>

    <div class="modal-footer">
        <div class="m-btn-group m-btn-group--pill btn-group" role="group" aria-label="First group">
		    <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal" id="btn_modal_close">Cerrar</button>
        	<button type="button" class="btn btn-primary btn-block-custom btn-sm" id="btn_guardar_grafica" onclick="javascript:GuardarGrafica()"><i class="fa fa-save"></i>&nbsp;Guardar imagen</button>
		</div>		
    </div>
<!--end::Gráfica de Isotopico -->
{include file="grafica_isotopico/index.js.tpl"}