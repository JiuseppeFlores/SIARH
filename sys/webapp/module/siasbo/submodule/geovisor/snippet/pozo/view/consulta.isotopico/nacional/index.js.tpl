{literal}
<script>
    var snippet_descarga_excel = function () {
        var btn_descargar_pozos_excel = $('#btn_descargar_pozos_excel');

        var get_descargar_excel = function() {
            var url = "{/literal}{$getModule}{literal}&accion=pozo_getDescargarExcelMonitorIsotopico";
            window.open(url, '_blank');
        };

        var handle_general_components = function(){
            /*$('.select2').select2({
                placeholder: "Seleccione una opción"
            });*/
        };

        var handle_get_components = function() {
            btn_descargar_pozos_excel.click(function() {
                get_descargar_excel();
            });
        };

        return {
            //main function to initiate the module
            init: function() {
                handle_general_components();
                handle_get_components();
            },
        };
    }();

    jQuery(document).ready(function() {
        snippet_descarga_excel.init();
    });
</script>
{/literal}