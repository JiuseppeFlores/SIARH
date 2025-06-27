<!--begin::Portlet-->
<div class="m-portlet">
    <!--begin::Form-->
    <form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" action="{$getModule}"  id="form_perforacion" autocomplete="off">

        <input type="hidden" name="item[itemId]" id="itemId" value="{$pozoCod}">

        <div class="m-portlet__head">
            <div class="m-portlet__head-caption">
                <div class="m-portlet__head-title">
                    <h3 class="m-portlet__head-text">Datos de perforación</h3>
                </div>
            </div>
        </div>

        <div class="m-portlet__body">
           
            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>Fecha de perforación</label>
                    <div class="input-group" >
                        <input class="form-control m-input" placeholder="Ingrese fecha de perforación" type="text" name="item[perforacion_fecha]" id="perforacion_fecha" value="{$item.perforacion_fecha|date_format:'%d/%m/%Y'|escape:"html"}" maxlength="10" data-msg="Campo requerido: seleccione una fecha valida">
                        <div class="input-group-append">
                            <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Se deberá poner la fecha en que se realizará la perforación.">
                                <i class="flaticon-questions-circular-button"></i>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <label>Tipo de pozo</label>
                    <div class="input-group" >
                        <select class="form-control m-input select2" name="item[perforacion_pozoId]" id="perforacion_pozoId" data-placeholder="Seleccione tipo de pozo" data-msg="Campo requerido: seleccione una opción">
                            <option value="">Seleccione tipo de pozo</option>
                            {html_options options=$cataobj.tipopozo selected=$item.perforacion_pozoId}
                        </select>                            
                    </div>                    
                </div>
            </div>

            <div id="divPerforacion">
                <div class="form-group m-form__group row">
                    <div class="col-lg-6">
                        <label>Tipo de perforación</label>
                        <div class="input-group" >
                            <select class="form-control m-input select2" name="item[perforacion_tipoId]" id="perforacion_tipoId" data-msg="Campo requerido: seleccione una opción">
                                <option value="">Seleccione tipo de perforación</option>
                                {html_options options=$cataobj.tipoperforacion selected=$item.perforacion_tipoId}
                            </select>                        
                        </div>                    
                    </div>

                    <div class="col-lg-6">
                        <label>Método de perforación</label>
                        <div class="input-group" >
                            <select class="form-control m-input select2" name="item[perforacion_metodoId]" id="perforacion_metodoId" data-msg="Campo requerido: Seleccione una opción">
                                <option value="">Seleccione método de perforación</option>
                                {html_options options=$cataobj.metodoperforacion selected=$item.perforacion_metodoId}
                            </select>
                        </div>                    
                    </div>
                </div>

                <div class="form-group m-form__group row">
                    <div class="col-lg-6">
                        <label>Profundidad perforada (m)</label>
                        <div class="input-group" >
                            <input class="form-control m-input" placeholder="Ingrese profundidad perforada (m)" type="text" name="item[perforacion_profundidad]" id="perforacion_profundidad" value="{$item.perforacion_profundidad|escape:"html"}" min="0" max="999" step="0.01" data-msg="Campo requerido: 3 enteros y 2 decimales">
                            <div class="input-group-append">
                                <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Profundidad en metros a la que se tiene previsto hacer la perforación."><i class="flaticon-questions-circular-button"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                    
                <div class="form-group m-form__group row">
                    <div class="col-lg-6">
                        <label>Diámetro de perforación inicial (pulg)</label>
                        <div class="input-group">
                            <input class="form-control m-input" placeholder="Ingrese diámetro de perforación inicial (pulg)" type="text" name="item[perforacion_diametro]" id="perforacion_diametro" value="{$item.perforacion_diametro|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido: 2 enteros y 2 decimales">
                            <div class="input-group-append">
                                <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Es el diámetro con el que se comienza a perforar el pozo."><i class="flaticon-questions-circular-button"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <label>Diámetro de perforación final (pulg)</label>
                        <div class="input-group" >
                            <input class="form-control m-input" placeholder="Ingrese diámetro de perforación final (pulg)" type="text" name="item[perforacion_diametro_final]" id="perforacion_diametro_final" value="{$item.perforacion_diametro_final|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido: 2 enteros y 2 decimales">
                            <div class="input-group-append">
                                <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Es el diámetro con el que se culmina la perforación del pozo."><i class="flaticon-questions-circular-button"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>               

            <!--BEGIN NUEVA IMPLEMENTACIÓN -->
            <div id="divExcavacion">
                <div class="form-group m-form__group row">
                    <div class="col-lg-6">
                        <label>Tipo de revestimiento</label>
                        <div class="input-group" >
                            <select class="form-control m-input select2" name="item[perforacion_revestimientoId]" id="perforacion_revestimientoId" data-msg="Campo requerido: seleccione una opción">
                                <option value="">Seleccione tipo de revestimiento</option>
                                {html_options options=$cataobj.tiporevestimiento selected=$item.perforacion_revestimientoId}
                            </select>                        
                        </div>                    
                    </div>

                    <div class="col-lg-6">
                        <label>Tipo de excavación</label>
                        <div class="input-group" >
                            <select class="form-control m-input select2" name="item[perforacion_excavacionId]" id="perforacion_excavacionId" data-msg="Campo requerido: seleccione una opción">
                                <option value="">Seleccione tipo de excavación</option>
                                {html_options options=$cataobj.tipoexcavacion selected=$item.perforacion_excavacionId}
                            </select>
                        </div>                    
                    </div>
                </div>

                <div class="form-group m-form__group row">
                    <div class="col-lg-6">
                        <label>Profundidad excavada (m)</label>
                        <div class="input-group">
                            <input class="form-control m-input" placeholder="Ingrese profundidad excavada (m)" type="text" name="item[perforacion_profundidadexcavada]" id="perforacion_profundidadexcavada" value="{$item.perforacion_profundidadexcavada|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido: 2 enteros y 2 decimales">
                            <div class="input-group-append">
                                <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <label>Diámetro de excavación (pulg)</label>
                        <div class="input-group" >
                            <input class="form-control m-input" placeholder="Ingrese diámetro de excavacion (pulg)" type="text" name="item[perforacion_diametroexcavacion]" id="perforacion_diametroexcavacion" value="{$item.perforacion_diametroexcavacion|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido: 2 enteros y 2 decimales">
                            <div class="input-group-append">
                                <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                </div> 

                <div class="form-group m-form__group row">
                    <div class="col-lg-6">
                        <label>Nivel freático (m)</label>
                        <div class="input-group">
                            <input class="form-control m-input" placeholder="Ingrese nivel freático (m)" type="text" name="item[perforacion_nivelfreatico]" id="perforacion_nivelfreatico" value="{$item.perforacion_nivelfreatico|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido: 2 enteros y 2 decimales">
                            <div class="input-group-append">
                                <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <label>Caudal (l/s)</label>
                        <div class="input-group" >
                            <input class="form-control m-input" placeholder="Ingrese caudal (l/s)" type="text" name="item[perforacion_caudal]" id="perforacion_caudal" value="{$item.perforacion_caudal|escape:"html"}" min="0" max="99" step="0.01" data-msg="Campo requerido: 2 enteros y 2 decimales">
                            <div class="input-group-append">
                                <span class="input-group-text" data-toggle="m-tooltip" data-placement="top" title="" data-original-title="Texto. Ej. Texto"><i class="flaticon-questions-circular-button"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--END NUEVA IMPLEMENTACIÓN -->

            <div class="form-group m-form__group row">
                <div class="col-lg-12">
                    <label>Observaciones</label>
                    <div class="input-group" >
                        <textarea class="form-control m-input" placeholder="Ingrese observaciones" type="text" name="item[perforacion_observaciones]" id="perforacion_observaciones" rows="4" maxlength="150" data-msg="Un máximo de 150 caracteres">{$item.perforacion_observaciones|escape:"html"}</textarea>
                    </div>
                </div>
            </div>

        </div>

        <div class="m-portlet__foot m-portlet__no-border m-portlet__foot--fit">
            <div class="m-form__actions m-form__actions--solid">
                <div class="row">
                    <div class="col-lg-12">
                        {if $privFace.editar == 1}
                        <button type="button" class="btn btn-primary btn-block-custom" id="btn_perforacion_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button>
                        {/if}
                        <a href="{$getModule}" class="btn btn-secondary btn-block-custom" style="float: right;"><i class="fa fa-arrow-left"></i>&nbsp;Volver</a>
                    </div>

                </div>
            </div>
        </div>
    </form>
    <!--end::Form-->
</div>
<!--end::Portlet-->

{include file="index.js.tpl"}
{include file="index.css.tpl"}