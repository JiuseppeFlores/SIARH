<div class="m-portlet__head">
    
    <div class="m-portlet__head-caption">
        <div class="m-portlet__head-title">
            <h3 class="m-portlet__head-text">Designar acciones a los usuarios</h3>
        </div>
    </div>
    
    <div class="m-portlet__head-tools">
        <ul class="m-portlet__nav">
            <li class="m-portlet__nav-item">
                <!-- <button class="btn btn-focus m-btn m-btn--custom m-btn--pill m-btn--icon m-btn--air" id="btn_prueba" rel="new">
                    <span><i class="fa fa-file"></i><span>&nbsp;Boton de pruebas</span></span>
                </button>&nbsp; -->
                <!-- <button class="btn btn-focus m-btn m-btn--custom m-btn--pill m-btn--icon m-btn--air" data-toggle="modal" data-target=".bd-example-modal-lg" id="btn_prueba" rel="new">
                    <span><i class="fa fa-file"></i><span>&nbsp;Boton de pruebas</span></span>
                </button>&nbsp; -->
                <!-- <a href="#" class="btn btn-focus m-btn m-btn--custom m-btn--pill m-btn--icon m-btn--air" id="btn_update" rel="new">
						<span><i class="fa fa-plus"></i><span>Probar</span></span>
                </a> -->
            </li>
            <li class="m-portlet__nav-item"></li>

        </ul>
    </div>
</div>

<!-- Begin Modal -->
<div class="modal fade bd-example-modal-lg" id="modal_configuracion" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

        <form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" id="form_importar">
            <input type="hidden" name="item[fichaId]" id="fichaId" value="{$pozoId}">

            <div class="modal-header">
                <h4 class="modal-title">Configurar permisos</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="btn_icon_modal_close"><span aria-hidden="true">&times;</span></button>    
            </div>

            <div class="modal-body">   
                <!-- <div class="form-group m-form__group row" id="divPaso1">
                    <div class="col-md-12">
                        <label for="Name" id="lbl_usuario"><strong></strong></label>
                    </div>
                </div> -->

                <div class="form-group m-form__group row" id="divPaso1">
                    <div class="col-md-12">
                        <label for="Name"><strong>CONFIGURACION BASICA</strong></label>
                    </div>
                    <div class="col-md-6">
                        <label for="Name">Seleccione esta opción para: tecnicos, operadores, invitados o cargos afines</label>
                    </div>
                    <div class="col-md-6">
                        <button type="button" class="form-group col-md-12 btn btn-primary mr-auto" id="btn_basico">Seleccionar configuracion <strong>BASICA</strong></button>
                    </div>
                </div>

                <div class="form-group m-form__group row" id="divPaso2">
                    <div class="col-md-12">
                        <label for="Name"><strong>CONFIGURACION MEDIA</strong></label>
                    </div>
                    <div class="col-md-6">
                        <label for="Name">Seleccione esta opcion para: fiscales, supervisores o cargos afines</label>
                    </div>
                    <div class="col-md-6">
                        <button type="button" class="form-group col-md-12 btn btn-primary mr-auto" id="btn_medio">Seleccionar configuracion <strong>MEDIA</strong></button>
                    </div>
                </div>

                <div class="form-group m-form__group row" id="divPaso3">
                    <div class="col-md-12">
                        <label for="Name"><strong>CONFIGURACION AVANZADA</strong></label>
                    </div>
                    <div class="col-md-6">
                        <label for="Name">Seleccione esta opcion para: administradores de sistemas o cargos afines</label>
                    </div>
                    <div class="col-md-6">
                        <button type="button" class="form-group col-md-12 btn btn-primary mr-auto" id="btn_avanzado">Seleccionar configuracion <strong>AVANZADA</strong></button>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <!-- <button type="button" class="btn btn-primary btn-block-custom mr-auto" id="btn_nueva_importacion">Nueva Importacion</button> -->
                <button type="button" class="btn btn-secondary btn-block-custom" id="btn_modal_close" data-dismiss="modal">Cerrar</button>
                <!-- <button type="button" class="btn btn-primary btn-block-custom" id="btn_archivo_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button> -->
            </div>
            
        </form>

    </div>
  </div>
</div>
<!-- End Modal -->