{literal}
<script>
function show_modal_window_form_tomografia_vinculo_pozo() {
    $("#modal_content_list_tomografia_vinculo_pozo").hide();
    $("#modal_content_form_tomografia_vinculo_pozo").fadeIn();
}

function show_modal_window_list_tomografia_vinculo_pozo() {
    $("#modal_content_form_tomografia_vinculo_pozo").hide();
    $("#modal_content_list_tomografia_vinculo_pozo").fadeIn();
}

jQuery(document).ready(function() {
    show_modal_window_list_tomografia_vinculo_pozo();
});
</script>
{/literal}