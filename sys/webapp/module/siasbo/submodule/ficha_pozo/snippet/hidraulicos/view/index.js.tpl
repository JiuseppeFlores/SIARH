{literal}
<script>
    const TIPO_ESCALONADA = 1;
    const TIPO_CONTINUA = 2;
    const TIPO_DESCONOCIDO = 3;
	
    jQuery(document).ready(function() {
        $('#nav_tipo').hide();
        $('#nav_escalon').hide();
        $('#nav_recuperacion').hide();
        $('#nav_observacion').hide();

        $('#nav_prueba').addClass('active show');
        $('#window_prueba').addClass('active show');

        $.fn.datepicker.dates['es'] = {
            days: ["Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado"],
            daysShort: ["Dom", "Lun", "Mar", "Mier", "Jue", "Vie", "Sab"],
            daysMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
            months: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
            monthsShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"],
            today: "Hoy",
            clear: "Clear",
            format: "dd/mm/yyyy",
            titleFormat: "MM yyyy",
            weekStart: 0
        };
    });
</script>
{/literal}