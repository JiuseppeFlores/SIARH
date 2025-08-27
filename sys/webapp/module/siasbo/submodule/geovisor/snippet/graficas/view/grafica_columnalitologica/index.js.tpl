{literal}
<script>
    //Grafica Litologica
    var canvas = document.getElementById("lienzo");
    var contexto = Iniciar(canvas);
    // Colores Base
    //var colortexto = "#808080";
    //var colorejes = "#808080";
    //var ancholinea = 1;
    //var colorborde = "#384ad7";
    var colorrelleno = "#384ad7";   
    var anchoborde = 1;

    var profundidades = [];
    var litologia = [];
    var dtl;

    var litologias = [];

    var posyinicial = 120;
    var unmetro = 10;
    var pt = 0;   

    function RecuperarDatosLitologia(){
        var url = "{/literal}{$getModule}{literal}&accion={/literal}{$subcontrol}_getItemLitologia{literal}&id={/literal}{$id}{literal}";

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
            if (respuesta != 0){
                var datos = JSON.parse(respuesta);
                dtl = datos;
                Datos();
                DibujarColumnaLitologica();
            }else{
                swal("ADBERTENCIA", "No existen datos", "warning");
            }             
        });
    }

    function Iniciar(canvas){
        if (canvas && canvas.getContext){
            var ctx = canvas.getContext("2d");
            if (ctx){
                return ctx;
            }else{
                alert("No se pudo cargar el lienzo");
            }
        }
    }

    function Redondeo(numero){
        return Math.round(numero * 100) / 100;
    }

    function ConfigurarLienzo(){
        for (var i = 0; i <= profundidades.length-1; i++){          
            pt += (profundidades[i]*unmetro);
        };

        canvas.width = 700;
        canvas.height = pt+posyinicial+10;
        pt = 0;
    }

    function Datos(){
        //RecuperarDatosLitologia();

        //var data = table_list_litologico.rows().data();
        var dataaux = [];

        for (var i = 0; i <= dtl.length-1; i++) {
            profundidades[i] = dtl[i].profundidad_hasta-dtl[i].profundidad_desde;
            if(EsFormatoAnterior(i)){
                dataaux = dtl[i].litologia.split(" ");
                litologia[i] = dataaux[0];
            }else{
                litologia[i] = dtl[i].litologia1;
                litologias[i] = [];
                for(var j = 1 ; j <= 4 ; j++){
                    if(dtl[i][`litologia${j}`] != null){
                        litologias[i].push({
                            nombre: dtl[i][`litologia${j}`],
                            imagen: dtl[i][`imagen${j}`],
                            porcentaje: parseFloat(dtl[i][`porcentaje${j}`]),
                        });
                    }
                }
            }
        };
    }

    /* Verifica si la litología tiene una estructura anterior
       a la gestion 2025 */
    function EsFormatoAnterior(index){
        return dtl[index].litologia1 == null || dtl[index].litologia1 == 0;
    }

    function DibujarColumnaLitologica(){        
        //Datos();
        ConfigurarLienzo();
        contexto.clearRect(0, 0, canvas.width, canvas.height);
        DibujarTitulo(contexto, canvas.width/2, 29, "Columna Litológica", 19, "center", "#505050");
        DibujarTitulo(contexto, canvas.width/2, 50, "Nombre Pozo: "+dtl[0].nombre, 12, "center", "#a0a0a0");
        DibujarBloqueLitologia();
    }   

    function DibujarBloqueLitologia(){
        var swcolor = true;
        var profundidad = 0;
        var profundidadtotal = 0;   

        for (var i=0; i<=profundidades.length-1; i++){
            if(i == 0){             
                //Parte Profundidad
                DibujarTexto("Profundidad", (canvas.width/2)-322, posyinicial-50, 120, 40, "#384ad7", "#384ad7", "#ffffff");
                //Parte Espesor
                DibujarTexto("Espesor", (canvas.width/2)-201, posyinicial-50, 130, 40, "#384ad7", "#384ad7", "#ffffff");
                DibujarRectanguloProfundidad(Redondeo(profundidades[i])+" m.", (canvas.width/2)-100, posyinicial, 5, ((profundidades[i])*unmetro), "#808080", "#ffffff");
                //Parte Formacion
                DibujarTexto("Formacion", (canvas.width/2)+71, posyinicial-50, 140, 40, "#384ad7", "#384ad7", "#ffffff");
                DibujarRectanguloFormacion(litologia[i], (canvas.width/2)+71, posyinicial, 140, ((profundidades[i])*unmetro));
                //Parte Litologia
                DibujarTexto("Litologia", (canvas.width/2)-70, posyinicial-50, 140, 40, "#384ad7", "#384ad7", "#ffffff");
                if(EsFormatoAnterior(i)){
                    DibujarRectanguloLitologia(litologia[i].toLowerCase()+".png", (canvas.width/2)-70, posyinicial, 140, ((profundidades[i])*unmetro));
                }else{
                    DibujarSubRectanguloLitologia(litologias[i], (canvas.width/2)-70, posyinicial, 140, ((profundidades[i])*unmetro));
                }
                profundidad = profundidad+((profundidades[i])*unmetro);
            }else{
                //Parte Profundidad
                if(swcolor){
                    DibujarRectanguloProfundidad(Redondeo(profundidades[i])+" m.", (canvas.width/2)-100, posyinicial+profundidad, 5, ((profundidades[i])*unmetro), "#808080", "#808080");
                    swcolor = false;
                }else{
                    DibujarRectanguloProfundidad(Redondeo(profundidades[i])+" m.", (canvas.width/2)-100, posyinicial+profundidad, 5, ((profundidades[i])*unmetro), "#808080", "#ffffff");
                    swcolor = true;
                }           
                //Parte Formacion
                DibujarRectanguloFormacion(litologia[i], (canvas.width/2)+71, posyinicial+profundidad, 140, ((profundidades[i])*unmetro));
                //Parte Litologica
                if(EsFormatoAnterior(i)){
                    DibujarRectanguloLitologia(litologia[i].toLowerCase()+".png", (canvas.width/2)-70, posyinicial+profundidad, 140, ((profundidades[i])*unmetro));
                }else{
                    DibujarSubRectanguloLitologia(litologias[i], (canvas.width/2)-70, posyinicial+profundidad, 140, ((profundidades[i])*unmetro));
                }
                profundidad = profundidad+((profundidades[i])*unmetro);
            }
            profundidadtotal += profundidades[i];
        }

        DibujarRectanguloProfundidad(profundidadtotal+" m.", (canvas.width/2)-180, posyinicial, 5, ((profundidadtotal)*unmetro), "#808080", "#808080");

        DibujarRegla("", (canvas.width/2)-321, posyinicial, 80, ((profundidadtotal)*unmetro), "#808080", "#808080");
    }

    function DibujarRectanguloProfundidad(texto, posx, posy, anchobloque, altobloque, colorborde, colorrelleno){
        contexto.fillStyle = colorrelleno;
        contexto.strokeStyle = colorborde;
        contexto.lineWidth = anchoborde;
        contexto.strokeRect(posx, posy, anchobloque, altobloque);
        contexto.fillRect(posx, posy, anchobloque, altobloque);//#384ad7
        DibujarTexto(texto, posx-32, posy, anchobloque, altobloque, "#50505000", "#ffffff00", "#505050");
        contexto.stroke();
        contexto.restore();
    }

    function DibujarRectanguloFormacion(texto, posx, posy, anchobloque, altobloque){
        contexto.fillStyle = colorrelleno;
        contexto.strokeStyle = "#ffffff";
        contexto.lineWidth = anchoborde;
        contexto.strokeRect(posx, posy, anchobloque, altobloque);
        //contexto.fillRect(posx, posy, anchobloque, altobloque);
        DibujarTexto(texto, posx, posy, anchobloque, altobloque, "#384ad7", "#384ad7", "#ffffff"); //#1B4F72 #2874A6
        contexto.stroke();
        contexto.restore();
    }

    function DibujarRectanguloLitologia(imagen, posx, posy, anchobloque, altobloque){//color
        var img = new Image();
        img.src = "images/siasbo/textura/"+imagen;
        contexto.strokeStyle = "#101010";
        contexto.lineWidth = anchoborde;
        contexto.strokeRect(posx, posy, anchobloque, altobloque);
        contexto.fillRect(posx, posy, anchobloque, altobloque);

        img.onload = function(){
            contexto.drawImage(img, 0, 0, anchobloque, altobloque, posx, posy, anchobloque, altobloque);
        }

        contexto.stroke();
        contexto.restore();
    }

    function DibujarSubRectanguloLitologia(litologia, posX, posY, anchoBloque, altoBloque){
        var subAltoBloque = 0;
        var subPosY = posY;
        for(var i = 0 ; i < litologia.length ; i++){
            subAltoBloque = (altoBloque * (litologia[i].porcentaje / 100));
            DibujarRectanguloLitologia(litologia[i].imagen, posX, subPosY, anchoBloque, subAltoBloque);
            subPosY += (altoBloque * (litologia[i].porcentaje / 100));
        }
    }

    function DibujarTexto(texto, posx, posy, anchobloque, altobloque, colorborde, colorrelleno, colortexto){
        contexto.lineWidth = 0.5;
        contexto.strokeStyle = colorborde;
        contexto.fillStyle = colorrelleno;
        contexto.font= "12px Verdana";
        contexto.textAlign= "center"; 
        contexto.textBaseline = "middle";
        contexto.strokeRect(posx, posy, anchobloque, altobloque);
        contexto.fillRect(posx, posy, anchobloque, altobloque);
        contexto.fillStyle = colortexto;
        contexto.fillText(texto ,posx+(anchobloque/2), posy+(altobloque/2));
    }

    function DibujarTitulo(ctx, posx, posy, texto, tamanofuente, alineartexto, colortexto){
        ctx.beginPath();
        ctx.fillStyle = colortexto;
        ctx.textAlign= alineartexto;
        ctx.font = tamanofuente+"px Verdana";
        ctx.fillText(texto, posx, posy);
        ctx.stroke();
    }

    function DibujarRegla(texto, posx, posy, anchobloque, altobloque, colorborde, colorrelleno){    
        var swregla = true;
        var valorregla = 0;
        var gradiente = contexto.createLinearGradient(posx, 0, anchobloque+posx, 0);
        // gradiente.addColorStop(0, 'rgba(231, 231, 231, 1)');   
        // gradiente.addColorStop(0.5, 'rgba(255, 255, 255, 1)');   
        // gradiente.addColorStop(0.5, 'rgba(255, 255, 255, 1)');
        // gradiente.addColorStop(1, 'rgba(231, 231, 231, 1)');

        gradiente.addColorStop(0, 'rgba(231, 231, 231, 1)');
        gradiente.addColorStop(1, 'rgba(255, 255, 255, 1)');
        contexto.fillStyle = gradiente; //colorrelleno;
        contexto.strokeStyle = colorborde;
        contexto.lineWidth = anchoborde;
        contexto.strokeRect(posx, posy-5, anchobloque, altobloque+10);
        contexto.fillRect(posx, posy-5, anchobloque, altobloque+10);

        contexto.strokeStyle = '#505050';
        contexto.lineWidth = 1;
        contexto.beginPath();
        //contexto.setLineDash([0,0]);  
        for (var i=posy; i<=posy+altobloque; i+=(unmetro/2)) {
            if(swregla){
                contexto.moveTo((posx+anchobloque)-20, i);
                contexto.lineTo((posx+anchobloque), i);             
                swregla = false;                
            }else{
                contexto.moveTo((posx+anchobloque)-10, i);
                contexto.lineTo((posx+anchobloque), i);
                swregla = true;
            }           
        }
        //contexto.setLineDash([1,2]);
        contexto.moveTo(posx+anchobloque+5, posy);
        contexto.lineTo((posx+anchobloque)+170, posy);  
        contexto.moveTo(posx+anchobloque+5, posy+altobloque);
        contexto.lineTo((posx+anchobloque)+170, posy+altobloque);   
        contexto.stroke();

        // for (var j=posy; j<posy+altobloque+10; j+=(unmetro/2)){  
        //     if(j%2===0){
        //         DibujarTexto(valorregla+" m.", (posx+anchobloque)-65, j-6, 30, 10, "#50505000", "#ffffff00", "#505050");
        //         valorregla++;
        //     }              
        // }

        var limite = Math.trunc(((posy+altobloque)/50)-1);
        var posvalor = -5;

        for (var j=1; j<=limite; j++){
            DibujarTexto(valorregla+" m.", (posx+anchobloque)-65, posy+(posvalor), 30, 10, "#50505000", "#ffffff00", "#505050");
            valorregla+=5; 
            posvalor+=50;             
        }

        DibujarTexto(texto, posx-32, posy, anchobloque, altobloque, "#50505000", "#ffffff00", "#505050");
        contexto.stroke();
        contexto.restore();
    }

    function GuardarGrafica(){
        Canvas2Image.saveAsPNG(canvas, canvas.width, canvas.height, "ColumnaLitologica");
    }

    $(document).ready(function(){
        RecuperarDatosLitologia();
        //Datos();
        //DibujarColumnaLitologica();
    });    

</script>
{/literal}