{include file="geovisor/index.js.tpl"}
{literal}
<script src="js/reportes_log/reportes-log.js"></script>
<script>
/**--=================================
======== APLICACION DE LOGS ==========
===================================**/
Logs.create({
    'sistema_id': 7,
    'recurso_id': 6,
    'nombre': "Acceso al geovisor", 
    'descripcion': 'Geovisor SIASBO', 
    'base_datos': 'mmaya_siasbo',
    'userCreate': {/literal}{$smarty.session.userv.memberId}{literal} 
}).then(response => { 
    if(response.status == 201) { 
        console.log('Log registrado'); 
    } 
});
/**--==== End of APLICACION DE LOGS ====**/
</script>
{/literal}