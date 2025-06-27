{include file="grafica_caudal/index.css.tpl"}
<!--begin::Gráfica de Caudal -->
    <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Diagrama de caudal</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
    </div>

    <div class="modal-body">
        <!-- <div class="form-group m-form__group row">
          <label for="example-text-input" class="col-2 col-form-label">Campaña</label>
          <div class="col-4">
            <select class="form-control select2" style="width: 100%;" name="campaniaStiffId" id="campaniaStiffId" required data-msg="Campo requerido. Seleccione campaña.">
                <option value="">Seleccione campaña</option>
                {html_options options=$campanias selected=''}
            </select>
          </div>
        </div>
        <br> -->
		<!-- <div style="overflow: auto;">
			<canvas id="grafico_caudal" width="750px" height="350px" style="border: solid 1px #e0e0e0;"></canvas>
		</div> -->
        <div id="contenedor">
            <canvas id="lienzo" width="750px" height="350px" style="border: solid 1px #e0e0e0;"></canvas>
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