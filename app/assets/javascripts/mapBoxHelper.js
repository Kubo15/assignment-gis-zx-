/**
 * Created by z on 9.11.2015.
 */
/**
 *
 * @param map - map box L.mapbox.map object;
 * @constructor
 */
var MapBoxHelper = function ( map ) {

    this._map = map;
    this._layers = {};
    this._layerNaming = 0;

    this.styles = {

        lineAll : {
            "line-color" : "red",
            "line-opacity": "0.5"
        },

        lineAllLayer : {
            "color": "#4F7380",
            "weight": 1.59,
            "opacity": 0.7
        }

    };

};

MapBoxHelper.prototype._getDefaultName = function (){

    return "__"+( this._layerNaming++ );
};

/**
 * @param layer
 * @param (optional) layerName
 */
MapBoxHelper.prototype.addLayer = function ( layer, layerName = this._getDefaultName() ) {

    layer.addTo( this._map );
    this._layers[ layerName ] = layer;

};

MapBoxHelper.prototype.removeAllLayers = function () {

    for( var l in this._layers ){

        this._map.removeLayer( this._layers[l] );
        delete this._layers[l];

    }

};

MapBoxHelper.prototype.removeLayerByName = function ( name ) {

    if ( this._layers[name] !== undefined ) {

        this._map.removeLayer(this._layers[name]);

    }

};