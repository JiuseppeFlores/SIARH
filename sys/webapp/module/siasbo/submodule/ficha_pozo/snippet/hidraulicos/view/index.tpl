
{include file="index.css.tpl"}

<div class="m-portlet m-portlet--tabs">
    <div class="m-portlet__head">
        
        <div class="m-portlet__head-tools">
            <ul class="nav nav-tabs m-tabs-line m-tabs-line--brand" role="tablist">
                <li class="nav-item m-tabs__item">
                    <a id="nav_prueba" class="nav-link m-tabs__link" data-toggle="tab" href="#window_prueba" role="tab" aria-selected="false">
                        <i class="la la-check"></i>&nbsp;General 
                    </a>
                </li>
                <li class="nav-item m-tabs__item">
                    <a id="nav_tipo" class="nav-link m-tabs__link" data-toggle="tab" href="#window_tipo" role="tab" aria-selected="true">
                        <i class="la la-arrow-right"></i>&nbsp;Tipo bombeo
                    </a>
                </li>
                <li class="nav-item m-tabs__item">
                    <a id="nav_escalon" class="nav-link m-tabs__link" data-toggle="tab" href="#window_escalon" role="tab">
                        <i class="la la-arrow-right"></i>&nbsp;Escalón
                    </a>
                </li>
                <li class="nav-item m-tabs__item">
                    <a id="nav_recuperacion" class="nav-link m-tabs__link" data-toggle="tab" href="#window_recuperacion" role="tab">
                        <i class="la la-arrow-right"></i>&nbsp;Recuperación
                    </a>
                </li>
                <li class="nav-item m-tabs__item">
                    <a id="nav_observacion" class="nav-link m-tabs__link" data-toggle="tab" href="#window_observacion" role="tab">
                        <i class="la la-arrow-right"></i>&nbsp;Observación
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="m-portlet__body">                   
        <div class="tab-content">
            <div class="tab-pane" id="window_prueba" role="tabpanel">
				{include file="prueba/lista/lista.tpl"}
            </div>
            <div class="tab-pane" id="window_tipo" role="tabpanel">

            </div>
            <div class="tab-pane" id="window_escalon" role="tabpanel">

            </div>
            <div class="tab-pane" id="window_recuperacion" role="tabpanel">

            </div>
            <div class="tab-pane" id="window_observacion" role="tabpanel">

            </div>
        </div>      
    </div>
</div>

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

<!--begin::Modal-->
<div class="modal fade" id="modal_window_escalon" tabindex="-1" role="dialog"
     data-backdrop="static"
     data-keyboard="false"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content" id="modal_content_escalon">

        </div>
    </div>
</div>
<!--end::Modal-->

<!--begin::Modal-->
<div class="modal fade" id="modal_window_pozo" tabindex="-1" role="dialog"
     data-backdrop="static"
     data-keyboard="false"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content" id="modal_content_pozo">

        </div>
    </div>
</div>
<!--end::Modal-->
{include file="index.js.tpl"}