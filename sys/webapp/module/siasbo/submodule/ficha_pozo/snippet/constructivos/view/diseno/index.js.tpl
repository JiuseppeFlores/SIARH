{literal}
<script>
function show_modal_window_form_diseno() {
    $("#modal_content_list_diseno").hide();
    $("#modal_content_form_diseno").fadeIn();
}

function show_modal_window_list_diseno() {
    $("#modal_content_form_diseno").hide();
    $("#modal_content_list_diseno").fadeIn();
}

jQuery(document).ready(function() {
    show_modal_window_list_diseno();
});
</script>
{/literal}