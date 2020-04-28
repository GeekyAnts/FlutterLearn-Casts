import 'package:google_maps_flutter/google_maps_flutter.dart';

List<LatLng> decodePolyline(String encodedPolyline) {
  final List<LatLng> poly = <LatLng>[];
  final int len = encodedPolyline.length;
  int index = 0;
  int lat = 0;
  int lng = 0;
  while (index < len) {
    int i, shift = 0, result = 0;
    do {
      i = encodedPolyline.codeUnits[index++] - 63;
      result |= (i & 0x1f) << shift;
      shift += 5;
    } while (i >= 0x20);
    final int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
    lat += dlat;
    shift = 0;
    result = 0;
    do {
      i = encodedPolyline.codeUnits[index++] - 63;
      result |= (i & 0x1f) << shift;
      shift += 5;
    } while (i >= 0x20);
    final int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
    lng += dlng;
    final LatLng p = new LatLng(lat / 1E5, lng / 1E5);
    poly.add(p);
  }

  return poly;
}
