import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_map_example/utils/map_screen_mixin.dart';
import 'package:google_map_example/utils/map_style_json.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with MapScreenMixins {
  Completer<GoogleMapController> _controller = Completer();
  static double currentLat = 0.0;
  static double currentLong = 0.0;
  Set<Marker> _markers = {};
  BitmapDescriptor sourceMapMarkerIcon;
  BitmapDescriptor destinationMapMarkerIcon;
  @override
  void initState() {
    getPermission();
    setCustomMapPins();
    getCurrentLocation().then((value) {
      print("Location data => $value");
      setState(() {
        currentLat = value.latitude;
        currentLong = value.longitude;
      });
      _markers.add(
        Marker(
          markerId: MarkerId("source"),
          position: LatLng(value.latitude, value.longitude),
          icon: sourceMapMarkerIcon,
        ),
      );
      _markers.add(
        Marker(
          markerId: MarkerId("destination"),
          position: LatLng(12.11, 77.33),
          icon: destinationMapMarkerIcon,
        ),
      );
    });
    super.initState();
  }

  void setCustomMapPins() async {
    await getBytesFromAsset('assets/man_marker.png', 150).then((pic) {
      sourceMapMarkerIcon = BitmapDescriptor.fromBytes(pic);
    });
    await getBytesFromAsset('assets/car_marker.png', 150).then((pic) {
      destinationMapMarkerIcon = BitmapDescriptor.fromBytes(pic);
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(currentLat, currentLong),
    zoom: 10,
    tilt: 80,
    bearing: 30,
  );
  @override
  Widget build(BuildContext context) {
    return currentLat != 0.0
        ? GoogleMap(
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            compassEnabled: true,
            tiltGesturesEnabled: true,
            markers: _markers,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              controller.setMapStyle(mapJson);
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
