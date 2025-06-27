<div class="m-portlet__head">
    <div class="m-portlet__head-caption">
        <div class="m-portlet__head-title">
            <h3 class="m-portlet__head-text">Lista datos de cantidad</h3>
        </div>
    </div>
    <div class="m-portlet__head-tools">
        <ul class="m-portlet__nav">
            <li class="m-portlet__nav-item">
           <!--  data-toggle="modal" data-target=".bd-example-modal-lg" -->
                <!-- <button type="button" class="btn btn-secondary btn-block-custom"  onclick="javascript:CargarGraficaCaudal();"><span><i class="fa fa-chart-area"></i><span>&nbsp;Graficar caudal</button>&nbsp;
                <button type="button" class="btn btn-secondary btn-block-custom"  onclick="javascript:CargarGraficaHidrograma();"><span><i class="fa fa-chart-area"></i><span>&nbsp;Graficar abatimiento</button>&nbsp; -->
                <button type="button" class="btn btn-secondary btn-block-custom"  onclick="javascript:RecuperarDatosCaudal();"><span><i class="fa fa-chart-area"></i><span>&nbsp;Graficar caudal</button>&nbsp;
                <button type="button" class="btn btn-secondary btn-block-custom"  onclick="javascript:RecuperarDatosHidrograma();"><span><i class="fa fa-chart-area"></i><span>&nbsp;Graficar abatimiento</button>&nbsp;
                <button type="button" class="btn btn-primary" id="btn_cantidad_submit" onclick="javascript:get_form_cantidad('', 'new');"><span><i class="fa fa-plus"></i><span>&nbsp;Nuevo registro de cantidad</span></span></button>
            </li>
        </ul>
    </div>

    <!-- BEGIN MODAL -->
    <div class="modal fade bd-example-modal-lg" id="modalgraficacantidad" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
      <div class="modal-dialog modal-lg">        
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Abatimiento</h5>
            <button type="button" class="close" onclick="javascript:CerrarModal();" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>          </div>
          <div class="modal-body" id="contenedor">
            <canvas id="lienzo"></canvas>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" id="btn_cerrar_grafica" onclick="javascript:CerrarModal();" data-dismiss="modal">Cerrar</button>
            <button type="button" class="btn btn-primary btn-block-custom" id="btn_guardar_grafica" onclick="javascript:GuardarGrafica()"><i class="fa fa-save"></i>&nbsp;Guardar imagen</button>
            <!-- <button type="button" class="btn btn-primary btn-block-custom" id="btn_zoom_min_grafica"><i class="fa fa-search"></i>&nbsp;<strong>-</strong></button>
            <button type="button" class="btn btn-primary btn-block-custom" id="btn_zoom_max_grafica"><i class="fa fa-search"></i>&nbsp;<strong>+</strong></button> -->
          </div>
        </div>
      </div>
    </div>
    <!-- END MODAL -->
</div>