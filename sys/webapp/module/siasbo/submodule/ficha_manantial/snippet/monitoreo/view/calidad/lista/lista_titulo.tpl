<div class="m-portlet__head">
    <div class="m-portlet__head-caption">
        <div class="m-portlet__head-title">
            <h3 class="m-portlet__head-text">Lista datos de calidad</h3>
        </div>
    </div>
    <div class="m-portlet__head-tools">
        <ul class="m-portlet__nav">
            <li class="m-portlet__nav-item">
                <button type="button" class="btn btn-default" id="btn_grafica_calidad" onclick="javascript:RecuperarDatosCalidad();"><span><i class="fa fa-plus"></i><span>&nbsp;Grafica de toma muestras</span></span></button>
            </li>
            <li class="m-portlet__nav-item">
                <button type="button" class="btn btn-primary" id="btn_nuevo_calidad_submit" onclick="javascript:get_form_calidad('', 'new');"><span><i class="fa fa-plus"></i><span>&nbsp;Nuevo registro de calidad</span></span>
                </button>
            </li>
        </ul>
    </div>
    <!-- BEGIN MODAL -->
    <div class="modal fade bd-example-modal-lg" id="modalgraficacalidad" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
      <div class="modal-dialog modal-lg">        
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel_calidad">Monitoreo de Calidad</h5>
            <button type="button" class="close" onclick="javascript:CerrarModalCalidad();" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>          </div>
          <div class="modal-body" id="contenedor_calidad">
            <canvas id="lienzo_profundidad"></canvas>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" id="btn_cerrar_grafica_calidad" onclick="javascript:CerrarModalCalidad();" data-dismiss="modal">Cerrar</button>
            <button type="button" class="btn btn-primary btn-block-custom" id="btn_guardar_grafica_calidad" onclick="javascript:GuardarGraficaCalidad()"><i class="fa fa-save"></i>&nbsp;Guardar imagen</button>
          </div>
        </div>
      </div>
    </div>
    <!-- END MODAL -->
</div>