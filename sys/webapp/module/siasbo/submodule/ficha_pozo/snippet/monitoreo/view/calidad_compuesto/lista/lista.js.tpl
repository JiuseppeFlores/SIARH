{literal}
<script>
    var table_list_calidad_compuesto;

    function item_update_calidad_compuesto(id) {
        //var url = '{/literal}{$getModule}{literal}&accion=sev_itemUpdate&id='+id+'&type=update';
        //location = url;
        get_form_calidad_compuesto(id, "update");
    }

    function item_delete_calidad_compuesto(id) {
        swal({
            title: 'Está seguro de borrar el registro?',
            text: "Recuerde que el registro se eliminará permanentemente. ID="+id+", ",
            type: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Si, eliminar!!!',
            cancelButtonText: "No, cancelar"
        }).then(function(result) {
            if (result.value) {
                itemDeleteActionCalidadCompuesto(id);
            }
        });
    }

    function item_print_calidad_compuesto(id) {
        alert("Imprime el dato:"+id);
    }

    function itemDeleteActionCalidadCompuesto(id) {
        randomnumber=Math.floor(Math.random()*11);
        $.get( "{/literal}{$getModule}{literal}",
            {accion:"{/literal}{$subcontrol}_itemDeleteCalidadCompuesto{literal}", random:randomnumber, id:id},
            function(res){
                if(res.res == 1){
                    swal('Eliminado!','El registro fue eliminado con éxito.','success');
                    //swal({position: 'top-center',type: 'success',title: 'El registro fue eliminado.',showConfirmButton: false,timer: 1200});
                    table_list_calidad_compuesto.draw();
                }else if(res.res == 2){
                    swal("Ocurrió un error!", res.msg, "error");
                }else{
                    swal("ocurrió un error!", res.msg, "error");
                }
            },"json");
    }

    function item_opcion_editar_calidad_compuesto(id) {
        return '<a class="dropdown-item" href="javascript:item_update_calidad_compuesto(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-warning m-btn--icon m-btn--icon-only m-btn--pill" title="Editar"><i class="la flaticon-edit-1 m--font-brand"></i>&nbsp;Editar</a>';
    }

    function item_opcion_eliminar_calidad_compuesto(id) {
        return '<a class="dropdown-item" href="javascript:item_delete_calidad_compuesto(\''+ id +'\');" class="m-portlet__nav-link btn m-btn m-btn--hover-danger m-btn--icon m-btn--icon-only m-btn--pill" title="Eliminar"><i class="la flaticon-delete-2 m--font-brand"></i>&nbsp;Eliminar</a>';
    }

    function get_form_calidad_compuesto(id, type) {
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_itemUpdateCalidadCompuesto{literal}&calidadId={/literal}{$calidadId}{literal}&id="+id+"&type="+type;

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
            $('#modal_content_compuesto').html(respuesta);
            swal.close();
            $('#modal_window_compuesto').modal("show");            
        });
    }
    
    var snippet_datatable_list_calidad_compuesto = function () {
        $.fn.dataTable.Api.register('column().title()', function() {
            return $(this.header()).text().trim();
        });

        var exporta_titulo = "SIASBO - LISTA DATOS DE CALIDAD";
        var exporta_columnas = [':visible :not(.noExport)'];

        var initTable = function() {
            // begin first table
            table_list_calidad_compuesto = $('#lista_calidad_compuesto').DataTable({

                initComplete: function(settings, json) {
                    $('#lista_calidad_compuesto').removeClass('m--hide');
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
                lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "Todo"]], //[5, 10, 25, 50, 1000],
                pageLength: 10,
                order: [[ 2, "asc" ]], // Por que campo ordenara al momento de desplegar
                searchDelay: 500,
                processing: true,
                serverSide: true,
                ajax: {
                    url: '{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemListCalidadCompuesto{literal}&calidadId={/literal}{$calidadId}{literal}',
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
                            // var boton = '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-h m--font-brand"></i></a><div class="dropdown-menu dropdown-menu-left">{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar_calidad_compuesto(data) + '{/literal}{/if}{literal}{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar_calidad_compuesto(data) + '{/literal}{/if}{literal}</div></span>';
                            // return boton;

                            var boton = '<span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-h m--font-brand"></i></a><div class="dropdown-menu dropdown-menu-left">';
                            
                            // var permisoedit = 1;
                            // var permisodelete = 1;
                            // var permisoreadonly = 1;
                            var botonedit = "";
                            var botondelete = ""; 
                            //var botonreadonly = "";               

                            if (obj_permiso[0].editar == 1){ //permisoedit
                                botonedit = '{/literal}{if $privFace.editar == 1}{literal}' + item_opcion_editar_calidad_compuesto(data) + '{/literal}{/if}{literal}';
                            }

                            if (obj_permiso[0].eliminar == 1){ //permisodelete
                                botondelete = '{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_eliminar_calidad_compuesto(data) + '{/literal}{/if}{literal}';
                            }
                            
                            //botonreadonly = '{/literal}{if $privFace.eliminar == 1}{literal}' + item_opcion_sololeer(data) + '{/literal}{/if}{literal}';
                            //table_list.column(0).visible(false); //Solo funciona con false
                            
                            return boton+botonedit+botondelete+'</div></span>'; //+botonreadonly;
                        }
                    },
                    {
                        targets: 1,
                        visible: false,
                    },
                    {
                        targets: 2,
                        render: function(data, type, full, meta) {
                            return full.nombre_parametro;
                        }
                    },
                    {
                        targets: 3,
                        visible: false,
                    },
                    {
                        targets: 4,
                        render: function(data, type, full, meta) {
                            return full.nombre_compuesto;
                        }
                    },
                    {
                        targets: 5,
                        visible: false,
                    },
                ],
            });

        };

        return {

            //main function to initiate the module
            init: function() {
                initTable();
            },

        };

    }();

    var select_campania;

    var canvasstiff = document.getElementById("lienzoCalidad");    

    var colortexto = "#505050";
    var colorejes = "#808080";
    var ancholinea = 0.5;
    var colorrelleno = "rgba(56, 74, 215, 0.5)";
    var colorborde = "rgba(56, 74, 215, 1)";
    var anchoborde = 0.5;

    var na = 0; //0;
    var k = 0; //1.20;
    var nak = 0; //1.90;
    var ca = 0; //4.20;
    var mg = 0; //3.50;

    var cl = 0; //3.90
    var hco = 0; //5.10
    var so = 0; //0.60

    var vecmax = [nak,ca,mg,cl,hco,so];

    var cont = 0;
    var valsegmento = 0;

    Array.prototype.max = function() {
      return Math.max.apply(null, this);
    };

    Array.prototype.min = function() {
      return Math.min.apply(null, this);
    };

    //Dibuja las Lineas Segmentadas
    var XMedio = canvasstiff.width/2;
    var NumeroIntervaloSegmentos = 0; //Math.trunc(vecmax.max())+1;
    var IntervaloSegmentos = 40;

    //Dibuja los tres ejes ternarios
    var NumeroEjes = 3;
    var IntervaloEjes = 50;
    var YInicial = 140;
    var YFinal = 140;

    var cationes = ["Na+K","Ca","Mg"];
    var supsubcationes = ["+","++","++","","",""];
    var aniones = ["Cl","HCO","SO"];
    var supsubaniones = ["-","-","=","","3","4"];

    var dtstiff = [];
    var tipocompuesto = "";

    function RecuperarDatosStiff(campania){
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemStiff{literal}&calidadId={/literal}{$calidadId}{literal}&campaniaId="+campania;

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
            swal.close();
            var datos = JSON.parse(respuesta);
            dtstiff = datos;
            CargarGraficaS();
            //alert("Nivel estatico"+datos[0].nivel_estatico);
        });
    }

    function Redondeo(numero){
        return Math.round(numero * 100) / 100;
    }

    function Datos(){
        //RecuperarDatosStiff(campania);

        var sw = 0;        

        for (var i = 0; i <= dtstiff.length-1; i++) {
            switch(dtstiff[i].compuestoId){
                case "47":
                    hco = dtstiff[i].valor;
                    cont++;
                    break;
                case "54":                
                    ca = dtstiff[i].valor;
                    cont++;
                    break;
                case "59":
                    cl = dtstiff[i].valor;
                    cont++;
                    break;
                case "75":
                    mg = dtstiff[i].valor;
                    cont++;
                    break;
                case "90":
                    k = dtstiff[i].valor;
                    cont++;
                    break;
                case "93":
                    na = dtstiff[i].valor;
                    cont++;
                    break;
                case "94":
                    so = dtstiff[i].valor;
                    cont++;
                    break;
                default:
                    sw = 1;
            }
        };
        
        //if(sw == 1){
            hco = hco*(1/29); //hco/29;           
            ca = ca*(1/40); //ca/40;
            cl = cl*(1/35.45); //cl/35.45;
            mg = mg*(1/24.3); //mg/24.3;
            nak = (parseInt(na)+parseInt(k))*(1/62); //(parseInt(na)+parseInt(k))/62;
            so = so*(1/48); //so/48;
        //}
        
        vecmax = [nak,ca,mg,cl,hco,so];
        var aniones = [{nombre:"nak", valor:nak},{nombre:"ca", valor:ca},{nombre:"mg", valor:mg}];
        var cationes = [{nombre:"cl", valor:cl},{nombre:"hco", valor:hco},{nombre:"so", valor:so}];
        NumeroIntervaloSegmentos = Math.trunc(vecmax.max())+1;
        valsegmento = (NumeroIntervaloSegmentos+(10-(NumeroIntervaloSegmentos%10)))/5;
        var valmaximo = NumeroIntervaloSegmentos+(10-(NumeroIntervaloSegmentos%10));

        var auxaniones = aniones.sort(function (a, b){
            return a.valor - b.valor;
        })

        var auxcationes = cationes.sort(function (a, b){
            return a.valor - b.valor;
        })

        var tipo = auxcationes[auxcationes.length-1].nombre+auxaniones[auxaniones.length-1].nombre;

        switch(tipo){
            case "clnak":
                tipocompuesto = "Agua Clorurada Sódica";
                break;
            case "clca":
                tipocompuesto = "Agua Clorurada Cálcica";
                break;
            case "clmg":
                tipocompuesto = "Agua Clorurada Magnésica";
                break;
            case "hconak":
                tipocompuesto = "Agua Bicarbonatada Sódica";
                break;
            case "hcoca":
                tipocompuesto = "Agua Bicarbonatada Cálcica";
                break;
            case "hcomg":
                tipocompuesto = "Agua Bicarbonatada Magnésica";
                break;
            case "sonak":
                tipocompuesto = "Agua Sulfatada Sódica";
                break;
            case "soca":
                tipocompuesto = "Agua Sulfatada Cálcica";
                break;
            case "somg":
                tipocompuesto = "Agua Sulfatada Magnésica";
                break;
        }

        //if(sw == 1){
            hco = (hco*200)/valmaximo;
            ca = (ca*200)/valmaximo;
            cl = (cl*200)/valmaximo;
            mg = (mg*200)/valmaximo;
            nak = (nak*200)/valmaximo;
            so = (so*200)/valmaximo;
        //}
    }

    function CargarGraficaS(){
        Datos();
        if(cont == 7){
            var ctx = canvasstiff.getContext("2d");
            ctx.clearRect(0, 0, canvasstiff.width, canvasstiff.height);  
            DibujarTexto(ctx, canvasstiff.width/2, 29, "Diagrama de Stiff", 19, "center");
            DibujarTexto(ctx, canvasstiff.width/2, 50, "Nombre Pozo: "+dtstiff[0].nombre, 14, "center");
            DibujarEjeTernario(ctx, canvasstiff);
            DibujarPoligono(ctx, canvasstiff);
            DibujarTextoInformativo(ctx, canvasstiff.width/2, 320, tipocompuesto, 14, "center");            
        }else{
            var ctx = canvasstiff.getContext("2d");
            ctx.clearRect(0, 0, canvasstiff.width, canvasstiff.height);  
            swal("Advertencia!", "Número de compuestos insuficientes para generar la gráfica.", "error");
        }
        cont = 0;  
    }

    function DibujarEjeTernario(ctx, canvasstiff){     

        for(i=0; i<=NumeroEjes-1; i++){
            DibujarTextoSupSubIndice(ctx, (canvasstiff.width/2)-250, YInicial+(i*IntervaloEjes), cationes[i], 15, supsubcationes[i], supsubcationes[i+3]);
            DibujarLinea(ctx, canvasstiff.width/2, YInicial+(i*IntervaloEjes), (canvasstiff.width/2)-225, YFinal+(i*IntervaloEjes));
            DibujarTextoSupSubIndice(ctx, (canvasstiff.width/2)+250, YFinal+(i*IntervaloEjes), aniones[i], 15, supsubaniones[i], supsubaniones[i+3]);
            DibujarLinea(ctx, canvasstiff.width/2, YInicial+(i*IntervaloEjes), (canvasstiff.width/2)+225, YFinal+(i*IntervaloEjes));
        }   

        for(j=0; j<=NumeroEjes-1; j++){
            for(k=1; k<=5; k++){
                //Segmentos de la izquierda         
                DibujarTexto(ctx, XMedio-(IntervaloSegmentos*k), (YInicial+(j*IntervaloEjes))-20, k*valsegmento, 15, "center");
                DibujarLinea(ctx, XMedio-(IntervaloSegmentos*k), (YInicial+(j*IntervaloEjes))-10, XMedio-(IntervaloSegmentos*k), (YInicial+(j*IntervaloEjes))+10);
                //Segmentos de la derecha           
                DibujarTexto(ctx, XMedio+(IntervaloSegmentos*k), (YInicial+(j*IntervaloEjes))-20, k*valsegmento, 15, "center");
                DibujarLinea(ctx, XMedio+(IntervaloSegmentos*k), (YInicial+(j*IntervaloEjes))-10, XMedio+(IntervaloSegmentos*k), (YInicial+(j*IntervaloEjes))+10);
            }
        }

        DibujarLinea(ctx, canvasstiff.width/2, YInicial-50, canvasstiff.width/2, (YInicial-50)+(NumeroEjes*IntervaloEjes)+50);
    }

    function DibujarTextoSupSubIndice(ctx, posx, posy, texto, tamanofuente, textosuperindice, textosubindice){
        DibujarTexto(ctx, posx, posy, texto, tamanofuente, "center");   
        if(textosuperindice != ""){
            DibujarTexto(ctx, posx+20, posy-8, textosuperindice, tamanofuente-5, "left");
        }

        if(textosubindice != ""){
            DibujarTexto(ctx, posx+20, posy+5, textosubindice, tamanofuente-5, "left");
        }
    }

    function DibujarTexto(ctx, posx, posy, texto, tamanofuente, alineartexto){
        ctx.beginPath();
        ctx.fillStyle = colortexto;
        ctx.textAlign= alineartexto;
        ctx.font = tamanofuente+"px Verdana";
        ctx.fillText(texto, posx, posy);
    }

    function DibujarTextoInformativo(ctx, posx, posy, texto, tamanofuente, alineartexto){
        ctx.beginPath();
        ctx.fillStyle = "#FF5733";
        ctx.textAlign= alineartexto;
        ctx.font = tamanofuente+"px Verdana";
        ctx.fillText(texto, posx, posy);
    }

    function DibujarLinea(ctx, XInicial, YInicial, XFinal, YFinal){ 
        ctx.lineWidth = ancholinea;
        ctx.strokeStyle = colorejes;    
        ctx.beginPath(); 
        ctx.moveTo(XInicial, YInicial); 
        ctx.lineTo(XFinal, YFinal); 
        ctx.stroke(); 
    }

    function DibujarPoligono(ctx, canvasstiff){
        ctx.fillStyle = colorrelleno;
        ctx.strokeStyle = colorborde;
        ctx.lineWidth = anchoborde; 
        ctx.beginPath();
        ctx.moveTo((canvasstiff.width/2)-(nak), YInicial);
        ctx.lineTo((canvasstiff.width/2)-(ca), YInicial+50);
        ctx.lineTo((canvasstiff.width/2)-(mg), YInicial+100);
        ctx.lineTo((canvasstiff.width/2)+(so), YInicial+100);
        ctx.lineTo((canvasstiff.width/2)+(hco), YInicial+50);
        ctx.lineTo((canvasstiff.width/2)+(cl), YInicial);
        ctx.closePath();
        ctx.fill();
        ctx.stroke();
    }

    function GuardarGraficaS(){
        Canvas2Image.saveAsPNG(canvasstiff, canvasstiff.width, canvasstiff.height, "DiagramaStiff");
    }

    function AbrirModalS(){
        $('#modalgraficastiff').modal('show');
    }

    function CerrarModalS(){
        swal({type: 'success', title: 'Cerrando!', showConfirmButton: false, timer: 300});
        $('#modalgraficastiff').modal('hide');

    }

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
                //     $("#btn_nuevo_compuesto_calidad_submit").show();
                // }else{
                //     $("#btn_nuevo_compuesto_calidad_submit").hide();
                // }   
                switch (parseInt(obj_permiso[0].tipoUsuario)) {
                    case 2:
                        if ((obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1) && obj_permiso[0].usuarioId == idUsuarioResponsable){    
                            $("#btn_nuevo_compuesto_calidad_submit").show();
                        }else{
                            $("#btn_nuevo_compuesto_calidad_submit").hide();
                        }
                        break;
                    case 3:
                        $("#btn_nuevo_compuesto_calidad_submit").hide();
                        break;
                    default:
                        if (obj_permiso[0].crear == 1 || obj_permiso[0].editar == 1){                                
                            $("#btn_nuevo_compuesto_calidad_submit").show();
                        }else{
                            $("#btn_nuevo_compuesto_calidad_submit").hide();
                        }
                        break;
                }              
            },
        });
    }

    jQuery(document).ready(function() {
        permisos_usuario();
        snippet_datatable_list_calidad_compuesto.init();
        //RecuperarDatosStiff();
        $('.select2').select2({
            placeholder: "Seleccione una opción",
            dropdownParent: $("#modalgraficastiff")
        });

        select_campania = $('#campaniaId');

        select_campania.change(function() {
            var campania = $('#campaniaId').val();
            RecuperarDatosStiff(campania);
        });
    });

</script>
{/literal}