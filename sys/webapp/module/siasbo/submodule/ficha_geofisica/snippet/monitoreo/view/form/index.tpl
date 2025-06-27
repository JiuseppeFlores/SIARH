<div class="modal fade " tabindex="-1" role="dialog" id="ventana_form">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<!-- <div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        		<h4 class="modal-title">Agregar Monitoreo</h4>
      		</div> -->
			<div class="modal-body">

				<!--begin::Portlet-->
				<div class="m-portlet">
				    <!--begin::Form-->
				    <form class="m-form" method="POST" action="{$getModule}" id="general_form">

				        <div class="m-portlet__head">
				            <div class="m-portlet__head-caption">
				                <div class="m-portlet__head-title">
				                    <h3 class="m-portlet__head-text">Agregar Monitoreo</h3>
				                </div>
				            </div>
				        </div>

				        <div class="m-portlet__body">
				            <div class="row">
				                <div class="form-group col-lg-6">
									<!-- Código de manantial -->
				                	<input class="form-control m-input" type="hidden" name="item[manantialId]" id="manantialId" value="{$manantialId|escape:"html"}" {$privFace.input} required>

				                    <label class="control-label">Fecha</label>
				                    <input class="form-control m-input" placeholder="Ingrese fecha" type="text" name="item[fecha]" id="fecha" value="{$item.fecha|escape:"html"}" {$privFace.input} required>
				                </div>

				                <div class="form-group col-lg-6">
				                    <label class="control-label">Caudal (l/s)</label>
				                    <input class="form-control" type="text" name="item[caudal]" id="caudal" placeholder="Ingrese caudal (l/s)" value="{$item.caudal|escape:"html"}" {$privFace.input} required>
				                </div>
				            </div>

				            <div class="row">
				                <div class="form-group col-lg-12">
				                    <label class="control-label">Observaciones</label>
				                    <textarea class="form-control" name="item[observaciones]" id="observaciones" placeholder="Ingrese observaciones" rows="4">{$item.observaciones|escape:"html"}</textarea>
				                </div>
				            </div>

				        </div>

				        <div class="m-portlet__foot m-portlet__no-border m-portlet__foot--fit">
				            <div class="m-form__actions m-form__actions--solid">
				                <div class="row">
				                    <div class="col-lg-6">
				                        {if $privFace.editar == 1}
				                        <button type="submit" class="btn btn-primary btn-block-custom" id="general_submit"><i class="fa fa-check"></i>&nbsp;Guardar</button>
				                        {/if}
				                        <button type="reset" class="btn btn-danger btn-block-custom">Cancelar</button>
				                        <button type="button" class="btn btn-default btn-block-custom" data-dismiss="modal">Cerrar</button>
				                    </div>
				                </div>
				            </div>
				        </div>
				    </form>
				    <!--end::Form-->
				</div>
				<!--end::Portlet-->

			</div>
      		<!-- <div class="modal-footer">
        		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        		<button type="button" class="btn btn-primary">Save changes</button>
      		</div> -->
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->