{literal}
<script>
    var lienzo = document.getElementById('grafico_diseno');

    var snippet_grafica_diseno = function () {
        var idfichaCapa = '{/literal}{$id}{literal}';
        var btn_cerrar_grafica = $('#btn_cerrar_grafica');
        var btn_zoom_min_grafica = $('#btn_zoom_min_grafica');
        var btn_zoom_max_grafica = $('#btn_zoom_max_grafica');
        
        var graficar_diseno = function(configLienzo, config) {
            //var lienzo = document.getElementById('grafico_diseno');
            var ctx = lienzo.getContext('2d');

            // Redimensiona tamaño de lienzo
            var dibujarLienzo = function(config, lienzo) {
                lienzo.width = config.ancho;
                lienzo.height = config.alto;
            };

            // Genera gráfica del tubo
            var dibujarTubo = function(config, ctx) {
                var inicioX = config.inicioX;
                var inicioY = config.inicioY;
                var finalY = config.alto - 25;
                var finalX = inicioX + (Math.round((finalY - inicioY)/10) * 2);
                var escalaZoom = (finalY - inicioY)/100;
                var medioX = (config.ancho/20) * escalaZoom;
                var ancho = Math.round((finalY - inicioY)/10) * 2;
                var alto = finalY - inicioY;

                // Genera ademe
                ctx.strokeStyle = "#222222";
                ctx.lineWidth = 0.5;
                ctx.fillStyle = "#eeeeee";
                var gradienteHorizontal = ctx.createLinearGradient(inicioX, inicioY, finalX, inicioY);
                gradienteHorizontal.addColorStop(0, "#adadad");
                gradienteHorizontal.addColorStop(0.50, "#ffffff");
                gradienteHorizontal.addColorStop(1, "#adadad");
                ctx.fillStyle = gradienteHorizontal;
                ctx.fillRect(inicioX, inicioY - 20, ancho, 20);
                ctx.strokeRect(inicioX, inicioY - 20, ancho, 20);

                // Genera cilindro del tubo
                ctx.strokeStyle = "#444444";
                ctx.lineWidth = 0.5;
                ctx.fillStyle = "#eeeeee";
                gradienteHorizontal = ctx.createLinearGradient(inicioX, inicioY, finalX, inicioY);
                gradienteHorizontal.addColorStop(0, "#adadad");
                gradienteHorizontal.addColorStop(0.50, "#ffffff");
                gradienteHorizontal.addColorStop(1, "#adadad");
                ctx.fillStyle = gradienteHorizontal;
                ctx.fillRect(inicioX, inicioY, ancho, alto);
                ctx.strokeRect(inicioX, inicioY, ancho, alto);

                // Genera triángulo final del tubo
                ctx.beginPath();
                ctx.strokeStyle = "#444444";
                ctx.lineWidth = 0.5;
                ctx.fillStyle = gradienteHorizontal;
                ctx.setLineDash([0]);
                ctx.moveTo(inicioX, finalY);
                ctx.lineTo(finalX, finalY);
                ctx.lineTo(inicioX + (finalX - inicioX)/2, finalY + 20);
                ctx.lineTo(inicioX, finalY);
                ctx.fill();
                ctx.closePath();
                ctx.stroke();
            };

            // Genera gráfica de rejillas y filtros
            var dibujarRejillaFiltro = function(inicioX, finalX, inicioY, finalY, ctx, color) {
                // Genera rejilla del tubo
                ctx.strokeStyle = "#000000";
                ctx.lineWidth = 0.5;
                //ctx.fillStyle = "#f5f5f5";
                ctx.fillStyle = color;
                ctx.fillRect(inicioX, inicioY, finalX - inicioX, finalY - inicioY);
                ctx.strokeRect(inicioX, inicioY, finalX - inicioX, finalY - inicioY);

                ctx.strokeStyle = "#000000";
                ctx.lineWidth = 1;
                ctx.setLineDash([0]);
                for (var i = inicioY + 5; i < finalY; i += 5) {
                    // Genera trazo de filtro
                    ctx.moveTo(inicioX, i);
                    ctx.lineTo(finalX, i);
                    ctx.stroke();
                }
            };

            // Genera gráfica de la escala de profundidad y escala de rejilla y filtros
            var dibujarEscala = function(config, ctx, datos, colores) {
                var inicioX = config.inicioX;
                var inicioY = config.inicioY;
                var finalY = config.alto - 25;
                var finalX = inicioX + (Math.round((finalY - inicioY)/10) * 2);
                var escalaZoomY = (finalY - inicioY)/100;
                var ancho = Math.round((finalY - inicioY)/10) * 2;
                var alto = finalY - inicioY;
                var separacionY = alto/10;
                var separacionProfundidadY = datos[0].profundidad/10;
                var escalaProfundidadY = datos[0].profundidad/100;

                // Genera escala gráfica
                var contador = 0;
                ctx.font = "normal 12px sans-serif";
                for (var i = inicioY; i <= finalY; i += separacionY) {
                    // Genera escala profundidad
                    ctx.beginPath();
                    ctx.fillStyle = "#000000";
                    //ctx.fillText(Math.round(contador*100)/100 + 'm', inicioX - 150, i - 3);
                    ctx.fillText(Math.round(contador) + 'm', inicioX - 150, i - 3);
                    contador += separacionProfundidadY;
                    ctx.beginPath();

                    // Genera trazo segmentado profundidad
                    ctx.strokeStyle = "#000000";
                    ctx.lineWidth = 0.5;
                    ctx.setLineDash([3]);
                    ctx.moveTo(inicioX - 150, i);
                    ctx.lineTo(inicioX, i);
                    ctx.stroke();
                }

                ctx.beginPath();
                ctx.font = "bold 13px sans-serif";
                ctx.fillStyle = "#000000";
                ctx.textAlign = "center";
                ctx.fillText("Ademe",inicioX + ((finalX - inicioX)/2), inicioY - 6); 

                ctx.beginPath();
                ctx.font = "bold 13px sans-serif";
                ctx.fillStyle = "#000000";
                ctx.textAlign = "start";
                ctx.fillText('Profundidad (m)', inicioX - 150, finalY + 19);

                // Genera escala gráfica de rejilla/filtro
                var distancia = 100;
                ctx.font = "normal 9px sans-serif";
                var limite = datos[0].rejillafiltro.length;
                var limiteColor = colores.length;
                var contadorColor = 0;
                for (var i = 0; i < limite; i++) {
                    if(i % 2 == 0) {
                        distancia = 50;
                    } else {
                        distancia = 100;
                    }

                    // Genera rejilla/filtro
                    dibujarRejillaFiltro(inicioX, finalX, inicioY + (datos[0].rejillafiltro[i].desde/escalaProfundidadY * escalaZoomY), inicioY + (datos[0].rejillafiltro[i].hasta/escalaProfundidadY * escalaZoomY), ctx, colores[contadorColor]);

                    if (contadorColor >= limiteColor - 1) {
                        contadorColor = 0;
                    } else {
                        contadorColor++;
                    }
                }
            };

            // Genera gráfica de título
            var dibujarTitulo = function(configLienzo, config, ctx, datos) {
                var escalaZoom = config.alto/100;
                var inicioX = config.inicioX;
                var finalX = inicioX + (config.ancho * escalaZoom);
                var inicioY = config.inicioY;
                var finalY = config.alto - 30;

                /*ctx.beginPath();
                ctx.strokeStyle = "#384ad7";
                ctx.lineWidth = 1;
                ctx.fillStyle = "#384ad7";
                ctx.setLineDash([0]);
                ctx.moveTo(0, 0);
                ctx.lineTo(configLienzo.ancho, 0);
                ctx.lineTo(configLienzo.ancho, inicioY - 25);
                ctx.lineTo(0, inicioY - 25);
                ctx.lineTo(0, 0);
                ctx.fill();
                ctx.closePath();
                ctx.stroke();*/

                // Genera título de la gráfica
                ctx.moveTo(configLienzo.ancho/2, 10);
                ctx.lineTo(configLienzo.ancho/2, 20);
                ctx.font = "bold 16px sans-serif";
                ctx.beginPath();
                ctx.fillStyle = "#000000";
                ctx.textAlign="center";
                ctx.fillText('DISEÑO DE CONSTRUCCIÓN DE POZO', configLienzo.ancho/2, 20);
                ctx.font = "normal 14px sans-serif";
                ctx.textAlign="center";
                ctx.beginPath();
                ctx.fillStyle = "#000000";
                ctx.fillText('Nombre: '+datos[0].nombre + '  Código: '+datos[0].codigo, configLienzo.ancho/2, 37);
            };

            var dibujarLeyendas = function(config, ctx, datos, colores) {
                var inicioX = config.inicioX;
                var inicioY = config.inicioY;
                var finalY = config.alto - 25;
                var finalX = inicioX + (Math.round((finalY - inicioY)/10) * 2);
                var escalaZoomY = (finalY - inicioY)/100;
                var ancho = Math.round((finalY - inicioY)/10) * 2;
                var alto = finalY - inicioY;
                var separacionY = alto/10;

                // Genera etiqueta rectángulo leyenda
                ctx.font = "bold 13px sans-serif";
                ctx.beginPath();
                ctx.fillStyle = "#000000";
                ctx.fillText('LEYENDA DE REJILLAS/FILTROS', finalX + 50, inicioY);
                ctx.font = "normal 13px sans-serif";
                ctx.fillText('Profundidad (desde - hasta)', finalX + 50, inicioY + 17);

                // Genera leyendas rectangulo de color y texto
                var limite = datos[0].rejillafiltro.length;
                var contadorColor = 0;
                var limiteColor = colores.length;
                var avanceX = 50;
                var contador = 30;
                for (var i = 0; i < limite; i++) {
                    // Genera leyenda rectángulo
                    ctx.beginPath();
                    ctx.fillStyle = colores[contadorColor];
                    ctx.fillRect(finalX + avanceX, inicioY + contador, 25, 15);
                    ctx.fill();
                    ctx.closePath();

                    // Genera leyenda texto
                    ctx.font = "normal 13px sans-serif";
                    ctx.beginPath();
                    ctx.fillStyle = "#000000";
                    ctx.fillText(datos[0].rejillafiltro[i].desde + 'm - ' + datos[0].rejillafiltro[i].hasta + 'm', finalX + 35 + avanceX, inicioY + contador + 12);
                    contador += 25;

                    if (contadorColor >= limiteColor - 1) {
                        contadorColor = 0;
                    } else {
                        contadorColor++;
                    }
                }
            };

            // Almacena datos de la BD
            var datos = {/literal}{$datosPozo}{literal};

            // Genera una lista de colores
            var colores = [
                '#880e4f',
                '#0d47a1',
                '#004d40',
                '#827717',
                '#f57f17',
                '#bf360c',
                '#a5a5a5'
            ];

            dibujarLienzo(configLienzo, lienzo);
            dibujarTubo(config, ctx);
            dibujarTitulo(configLienzo, config, ctx, datos);
            dibujarEscala(config, ctx, datos, colores);
            dibujarLeyendas(config, ctx, datos, colores);
        };
        
        var handle_get_components = function() {
            var configLienzo = {
                ancho: screen.width - (screen.width * 50)/100,
                alto: screen.height - (screen.height * 40)/100
            };

            var config = {
                escala: 100,
                inicioX: 170,
                inicioY: 70,
                ancho: 60,
                alto: configLienzo.alto
            };

            $('#contenedor_grafico_diseno').css('height', configLienzo.alto);

            btn_cerrar_grafica.click(function() {
                $('#modal_window_grafica_diseno').modal('hide');
                $('#modal_window_diseno').modal('show');
            });

            btn_zoom_min_grafica.click(function() {
                if (configLienzo.alto >= 461) {
                    configLienzo.alto = configLienzo.alto - 100;
                    config.alto = configLienzo.alto;
                    graficar_diseno(configLienzo, config);
                }
            });

            btn_zoom_max_grafica.click(function() {
                if (configLienzo.alto <= 1350) {
                    configLienzo.alto = configLienzo.alto + 100;
                    config.alto = configLienzo.alto;
                    graficar_diseno(configLienzo, config);
                }
            });

            graficar_diseno(configLienzo, config);
        };

        //== Public Functions
        return {
            // public functions
            init: function () {
                handle_get_components();
            }
        };
    } ();

    function GuardarGrafica(){
        Canvas2Image.saveAsPNG(lienzo, lienzo.width, lienzo.height, "RejillaFiltro");        
    }

    //== Class Initialization
    jQuery(document).ready(function () {
        snippet_grafica_diseno.init();
    });

</script>
{/literal}