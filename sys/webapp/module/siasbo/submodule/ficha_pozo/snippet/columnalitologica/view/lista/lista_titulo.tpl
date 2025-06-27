<div class="m-portlet__head">
    <div class="m-portlet__head-caption">
        <div class="m-portlet__head-title">
            <h3 class="m-portlet__head-text">Lista datos de columna litológica</h3>
        </div>
    </div>
    <div class="m-portlet__head-tools">
        <ul class="m-portlet__nav">
            <li class="m-portlet__nav-item">
                <!--onclick="javascript:graficar_diseno();"-->
                <!-- javascript:CargarGrafica(); -->
                <!-- <button type="button" class="btn btn-secondary btn-block-custom" onclick="javascript:DibujarColumnaLitologica();" data-toggle="modal" data-target=".bd-example-modal-lg"><span><i class="fa fa-chart-area"></i><span>&nbsp;Graficar columna litológica</button>&nbsp; -->
                <button type="button" class="btn btn-secondary btn-block-custom" data-toggle="modal" data-target=".bd-example-modal-lg" onclick="javascript:get_grafica('1');"><span><i class="fa fa-chart-area"></i><span>&nbsp;Graficar columna litológica</button>&nbsp;
                <button type="button" class="btn btn-primary" id="btn_litologia_submit" onclick="javascript:get_form_litologico('', 'new');"><span><i class="fa fa-plus"></i><span>&nbsp;Nueva columna litológica</span></span>
                </button>
            </li>
            <li class="m-portlet__nav-item"></li>

        </ul>
    </div>

    <!-- BEGIN MODAL -->
    <!-- <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
      <div class="modal-dialog modal-lg">        
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Gráfica Columna Litológica</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body pre-scrollable" id="contenedor">
            <canvas id="lienzo"></canvas>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" id="btn_cerrar_grafica" data-dismiss="modal">Cerrar</button>
            <button type="button" class="btn btn-primary btn-block-custom" id="btn_guardar_grafica" onclick="javascript:GuardarGrafica()"><i class="fa fa-save"></i>&nbsp;Guardar imagen</button>
          </div>
        </div>
      </div>
    </div> -->
    <!-- END MODAL -->

    <!--begin::Modal Para Graficas-->
    <div class="modal fade bd-example-modal-lg" id="modal_litologia" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
      <div class="modal-dialog modal-lg">
        <div class="modal-content" id="modal_litologia_contenido"></div>
      </div>
    </div>
    <!--end::Modal Para Graficas-->
</div>