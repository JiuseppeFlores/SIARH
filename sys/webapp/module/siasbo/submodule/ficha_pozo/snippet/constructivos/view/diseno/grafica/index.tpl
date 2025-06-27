{include file="diseno/grafica/index.css.tpl"}

    <!-- <div class="modal-header">
        <h4 class="modal-title">Gráfica de diseño</h4>
    </div> -->

    <div class="modal-body text-center" id="modal_body">
        <div id="contenedor_grafico_diseno" class="m-scrollable m-scroller" style="overflow: auto;">
            <canvas id="grafico_diseno" style="border: solid 1px #ffffff;"></canvas>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-block-custom" id="btn_cerrar_grafica">Cerrar</button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_guardar_grafica" onclick="javascript:GuardarGrafica()"><i class="fa fa-save"></i>&nbsp;Guardar imagen</button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_zoom_min_grafica"><i class="fa fa-search"></i>&nbsp;<strong>-</strong></button>
        <button type="button" class="btn btn-primary btn-block-custom" id="btn_zoom_max_grafica"><i class="fa fa-search"></i>&nbsp;<strong>+</strong></button>
    </div>

{include file="diseno/grafica/index.js.tpl"}