{include file="geovisor/index.css.tpl"}
<div id="mapa" class="mapa">
	<div class="geovisor_data" id="window_location">
		<div class="geovisor_data_contenido">
			<div class="geovisor_data_cuerpo">
				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-10">
							<small>
								El Ministerio de Medio Ambiente y Agua - MMAyA, no se hace responsable de la mala utilización de los datos.
							</small>
						</div>
						<div class="col-lg-2">
							<p id="window_content_location" style="padding-bottom: 10px;"></p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="geovisor_busqueda" id="window_search">
		<div class="container-fluid">
			<div class="row">
				<div class="input-group input-group">
					<input type="text" class="form-control" placeholder="Buscar pozo, geofísica o manantial" id="txt_busca_punto">
					<div class="input-group-append">
						<button class="btn btn-primary" type="button" id="btn_busca_punto"><i class="fa fa-search"></i></button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="geovisor_botones" id="window_botones">
		<div class="geovisor_botones_contenido">
			<div class="geovisor_botones_cuerpo text-center">
				<a href="#" class="btn btn-warning m-btn m-btn--icon m-btn--icon-only m-btn--custom m-btn--pill" title="Consultas" id="lnk_mapa_consultas" style="margin-bottom: 7px;">
					<i class="fa fa-map-marked-alt"></i>
				</a>
				<br>
				<a href="#" class="btn btn-success m-btn m-btn--icon m-btn--icon-only m-btn--custom m-btn--pill" title="Centrar mapa" id="lnk_mapa_centrar" style="margin-bottom: 7px;">
					<i class="fa fa-expand"></i>
				</a>
				<br>
				<span class="dropdown show">
					<a href="#" class="btn btn-primary m-btn m-btn--icon m-btn--icon-only m-btn--custom m-btn--pill" data-toggle="dropdown" aria-expanded="true" title="Imprimir mapa"  style="margin-bottom: 7px;">
						<i class="fa fa-print"></i>
					</a>
					<div class="dropdown-menu dropdown-menu-left" x-placement="bottom-start" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 27px, 0px);">
						<a class="dropdown-item" href="#" title="Guardar reporte PDF" id="lnk_mapa_imprimir_pdf" >Guardar reporte PDF</a>
						<a class="dropdown-item" href="#" title="Guardar imagen PNG" id="lnk_mapa_imprimir_png">Guardar imagen PNG</a>
					</div>
				</span>
				<br>
				<a href="#" class="btn btn-primary m-btn m-btn--icon m-btn--icon-only m-btn--custom m-btn--pill" title="Mostrar gratícula" id="lnk_mapa_graticula" style="margin-bottom: 7px;">
					<i class="flaticon-squares-2"></i>
				</a>
				<br>
				<a href="#" class="btn btn-primary m-btn m-btn--icon m-btn--icon-only m-btn--custom m-btn--pill" title="Mostrar orientación" id="lnk_mapa_orientacion" style="margin-bottom: 7px;">
					<i class="fa fa-arrows-alt"></i>
				</a>
				<br>
				<a href="#" class="btn btn-primary m-btn m-btn--icon m-btn--icon-only m-btn--custom m-btn--pill" title="Búsqueda" id="lnk_mapa_busqueda" style="margin-bottom: 7px;">
					<i class="fa fa-search"></i>
				</a>
			</div>
		</div>
	</div>
</div>

<div class="mapa_datos">
	<div class="geovisor_info" id="window_info">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12" id="window_content_info">
				</div>
			</div>
		</div>
	</div>
	<!-- <div class="geovisor_info" id="window_info">
		<div class="geovisor_info_contenido">
			<div class="geovisor_info_cuerpo">
				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-12" id="window_content_info">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div> -->
	<div class="geovisor_menu">
		<div class="geovisor_menu_contenido">
			<div class="m-btn-group m-btn-group--pill btn-group geovisor_menu_boton" role="group" aria-label="First group">
			    <button type="button" class="m-btn btn btn-success btn-sm" id="btn_geovisor_move"><i class="fa fa-expand"></i>&nbsp;CENTRAR</button>
			   	<button type="button" class="m-btn btn btn-warning btn-sm" id="btn_geovisor_search"><i class="fa fa-map-marked-alt"></i>&nbsp;CONSULTAS</button>
			</div>
		</div>
	</div>
</div>

<!--begin::Modal consultas-->
<div class="modal fade" id="modal_consultas" tabindex="-1" role="dialog"
     data-backdrop="static"
     data-keyboard="false"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content" id="modal_content_consultas">
			<div class="modal-header">
                <h4 class="modal-title">Consultas</h4>
            </div>
            <div class="modal-body">
            	<ul class="nav nav-pills nav-pills--warning" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active show" data-toggle="tab" href="#tab_nacional" data-target="#tab_nacional" id="lnk_info_nacional">Nacional</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#tab_deptal" id="lnk_info_deptal">Departamental</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#tab_municipal" id="lnk_info_municipal">Municipal</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#tab_cuenca_estrategica" id="lnk_info_cuenca_estrategica">
                        	Cuenca estratégica
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#tab_acuifero" id="lnk_info_acuifero">Acuífero</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#tab_epsa" id="lnk_info_epsa">EPSAs</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#tab_pozo" id="lnk_info_pozo">Pozos</a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active show" id="tab_nacional" role="tabpanel">
                    </div>

                    <div class="tab-pane" id="tab_deptal" role="tabpanel">
                    </div>

                    <div class="tab-pane" id="tab_municipal" role="tabpanel">
                    </div>

                    <div class="tab-pane" id="tab_cuenca_estrategica" role="tabpanel">
                    </div>

                    <div class="tab-pane" id="tab_acuifero" role="tabpanel">
                    </div>

                    <div class="tab-pane" id="tab_epsa" role="tabpanel">
                    </div>

                    <div class="tab-pane" id="tab_pozo" role="tabpanel">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-block-custom" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>
<!--end::Modal consultas-->

<!--begin::Modal-->
<div class="modal fade" id="modal_window" tabindex="-1" role="dialog"
     data-backdrop="static"
     data-keyboard="false"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content" id="modal_content">
        </div>
    </div>
</div>
<!--end::Modal-->

<!--begin::Modal Para Graficas-->
<div class="modal fade bd-example-modal-lg" id="modal_stiff" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content" id="modal_stiff_contenido">
    </div>
  </div>
</div>
<!--end::Modal Para Graficas-->