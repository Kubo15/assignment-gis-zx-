$(document).ready(function() {

    var styles = {

        lineAll : {
            "line-color" : "red",
            "line-opacity": "0.5"
        },

        lineAllLayer : {
            "color": "#00a9a9",
            "weight": 1.59,
            "opacity": 0.7
        }

    };

    var layers = [];


    L.mapbox.accessToken = 'pk.eyJ1IjoiengtIiwiYSI6ImNpZmk0a3V5YzAwdzR1ZWx5Zzl3cXI3encifQ.nzeOXnOV_lJ0zLeTrrAiYg';
    var map = L.mapbox.map('map', 'zx-.94807f7b')
        .setView(L.latLng(48.1366, 17.1172), 13);
    var routesLayer;

    $( "#menu" ).draggable();

    $("#menu-all").click(function() {
        $.ajax({url: "/routes/all"}).done(function (result) {

            console.log('all routes');
            console.log(result);

            addResults(result);

        });
    });

    $("#menu-points").click(function() {
        $.ajax({url: "/hist/all"}).done(function (result) {

            console.log('all hist');
            console.log(result);

            addPoints(result);

        });
    });

    $("#menu-clear").click(function() {

        for(var i = 0; i< layers.length; i++){

            map.removeLayer(layers[i]);

        }

    });



    function addResults(res){

        var s = [];

        for(var i = 0; i < res.length; i++ ){

            var geo = $.parseJSON( res[i].data );

            s.push({

                "type": "Feature",
                "geometry": geo

            });

        }


        var lay = L.geoJson(s, { style: styles.lineAllLayer });
        lay.addTo(map);

        layers.push(lay);

    };

    function addPoints(res){

        var layer = L.mapbox.featureLayer().addTo(map);

        var geojson = [];
        for(var i = 0; i < res.length; i++) {

            var marker = {
                "type": "Feature",
                "geometry": $.parseJSON( res[i].data ),

                "properties": {
                    "title": res[i].name,
                    "marker-color": "#ff00ff",
                    "marker-size": "small",
                    "marker-symbol": "embassy"
                }
            }
            geojson.push(marker);
        }

        layer.setGeoJSON(geojson);

        layers.push(layer);


    }

});