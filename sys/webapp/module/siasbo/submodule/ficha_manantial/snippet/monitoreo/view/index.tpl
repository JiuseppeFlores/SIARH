{include file="index.css.tpl"}

<div class="m-portlet m-portlet--tabs">
    <div class="m-portlet__head">
        <div class="m-portlet__head-tools">
            <ul class="nav nav-tabs m-tabs-line m-tabs-line--brand" role="tablist">
                <li class="nav-item m-tabs__item">
                    <a id="nav_cantidad" class="nav-link m-tabs__link" data-toggle="tab" href="#window_cantidad" role="tab" aria-selected="false">
                        <i class="la la-check"></i> Monitoreo de Cantidad 
                    </a>
                </li>
                <li class="nav-item m-tabs__item">
                    <a id="nav_calidad" class="nav-link m-tabs__link" data-toggle="tab" href="#window_calidad" role="tab" aria-selected="true">
                        <i class="la la-check"></i> Monitoreo de Calidad
                    </a>
                </li>
                <li class="nav-item m-tabs__item">
                    <a id="nav_isotopico" class="nav-link m-tabs__link" data-toggle="tab" href="#window_isotopico" role="tab">
                        <i class="la la-check"></i> Monitoreo Isotópico
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="m-portlet__body">                   
        <div class="tab-content">
            <div class="tab-pane" id="window_cantidad" role="tabpanel">
            </div>
            <div class="tab-pane" id="window_calidad" role="tabpanel">
            </div>
            <div class="tab-pane" id="window_isotopico" role="tabpanel">
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
<div class="modal fade" id="modal_window_compuesto" tabindex="-1" role="dialog"
     data-backdrop="static"
     data-keyboard="false"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content" id="modal_content_compuesto">

        </div>
    </div>
</div>
<!--end::Modal-->

{include file="index.js.tpl"}