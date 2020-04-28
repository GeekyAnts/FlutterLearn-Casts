import 'package:google_map_example/services/api_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'directional_api_serializer.dart';

class GetDirectionalApiData {
  ApiService _apiService = ApiService();
  String apiKey = "apiKey";
  fetch(LatLng source, LatLng destination) async {
    var result = await _apiService.getRequest(
        "https://maps.googleapis.com/maps/api/directions/json?origin=${source.latitude},${source.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey");
    print(result);
    return DirectionApiResult.fromJson(result);
  }
}
