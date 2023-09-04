import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pvt_v1/screens/Map_screen.dart';

// Colors that we use in our app
const kPrimaryColor = Color(0xFF2ACAEA);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);
//const kBackgroundColor = Color(0xFFF9F8FD);
//const kPrimaryColor = Color(0xFF0C9869);
// const kTextColor = Color(0xFF3C4046);
const double kDefaultPadding = 20.0;


/*

Set<Marker> _markers = {};



// Set<Polygon> _polygons = {

// };

// List<LatLng> polygonList = <LatLng>[];
// int _polygonIdCounter = 1;


Set<Marker> getMarkers(){
  print("MARKERS: ");
  print(_markers);
  return _markers;
}


void addMarker(double longitude, double latitude, String id){
  var latlong= LatLng(latitude, longitude);
  _markers.add(
    Marker(
    markerId: MarkerId(id),
    position: latlong,
      infoWindow: InfoWindow(
        title: id,
        snippet: "Press for directions",
          onTap: (){

            var target = LatLng(latitude, longitude);
            getDirections(target);

          }
      ),
    ));

}


 */
