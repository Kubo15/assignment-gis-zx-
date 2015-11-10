/**
 * Created by z on 10.11.2015.
 */
var MenuHelper = function ( mapHelper, formatter ) {

    this._mapHelper = mapHelper;
    this._formatter = formatter;
    this._lastLatLng = undefined;

};

MenuHelper.prototype.initMenu = function () {

    var menuHelper = this;

    $( "#menu" ).draggable();

    $("#menu-all").click(function() {

        $.ajax({url: "/routes/all"})
            .done(function (result) {
                menuHelper.addRoutes(result);
            });
    });

    $("#menu-points").click(function() {

        $.ajax({url: "/hist/all"})
            .done(function (result) {
                menuHelper.addPoints(result);
            });

    });

    $("#menu-clear").click(function() {

        this._mapHelper.removeAllLayers();

    }.bind(this));

    $("#menu-near").click(function(){

        menuHelper.postLatLng();

    });


};

MenuHelper.prototype.addRoutes = function (res, style = this._mapHelper.styles.lineAllLayer) {

    var s = [];

    for(var i = 0; i < res.length; i++ ){

        s.push(this._formatter.newFeature(res[i].data));

    }

    var lay = L.geoJson(s, { style: style  });
    this._mapHelper.addLayer(lay);

};

MenuHelper.prototype.addPoints = function (res) {

    var geojson = [];
    for(var i = 0; i < res.length; i++) {

        var marker = this._formatter.newFeature(
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

    this._mapHelper.addLayer(layer);

};

MenuHelper.prototype.showLatLng = function ( latlng ) {

    $('#menu-click span')[0].innerHTML = latlng.lat;
    $('#menu-click span')[1].innerHTML = latlng.lng;

    this._mapHelper.removeLayerByName( "lastClick" );

    var layer = L.mapbox.featureLayer({
        // this feature is in the GeoJSON format: see geojson.org
        // for the full specification
        type: 'Feature',
        geometry: {
            type: 'Point',
            // coordinates here are in longitude, latitude order because
            // x, y is the standard for GeoJSON and many formats
            coordinates: [
                latlng.lng,
                latlng.lat
            ]
        },
        properties: {
            title: 'Last Click',
            'marker-size': 'small',
            'marker-color': '#BE9A6B',
            'marker-symbol': 'marker-stroked'
        }
    });

    this._lastLatLng = latlng;

    this._mapHelper.addLayer( layer, "lastClick" );

};


MenuHelper.prototype.postLatLng = function (latLng = this._lastLatLng) {

    if( latLng !== undefined ) {

        $.ajax({

            url: "routes/near",
            method: "post",
            data: {
                position: { lat: latLng.lat, long: latLng.lng, dist: 150 }
            }

        }).done(

            function ( res ) {

                this.addRoutes(res, this._mapHelper.styles.lineRedLayer );

            }.bind(this)

        );

    }
};