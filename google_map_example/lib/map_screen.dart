import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_map_example/utils/decode_polylines.dart';
import 'package:google_map_example/utils/directional_api_data.dart';
import 'package:google_map_example/utils/directional_api_serializer.dart';
import 'package:google_map_example/utils/map_screen_mixin.dart';
import 'package:google_map_example/utils/map_style_json.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with MapScreenMixins {
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  static double currentLat = 0.0;
  static double currentLong = 0.0;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  BitmapDescriptor sourceMapMarkerIcon;
  BitmapDescriptor destinationMapMarkerIcon;
  DirectionApiResult directionApiResult;
  GetDirectionalApiData _getDirectionalApiData = GetDirectionalApiData();
  bool isDataAvailable = false;
  bool isCameraIdle = false;
  @override
  void initState() {
    getPermission();
    setCustomMapPins();
    getMapData();
    super.initState();
  }

  getMapData() {
    getCurrentLocation().then((value) async {
      print("Location data => $value");
      currentLat = value.latitude;
      currentLong = value.longitude;
      directionApiResult = await _getDirectionalApiData.fetch(
          LatLng(currentLat, currentLong), LatLng(12.11, 77.33));
      print(directionApiResult);
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
      _polylines.add(Polyline(
        polylineId: PolylineId("polyValue"),
        color: Colors.blue,
        width: 5,
        consumeTapEvents: true,
        onTap: () {},
        points: decodePolyline(
            directionApiResult.routes[0].overviewPolyline.points.toString()),
      ));

      setState(() {
        isDataAvailable = true;
      });
    });
  }

  checkUpdate(CameraUpdate cameraUpdate, GoogleMapController c) async {
    c.animateCamera(cameraUpdate);
    mapController.animateCamera(cameraUpdate);
    LatLngBounds boundStart = await c.getVisibleRegion();
    LatLngBounds boundEnd = await c.getVisibleRegion();
    if (boundStart.southwest.latitude == -90 ||
        boundEnd.southwest.latitude == -90) {
      checkUpdate(cameraUpdate, c);
    }
  }

  boundMap(LatLng south, LatLng north) async {
    LatLngBounds bound = LatLngBounds(southwest: south, northeast: north);
    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bound, 50);
    this.mapController.animateCamera(cameraUpdate).then((void v) {
      checkUpdate(cameraUpdate, this.mapController);
    });
    setState(() {
      isCameraIdle = true;
    });
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
    zoom: 11,
    tilt: 80,
    bearing: 30,
  );
  @override
  Widget build(BuildContext context) {
    return isDataAvailable
        ? GoogleMap(
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            compassEnabled: true,
            tiltGesturesEnabled: true,
            markers: _markers,
            polylines: _polylines,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              _controller.complete(controller);
              controller.setMapStyle(mapJson);
            },
            onCameraIdle: isCameraIdle
                ? () {}
                : () {
                    boundMap(
                      LatLng(directionApiResult.routes[0].bounds.southwest.lat,
                          directionApiResult.routes[0].bounds.southwest.lng),
                      LatLng(directionApiResult.routes[0].bounds.northeast.lat,
                          directionApiResult.routes[0].bounds.northeast.lng),
                    );
                  },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
