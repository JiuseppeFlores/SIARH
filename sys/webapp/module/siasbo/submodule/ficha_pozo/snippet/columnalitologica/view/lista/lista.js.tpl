{literal}
<script>
    var table_list_litologico;

    function item_update_litologico(id) {
        //var url = '{/literal}{$getModule}{literal}&accion=sev_itemUpdate&id='+id+'&type=update';
        //location = url;
        get_form_litologico(id, "update");
    }

    function item_delete_litologico(id) {
        swal({
            title: 'Está seguro de borrar el registro?',
            text: "Recuerde que el registro se eliminará permanentemente. ID="+id+", ",
            type: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Si, eliminar!!!',
            cancelButtonText: "No, cancelar"
        }).then(function(result) {
            if (result.value) {
                itemDeleteActionLitologico(id);
            }
        });
    }

    function item_print_litologico(id) {
        alert("Imprime el dato:"+id);
    }

    function itemDeleteActionLitologico(id) {
        randomnumber=Math.floor(Math.random()*11);
        $.get( "{/literal}{$getModule}{literal}",
            {accion:"columnalitologica_itemDelete", random:randomnumber, id:id},
            function(res){
                if(res.res == 1){
                    swal('Eliminado!','El registro fue eliminado con éxito.','success');
                    //swal({position: 'top-center',type: 'success',title: 'El registro fue eliminado.',showConfirmButton: false,timer: 1200});
                    table_list_litologico.draw();
                }else if(res.res == 2){
                    swal("Ocurrió un error!", res.msg, "error");
                }else{
                    swal("ocurrió un error!", res.msg, "error");
                }
            },"json");
    }

    function item_opcion_editar_litologico(id) {
        return '<a class="dropdown-item" href="javascript:item_update_litologico(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-warning m-btn--icon m-btn--icon-only m-btn--pill" title="Editar"><i class="la flaticon-edit-1 m--font-brand"></i>&nbsp;Editar</a>';
    }

    function item_opcion_eliminar_litologico(id) {        
        return '<a class="dropdown-item" href="javascript:item_delete_litologico(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-danger m-btn--icon m-btn--icon-only m-btn--pill" title="Eliminar"><i class="la flaticon-delete-2 m--font-brand"></i>&nbsp;Eliminar</a>';
    }

    function get_form_litologico(id, type) {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemUpdate{literal}&pozoId={/literal}{$id}{literal}&id="+id+"&type="+type;

        $('#modal_content_compuesto').html(" Cargando Tab.. ");
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
            $('#modal_content_litologico').html(respuesta);
            swal.close();
            $('#modal_window_litologico').modal("show");
        });
    }
    
    var snippet_datatable_list_litologico = function () {
        $.fn.dataTable.Api.register('column().title()', function() {
            return $(this.header()).text().trim();
        });

        var exporta_titulo = "SIASBO - LISTA DATOS DE COLUMNA LITOLÓGICA";
        var exporta_columnas = [':visible :not(.noExport)'];

        var initTable = function() {
            // begin first table
            table_list_litologico = $('#lista_litologica').DataTable({

                initComplete: function(settings, json) {
                    $('#lista_litologica').removeClass('m--hide');
                },
                responsive: true,
                keys: {
                    blurable: false,
                    columns: exporta_columnas,
                    clipboard: false,
                },
                //stateSave: true,
                colReorder: true,
                //== Pagination settings
                dom:
                "<'row'<'col-sm-12 col-md-12 dataTables_pager'lp>>" +
                    `<'row'<'col-sm-5 text-left'f><'col-sm-7 text-right'B>>
                     <'row'<'col-sm-12'tr>>
                     <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'lp>>`,
                // read more: https://datatables.net/examples/basic_init/dom.html
                buttons: [
                    {extend:'colvis',text:'Ver '
                        ,columnText: function ( dt, idx, title ) {
                            return (idx+1)+': '+title;
                        }
                    },
                    {extend:'excelHtml5'
                        ,exportOptions: {columns: exporta_columnas}
                        , title: exporta_titulo
                    },
                    {extend:'pdfHtml5'
                        ,exportOptions: {columns: exporta_columnas}
                        , title: exporta_titulo
                        , download: 'open'
                        //, orientation: 'landscape'
                        , pageSize: 'LETTER'
                        ,customize: function(doc) {
                            doc.styles.tableHeader.fontSize = 7;
                            doc.defaultStyle.fontSize = 7;
                            doc.pageMargins= [ 20, 20];
                        }
                    },

                ],

                // read more: https://datatables.net/examples/basic_init/dom.html
                language: {"url": "language/datatable.spanish.json"},
                lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "Todo"]], //[5, 10, 25, 50, 100],
                pageLength: 10,
                order: [[ 1, "asc" ]], // Por que campo ordenara al momento de desplegar
                searchDelay: 500,
                processing: true,
                serverSide: true,
                ajax: {
                    url: '{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemList{literal}&id={/literal}{$id}{literal}',
                    type: 'POST',
                    data: {},
                },
                columns: [
                    {/literal}
                    {foreach from=$grill_list item=row key=idx}
                        {literal}{data: '{/literal}{$row.field}{literal}'} ,{/literal}
                    {/foreach}
                    {literal}
                ],
                columnDefs: [
                    {
                        targets: 0,
                        title: 'Acción',
                        orderable: false,
                        render: function(data, type, full, meta) {
                            // var boton = '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-h"></i></a><div class="dropdown-menu dropdown-menu-left">{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar_litologico(data) + '{/literal}{/if}{literal}{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar_litologico(data) + '{/literal}{/if}{literal}</div></span>';
                            // return boton;

                            var boton = '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-h"></i></a><div class="dropdown-menu dropdown-menu-left">';

                            // var permisoedit = 1;
                            // var permisodelete = 1;
                            // var permisoreadonly = 1;
                            var botonedit = "";
                            var botondelete = ""; 
                            //var botonreadonly = "";               

                            if (obj_permiso[0].editar == 1){ //permisoedit
                                botonedit = '{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar_litologico(data) + '{/literal}{/if}{literal}';
                            }

                            if (obj_permiso[0].eliminar == 1){ //permisodelete
                                botondelete = '{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar_litologico(data) + '{/literal}{/if}{literal}';
                            }
                            
                            //botonreadonly = '{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_sololeer(data) + '{/literal}{/if}{literal}';
                            //table_list.column(0).visible(false); //Solo funciona con false
                            
                            return boton+botonedit+botondelete+'</div></span>'; //+botonreadonly;
                        }
                    },
                    {
                        targets: [1,8,9,10,11,12,13],
                        visible: false
                    },
                ],
            });
        };

        //Desde aqui



        //Hasta aqui

        return {

            //main function to initiate the module
            init: function() {
                initTable();
            },

        };

    }();

    //Grafica Litologica
    function get_grafica(id) {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getGraficaColumnaLitologica{literal}&id="+id;
        
        //$('#window_content_data').html("Cargando...");
        swal({
            title: 'Cargando!',
            text: 'Procesando datos',
            imageUrl: 'images/loading/loading05.gif',
            showConfirmButton: false,
            allowEnterKey: false,
            allowOutsideClick: false,
            allowEscapeKey: false,
        });

        $.get(url, function(respuesta) {
            if (respuesta == 0) {
                swal.close();
                swal('Advertencia!','No existen datos.','warning');
            } else {
                //var datos = JSON.parse(respuesta);
                $('#modal_litologia_contenido').html(respuesta);
                $("#modal_litologia").modal("show");
                swal.close();
            }
        });
    }

    //Grafica Litologica
    // var canvas = document.getElementById("lienzo");
    // var contexto = Iniciar(canvas);
    // // Colores Base
    // //var colortexto = "#808080";
    // //var colorejes = "#808080";
    // //var ancholinea = 1;
    // //var colorborde = "#384ad7";
    // var colorrelleno = "#384ad7";   
    // var anchoborde = 1;

    // var profundidades = [];
    // var litologia = [];
    // var dtl;

    // var posyinicial = 120;
    // var unmetro = 10;
    // var pt = 0;   

    // function RecuperarDatosLitologia(){
    //     var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemLitologia{literal}&id={/literal}{$id}{literal}";

    //     swal({
    //         title: 'Cargando tab!',
    //         text: 'Procesando datos',
    //         imageUrl: 'images/loading/loading05.gif',
    //         showConfirmButton: false,
    //         allowEnterKey: false,
    //         allowOutsideClick: false,
    //         allowEscapeKey: false,
    //     });

    //     $.get(url, function(respuesta) {
    //         swal.close();
    //         var datos = JSON.parse(respuesta);
    //         dtl = datos;
    //         Datos();
    //         DibujarColumnaLitologica();
    //         //alert("Nivel estatico"+datos[0].nivel_estatico);
    //     });
    // }

    // function Iniciar(canvas){
    //     if (canvas && canvas.getContext){
    //         var ctx = canvas.getContext("2d");
    //         if (ctx){
    //             return ctx;
    //         }else{
    //             alert("No se pudo cargar el lienzo");
    //         }
    //     }
    // }

    // function Redondeo(numero){
    //     return Math.round(numero * 100) / 100;
    // }

    // function ConfigurarLienzo(){
    //     for (var i = 0; i <= profundidades.length-1; i++){          
    //         pt += (profundidades[i]*unmetro);
    //     };

    //     canvas.width = 700;
    //     canvas.height = pt+posyinicial+10;
    //     pt = 0;
    // }

    // function Datos(){
    //     //RecuperarDatosLitologia();
    //     var data = table_list_litologico.rows().data();
    //     var dataaux = [];

    //     for (var i = 0; i <= dtl.length-1; i++) {
    //         profundidades[i] = dtl[i].profundidad_hasta-dtl[i].profundidad_desde;
    //         dataaux = dtl[i].litologia1.split(" ");
    //         litologia[i] = dataaux[0];
    //     };
    // }

    // function DibujarColumnaLitologica(){        
    //     //Datos();
    //     ConfigurarLienzo();
    //     contexto.clearRect(0, 0, canvas.width, canvas.height);
    //     DibujarTitulo(contexto, canvas.width/2, 29, "Columna Litológica", 19, "center", "#505050");
    //     DibujarTitulo(contexto, canvas.width/2, 50, "Nombre Pozo: "+dtl[0].nombre, 12, "center", "#a0a0a0");
    //     DibujarBloqueLitologia();
    // }   

    // function DibujarBloqueLitologia(){
    //     var swcolor = true;
    //     var profundidad = 0;
    //     var profundidadtotal = 0;   

    //     for (var i=0; i<=profundidades.length-1; i++){
    //         if(i == 0){             
    //             //Parte Profundidad
    //             DibujarTexto("Profundidad", (canvas.width/2)-211, posyinicial-50, 140, 40, "#384ad7", "#384ad7", "#ffffff");
    //             DibujarRectanguloProfundidad(Redondeo(profundidades[i])+" m.", (canvas.width/2)-100, posyinicial, 5, ((profundidades[i])*unmetro), "#808080", "#ffffff");
    //             //Parte Formacion
    //             DibujarTexto("Formacion", (canvas.width/2)+71, posyinicial-50, 140, 40, "#384ad7", "#384ad7", "#ffffff");
    //             DibujarRectanguloFormacion(litologia[i], (canvas.width/2)+71, posyinicial, 140, ((profundidades[i])*unmetro));
    //             //Parte Litologia
    //             DibujarTexto("Litologia", (canvas.width/2)-70, posyinicial-50, 140, 40, "#384ad7", "#384ad7", "#ffffff");
    //             DibujarRectanguloLitologia(litologia[i].toLowerCase()+".png", (canvas.width/2)-70, posyinicial, 140, ((profundidades[i])*unmetro));
    //             profundidad = profundidad+((profundidades[i])*unmetro);
    //         }else{
    //             //Parte Profundidad
    //             if(swcolor){
    //                 DibujarRectanguloProfundidad(Redondeo(profundidades[i])+" m.", (canvas.width/2)-100, posyinicial+profundidad, 5, ((profundidades[i])*unmetro), "#808080", "#808080");
    //                 swcolor = false;
    //             }else{
    //                 DibujarRectanguloProfundidad(Redondeo(profundidades[i])+" m.", (canvas.width/2)-100, posyinicial+profundidad, 5, ((profundidades[i])*unmetro), "#808080", "#ffffff");
    //                 swcolor = true;
    //             }           
    //             //Parte Formacion
    //             DibujarRectanguloFormacion(litologia[i], (canvas.width/2)+71, posyinicial+profundidad, 140, ((profundidades[i])*unmetro));
    //             //Parte Litologica
    //             DibujarRectanguloLitologia(litologia[i].toLowerCase()+".png", (canvas.width/2)-70, posyinicial+profundidad, 140, ((profundidades[i])*unmetro));
    //             profundidad = profundidad+((profundidades[i])*unmetro);
    //         }
    //         profundidadtotal += profundidades[i];
    //     }

    //     DibujarRectanguloProfundidad(profundidadtotal+" m.", (canvas.width/2)-180, posyinicial, 5, ((profundidadtotal)*unmetro), "#808080", "#808080");

    //     DibujarRegla("", (canvas.width/2)-321, posyinicial, 80, ((profundidadtotal)*unmetro), "#808080", "#808080");
    // }

    // function DibujarRectanguloProfundidad(texto, posx, posy, anchobloque, altobloque, colorborde, colorrelleno){
    //     contexto.fillStyle = colorrelleno;
    //     contexto.strokeStyle = colorborde;
    //     contexto.lineWidth = anchoborde;
    //     contexto.strokeRect(posx, posy, anchobloque, altobloque);
    //     contexto.fillRect(posx, posy, anchobloque, altobloque);//#384ad7
    //     DibujarTexto(texto, posx-32, posy, anchobloque, altobloque, "#50505000", "#ffffff00", "#505050");
    //     contexto.stroke();
    //     contexto.restore();
    // }

    // function DibujarRectanguloFormacion(texto, posx, posy, anchobloque, altobloque){
    //     contexto.fillStyle = colorrelleno;
    //     contexto.strokeStyle = "#ffffff";
    //     contexto.lineWidth = anchoborde;
    //     contexto.strokeRect(posx, posy, anchobloque, altobloque);
    //     //contexto.fillRect(posx, posy, anchobloque, altobloque);
    //     DibujarTexto(texto, posx, posy, anchobloque, altobloque, "#384ad7", "#384ad7", "#ffffff"); //#1B4F72 #2874A6
    //     contexto.stroke();
    //     contexto.restore();
    // }

    // function DibujarRectanguloLitologia(imagen, posx, posy, anchobloque, altobloque){//color
    //     var img = new Image();
    //     img.src = "images/siasbo/textura/"+imagen;
    //     contexto.strokeStyle = "#101010";
    //     contexto.lineWidth = anchoborde;
    //     contexto.strokeRect(posx, posy, anchobloque, altobloque);
    //     contexto.fillRect(posx, posy, anchobloque, altobloque);

    //     img.onload = function(){
    //         contexto.drawImage(img, 0, 0, anchobloque, altobloque, posx, posy, anchobloque, altobloque);
    //     }

    //     contexto.stroke();
    //     contexto.restore();
    // }

    // function DibujarTexto(texto, posx, posy, anchobloque, altobloque, colorborde, colorrelleno, colortexto){
    //     contexto.lineWidth = 0.5;
    //     contexto.strokeStyle = colorborde;
    //     contexto.fillStyle = colorrelleno;
    //     contexto.font= "12px Verdana";
    //     contexto.textAlign= "center"; 
    //     contexto.textBaseline = "middle";
    //     contexto.strokeRect(posx, posy, anchobloque, altobloque);
    //     contexto.fillRect(posx, posy, anchobloque, altobloque);
    //     contexto.fillStyle = colortexto;
    //     contexto.fillText(texto ,posx+(anchobloque/2), posy+(altobloque/2));
    // }

    // function DibujarTitulo(ctx, posx, posy, texto, tamanofuente, alineartexto, colortexto){
    //     ctx.beginPath();
    //     ctx.fillStyle = colortexto;
    //     ctx.textAlign= alineartexto;
    //     ctx.font = tamanofuente+"px Verdana";
    //     ctx.fillText(texto, posx, posy);
    //     ctx.stroke();
    // }

    // function DibujarRegla(texto, posx, posy, anchobloque, altobloque, colorborde, colorrelleno){    
    //     var swregla = true;
    //     var valorregla = 0;
    //     var gradiente = contexto.createLinearGradient(posx, 0, anchobloque+posx, 0);
    //     // gradiente.addColorStop(0, 'rgba(231, 231, 231, 1)');   
    //     // gradiente.addColorStop(0.5, 'rgba(255, 255, 255, 1)');   
    //     // gradiente.addColorStop(0.5, 'rgba(255, 255, 255, 1)');
    //     // gradiente.addColorStop(1, 'rgba(231, 231, 231, 1)');

    //     gradiente.addColorStop(0, 'rgba(231, 231, 231, 1)');
    //     gradiente.addColorStop(1, 'rgba(255, 255, 255, 1)');
    //     contexto.fillStyle = gradiente; //colorrelleno;
    //     contexto.strokeStyle = colorborde;
    //     contexto.lineWidth = anchoborde;
    //     contexto.strokeRect(posx, posy-5, anchobloque, altobloque+10);
    //     contexto.fillRect(posx, posy-5, anchobloque, altobloque+10);

    //     contexto.strokeStyle = '#505050';
    //     contexto.lineWidth = 1;
    //     contexto.beginPath();
    //     //contexto.setLineDash([0,0]);  
    //     for (var i=posy; i<=posy+altobloque; i+=(unmetro/2)) {
    //         if(swregla){
    //             contexto.moveTo((posx+anchobloque)-20, i);
    //             contexto.lineTo((posx+anchobloque), i);             
    //             swregla = false;                
    //         }else{
    //             contexto.moveTo((posx+anchobloque)-10, i);
    //             contexto.lineTo((posx+anchobloque), i);
    //             swregla = true;
    //         }           
    //     }
    //     //contexto.setLineDash([1,2]);
    //     contexto.moveTo(posx+anchobloque+5, posy);
    //     contexto.lineTo((posx+anchobloque)+170, posy);  
    //     contexto.moveTo(posx+anchobloque+5, posy+altobloque);
    //     contexto.lineTo((posx+anchobloque)+170, posy+altobloque);   
    //     contexto.stroke();

    //     // for (var j=posy; j<posy+altobloque+10; j+=(unmetro/2)){
    //     //     if(j%2 == 0){
    //     //         DibujarTexto(valorregla+" m.", (posx+anchobloque)-65, j-6, 30, 10, "#50505000", "#ffffff00", "#505050");
    //     //         valorregla++;
    //     //     }              
    //     // }

    //     var limite = Math.trunc(((posy+altobloque)/50)-1);
    //     var posvalor = -5;

    //     for (var j=1; j<=limite; j++){
    //         DibujarTexto(valorregla+" m.", (posx+anchobloque)-65, posy+(posvalor), 30, 10, "#50505000", "#ffffff00", "#505050");
    //         valorregla+=5; 
    //         posvalor+=50;             
    //     }   

    //     DibujarTexto(texto, posx-32, posy, anchobloque, altobloque, "#50505000", "#ffffff00", "#505050");
    //     contexto.stroke();
    //     contexto.restore();
    // }

    // function GuardarGrafica(){
    //     // var dato = canvas.toDataURL("image/png");
    //     // dato = dato.replace("image/png", "image/octet-stream");
    //     // document.location.href = dato;

    //     Canvas2Image.saveAsPNG(canvas, canvas.width, canvas.height, "ColumnaLitologica");
    // }

//----------------Permisos--------------------------------------------
    var obj_permiso;

    function permisos_usuario(){
        var idUsuarioResponsable = parseInt($('#idUsuarioResponsable').val());
        jQuery.ajax({
            url: '{/literal}{$getModule}{literal}&accion=obtenerPermisos&perpozo=pozo', //&perpozo=pozo
            //data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            //dataType: "json",
            success: function(data){
                obj_permiso = JSON.parse(data);

                // if (obj_permiso[0].crear == 1){                                
                //     $("#btn_litologia_submit").show();
                // }else{
                //     $("#btn_litologia_submit").hide();
                // }    
                
                switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#btn_litologia_submit").show();
                        }else{
                            $("#btn_litologia_submit").hide();
                        }
                        break;
                    case 3:
                        $("#btn_litologia_submit").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                            $("#btn_litologia_submit").show();
                        }else{
                            $("#btn_litologia_submit").hide();
                        }
                        break;
                }
            },
        });
    }

    jQuery(document).ready(function() {
        permisos_usuario();
        snippet_datatable_list_litologico.init();
        RecuperarDatosLitologia();
        //DibujarColumnaLitologica();
    });

</script>
{/literal}