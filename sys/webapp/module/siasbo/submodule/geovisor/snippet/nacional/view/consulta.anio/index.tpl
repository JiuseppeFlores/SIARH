{include file="consulta.profundidad/index.css.tpl"}
<!--begin:: Datos estadísticos -->
<div class="m-portlet m-portlet--creative m-portlet--first m-portlet--bordered-semi">
	<div class="m-portlet__head">
		<div class="m-portlet__head-caption">
			<div class="m-portlet__head-title">
				<span class="m-portlet__head-icon m--hide">
					<i class="flaticon-statistics"></i>
				</span>
				<h3 class="m-portlet__head-text">
					Los siguientes cuadros muestran información de pozos perforados por año.
				</h3>
				<h2 class="m-portlet__head-label m-portlet__head-label--warning">
					<span id="titulo_consulta">Información Nacional</span>
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
							<div class="col text-left">
								<h3 class="m-widget1__title">Total EPSAs</h3>
							</div>
						</div>
						<div class="row m-row--no-padding align-items-center">
							<div class="col text-left">
								<span class="m-widget1__number m--font-brand"><h2>{$pozosTotal}</h2></span>
							</div>
							<div class="col text-left">
								<span class="m-widget1__number m--font-brand"><h2>{$cantidadEpsas}</h2></span>
							</div>
						</div>
					</div>
					<div class="m-widget1__item">
						<div class="row m-row--no-padding align-items-center">
							<div class="col text-left">
								<h3 class="m-widget1__title">Total Otros Pozos</h3>
							</div>
							<div class="col text-left">
								<h3 class="m-widget1__title">Total Pozos EPSAs</h3>
							</div>
						</div>

						<div class="row m-row--no-padding align-items-center">
							<div class="col text-left">
								<span class="m-widget1__number m--font-success">
									<h2>{math equation="x - y" x=$pozosTotal y=$pozosEpsasTotal}</h2>
								</span>
							</div>
							<div class="col text-left">
								<span class="m-widget1__number m--font-success"><h2>{$pozosEpsasTotal}</h2></span>
							</div>
						</div>
					</div>

					<div class="m-widget1__item">
						<div class="row m-row--no-padding">
							<div class="col-md-6 col-lg-12 text-left">
								<h3 class="m-widget1__title">Pozos por departamento (%)</h3>
								<br>
								<canvas id="pozoChart" width="auto" height="{$pozosCantidadEtiquetas}"></canvas>
							</div>
							<div class="col-md-6 col-lg-12 text-left">
								<h3 class="m-widget1__title">Pozos administrados por EPSAs (%)</h3>
								<br>
								<canvas id="pozosEpsasChart" width="auto" height="{$epsasCantidadEtiquetas}"></canvas>
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
{include file="consulta.profundidad/index.js.tpl"}