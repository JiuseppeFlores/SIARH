{literal}
<script>
function show_modal_window_form_vinculo_pozo() {
    $("#modal_content_vinculo_pozo_list").hide();
    $("#modal_content_vinculo_pozo_form").fadeIn();
}

function show_modal_window_list_vinculo_pozo() {
    $("#modal_content_vinculo_pozo_form").hide();
    $("#modal_content_vinculo_pozo_list").fadeIn();
}

jQuery(document).ready(function() {
    show_modal_window_list_vinculo_pozo();
});
</script>
{/literal}