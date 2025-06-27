{literal}
<script type="text/javascript">
var dataGrid = null;

jQuery(document).ready(function() {
    /*--BEGIN::INIT--*/
    //$("#ventanaGrilla").removeClass("win-active");
    dataGrid = $('#gridMain').DataTable( {
        "columnDefs": [
            {
                "targets": 0,
                "orderable": true
            },
            {
                "targets": 1,
                "orderable": true
            },
            {
                "targets": 2,
                "orderable": false
            }
        ],
        "responsive": true,
        "language": {"url": "language/datatable.spanish.json"},
        "lengthMenu": [10, 25, 50],
        "order": [[ 0, "asc" ]]
    } );
    /*--END::INIT--*/
});


/**
 * BEGIN::FUNCIONES
 */

/*--BEGIN::VENTANAS--*/
function fnMostrarVentanaGrilla(){
    $("#ventanaGrilla").fadeIn();
}

function fnOcultarVentanaGrilla(){
    $("#ventanaGrilla").hide();
}
/*--END::VENTANAS--*/

/**
 * END::FUNCIONES
 */
</script>
{/literal}