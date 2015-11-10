/**
 * Created by z on 9.11.2015.
 */

var Formatter = function() {



};
/**
 * @param data - {string} from db
 * @param properties
 * @return {{type: string, geometry: *, properties: *}}
 */
Formatter.prototype.newFeature = function ( data, properties = {} ) {

    var geo = $.parseJSON( data );

    return {

        "type": "Feature",
        "geometry": geo,
        "properties": properties

    };

};