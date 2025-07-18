<div class="m-portlet__head">
    <div class="m-portlet__head-caption">
        <div class="m-portlet__head-title">
            <h3 class="m-portlet__head-text">Lista datos de cantidad</h3>
        </div>
    </div>
    <div class="m-portlet__head-tools">
        <ul class="m-portlet__nav">
            <li class="m-portlet__nav-item">
                <button type="button" class="btn btn-default" id="btn_grafica_cantidad" onclick="javascript:RecuperarDatosQVST();"><span><i class="fa fa-plus"></i><span>&nbsp;Grafica de cantidad Q vs T</span></span></button>
            </li>
            <li class="m-portlet__nav-item">
                <button type="button" class="btn btn-primary" id="btn_nuevo_cantidad_submit" onclick="javascript:get_form_cantidad('', 'new');"><span><i class="fa fa-plus"></i><span>&nbsp;Nuevo registro de cantidad</span></span></button>
            </li>
        </ul>
    </div>

    <!-- BEGIN MODAL -->
    <div class="modal fade bd-example-modal-lg" id="modalgraficacantidad" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
      <div class="modal-dialog modal-lg">        
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel_cantidad">Monitoreo de Cantidad</h5>
            <button type="button" class="close" onclick="javascript:CerrarModalCantidad();" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>          </div>
          <div class="modal-body" id="contenedor_cantidad">
            <canvas id="lienzo_cantidad"></canvas>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" id="btn_cerrar_grafica_cantidad" onclick="javascript:CerrarModalCantidad();" data-dismiss="modal">Cerrar</button>
            <button type="button" class="btn btn-primary btn-block-custom" id="btn_guardar_grafica_cantidad" onclick="javascript:GuardarGraficaCantidad()"><i class="fa fa-save"></i>&nbsp;Guardar imagen</button>
          </div>
        </div>
      </div>
    </div>
    <!-- END MODAL -->
</div>