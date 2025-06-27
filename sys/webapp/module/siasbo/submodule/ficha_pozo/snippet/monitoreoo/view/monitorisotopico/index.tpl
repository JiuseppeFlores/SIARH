
{include file="monitorcantidad/index.css.tpl"}
{include file="monitorcantidad/lista/lista.tpl"}

<!--begin::Modal-->
<div class="modal fade" id="modal_window_monitor_cantidad" tabindex="-1" role="dialog"
     data-backdrop="static"
     data-keyboard="false"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content" id="modal_content_monitor_cantidad">

        </div>
    </div>
</div>
<!--end::Modal-->

<!--begin::Modal-->
<!-- <div class="modal fade" id="modal_window_tipo_bombeo_pozo" tabindex="-1" role="dialog"
     data-backdrop="static"
     data-keyboard="false"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content" id="modal_content_form_tipo_bombeo_pozo">
        </div>

        <div class="modal-content" id="modal_content_list_tipo_bombeo_pozo">
        </div>
    </div>
</div> -->
<!--end::Modal-->

{include file="monitorcantidad/index.js.tpl"}