{include file="geovisor/index.css.tpl"}

<!--begin::Modal-->
<div class="modal fade" id="modal_mapa" tabindex="-1" role="dialog"
     data-backdrop="static"
     data-keyboard="false"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <h4 class="modal-title">Ubicación geográfica</h4>
            </div> -->
            <div class="modal-body">
                <div class="form-group m-form__group row" id="mapa_lat_lon">
                    <div class="col-lg-5">
                        <label>Latitud sud (Grado-Min.-Seg.)</label>
                        <div class="input-group">
                            <input class="form-control m-input" type="number" id="mapa_lat_gra" placeholder="Grados" value="{$latitud.0|escape:"html"}" min="8" max="24" step="1" data-msg="Campo requerido. Los grados deben ser números entre 8 y 24.">
                            <input class="form-control m-input" type="number" id="mapa_lat_min" placeholder="Minutos" value="{$latitud.1|escape:"html"}" min="0" max="59" step="1" data-msg="Campo requerido. Los minutos deben ser números entre 0 y 59">
                            <input class="form-control m-input" type="number" id="mapa_lat_seg" placeholder="Segundos" value="{$latitud.2|escape:"html"}" min="0" max="59.999" step="0.001" data-msg="Campo requerido. Los segundos deben ser números entre 0 y 59.999 (3 decimales como máximo).">
                        </div>

                        <input class="form-control m-input" type="hidden" id="mapa_latitudDec" value="{$item.latitudDec|escape:"html"}">
                    </div>
                    <div class="col-lg-5">
                        <label>Longitud oeste (Grado-Min.-Seg.)</label>
                        <div class="input-group">
                            <input class="form-control m-input" type="number" id="mapa_lon_gra" placeholder="Grados" value="{$longitud.0|escape:"html"}" min="55" max="70" step="1" data-msg="Campo requerido. Los grados deben ser números entre 55 y 70.">
                            <input class="form-control m-input" type="number" id="mapa_lon_min" placeholder="Minutos" value="{$longitud.1|escape:"html"}" min="0" max="59" step="1" data-msg="Campo requerido. Los minutos deben ser números entre 0 y 59.">
                            <input class="form-control m-input" type="number" id="mapa_lon_seg" placeholder="Segundos" value="{$longitud.2|escape:"html"}" min="0" max="59.999" step="0.001" data-msg="Campo requerido. Los segundos deben ser números entre 0 y 59.999 (3 decimales como máximo).">
                        </div>

                        <input class="form-control m-input" type="hidden" id="mapa_longitudDec" value="{$item.longitudDec|escape:"html"}">
                    </div>
                    <div class="col-lg-2">
                        <label>Acción</label>
                        <button type="button" class="btn btn-success btn-block-custom" id="btn_convertir_lat_lon">
                            Localizar
                        </button>
                    </div>
                </div>

                <div class="form-group m-form__group row" id="mapa_utm">
                    <div class="col-lg-3">
                        <label>UTM este (X)</label>
                        <input class="form-control m-input" type="number" id="mapa_latitudUtm" placeholder="UTM este (X)" value="{$item.latitudUtm|escape:"html"}" min="0" max="999999" step="0.001" data-msg="Campo requerido. UTM este (X) debe contener números, 6 enteros y 3 decimales como máximo.">
                    </div>
                    <div class="col-lg-3">
                        <label>UTM norte (Y)</label>
                        <input class="form-control m-input" type="number" id="mapa_longitudUtm" placeholder="UTM norte (Y)" value="{$item.longitudUtm|escape:"html"}" min="0" max="9999999" step="0.001" data-msg="Campo requerido. UTM norte (Y) debe contener números, 7 enteros y 3 decimales como máximo.">
                    </div>
                    <div class="col-lg-4">
                        <label>Zona</label>
                        <select class="form-control m-input select2" id="mapa_utmZona" data-msg="Campo requerido. Seleccione una zona.">
                            <option value="">Seleccione zona</option>
                            <option value="19K" {if $item.utmZona == '19K'} selected {/if}>19</option>
                            <option value="20K" {if $item.utmZona == '20K'} selected {/if}>20</option>
                            <option value="21K" {if $item.utmZona == '21K'} selected {/if}>21</option>
                        </select>
                    </div>
                    <div class="col-lg-2">
                        <label>Acción</label>
                        <button type="button" class="btn btn-success btn-block-custom" id="btn_convertir_utm">
                            Localizar
                        </button>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="mapa" id="mapa">
                            <div class="mapa_tool_escala" id="mapa_tool_escala"></div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-5">
                        <strong>Latitud sud:&nbsp;</strong>
                        <span id="texto_latitud">
                            {$latitud.0|escape:"html"}&ordm;&nbsp;
                            {$latitud.1|escape:"html"}&apos;&nbsp;
                            {$latitud.2|escape:"html"}&quot;
                        </span>
                    </div>
                    <div class="col-lg-5">
                        <strong>Longitud oeste:&nbsp;</strong>
                        <span id="texto_longitud">
                            {$longitud.0|escape:"html"}&ordm;&nbsp;
                            {$longitud.1|escape:"html"}&apos;&nbsp;
                            {$longitud.2|escape:"html"}&quot;
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-5">
                        <strong>Latitud sud decimal:&nbsp;</strong>
                        <span id="texto_latitudDec">{$item.latitudDec|escape:"html"}</span>
                    </div>
                    <div class="col-lg-5">
                        <strong>Longitud oeste decimal:&nbsp;</strong>
                        <span id="texto_longitudDec">{$item.longitudDec|escape:"html"}</span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-5">
                        <strong>UTM este:&nbsp;</strong>
                        <span id="texto_latitudUtm">{$item.latitudUtm|escape:"html"}</span>
                    </div>
                    <div class="col-lg-5">
                        <strong>UTM norte:&nbsp;</strong>
                        <span id="texto_longitudUtm">{$item.longitudUtm|escape:"html"}</span>
                    </div>
                    <div class="col-lg-2">
                        <strong>Zona:&nbsp;</strong>
                        <span id="texto_utmZona">{$item.utmZona|escape:"html"}</span>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="m-btn-group m-btn-group--pill btn-group geovisor_menu_boton" role="group" aria-label="First group">
                    <button type="button" class="m-btn btn btn-success btn-sm" id="btn_mapa_inicio"><i class="fa fa-cog"></i>&nbsp;Centrar</button>
                    <button type="button" class="btn btn-secondary btn-block-custom btn-sm" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="m-btn btn btn-primary btn-sm" id="btn_asignar_coordenada"><i class="fa fa-map-marked-alt"></i>&nbsp;Aceptar</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!--end::Modal-->

{include file="geovisor/index.js.tpl"}