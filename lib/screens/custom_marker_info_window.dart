import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({ Key? key }) : super(key: key);

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  
  CustomInfoWindowController _customInfoWindowController = 
  CustomInfoWindowController();
  
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latLang = [
    LatLng(33.6941, 72.9734),LatLng(33.7008, 72.9682), LatLng(33.6992, 72.9744),
    LatLng(33.6939, 72.9771), LatLng(33.6910, 72.9887), LatLng(33.7036, 72.9785)
  ];

  @override
    void initState() {
      // TODO: implement initState
      super.initState();

      loadData();
    }

  loadData(){
    for(int i = 0; i < _latLang.length; i++){
      _markers.add(
        Marker(markerId: MarkerId(i.toString()), 
          icon: BitmapDescriptor.defaultMarker,
          position: _latLang[i],
          onTap: (){
            _customInfoWindowController.addInfoWindow!(
              Container(
                height: 75,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('hej'),
                  ],
                ),
              ),
              _latLang[i]
            );
          }
        ),
      );
    }

  }

  // Nedan ska inte vara med i vårt program
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Info Window Example'),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(33.6941, 72.9734),
              zoom: 15,
            ),
            markers: Set<Marker>.of(_markers),
            onTap: (position){
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position){
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller){
              _customInfoWindowController.googleMapController =controller;
            }
          ),
          CustomInfoWindow(
              controller: _customInfoWindowController,
            height: 80,
            width: 150,
            offset: 35,
          ),
        ],
      )
    );
  }
}