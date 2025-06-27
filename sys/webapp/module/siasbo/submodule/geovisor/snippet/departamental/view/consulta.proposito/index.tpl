{include file="consulta.proposito/index.css.tpl"}
<!--begin:: Datos estadísticos -->
<div class="m-portlet m-portlet--creative m-portlet--first m-portlet--bordered-semi">
	<div class="m-portlet__head">
		<div class="m-portlet__head-caption">
			<div class="m-portlet__head-title">
				<span class="m-portlet__head-icon m--hide">
					<i class="flaticon-statistics"></i>
				</span>
				<h3 class="m-portlet__head-text">
					Los siguientes cuadros muestran información sobre propósitos de pozos (un pozo puede tener uno o más propósitos).
				</h3>
				<h2 class="m-portlet__head-label m-portlet__head-label--warning">
					<span id="titulo_consulta">Información Departamental - {$nombreDepto}</span>
				</h2>
			</div>			
		</div>
	</div>

	<div class="m-portlet__body  m-portlet__body--no-padding">
		<div class="row m-row--no-padding m-row--col-separator-xl">			
			<div class="col-xl-12">
				<!--begin:: Widgets/Stats2-1 -->
				<div class="m-widget1">
					<div class="m-widget1__item">
						<div class="row m-row--no-padding align-items-center">
							<div class="col text-left">
								<h3 class="m-widget1__title">Total Pozos</h3>
							</div>
							<div class="col text-right">
								<span class="m-widget1__number m--font-brand"><h2>{$pozosTotal}</h2></span>
							</div>
						</div>
					</div>

					<div class="m-widget1__item">
						<div class="row m-row--no-padding">
							<div class="col-md-6 col-lg-12 text-left">
								<h3 class="m-widget1__title">Pozos por propósito (%)</h3>
								<br>
								<canvas id="pozoChart" width="auto" height="{$pozosCantidadEtiquetas}"></canvas>
							</div>
						</div>
					</div>

				</div>
				<!--end:: Widgets/Stats2-1 -->
			</div>
		</div>
	</div>
</div>
<!--end:: Datos estadísticos -->
{include file="consulta.proposito/index.js.tpl"}