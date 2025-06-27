<div class="m-portlet__head">
    <div class="m-portlet__head-caption">
        <div class="m-portlet__head-title">
            <h3 class="m-portlet__head-text">Lista compuestos de calidad</h3>
        </div>
    </div>
    <div class="m-portlet__head-tools">
        <ul class="m-portlet__nav">
            <li class="m-portlet__nav-item">
                <!-- <button type="button" class="btn btn-secondary btn-block-custom"  onclick="javascript:CargarGraficaS();"><span><i class="fa fa-chart-area"></i><span>&nbsp;Graficar Stiff</button>&nbsp; -->
                <button type="button" class="btn btn-secondary btn-block-custom"  onclick="javascript:AbrirModalS();"><span><i class="fa fa-chart-area"></i><span>&nbsp;Graficar Stiff</button>&nbsp;
                <button type="button" class="btn btn-primary" id="btn_nuevo_compuesto_calidad_submit" onclick="javascript:get_form_calidad_compuesto('', 'new');"><span><i class="fa fa-plus"></i><span>&nbsp;Nuevo compuesto de calidad</span></span>
                </button>
            </li>
        </ul>
    </div>

    <!-- BEGIN MODAL -->
    <div class="modal fade bd-example-modal-lg" id="modalgraficastiff" tabindex="-1" role="dialog" data-backdrop="static" 
  data-keyboard="false">
      <div class="modal-dialog modal-lg">        
        <div class="modal-content">
          <!-- <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Diagrama stiff</h5>
            <button type="button" class="close" onclick="javascript:CerrarModalS();" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div> -->
          <div class="modal-body" id="contenedor">
            <div class="form-group m-form__group row">
              <label for="example-text-input" class="col-2 col-form-label">Campaña</label>
              <div class="col-4">
                <select class="form-control select2" style="width: 100%;" name="campaniaId" id="campaniaId" required data-msg="Campo requerido. Seleccione campaña.">
                    <option value="">Seleccione campaña</option>
                    {html_options options=$campanias selected=''}
                </select>
              </div>
            </div>
            <br>
            <canvas id="lienzoCalidad" width="750px" height="350px" style="border: solid 1px #e0e0e0;"></canvas>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" id="btn_cerrar_grafica" onclick="javascript:CerrarModalS();" data-dismiss="modal">Cerrar</button>
            <button type="button" class="btn btn-primary btn-block-custom" id="btn_guardar_grafica" onclick="javascript:GuardarGraficaS()"><i class="fa fa-save"></i>&nbsp;Guardar imagen</button>
            <!-- <button type="button" class="btn btn-primary btn-block-custom" id="btn_zoom_min_grafica"><i class="fa fa-search"></i>&nbsp;<strong>-</strong></button>
            <button type="button" class="btn btn-primary btn-block-custom" id="btn_zoom_max_grafica"><i class="fa fa-search"></i>&nbsp;<strong>+</strong></button> -->
          </div>
        </div>
      </div>
    </div>
    <!-- END MODAL -->
</div>