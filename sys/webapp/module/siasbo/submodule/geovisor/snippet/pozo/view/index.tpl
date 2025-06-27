{include file="index.css.tpl"}
<!--begin:: Pozo -->
<div class="m-portlet m-portlet--creative m-portlet--first m-portlet--bordered-semi">
	<div class="m-portlet__head">
		<div class="m-portlet__head-caption">
			<div class="m-portlet__head-title">
				<span class="m-portlet__head-icon m--hide">
					<i class="flaticon-statistics"></i>
				</span>
				<h3 class="m-portlet__head-text">
					Los siguientes cuadros muestran información sobre pozos, manantiales, estudios geofísicos y otros.
				</h3>
				<h2 class="m-portlet__head-label m-portlet__head-label--warning">
					<span id="titulo_consulta">Información EPSA - {$nombreEpsa}</span>
				</h2>
			</div>
		</div>
	</div>

	<div class="m-portlet__body  m-portlet__body--no-padding">
		<div class="row m-row--no-padding m-row--col-separator-xl">

			<div class="col-md-12">
				<!--begin:: Widgets/Stats2-1 -->
				<div class="m-widget1">
					<div class="m-widget1__item">
						<div class="row m-row--no-padding align-items-center">
							<div class="col text-left">
								<h3 class="m-widget1__title">Total Pozos EPSAS</h3>
							</div>
							<div class="col text-left">
								<h3 class="m-widget1__title">Total Captación Superficial EPSAS</h3>
							</div>
						</div>
						<div class="row m-row--no-padding align-items-center">
							<div class="col text-left">
								<span class="m-widget1__number m--font-brand"><h2>{$pozosTotal}</h2></span>
							</div>
							<div class="col text-left">
								<span class="m-widget1__number m--font-brand"><h2>{$captacionTotal}</h2></span>
							</div>
						</div>
					</div>
					<div class="m-widget1__item">
						<div class="row m-row--no-padding align-items-center">
							<div class="col">
								<h3 class="m-widget1__title">Total caudal producido pozos</h3>
								<span class="m-widget1__desc"></span>
							</div>
							<div class="col m--align-left">
								<span class="m-widget1__number m--font-brand">
									<h2>{$caudalProduccionPozos}&nbsp;m3/s</h2>
								</span>
							</div>
						</div>
					</div>
					<div class="m-widget1__item">
						<div class="row m-row--no-padding align-items-center">
							<div class="col text-left">
								<h3 class="m-widget1__title">Total Manantiales</h3>
							</div>
							<div class="col text-left">
								<h3 class="m-widget1__title">Caudal producido</h3>
							</div>
						</div>
						<div class="row m-row--no-padding align-items-center">
							<div class="col text-left">
								<span class="m-widget1__number m--font-brand"><h2>{$manantialTotal}</h2></span>
							</div>
							<div class="col text-left">
								<span class="m-widget1__number m--font-brand"><h2>{$caudalProduccionManantiales}&nbsp;m3/s</h2></span>
							</div>
						</div>
					</div>
					<div class="m-widget1__item">
						<div class="row m-row--no-padding align-items-center">
							<div class="col text-left">
								<button type="button" class="btn m-btn--pill btn-outline-brand btn-sm btn-block" id="btn_graficar_piper">&nbsp;GRAFICAR DIAGRAMA PIPER</button>
								<button type="button" class="btn m-btn--pill btn-outline-brand btn-sm btn-block" id="btn_graficar_caudal">&nbsp;GRAFICAR DIAGRAMA CAUDAL</button>
								<button type="button" class="btn m-btn--pill btn-outline-brand btn-sm btn-block" id="btn_graficar_isotopico">&nbsp;GRAFICAR DIAGRAMA ISOTÓPICO</button>
							</div>
						</div>
					</div>

				</div>
				<!--end:: Widgets/Stats2-1 -->
			</div>
		</div>
	</div>
</div>
<!--end:: Pozo -->
{include file="index.js.tpl"}