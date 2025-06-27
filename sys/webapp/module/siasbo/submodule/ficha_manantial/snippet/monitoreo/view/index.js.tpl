{literal}
<script>
    function get_cantidad() {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemGrillaCantidad{literal}&id={/literal}{$id}{literal}&type={/literal}{$type}{literal}";

        $('#window_cantidad').html(" Cargando Tab.. ");
        swal({
            title: 'Cargando tab!',
            text: 'Procesando datos',
            imageUrl: 'images/loading/loading05.gif',
            showConfirmButton: false,
            allowEnterKey: false,
            allowOutsideClick: false,
            allowEscapeKey: false,
        });

        $.get(url, function(respuesta) {
            $('#window_cantidad').html(respuesta);
            swal.close();            
        });
    }

    function get_calidad() {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemGrillaCalidad{literal}&id={/literal}{$id}{literal}&type={/literal}{$type}{literal}";

        $('#window_calidad').html(" Cargando Tab.. ");
        swal({
            title: 'Cargando tab!',
            text: 'Procesando datos',
            imageUrl: 'images/loading/loading05.gif',
            showConfirmButton: false,
            allowEnterKey: false,
            allowOutsideClick: false,
            allowEscapeKey: false,
        });

        $.get(url, function(respuesta) {
            $('#window_calidad').html(respuesta);
            swal.close();           
        });
    }

    function get_isotopico() {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemGrillaIsotopico{literal}&id={/literal}{$id}{literal}&type={/literal}{$type}{literal}"

        $('#window_isotopico').html(" Cargando Tab.. ");
        swal({
            title: 'Cargando tab!',
            text: 'Procesando datos',
            imageUrl: 'images/loading/loading05.gif',
            showConfirmButton: false,
            allowEnterKey: false,
            allowOutsideClick: false,
            allowEscapeKey: false,
        });

        $.get(url, function(respuesta) {
            $('#window_isotopico').html(respuesta);
            swal.close();           
        });
    }

	jQuery(document).ready(function() {
        $('#nav_cantidad').addClass('active show');
        $('#window_cantidad').addClass('active show');

        get_cantidad();
        get_calidad();
        get_isotopico();
    });
</script>
{/literal}