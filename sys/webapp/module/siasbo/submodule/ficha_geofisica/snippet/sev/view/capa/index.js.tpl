{literal}
<script>
function show_modal_window_form_capa() {
    $("#modal_content_capa_list").hide();
    $("#modal_content_capa_form").fadeIn();
}

function show_modal_window_list_capa() {
    $("#modal_content_capa_form").hide();
    $("#modal_content_capa_list").fadeIn();
}

jQuery(document).ready(function() {
    show_modal_window_list_capa();
});
</script>
{/literal}