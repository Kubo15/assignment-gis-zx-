$(document).ready(function() {



    L.mapbox.accessToken = 'pk.eyJ1IjoiengtIiwiYSI6ImNpZmk0a3V5YzAwdzR1ZWx5Zzl3cXI3encifQ.nzeOXnOV_lJ0zLeTrrAiYg';
    var map = L.mapbox.map('map', 'zx-.94807f7b')
        .setView(L.latLng(48.1366, 17.1172), 13);
    var routesLayer;

    $( "#menu" ).draggable();

    $("#menu-all").click(function() {
        $.ajax({url: "/routes/all"}).done(function (result) {

            console.log('all routes');
            console.log(result);

            addResults(result,{"line-color" : "red"});

        });
    });



    function addResults(res,prop){

        var s = [];

        for(var i = 0; i < res.length; i++ ){

            var geo = $.parseJSON( res[i].data );

            s.push({

                "type": "Feature",
                "geometry": geo,
                "properties":  prop

            });

        }


        L.geoJson(s, { style: L.mapbox.simplestyle.style }).addTo(map);

        //var layer = L.mapbox.featureLayer().addTo(map);
        //var myArray= [
        //    {
        //        "latitude": -77.03238901390978,
        //        "longitude": 38.913188059745586
        //    },
        //    {
        //        "latitude": -122.414,
        //        "longitude": 37.776
        //    }
        //];
        //var geojson = [];
        //for(var i = 0; i < myArray.length; i++) {
        //
        //    var marker = {
        //        "type": "Feature",
        //        "geometry": {
        //            "type": "Point",
        //            "coordinates": [
        //                myArray[i].latitude,
        //                myArray[i].longitude
        //            ]
        //        },
        //        "properties": {
        //            "title": "Mapbox DC",
        //            "description": "1714 14th St NW, Washington DC",
        //            "marker-color": "#fc4353",
        //            "marker-size": "large",
        //            "marker-symbol": "monument"
        //        }
        //    }
        //    geojson.push(marker);
        //}
        //
        //layer.setGeoJSON(geojson);
        //layer.on('ready', function() {
        //    map.fitBounds(layer.getBounds());
        //});

    };

});