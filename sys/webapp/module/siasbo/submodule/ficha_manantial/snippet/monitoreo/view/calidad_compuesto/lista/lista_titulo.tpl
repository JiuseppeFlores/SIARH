<div class="m-portlet__head">
    <div class="m-portlet__head-caption">
        <div class="m-portlet__head-title">
            <h3 class="m-portlet__head-text">Lista compuestos de calidad</h3>
        </div>
    </div>
    <div class="m-portlet__head-tools">
        <ul class="m-portlet__nav">
            <li class="m-portlet__nav-item">
                <button type="button" class="btn btn-secondary btn-block-custom"  onclick="javascript:AbrirModalCalidadS();"><span><i class="fa fa-chart-area"></i><span>&nbsp;Graficar Stiff</button>&nbsp;
                <button type="button" class="btn btn-primary" id="btn_nuevo_compuesto_calidad_submit" onclick="javascript:get_form_calidad_compuesto('', 'new');"><span><i class="fa fa-plus"></i><span>&nbsp;Nuevo compuesto de calidad</span></span>
                </button>
            </li>
        </ul>
    </div>

    <!-- BEGIN MODAL -->
    <div class="modal fade bd-example-modal-lg" id="modalgraficastiffCalidad" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
      <div class="modal-dialog modal-lg">        
        <div class="modal-content">
          <div class="modal-body" id="contenedor_stiff">
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
            <canvas id="lienzo_stiff" width="750px" height="350px" style="border: solid 1px #e0e0e0;"></canvas>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" id="btn_cerrar_grafica_stiff" onclick="javascript:CerrarModalCalidadS();" data-dismiss="modal">Cerrar</button>
            <button type="button" class="btn btn-primary btn-block-custom" id="btn_guardar_grafica_stiff" onclick="javascript:GuardarGraficaCalidadS()"><i class="fa fa-save"></i>&nbsp;Guardar imagen</button>
          </div>
        </div>
      </div>
    </div>
    <!-- END MODAL -->

</div>