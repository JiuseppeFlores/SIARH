{literal}
<script>
    var canvas = document.getElementById('grafico_piper');
    var ctx = canvas.getContext('2d');

    function guardarGrafica() {
        Canvas2Image.saveAsPNG(canvas, canvas.width, canvas.height, "grafico_piper");
    }

    var configTI = {
        escala: 250,
        inicioX: 70,
        inicioY: 60,
        distancia: 0,
        triangulo: 'izquierdo'
    };

    var configTD = {
        escala: configTI.escala,
        inicioX: configTI.escala + configTI.inicioX,
        inicioY: configTI.inicioY,
        distancia: 40,
        triangulo: 'derecho'
    };

	var dibujarTriangulo = function(config, ctx) {
        var escalaZoom = config.escala/100;
        var inicioX = config.inicioX + (escalaZoom * config.distancia);
        var finalX = config.escala + inicioX;
        var inicioY = config.escala + (config.inicioY * escalaZoom);
        var finalY = ((config.escala/100) * 85) + inicioY;
        var medioX = (finalX/2) + (inicioX/2);
        var separacionX = (finalX - inicioX)/10;
        var separacionY = (finalY - inicioY)/10;
        var contador, auxiliar;

        var fontSize = 8;
        var spaceFontLeft = 23;
        var spaceFontRight = 13;
        var spaceFontTop = 13;
        var spaceFontBottom = 11;

        if (config.escala >= 150 && config.escala <= 250) {
            fontSize = 10;
            spaceFontLeft = 32;
            spaceFontRight = 20;
            spaceFontTop = 17;
            spaceFontBottom = 14;
        }

        if (config.escala > 250 && config.escala <= 350) {
            fontSize = 12;
            spaceFontLeft = 42;
            spaceFontRight = 27;
            spaceFontTop = 22;
            spaceFontBottom = 20;
        }

        if (config.escala > 350 && config.escala <= 400) {
            fontSize = 14;
            spaceFontLeft = 50;
            spaceFontRight = 32;
            spaceFontTop = 22;
            spaceFontBottom = 23;
        }

        // Genera triángulo equilatero
        ctx.beginPath();
        ctx.strokeStyle = "#000000";
        ctx.lineWidth = 1;
        ctx.fillStyle = "#ffffff";
        ctx.setLineDash([0]);
        ctx.moveTo(medioX, inicioY);
        ctx.lineTo(inicioX, finalY);
        ctx.lineTo(finalX, finalY);
        ctx.fill();
        ctx.closePath();
        ctx.stroke();

       // Genera líneas horizontales
        auxiliar = separacionX/2;
        for (var i = finalY - separacionY; i > inicioY; i = i - separacionY) {
            ctx.beginPath();
            ctx.strokeStyle = "#000000";
            ctx.lineWidth = 0.5;
            ctx.setLineDash([4]);
            ctx.moveTo(inicioX + auxiliar, i);
            ctx.lineTo(finalX - auxiliar, i);
            ctx.stroke();
            auxiliar += separacionX/2;
        }

        // Genera líneas diagonales con pendiente positivo
        contador = inicioY + separacionY, auxiliar = separacionX/2;
        for (var i = inicioX + separacionX; i < finalX; i = i + separacionX) {
            ctx.beginPath();
            ctx.strokeStyle = "#000000";
            ctx.lineWidth = 0.5;
            ctx.setLineDash([4]);
            ctx.moveTo(i, finalY);
            ctx.lineTo(medioX +  auxiliar, contador);
            ctx.stroke();
            contador += separacionY;
            auxiliar += separacionX/2;
        }

        // Genera líneas diagonales con pendiente negativo
        contador = inicioY + separacionY, auxiliar = separacionX/2;
        for (var i = finalX - separacionX; i > inicioX; i = i - separacionX) {
          ctx.beginPath();
          ctx.strokeStyle = "#000000";
          ctx.lineWidth = 0.5;
          ctx.setLineDash([4]);
          ctx.moveTo(i, finalY);
          ctx.lineTo(medioX - auxiliar, contador);
          ctx.stroke();
          contador += separacionY;
          auxiliar += separacionX/2;
        }

        if (config.triangulo == 'izquierdo') {
            var escalaMg = 0, escalaNa = 100, escalaCa = 100;

            // Genera etiquetas escala diagonal
            contador = separacionY, auxiliar = separacionX/2;
            ctx.font = "normal " + fontSize + "px sans-serif";
            for (var i = finalY; i >= inicioY; i = i - separacionY) {
                ctx.beginPath();
                ctx.fillStyle = "blue";
                ctx.fillText(escalaMg, (inicioX + auxiliar) - spaceFontLeft, i);
                ctx.beginPath();
                ctx.fillStyle = "green";
                ctx.fillText(escalaNa, (finalX - auxiliar) + spaceFontRight, i);
                auxiliar += separacionX/2;
                escalaMg += 10;
                escalaNa -= 10;
            }

            // Genera etiquetas escala horizontal
            ctx.font = "normal " + fontSize + "px sans-serif";
            for (var i = inicioX; i <= finalX; i = i + separacionX) {
                ctx.beginPath();
                ctx.fillStyle = "red";
                ctx.fillText(escalaCa, i - 5, finalY + spaceFontBottom);
                escalaCa -= 10;
            }

            // Generar etiquetas de nombres de compuestos
            ctx.font = "bold " + fontSize + "px sans-serif";
            ctx.beginPath();
            ctx.fillStyle = "blue";
            ctx.fillText("Mg++", medioX - 7, inicioY - spaceFontTop);
            ctx.beginPath();
            ctx.fillStyle = "red";
            ctx.fillText("Ca++", inicioX - 20, finalY + (spaceFontBottom * 2));
            ctx.beginPath();
            ctx.fillStyle = "green";
            ctx.fillText("Na++Ka+", finalX - 20, finalY + (spaceFontBottom * 2));
        }

        if (config.triangulo == 'derecho') {
            var escalaSO = 0, escalaCL = 0, escalaHCO = 100;

            // Genera etiquetas escala diagonal
            contador = separacionY, auxiliar = separacionX/2;
            ctx.font = "normal " + fontSize + "px sans-serif";
            for (var i = finalY; i >= inicioY; i = i - separacionY) {
                ctx.beginPath();
                ctx.fillStyle = "#4a148c";
                ctx.fillText(escalaHCO, (inicioX + auxiliar) - spaceFontLeft, i);
                ctx.beginPath();
                ctx.fillStyle = "#004d40";
                ctx.fillText(escalaSO, (finalX - auxiliar) + spaceFontRight, i);
                auxiliar += separacionX/2;
                escalaSO += 10;
                escalaHCO -= 10;
            }

            // Genera etiquetas escala horizontal
            ctx.font = "normal " + fontSize + "px sans-serif";
            for (var i = inicioX; i <= finalX; i = i + separacionX) {
                ctx.beginPath();
                ctx.fillStyle = "#e65100";
                ctx.fillText(escalaCL, i - 5, finalY + spaceFontBottom);
                escalaCL += 10;
            }

            // Generar etiquetas de nombres de compuestos
            ctx.font = "bold " + fontSize + "px sans-serif";
            ctx.beginPath();
            ctx.fillStyle = "#004d40";
            ctx.fillText("SO4=", medioX - 7, inicioY - spaceFontTop);
            ctx.beginPath();
            ctx.fillStyle = "#4a148c";
            ctx.fillText("HCO3", inicioX - spaceFontLeft, finalY + (spaceFontBottom * 2));
            ctx.beginPath();
            ctx.fillStyle = "#e65100";
            ctx.fillText("CL-", finalX + spaceFontRight, finalY + (spaceFontBottom * 2));
        } 
    };

    var dibujarRombo = function(config, ctx) {
        var escalaZoom = config.escala/100;
        var inicioX = config.inicioX + (escalaZoom * config.distancia);
        var finalX = config.escala + inicioX;
        var inicioY = config.escala + (config.inicioY * escalaZoom);
        var finalY = ((config.escala/100) * 85) + inicioY;
        var medioX = (finalX/2) + (inicioX/2);
        var separacionX = (finalX - inicioX)/10;
        var separacionY = (finalY - inicioY)/10;
        var contador, auxiliar;

        // Genera rombo
        ctx.beginPath();
        ctx.strokeStyle = "#000000";
        ctx.lineWidth = 1;
        ctx.fillStyle = "#ffffff";
        ctx.setLineDash([0]);
        ctx.moveTo(finalX + (20*escalaZoom), finalY - (204*escalaZoom));
        ctx.lineTo(finalX - (30*escalaZoom), finalY - (119*escalaZoom));
        ctx.lineTo(finalX + (20*escalaZoom), finalY - (34*escalaZoom));
        ctx.lineTo(finalX + (70*escalaZoom), finalY - (119*escalaZoom));
        ctx.fill();
        ctx.closePath();
        ctx.stroke();

        // Genera líneas horizontales
        contador = finalY - (119*escalaZoom), auxiliar = separacionX/2;
        for (var i = finalY - (119*escalaZoom); i > finalY - (204*escalaZoom); i = i - separacionY) {
            if (i == finalY - (119*escalaZoom)) {
                ctx.beginPath();
                ctx.lineWidth = 0.5;
                ctx.setLineDash([4]);
                ctx.moveTo(finalX - (30*escalaZoom), i);
                ctx.lineTo(finalX + (70*escalaZoom), i);
                ctx.stroke();
                contador += separacionY;
            } else {
                ctx.beginPath();
                ctx.lineWidth = 0.5;
                ctx.setLineDash([4]);
                ctx.moveTo((finalX - (30*escalaZoom)) + auxiliar, i);
                ctx.lineTo((finalX + (70*escalaZoom)) - auxiliar, i);
                ctx.moveTo((finalX - (30*escalaZoom)) + auxiliar, contador);
                ctx.lineTo((finalX + (70*escalaZoom)) - auxiliar, contador);
                ctx.stroke();
                ctx.beginPath();
                auxiliar += separacionX/2;
                contador += separacionY;
            }
        }

        // Genera líneas diagonales con pendiente positivo
        contador = finalY - (204*escalaZoom) + separacionY, auxiliar = separacionX/2;
        var contadorAux = finalY - (119*escalaZoom) + separacionY;
        var contadorLinea = 1;
        for (var i = finalX - (20*escalaZoom); i < finalX + (70*escalaZoom); i = i + separacionX) {
            ctx.beginPath();
            if (contadorLinea == 5) {
                ctx.lineWidth = 1;
            ctx.setLineDash([0]);
            } else {
                ctx.lineWidth = 0.5;
                ctx.setLineDash([4]);
            }
            ctx.lineTo(finalX + (20*escalaZoom) + auxiliar, contador);
            ctx.lineTo(i - auxiliar, contadorAux);
            ctx.stroke();
            ctx.beginPath();
            contador += separacionY;
            contadorAux += separacionY;
            auxiliar += separacionX/2;
            contadorLinea++;
        }

        // Genera líneas diagonales con pendiente negativo
        contador = finalY - (34*escalaZoom) - separacionY, auxiliar = separacionX/2;
        var contadorAux = finalY - (119*escalaZoom) - separacionY;
        contadorLinea = 1;
        for (var i = finalX - (20*escalaZoom); i < finalX + (70*escalaZoom); i = i + separacionX) {
            ctx.beginPath();
            if (contadorLinea == 5) {
                ctx.lineWidth = 1;
            ctx.setLineDash([0]);
            } else {
                ctx.lineWidth = 0.5;
                ctx.setLineDash([4]);
            }
            ctx.moveTo(finalX + (20*escalaZoom) + auxiliar, contador);
            ctx.lineTo(i - auxiliar, contadorAux);
            ctx.stroke();
            ctx.beginPath();
            contador -= separacionY;
            contadorAux -= separacionY;
            auxiliar += separacionX/2;
            contadorLinea++;
        }
    };

    var dibujarPuntos = function(configTI, configTD, ctx, datos, colores) {
        var escalaZoom = configTI.escala/100;
        var inicioX = configTI.inicioX + (escalaZoom * configTI.distancia);
        var finalX = configTI.escala + inicioX;
        var inicioY = configTI.escala + (configTI.inicioY * escalaZoom);
        var finalY = ((configTI.escala/100) * 85) + inicioY;
        var separacionX = (finalX - inicioX)/10;
        var separacionY = (finalY - inicioY)/10;

        var inicioX1 = configTD.inicioX + (escalaZoom * configTD.distancia);
        var finalX1 = configTD.escala + inicioX1;
        var inicioY1 = configTD.escala + (configTD.inicioY * escalaZoom);
        var finalY1 = ((configTD.escala/100) * 85) + inicioY1;

        var tamanoPunto = 5;
        if (configTI.escala >= 150 && configTI.escala <= 250) {
            tamanoPunto = 5;
        }

        if (configTI.escala > 250 && configTI.escala <= 350) {
            tamanoPunto = 7;
        }

        if (configTI.escala > 350 && configTI.escala <= 400) {
            tamanoPunto = 9;
        }

        var limite = datos.length;
        var totalCationes = 0, totalAniones = 0;
        var limiteColores = colores.length;
        var contadorColores = 0;
        for (var i = 0; i < limite; i++) {
            // Cálculo de las coordenadas para los cationes
            caX = (100 - datos[i].valorCa)/10 * separacionX;
            mgY = datos[i].valorMg/10 * separacionY;
            naX = datos[i].valorNaK/10 * separacionX;
            pendienteEcuacionCa = -1.7;
            puntoIzqY = mgY;
            puntoDerX = (puntoIzqY + (pendienteEcuacionCa * caX))/pendienteEcuacionCa;

            // Cálculo de las coordenadas para los aniones
            hcoX = (100 - datos[i].valorHco)/10 * separacionX;
            soY = datos[i].valorSo/10 * separacionY;
            clX = datos[i].valorCl/10 * separacionX;
            pendienteEcuacionHco = -1.7;
            puntoIzqY1 = soY;
            puntoDerX1 = (puntoIzqY1 + (pendienteEcuacionHco * hcoX))/pendienteEcuacionHco;

            // Cálculo de las coordenadas para el rombo con las ecuaciones de NA y HCO
            puntoX1 = inicioX + naX;
            puntoX2 = inicioX1 + hcoX;
            intersecX = (1.7 * puntoX2 + 1.7 * puntoX1)/3.4;
            intersecY = 2.89 * puntoX2/3.4 + 2.89 * puntoX1/3.4 - 1.7 * puntoX1;

            totalCationes = datos[i].valorCa + datos[i].valorMg + datos[i].valorNaK;
            totalAniones = datos[i].valorHco + datos[i].valorSo + datos[i].valorCl;
            //if ((totalCationes <= 100) && (totalAniones <= 100)) {
                // Genera punto de intersección
                ctx.beginPath();
                ctx.strokeStyle = "#000000";
                ctx.lineWidth = 0.5;
                ctx.setLineDash([0]);
                ctx.fillStyle = colores[contadorColores];
                ctx.arc(puntoDerX + inicioX, finalY - puntoIzqY, tamanoPunto, 0, 2 * Math.PI, false);
                ctx.fill();
                ctx.stroke();
                ctx.closePath();

                // Genera punto de intersección
                ctx.beginPath();
                ctx.strokeStyle = "#000000";
                ctx.lineWidth = 0.5;
                ctx.setLineDash([0]);
                ctx.fillStyle = colores[contadorColores];
                ctx.arc(puntoDerX1 + inicioX1, finalY1 - puntoIzqY1, tamanoPunto, 0, 2 * Math.PI, false);
                ctx.fill();
                ctx.stroke();
                ctx.closePath();

                // Genera punto de intersección
                ctx.beginPath();
                ctx.strokeStyle = "#000000";
                ctx.lineWidth = 0.5;
                ctx.setLineDash([0]);
                ctx.fillStyle = colores[contadorColores];
                ctx.arc(intersecX, finalY - intersecY, tamanoPunto, 0, 2 * Math.PI, false);
                ctx.fill();
                ctx.stroke();
                ctx.closePath();
            //}
            
            if (contadorColores == limiteColores - 1) {
                contadorColores = 0;
            } else {
                contadorColores++;
            }
        }
    };

    var dibujarLeyendas = function(configTI, configTD, ctx, datos, colores) {
        var escalaZoom = configTI.escala/100;
        var inicioX = configTI.inicioX + (escalaZoom * configTI.distancia);
        var finalX = configTD.inicioX + (escalaZoom * configTD.distancia) + configTI.escala;
        var inicioY = configTI.escala + (configTI.inicioY * escalaZoom);
        var finalY = ((configTI.escala/100) * 85) + inicioY;

        var spaceBottomLegend = finalY + 50;
        var legendTitleFontSize = 12;
        var legendAtributesFontSize = 10;
        var legendSizeCircle = 7;
        var legendColumns = 2;
        var xSpaceLegend = (finalX - inicioX)/legendColumns;
        var ySpaceLegend = 20;

        if (configTI.escala >= 150 && configTI.escala <= 200) {
            spaceBottomLegend = finalY + 60;
            legendTitleFontSize = 14;
            legendAtributesFontSize = 12;
            legendSizeCircle = 8;
            legendColumns = 2;
            xSpaceLegend = (finalX - inicioX)/legendColumns;
            ySpaceLegend = 25;
        }

        if (configTI.escala >= 250 && configTI.escala <= 300) {
            spaceBottomLegend = finalY + 70;
            legendTitleFontSize = 16;
            legendAtributesFontSize = 14;
            legendSizeCircle = 9;
            legendColumns = 3;
            xSpaceLegend = (finalX - inicioX)/legendColumns;
            ySpaceLegend = 30;
        }

        if (configTI.escala >= 350 && configTI.escala <= 400) {
            spaceBottomLegend = finalY + 90;
            legendTitleFontSize = 18;
            legendAtributesFontSize = 16;
            legendSizeCircle = 10;
            legendColumns = 4;
            xSpaceLegend = (finalX - inicioX)/legendColumns;
            ySpaceLegend = 35;
        }

        // Genera etiquetas leyenda derecha
        ctx.font = "bold " + legendTitleFontSize + "px sans-serif";
        ctx.beginPath();
        ctx.fillStyle = "#000000";
        ctx.fillText('LEYENDA DE POZOS', inicioX, spaceBottomLegend);

        // Genera leyendas por pozo
        var limiteColores = colores.length;
        var limite = datos.length;
        var contador = spaceBottomLegend + ySpaceLegend;
        var auxiliar = 0;
        var avanceX = 0;
        var contadorColumnas = 1;
        for (var i = 0; i < limite; i++) {
            //if ((datos[i].valorCa + datos[i].valorMg + datos[i].valorNaK == 100) && (datos[i].valorHco + datos[i].valorSo + datos[i].valorCl == 100)) {

                // Genera rectángulo leyenda
                ctx.beginPath();
                ctx.strokeStyle = "#000000";
                ctx.lineWidth = 0.5;
                ctx.setLineDash([0]);
                ctx.fillStyle = colores[auxiliar];
                ctx.arc(inicioX + avanceX, contador, legendSizeCircle, 0, 2 * Math.PI, false);
                //ctx.fillRect(inicioX + avanceX, contador, 25, 15);
                ctx.fill();
                ctx.stroke();
                ctx.closePath();

                // Genera etiqueta rectángulo leyenda
                ctx.font = "normal " + legendAtributesFontSize + "px sans-serif";
                ctx.beginPath();
                ctx.fillStyle = "#000000";
                ctx.fillText(datos[i].nombre, inicioX + 15 + avanceX, contador + 4);
                
                if (contadorColumnas == legendColumns) {
                    contadorColumnas = 1;
                    contador += ySpaceLegend;
                    avanceX = 0;
                } else {
                    contadorColumnas++;
                    avanceX += xSpaceLegend;
                }

                if (auxiliar == limiteColores - 1) {
                    auxiliar = 0;
                } else {
                    auxiliar++;
                }
            //}
        }
    };

    var dibujarTitulo = function(configTI, configTD, ctx, datos, lienzo, datoCampania) {
        var escalaZoom = configTI.escala/100;
        var inicioX = configTI.inicioX + (escalaZoom * configTI.distancia);
        var finalX = configTD.inicioX + (escalaZoom * configTD.distancia) + configTI.escala;
        var inicioY = configTI.escala + (configTI.inicioY * escalaZoom);
        var finalY = ((configTI.escala/100) * 85) + inicioY;

        ctx.moveTo(lienzo.width/2, 10);
        ctx.lineTo(lienzo.width/2, 20);

        ctx.font = "bold 16px sans-serif";
        ctx.beginPath();
        ctx.fillStyle = "#000000";
        ctx.textAlign="center";
        ctx.fillText("DIAGRAMA HIDROQUÍMICO DE PIPER", lienzo.width/2, 20);
        ctx.font = "normal 14px sans-serif";
        ctx.fillText("NOMBRE: " + datos[0].acuifero + "  CAMPAÑA: " + datoCampania, lienzo.width/2, 37);

        var img = new Image();
        img.src = "images/siasbo/piper/interpretacion.png";
        img.onload = function(){
            ctx.drawImage(img, 0, 37, 218, 305);
        }
    };

    var dibujarLienzo = function(configTD, dimension, lienzo) {
        var escalaZoom = configTD.escala/100;
        var inicioX = configTD.inicioX + (escalaZoom * configTD.distancia);
        var finalX = configTD.escala + inicioX + configTI.inicioX;
        var inicioY = configTD.escala + (configTD.inicioY * escalaZoom);
        var finalY = ((configTD.escala/100) * 85) + inicioY;

        var spaceBottomLegend = finalY + 50;
        var legendTitleFontSize = 12;
        var legendAtributesFontSize = 10;
        var legendSizeCircle = 7;
        var legendColumns = 2;
        var xSpaceLegend = (finalX - inicioX)/legendColumns;
        var ySpaceLegend = 20;

        if (configTD.escala >= 150 && configTD.escala <= 200) {
            spaceBottomLegend = finalY + 60;
            legendTitleFontSize = 14;
            legendAtributesFontSize = 12;
            legendSizeCircle = 8;
            legendColumns = 2;
            xSpaceLegend = (finalX - inicioX)/legendColumns;
            ySpaceLegend = 25;
        }

        if (configTD.escala >= 250 && configTD.escala <= 300) {
            spaceBottomLegend = finalY + 70;
            legendTitleFontSize = 16;
            legendAtributesFontSize = 14;
            legendSizeCircle = 9;
            legendColumns = 3;
            xSpaceLegend = (finalX - inicioX)/legendColumns;
            ySpaceLegend = 30;
        }

        if (configTD.escala >= 350 && configTD.escala <= 400) {
            spaceBottomLegend = finalY + 90;
            legendTitleFontSize = 18;
            legendAtributesFontSize = 16;
            legendSizeCircle = 10;
            legendColumns = 4;
            xSpaceLegend = (finalX - inicioX)/legendColumns;
            ySpaceLegend = 35;
        }

        var altura = parseInt(dimension/legendColumns);
        if (dimension % legendColumns != 0 ) {
            altura += 1;
        }

        lienzo.width = finalX;
        lienzo.height = spaceBottomLegend + (altura * ySpaceLegend) + 40;

        ctx.clearRect(0, 0, lienzo.width, lienzo.height);
    };

    // Genera una lista de colores
    var colores = [
        /*'#b71c1c',
        '#880e4f',
        '#0d47a1',
        '#006064',
        '#004d40',
        '#827717',
        '#f57f17',
        '#bf360c',
        '#3e2723',
        '#263238'*/
        '#cd6155',
        '#a569bd',
        '#5499c7',
        '#45b39d',
        '#f4d03f',
        '#dc7633',
        '#af7ac5',
        '#ec7063',
        '#5dade2',
        '#48c9b0',
        '#f5b041',
        '#58d68d',
        '#eb984e',
        '#52be80' 
    ];

    // Inicialización y Configuración
    var datos = {/literal}{$compuestosDatos}{literal};
    var datoCampania = '{/literal}{$datoCampania}{literal}';

    jQuery(document).ready(function () {
        $("#btn_piper_min").click(function() {
            if (configTI.escala > 250) {

                configTI = {
                    escala: configTI.escala - 50,
                    inicioX: 70,
                    inicioY: 60,
                    distancia: 0,
                    triangulo: 'izquierdo'
                };

                configTD = {
                    escala: configTI.escala,
                    inicioX: configTI.escala + configTI.inicioX,
                    inicioY: configTI.inicioY,
                    distancia: 40,
                    triangulo: 'derecho'
                };

                dibujarLienzo(configTD, datos.length, canvas);
                dibujarTriangulo(configTI, ctx); 
                dibujarRombo(configTI, ctx);
                dibujarTriangulo(configTD, ctx);
                dibujarPuntos(configTI, configTD, ctx, datos, colores);
                dibujarLeyendas(configTI, configTD, ctx, datos, colores);
                dibujarTitulo(configTI, configTD, ctx, datos, canvas, datoCampania);
            }
        });

        $("#btn_piper_max").click(function() {
            if (configTI.escala < 400) {
                configTI = {
                    escala: configTI.escala + 50,
                    inicioX: 70,
                    inicioY: 40,
                    distancia: 0,
                    triangulo: 'izquierdo'
                };

                configTD = {
                    escala: configTI.escala,
                    inicioX: configTI.escala + configTI.inicioX,
                    inicioY: configTI.inicioY,
                    distancia: 40,
                    triangulo: 'derecho'
                };

                dibujarLienzo(configTD, datos.length, canvas);
                dibujarTriangulo(configTI, ctx); 
                dibujarRombo(configTI, ctx);
                dibujarTriangulo(configTD, ctx);
                dibujarPuntos(configTI, configTD, ctx, datos, colores);
                dibujarLeyendas(configTI, configTD, ctx, datos, colores);
                dibujarTitulo(configTI, configTD, ctx, datos, canvas, datoCampania);
            }
        });

        dibujarLienzo(configTD, datos.length, canvas);
        dibujarTriangulo(configTI, ctx); 
        dibujarRombo(configTI, ctx);
        dibujarTriangulo(configTD, ctx);
        dibujarPuntos(configTI, configTD, ctx, datos, colores);
        dibujarLeyendas(configTI, configTD, ctx, datos, colores);
        dibujarTitulo(configTI, configTD, ctx, datos, canvas, datoCampania);
    });
</script>
{/literal}