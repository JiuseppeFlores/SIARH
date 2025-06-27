{literal}
<script>
    var snippet_button_update = function () {
        var btn_update = $('#btn_update');
        var handle_button_update = function(){
            btn_update.click(function(e){
                e.preventDefault();
                //btn_update.attr("rel");
                item_Update("","new");

            });
        }
        return {
            // public functions
            init: function() {
                handle_button_update();
            }
        };
    }();

    jQuery(document).ready(function() {
        snippet_button_update.init();
        /**--=================================
        ======== APLICACION DE LOGS ==========
        ===================================**/
        Logs.create({
            'sistema_id': 7,
            'recurso_id': 1,
            'nombre': "Visita al sistema SIASBO", 
            'descripcion': 'Visita desde el SIARH al menu principal del sistema', 
            'base_datos': 'mmaya_siasbo',
            'userCreate': {/literal}{$smarty.session.userv.memberId}{literal} 
        }).then(response => { 
            if(response.status == 201) { 
                console.log('Log registrado'); 
            } 
        });
        /**--==== End of APLICACION DE LOGS ====**/
    });
    function item_Update(id,type){
        var url = '{/literal}{$getModule}{literal}&accion=itemUpdate&id='+id+'&type='+type;
        location = url;
    }
</script>
{/literal}