{literal}
<script>
    var select_campania_stiff;
    //var dtstiff = {/literal}{$datosStiff}{literal};

    var canvasstiff = document.getElementById("grafico_stiff");    

    var colortexto = "#505050";
    var colorejes = "#808080";
    var ancholinea = 0.5;
    var colorrelleno = "rgba(56, 74, 215, 0.5)";
    var colorborde = "rgba(56, 74, 215, 1)";
    var anchoborde = 0.5;

    var na = 0;
    var k = 0;
    var nak = 0;
    var ca = 0;
    var mg = 0;

    var cl = 0;
    var hco = 0;
    var so = 0;

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
    var NumeroIntervaloSegmentos = 0;
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
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getDatosStiff{literal}&pozoId={/literal}{$pozoId}{literal}&campaniaId="+campania;

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
            swal.close();
            if (respuesta != 0) {
                var datos = JSON.parse(respuesta);
                dtstiff = datos;
                CargarGraficaS();
            } else {
                var ctx = canvasstiff.getContext("2d");
                ctx.clearRect(0, 0, canvasstiff.width, canvasstiff.height);  
                swal("Advertencia!", "No existen datos para esta campaña.", "error");
            }
            //alert("Nivel estatico"+datos[0].nivel_estatico);
        });
    }

    function Redondeo(numero){
        return Math.round(numero * 100) / 100;
    }

    function Datos(){
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

        console.log(hco+', '+ca+', '+cl+', '+mg+', '+nak+', '+so);

        //if(sw == 1){
            hco = hco*(1/29);
            ca = ca*(1/40);
            cl = cl*(1/35.45);
            mg = mg*(1/24.3);
            nak = (parseInt(na)+parseInt(k))*(1/62);
            so = so*(1/48);
        //}

        console.log(hco+', '+ca+', '+cl+', '+mg+', '+nak+', '+so);
        
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
            //AbrirModalS();
            var ctx = canvasstiff.getContext("2d");

            ctx.clearRect(0, 0, canvasstiff.width, canvasstiff.height);  
            DibujarTexto(ctx, canvasstiff.width/2, 29, "Diagrama de Stiff", 19, "center");
            DibujarTexto(ctx, canvasstiff.width/2, 50, "Nombre Pozo: "+dtstiff[0].nombre, 14, "center");
            DibujarEjeTernario(ctx, canvasstiff);
            DibujarPoligono(ctx, canvasstiff);
            DibujarTextoInformativo(ctx, canvasstiff.width/2, 320, tipocompuesto, 14, "center");            
        }else{
            //alert("Numero de compuestos insuficientes");
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

    function GuardarGrafica(){
        Canvas2Image.saveAsPNG(canvasstiff, canvasstiff.width, canvasstiff.height, "DiagramaStiff");
    }

    $(document).ready(function(){
        /*Datos();
        var ctx = canvasstiff.getContext("2d");
        ctx.clearRect(0, 0, canvasstiff.width, canvasstiff.height);  
        DibujarTexto(ctx, canvasstiff.width/2, 29, "Diagrama de Stiff", 19, "center");
        DibujarTexto(ctx, canvasstiff.width/2, 50, "Nombre Pozo: "+dtstiff[0].nombre, 14, "center");
        DibujarEjeTernario(ctx, canvasstiff);
        DibujarPoligono(ctx, canvasstiff);
        DibujarTextoInformativo(ctx, canvasstiff.width/2, 320, tipocompuesto, 14, "center");
        cont = 0;*/

        $('.select2').select2({
            placeholder: "Seleccione una opción",
            dropdownParent: $("#modal_stiff")
        });

        select_campania_stiff = $('#campaniaStiffId');

        select_campania_stiff.change(function() {
            var campania = $('#campaniaStiffId').val();
            RecuperarDatosStiff(campania);
        });
    });    

</script>
{/literal}