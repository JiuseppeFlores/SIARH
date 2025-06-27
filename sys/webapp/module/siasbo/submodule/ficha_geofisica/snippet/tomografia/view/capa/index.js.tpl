{literal}
<script>
function show_modal_window_form_tomografia_capa() {
    $("#modal_content_list_tomografia_capa").hide();
    $("#modal_content_form_tomografia_capa").fadeIn();
}

function show_modal_window_list_tomografia_capa() {
    $("#modal_content_form_tomografia_capa").hide();
    $("#modal_content_list_tomografia_capa").fadeIn();
}

jQuery(document).ready(function() {
    show_modal_window_list_tomografia_capa();
});
</script>
{/literal}