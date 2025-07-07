<div class="m-portlet__head">
    <div class="m-portlet__head-caption">
        <div class="m-portlet__head-title">
            <h3 class="m-portlet__head-text">Lista de escalones</h3>
        </div>
    </div>
    <div class="m-portlet__head-tools">
        <ul class="m-portlet__nav">
            <li class="m-portlet__nav-item">
                <!-- <button type="button" class="btn btn-secondary btn-block-custom" data-toggle="modal" data-target=".bd-example-modal-lg" onclick="javascript:CargarGrafica();"><span><i class="fa fa-chart-area"></i><span>&nbsp;Graficar prueba de bombeo</button>&nbsp; -->
                <button type="button" class="btn btn-secondary btn-block-custom" data-toggle="modal" data-target=".bd-example-modal-lg" onclick="javascript:get_grafica({$pozoId},{$tipobombeo});"><span><i class="fa fa-chart-area"></i><span>&nbsp;Graficar prueba de bombeo</button>&nbsp;
                <button type="button" class="btn btn-primary" id="btn_nuevo_escalon_submit" onclick="javascript:get_form_escalon('', 'new', {$tipobombeo});"><span><i class="fa fa-plus"></i><span>&nbsp;Nuevo escalón</span></span>
                </button>
            </li>
        </ul>
    </div>

    <!-- BEGIN MODAL -->
    <!-- <div class="modal fade bd-example-modal-lg" id="modalgraficabombeo" tabindex="-1" role="dialog" data-backdrop="static" 
  data-keyboard="false">
      <div class="modal-dialog modal-lg">        
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel"></h5>
            <button type="button" class="close" onclick="javascript:CerrarModal();" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body" id="contenedor">
            <canvas id="lienzo"></canvas>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" id="btn_cerrar_grafica" onclick="javascript:CerrarModal();" data-dismiss="modal">Cerrar</button>
            <button type="button" class="btn btn-primary btn-block-custom" id="btn_guardar_grafica" onclick="javascript:GuardarGrafica()"><i class="fa fa-save"></i>&nbsp;Guardar imagen</button>
          </div>
        </div>
      </div>
    </div> -->
    <!-- END MODAL -->

    <!--begin::Modal Para Graficas-->
    <div class="modal fade bd-example-modal-lg" id="modal_escalon" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
      <div class="modal-dialog modal-lg">
        <div class="modal-content" id="modal_escalon_contenido"></div>
      </div>
    </div>
    <!--end::Modal Para Graficas-->
</div>