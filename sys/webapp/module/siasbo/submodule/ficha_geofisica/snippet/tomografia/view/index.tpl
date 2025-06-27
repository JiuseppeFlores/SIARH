
{include file="index.css.tpl"}
{include file="tomografia/lista/lista.tpl"}

<!--begin::Modal-->
<div class="modal fade" id="modal_window_tomografia" tabindex="-1" role="dialog"
     data-backdrop="static"
     data-keyboard="false"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content" id="modal_content_tomografia">
        </div>
    </div>
</div>
<!--end::Modal-->

<!--begin::Modal-->
<div class="modal fade" id="modal_window_tomografia_capa" tabindex="-1" role="dialog"
     data-backdrop="static"
     data-keyboard="false"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content" id="modal_content_form_tomografia_capa">
        </div>

        <div class="modal-content" id="modal_content_list_tomografia_capa">
        </div>
    </div>
</div>
<!--end::Modal-->

<!--begin::Modal-->
<div class="modal fade" id="modal_window_tomografia_vinculo_pozo" tabindex="-1" role="dialog"
     data-backdrop="static"
     data-keyboard="false"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content" id="modal_content_form_tomografia_vinculo_pozo">
        </div>

        <div class="modal-content" id="modal_content_list_tomografia_vinculo_pozo">
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