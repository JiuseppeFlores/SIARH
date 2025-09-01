<!-- BEGIN::VENTANAS-MODAL -->
<!-- Begin::Modal-Importar-Datos-Monitoreo -->
<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static" id="modalImportarDatosMonitoreo">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <form class="m-form m-form--state m-form--fit m-form--label-align-right" method="POST" id="frmImportarDatosMonitoreo">
                <input type="hidden" name="item[fichaId]" id="txtFichaId" value="">

                <div class="modal-header">
                    <h4 class="modal-title">Importar datos de monitoreo</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="btn_icon_modal_close"><span aria-hidden="true">&times;</span></button>    
                </div>

                <div class="modal-body">        
                    <div class="form-group m-form__group row" id="divImportarPaso1">
                        <div class="col-md-12">
                            <label for="Name"><strong>PASO 1: </strong>Seleccione el archivo Excel (*.xls o *.xlsx)</label>
                        </div>
                        <div class="col-md-7">
                            <input class="form-group col-md-12 btn btn-secondary btn-md" type="file" id="fileDatosMonitoreo" name="fileDatosMonitoreo" accept=".xls, .xlsx, .csv" placeholder="Seleccione un archivo">
                        </div>
                        <div class="col-md-5">
                            <button type="button" class="form-group col-md-12 btn btn-primary mr-auto" id="btnObtenerHojasArchivoDatosMonitoreo">Cargar</button>
                        </div>
                    </div>

                    <div class="form-group m-form__group row" id="divImportarPaso2">
                        <div class="col-md-12">
                            <label for="Name"><strong>PASO 2: </strong>Seleccione la hoja del archivo Excel que requiere importar</label>
                        </div>
                        <div class="col-md-7">
                            <select class="form-control" name="item[nombreHoja]" id="cboHojasArchivoDatosMonitoreo">
                                <option></option>
                            </select>
                        </div>
                        <div class="col-md-5">
                            <button type="button" class="form-group col-md-12 btn btn-primary mr-auto" id="btnImportarArchivoDatosMonitoreo">Importar</button>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary btn-block-custom" id="btnCerrarModalImportarDatosMonitoreo" data-dismiss="modal">Cerrar</button>
                </div>
                
            </form>
        </div>
    </div>
</div>
<!-- End::Modal-Importar-Datos-Monitoreo -->
<!-- END::VENTANAS-MODAL -->