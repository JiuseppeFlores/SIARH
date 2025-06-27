<div class="m-portlet__head">
    <div class="m-portlet__head-caption">
        <div class="m-portlet__head-title">
            <h3 class="m-portlet__head-text">Lista de captaciones superficiales</h3>
        </div>
    </div>
    <div class="m-portlet__head-tools">
        <ul class="m-portlet__nav">
            <li class="m-portlet__nav-item">
                <button class="btn btn-focus m-btn m-btn--custom m-btn--pill m-btn--icon m-btn--air" data-toggle="modal" data-target=".bd-example-modal-lg" id="btn_importar_archivo" rel="new">
                    <span><i class="fa fa-file"></i><span>&nbsp;Importar datos</span></span>
                </button>&nbsp;
                <a href="#" class="btn btn-focus m-btn m-btn--custom m-btn--pill m-btn--icon m-btn--air" id="btn_update" rel="new">
                    <span><i class="fa fa-plus"></i><span>&nbsp;Nueva captación superficial</span></span>
                </a>
            </li>
            <li class="m-portlet__nav-item"></li>
            {*{include file="$modulo_frontend_titulo_ayuda"}*}
        </ul>
    </div>
</div>

<!-- Begin Modal -->
<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

        <form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" id="form_importar">
            <input type="hidden" name="item[fichaId]" id="fichaId" value="{$pozoId}">

            <div class="modal-header">
                <h4 class="modal-title">Importar archivos</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="btn_icon_modal_close"><span aria-hidden="true">&times;</span></button>    
            </div>

            <div class="modal-body">        
                <div class="form-group m-form__group row" id="divPaso1">
                    <div class="col-md-12">
                        <label for="Name"><strong>PASO 1: </strong>Seleccione un archivo Excel 97-2003(.xls) o Excel 2007-Adelante(.xlsx)</label>
                    </div>
                    <div class="col-md-6">
                        <input class="form-group col-md-12 btn btn-secondary btn-md" type="file" id="input_importar" name="input_importar" accept=".xls, .xlsx, .csv" placeholder="Seleccione un archivo">
                    </div>
                    <div class="col-md-6">
                        <button type="button" class="form-group col-md-12 btn btn-primary mr-auto" id="btn_enviar">Enviar</button>
                    </div>
                </div>

                <div class="form-group m-form__group row" id="divPaso2">
                    <div class="col-md-12">
                        <label for="Name"><strong>PASO 2: </strong>Seleccione una hoja Excel de la lista (Hojas del libro Excel) y hacer click en Procesar</label>
                    </div>
                    <div class="col-md-6">
                        <select class="form-control" id="select_Hojas">
                            <option></option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <button type="button" class="form-group col-md-12 btn btn-primary mr-auto" id="btn_procesar">Procesar</button>
                    </div>
                </div>

                <div class="form-group m-form__group row" id="divPaso3">
                    <div class="col-md-12">
                        <label for="Name"><strong>PASO 3: </strong>Guardar los datos de la hoja Excel procesados</label>
                    </div>
                    <div class="col-md-6">
                        <div class="dropdown">
                          <button class="btn btn-secondary dropdown-toggle col-md-12" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Hojas Excel guardados</button>
                          <div class="dropdown-menu col-md-12" aria-labelledby="dropdownMenuButton" id="contenedor_lista_agregados">
                            <!-- <a class="dropdown-item" href="#">Action</a>
                            <a class="dropdown-item" href="#">Another action</a>
                            <a class="dropdown-item" href="#">Something else here</a> -->
                          </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <button type="button" class="form-group col-md-12 btn btn-primary mr-auto" id="btn_guardar">Guardar</button>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary btn-block-custom mr-auto" id="btn_nueva_importacion">Nueva Importacion</button>
                <button type="button" class="btn btn-secondary btn-block-custom" id="btn_modal_close" data-dismiss="modal">Cerrar</button>
                <!-- <button type="button" class="btn btn-primary btn-block-custom" id="btn_archivo_submit"><i class="fa fa-check"></i>&nbsp;{if $type == 'new'}Guardar{else}Actualizar{/if}</button> -->
            </div>
            
        </form>

    </div>
  </div>
</div>
<!-- End Modal -->