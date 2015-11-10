$(document).ready(function() {

    // SETUP
    L.mapbox.accessToken = 'pk.eyJ1IjoiengtIiwiYSI6ImNpZmk0a3V5YzAwdzR1ZWx5Zzl3cXI3encifQ.nzeOXnOV_lJ0zLeTrrAiYg';
    var map = L.mapbox.map('map', 'zx-.94807f7b')
        .setView(L.latLng(48.1366, 17.1172), 13);

    var formatter = new Formatter(),
        mapMelper = new MapBoxHelper(map),
        menuHelper = new MenuHelper( mapMelper, formatter );


    menuHelper.initMenu();
    // CALL BACKS

    map.on("click", function (e) {

        menuHelper.showLatLng( e.latlng );

    });





});