<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Prueba de conexión a GeoServer</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <link rel="apple-touch-icon" sizes="180x180" href="/favicon/apple-touch-icon.png">
    <link rel="icon" type="image/png" href="/favicon/favicon-32x32.png" sizes="32x32">
    <link rel="icon" type="image/png" href="/favicon/favicon-16x16.png" sizes="16x16">
    <link rel="manifest" href="/favicon/manifest.json">
    <link rel="mask-icon" href="/favicon/safari-pinned-tab.svg" color="#5bbad5">
    <style>
        @import url("https://fonts.googleapis.com/css?family=Dosis:300,400,700,800");

        /** Styles for the 403 Page **/

        .principal{

        }

        .particle-error,
        .permission_denied,
        #particles-js {
            width: 100%;
            height: 100%;
            margin: 0px !important;
        }

        #particles-js {
            position: fixed !important;
            opacity: 0.23;
        }

        .permission_denied {
            background: #24344c !important;
        }

        .permission_denied a {
            text-decoration: none;
        }

        .denied__wrapper {
            max-width: 390px;
            width: 100%;
            height: 390px;
            display: block;
            margin: 0 auto;
            position: relative;
            margin-top: 8vh;
        }

        .permission_denied h1 {
            text-align: center;
            color: #fff;
            font-family: "Dosis", sans-serif;
            font-size: 100px;
            margin-bottom: 0px;
            font-weight: 800;
        }

        .permission_denied h3 {
            text-align: center;
            color: #fff;
            font-size: 19px;
            line-height: 23px;
            max-width: 330px;
            margin: 0px auto 30px auto;
            font-family: "Dosis", sans-serif;
            font-weight: 400;
        }

        .permission_denied h3 span {
            position: relative;
            width: 65px;
            display: inline-block;
        }

        .permission_denied h3 span:after {
            content: "";
            border-bottom: 3px solid #ffbb39;
            position: absolute;
            left: 0;
            top: 43%;
            width: 100%;
        }

        .denied__link {
            background: none;
            color: #fff;
            padding: 12px 0px 10px 0px;
            border: 1px solid #fff;
            outline: none;
            border-radius: 7px;
            width: 150px;
            font-size: 15px;
            text-align: center;
            margin: 0 auto;
            vertical-align: middle;
            display: block;
            margin-bottom: 40px;
            margin-top: 25px;
            font-family: "Dosis", sans-serif;
            font-weight: 400;
        }

        .denied__link:hover {
            color: #ffbb39;
            border-color: #ffbb39;
            cursor: pointer;
            opacity: 1;
        }

        .permission_denied .stars {
            animation: sparkle 1.6s infinite ease-in-out alternate;
        }

        @keyframes sparkle {
            0% {
                opacity: 1;
            }
            100% {
                opacity: 0.3;
            }
        }

        #astronaut {
            width: 43px;
            position: absolute;
            right: 20px;
            top: 210px;
            animation: spin 4.5s infinite linear;
        }

        @keyframes spin {
            0% {
                transform: rotateZ(0deg);
            }
            100% {
                transform: rotateZ(360deg);
            }
        }

        @media (max-width: 600px) {
            .permission_denied h1 {
                font-size: 75px;
            }
            .permission_denied h3 {
                font-size: 16px;
                width: 200px;
                margin: 0 auto;
                line-height: 23px;
            }
            .permission_denied h3 span {
                width: 60px;
            }
            #astronaut {
                width: 35px;
                right: 40px;
                top: 170px;
            }
        }

        .saturn,
        .saturn-2,
        .hover {
            animation: hover 2s infinite ease-in-out alternate;
        }

        @keyframes hover {
            0% {
                transform: translateY(3px);
            }
            100% {
                transform: translateY(-3px);
            }
        }





        body{

        }
        body,td,table{

            font-family: "Dosis", arial;
            font-size: 14px;
            color: #404040;
        }

.nombre{
    background: #0CFF9C;
    padding-left: 20px;
    padding-right: 10px;
    border-bottom: 3px solid #ffbb39;
    font-weight: bold;
}
        .respuesta{
            background: #FFEE00;
            padding-left: 20;
        }
        .pregunta{
            color: #18005e;
            padding-left: 20px;
            padding-right: 10px;

            font-weight: bold;
            font-size: 15px;
        }

        #map {
            height: 400px;  /* The height is 400 pixels */
            width: 100%;  /* The width is the width of the web page */
        }

    </style>

</head>
<body >
<br><br>
<strong>Servidor</strong> http://geo.siarh.gob.bo/geoserver/geonode/wms?<br>
<strong>Layer</strong> geonode:clim<br>

<br><br>

<?PHP
if(isset($_GET["lat"])){
    $latitud = $_GET["lat"];
}else{
    $latitud = "-17.413977";
}

if(isset($_GET["lon"])){
    $longitud = $_GET["lon"];
}else{
    $longitud = "-66.165321";
}

//print_r($_GET);
?>
<form>
    <label class="pregunta">Latitud: <input type="text" value="<?PHP echo $latitud?>" name="lat"></label>
    <label class="pregunta">longitud: <input type="text" value="<?PHP echo $longitud?>" name="lon"></label>
    <input type="submit" value="Consultar Datos">
</form>

<div id="map"></div>
<script>
    // Initialize and add the map
    function initMap() {
        // The location of Uluru
        var uluru = {lat: <?PHP echo $latitud?>, lng: <?PHP echo $longitud?>};
        // The map, centered at Uluru
        var map = new google.maps.Map(
            document.getElementById('map'), {zoom: 14, center: uluru});
        // The marker, positioned at Uluru
        var marker = new google.maps.Marker({position: uluru, map: map});
    }
</script>

</script>


<script async defer
src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA1yluXnwTuci4HIU456tC7J8B3sa_ZSg0&callback=initMap">
</script>


<?PHP


require_once("./class.geoserverfeature.php");
$geoserver = new GeoserverFeature;
/**
 * Seteamos las configuraciónes antes de enviar los datos
 */
$server= "http://geo.siarh.gob.bo/geoserver/geonode/wms?";
$geoserver->set_server($server);;
$layer="geonode:clim";
$geoserver->set_parametro("QUERY_LAYERS",$layer);
$geoserver->set_parametro("LAYERS",$layer);
$geoserver->set_parametro("SRS","EPSG:4326");
$geoserver->set_parametro("INFO_FORMAT","application/json");

$data = $geoserver->get_data($latitud,$longitud);
//$data = $geoserver->get_data('-17.413977','-66.165321');

$datos = $data["features"][0]["properties"];


?>

<strong>Latitud</strong> <?PHP echo $latitud?><br>
<strong>Longitud</strong> <?PHP echo $longitud?><br>

<table>


<?PHP
foreach ( $datos as $nombre => $valor ) {
    echo "<tr>";
    echo "<td class='nombre'>".$nombre."</td>";
    echo "<td class='respuesta'>".$valor."</td>";
    echo "</tr>";
}
?>
    <table>
        <?PHP
echo "<pre>";
//print_r($data["features"][0]["properties"]);
//print_r($data);
echo "</pre>";



?>

</body>
</html>
