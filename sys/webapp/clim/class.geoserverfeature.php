<?php
class GeoserverFeature
{
    var $parametro;
    var $server;
    var $distance;
    var $radius;
    function __construct()
    {
        /**
         * Configuración de parametros
         */
        $parametro = array();
        $parametro["SERVICE"]="WMS";
        $parametro["VERSION"]="1.1.1";
        $parametro["REQUEST"]="GetFeatureInfo";
        $parametro["FORMAT"]="image/jpeg";
        $parametro["TRANSPARENT"]="true";
        $parametro["QUERY_LAYERS"]="geonode:clim";
        $parametro["STYLES"]="";
        $parametro["LAYERS"]="geonode:clim";
        $parametro["INFO_FORMAT"]="application/json";
        $parametro["FEATURE_COUNT"]="50";
        $parametro["X"]="50";
        $parametro["Y"]="50";
        $parametro["SRS"]="EPSG:4326";
        $parametro["WIDTH"]="101";
        $parametro["HEIGHT"]="101";
        $parametro["BBOX"]="";

        $this->parametro=$parametro;
        $this->server = "http://geo.siarh.gob.bo/geoserver/geonode/wms?";

        $this->radius = 3963.1;
        $this->distance = 1;
    }

    function get_data($lat,$lon){
        $bbox = $this->get_bounding_box($lat,$lon,$this->distance);
        /*
        echo "<pre>";
        print_r($bbox);
        echo "</pre>";
        */

        if(is_array($bbox)){
            $bbox_data= $bbox[2].','.$bbox[0].','.$bbox[3].','.$bbox[1];
        }else{
            $bbox_data="-65.10498046875,-19.083251953125,-62.8857421875,-16.864013671875";

        }
        $this->set_parametro("BBOX",$bbox_data);

        /*
        echo "<pre>";
        print_r($this->parametro);
        echo "</pre>";
        */

        $url = $this->get_query();

        $json = file_get_contents($url);
        $json = json_decode($json,TRUE);
        $res = $json;
        return $res;


    }

    function set_parametro($parametro,$str){
        $this->parametro[$parametro] = $str;
    }
    function set_distance($data){
        $this->distance = $data;
    }
    function set_radius($data){
        $this->radius = $data;
    }
    function set_server($server){
        $this->server = $server;
    }
    function get_query(){
        $query = http_build_query($this->parametro);
        $res = $this->server.$query;
        return $res;
    }

    function get_bounding_box($lat_degrees,$lon_degrees,$distance_in_miles){
        $radius = 3963.1; // of earth in miles
        // bearings - FIX
        $due_north = deg2rad(0);
        $due_south = deg2rad(180);
        $due_east = deg2rad(90);
        $due_west = deg2rad(270);

        // convert latitude and longitude into radians
        $lat_r = deg2rad($lat_degrees);
        $lon_r = deg2rad($lon_degrees);

        // find the northmost, southmost, eastmost and westmost corners $distance_in_miles away
        // original formula from
        // http://www.movable-type.co.uk/scripts/latlong.html

        $northmost  = asin(sin($lat_r) * cos($distance_in_miles/$radius) + cos($lat_r) * sin ($distance_in_miles/$radius) * cos($due_north));
        $southmost  = asin(sin($lat_r) * cos($distance_in_miles/$radius) + cos($lat_r) * sin ($distance_in_miles/$radius) * cos($due_south));

        $eastmost = $lon_r + atan2(sin($due_east)*sin($distance_in_miles/$radius)*cos($lat_r),cos($distance_in_miles/$radius)-sin($lat_r)*sin($lat_r));
        $westmost = $lon_r + atan2(sin($due_west)*sin($distance_in_miles/$radius)*cos($lat_r),cos($distance_in_miles/$radius)-sin($lat_r)*sin($lat_r));


        $northmost = rad2deg($northmost);
        $southmost = rad2deg($southmost);
        $eastmost = rad2deg($eastmost);
        $westmost = rad2deg($westmost);

        // sort the lat and long so that we can use them for a between query
        if ($northmost > $southmost) {
            $lat1 = $southmost;
            $lat2 = $northmost;

        } else {
            $lat1 = $northmost;
            $lat2 = $southmost;
        }


        if ($eastmost > $westmost) {
            $lon1 = $westmost;
            $lon2 = $eastmost;

        } else {
            $lon1 = $eastmost;
            $lon2 = $westmost;
        }

        $res =  array($lat1,$lat2,$lon1,$lon2);

        return $res;
    }


}