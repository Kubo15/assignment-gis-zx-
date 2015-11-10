$(document).ready(function() {






    var layers = [];


    L.mapbox.accessToken = 'pk.eyJ1IjoiengtIiwiYSI6ImNpZmk0a3V5YzAwdzR1ZWx5Zzl3cXI3encifQ.nzeOXnOV_lJ0zLeTrrAiYg';
    var map = L.mapbox.map('map', 'zx-.94807f7b')
        .setView(L.latLng(48.1366, 17.1172), 13);

    var formatter = new Formatter(),
        helper = new MapBoxHelper(map);

    $( "#menu" ).draggable();

    $("#menu-all").click(function() {
        $.ajax({url: "/routes/all"}).done(function (result) {
            addRoutes(result);
        });
    });

    $("#menu-points").click(function() {
        $.ajax({url: "/hist/all"}).done(function (result) {
            addPoints(result);
        });
    });

    $("#menu-clear").click(function() {

        helper.removeAllLayers();

    });



    function addRoutes(res){

        var s = [];

        for(var i = 0; i < res.length; i++ ){

            s.push(formatter.newFeature(res[i].data));

        }

        var lay = L.geoJson(s, { style: helper.styles.lineAllLayer });
        helper.addLayer(lay);

    };

    function addPoints(res){

        var geojson = [];
        for(var i = 0; i < res.length; i++) {

            var marker = formatter.newFeature(
                res[i].data,
                {
                    "title": res[i].name,


                    "marker-color": "#3ca0d3",
                    "marker-size": "small",
                    "marker-symbol": "camera"

                }
            );
            geojson.push(marker);
        }

        var layer = L.mapbox.featureLayer().setGeoJSON(geojson);

        helper.addLayer(layer);

    }

});