// To parse this JSON data, do
//
//     final directionApiResult = directionApiResultFromJson(jsonString);

import 'dart:convert';

bool validateMapKey(String key, Map map) {
  return map != null && map.containsKey('$key') && map[key] != null;
}

class DirectionApiResult {
  List<GeocodedWaypoint> geocodedWaypoints;
  List<Route> routes;
  String status;

  DirectionApiResult({
    this.geocodedWaypoints,
    this.routes,
    this.status,
  });

  factory DirectionApiResult.fromRawJson(String str) =>
      DirectionApiResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DirectionApiResult.fromJson(Map<String, dynamic> json) =>
      new DirectionApiResult(
        geocodedWaypoints: validateMapKey('geocoded_waypoints', json)
            ? new List<GeocodedWaypoint>.from(json['geocoded_waypoints']
                .map((x) => GeocodedWaypoint.fromJson(x)))
            : null,
        routes: validateMapKey('routes', json)
            ? new List<Route>.from(json['routes'].map((x) => Route.fromJson(x)))
            : null,
        status: validateMapKey('status', json) ? json['status'] : null,
      );

  Map<String, dynamic> toJson() => {
        'geocoded_waypoints': geocodedWaypoints == null
            ? null
            : new List<dynamic>.from(geocodedWaypoints.map((x) => x.toJson())),
        'routes': routes == null
            ? null
            : new List<dynamic>.from(routes.map((x) => x.toJson())),
        'status': status == null ? null : status,
      };
}

class GeocodedWaypoint {
  String geocoderStatus;
  String placeId;
  List<String> types;

  GeocodedWaypoint({
    this.geocoderStatus,
    this.placeId,
    this.types,
  });

  factory GeocodedWaypoint.fromRawJson(String str) =>
      GeocodedWaypoint.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeocodedWaypoint.fromJson(Map<String, dynamic> json) =>
      new GeocodedWaypoint(
        geocoderStatus: validateMapKey('geocoder_status', json)
            ? json['geocoder_status']
            : null,
        placeId: validateMapKey('place_id', json) ? json['place_id'] : null,
        types: validateMapKey('types', json)
            ? new List<String>.from(json['types'].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'geocoder_status': geocoderStatus == null ? null : geocoderStatus,
        'place_id': placeId == null ? null : placeId,
        'types':
            types == null ? null : new List<dynamic>.from(types.map((x) => x)),
      };
}

class Route {
  Bounds bounds;
  String copyrights;
  List<Leg> legs;
  PolylineData overviewPolyline;
  String summary;
  List<dynamic> warnings;
  List<dynamic> waypointOrder;

  Route({
    this.bounds,
    this.copyrights,
    this.legs,
    this.overviewPolyline,
    this.summary,
    this.warnings,
    this.waypointOrder,
  });

  factory Route.fromRawJson(String str) => Route.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Route.fromJson(Map<String, dynamic> json) => new Route(
        bounds: validateMapKey('bounds', json)
            ? Bounds.fromJson(json['bounds'])
            : null,
        copyrights:
            validateMapKey('copyrights', json) ? json['copyrights'] : null,
        legs: validateMapKey('legs', json)
            ? new List<Leg>.from(json['legs'].map((x) => Leg.fromJson(x)))
            : null,
        overviewPolyline: validateMapKey('overview_polyline', json)
            ? PolylineData.fromJson(json['overview_polyline'])
            : null,
        summary: validateMapKey('summary', json) ? json['summary'] : null,
        warnings: validateMapKey('warnings', json)
            ? new List<dynamic>.from(json['warnings'].map((x) => x))
            : null,
        waypointOrder: validateMapKey('waypoint_order', json)
            ? new List<dynamic>.from(json['waypoint_order'].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'bounds': bounds == null ? null : bounds.toJson(),
        'copyrights': copyrights == null ? null : copyrights,
        'legs': legs == null
            ? null
            : new List<dynamic>.from(legs.map((x) => x.toJson())),
        'overview_polyline':
            overviewPolyline == null ? null : overviewPolyline.toJson(),
        'summary': summary == null ? null : summary,
        'warnings': warnings == null
            ? null
            : new List<dynamic>.from(warnings.map((x) => x)),
        'waypoint_order': waypointOrder == null
            ? null
            : new List<dynamic>.from(waypointOrder.map((x) => x)),
      };
}

class Bounds {
  Northeast northeast;
  Northeast southwest;

  Bounds({
    this.northeast,
    this.southwest,
  });

  factory Bounds.fromRawJson(String str) => Bounds.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bounds.fromJson(Map<String, dynamic> json) => new Bounds(
        northeast: validateMapKey('northeast', json)
            ? Northeast.fromJson(json['northeast'])
            : null,
        southwest: validateMapKey('southwest', json)
            ? Northeast.fromJson(json['southwest'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'northeast': northeast == null ? null : northeast.toJson(),
        'southwest': southwest == null ? null : southwest.toJson(),
      };
}

class Northeast {
  double lat;
  double lng;

  Northeast({
    this.lat,
    this.lng,
  });

  factory Northeast.fromRawJson(String str) =>
      Northeast.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Northeast.fromJson(Map<String, dynamic> json) => new Northeast(
        lat: validateMapKey('lat', json) ? json['lat'].toDouble() : null,
        lng: validateMapKey('lng', json) ? json['lng'].toDouble() : null,
      );

  Map<String, dynamic> toJson() => {
        'lat': lat == null ? null : lat,
        'lng': lng == null ? null : lng,
      };
}

class Leg {
  Distance distance;
  Distance duration;
  String endAddress;
  Northeast endLocation;
  String startAddress;
  Northeast startLocation;
  List<Step> steps;
  List<dynamic> trafficSpeedEntry;
  List<dynamic> viaWaypoint;

  Leg({
    this.distance,
    this.duration,
    this.endAddress,
    this.endLocation,
    this.startAddress,
    this.startLocation,
    this.steps,
    this.trafficSpeedEntry,
    this.viaWaypoint,
  });

  factory Leg.fromRawJson(String str) => Leg.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Leg.fromJson(Map<String, dynamic> json) => new Leg(
        distance: validateMapKey('distance', json)
            ? Distance.fromJson(json['distance'])
            : null,
        duration: validateMapKey('duration', json)
            ? Distance.fromJson(json['duration'])
            : null,
        endAddress:
            validateMapKey('end_address', json) ? json['end_address'] : null,
        endLocation: validateMapKey('end_location', json)
            ? Northeast.fromJson(json['end_location'])
            : null,
        startAddress: validateMapKey('start_address', json)
            ? json['start_address']
            : null,
        startLocation: json['start_location'] == null
            ? Northeast.fromJson(json['start_location'])
            : null,
        steps: validateMapKey('steps', json)
            ? new List<Step>.from(json['steps'].map((x) => Step.fromJson(x)))
            : null,
        trafficSpeedEntry: validateMapKey('traffic_speed_entry', json)
            ? new List<dynamic>.from(json['traffic_speed_entry'].map((x) => x))
            : null,
        viaWaypoint: validateMapKey('via_waypoint', json)
            ? new List<dynamic>.from(json['via_waypoint'].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'distance': distance == null ? null : distance.toJson(),
        'duration': duration == null ? null : duration.toJson(),
        'end_address': endAddress == null ? null : endAddress,
        'end_location': endLocation == null ? null : endLocation.toJson(),
        'start_address': startAddress == null ? null : startAddress,
        'start_location': startLocation == null ? null : startLocation.toJson(),
        'steps': steps == null
            ? null
            : new List<dynamic>.from(steps.map((x) => x.toJson())),
        'traffic_speed_entry': trafficSpeedEntry == null
            ? null
            : new List<dynamic>.from(trafficSpeedEntry.map((x) => x)),
        'via_waypoint': viaWaypoint == null
            ? null
            : new List<dynamic>.from(viaWaypoint.map((x) => x)),
      };
}

class Distance {
  String text;
  int value;

  Distance({
    this.text,
    this.value,
  });

  factory Distance.fromRawJson(String str) =>
      Distance.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Distance.fromJson(Map<String, dynamic> json) => new Distance(
      text: validateMapKey('text', json) ? json['text'] : null,
      value: validateMapKey('value', json) ? json['value'] : null);

  Map<String, dynamic> toJson() => {
        'text': text == null ? null : text,
        'value': value == null ? null : value,
      };
}

class Step {
  Distance distance;
  Distance duration;
  Northeast endLocation;
  String htmlInstructions;
  PolylineData polyline;
  Northeast startLocation;
  TravelMode travelMode;
  String maneuver;

  Step({
    this.distance,
    this.duration,
    this.endLocation,
    this.htmlInstructions,
    this.polyline,
    this.startLocation,
    this.travelMode,
    this.maneuver,
  });

  factory Step.fromRawJson(String str) => Step.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Step.fromJson(Map<String, dynamic> json) => new Step(
        distance: validateMapKey('distance', json)
            ? Distance.fromJson(json['distance'])
            : null,
        duration: validateMapKey('duration', json)
            ? Distance.fromJson(json['duration'])
            : null,
        endLocation: validateMapKey('end_location', json)
            ? Northeast.fromJson(json['end_location'])
            : null,
        htmlInstructions: validateMapKey('html_instructions', json)
            ? json['html_instructions']
            : null,
        polyline: validateMapKey('polyline', json)
            ? PolylineData.fromJson(json['polyline'])
            : null,
        startLocation: validateMapKey('start_location', json)
            ? Northeast.fromJson(json['start_location'])
            : null,
        travelMode: validateMapKey('travel_mode', json)
            ? travelModeValues.map[json['travel_mode']]
            : null,
        maneuver: validateMapKey('maneuver', json) ? json['maneuver'] : null,
      );

  Map<String, dynamic> toJson() => {
        'distance': distance == null ? null : distance.toJson(),
        'duration': duration == null ? null : duration.toJson(),
        'end_location': endLocation == null ? null : endLocation.toJson(),
        'html_instructions': htmlInstructions == null ? null : htmlInstructions,
        'polyline': polyline == null ? null : polyline.toJson(),
        'start_location': startLocation == null ? null : startLocation.toJson(),
        'travel_mode':
            travelMode == null ? null : travelModeValues.reverse[travelMode],
        'maneuver': maneuver == null ? null : maneuver,
      };
}

class PolylineData {
  String points;

  PolylineData({
    this.points,
  });

  factory PolylineData.fromRawJson(String str) =>
      PolylineData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PolylineData.fromJson(Map<String, dynamic> json) => new PolylineData(
        points: validateMapKey('points', json) ? json['points'] : null,
      );

  Map<String, dynamic> toJson() => {
        'points': points == null ? null : points,
      };
}

enum TravelMode { DRIVING }

final travelModeValues = new EnumValues({'DRIVING': TravelMode.DRIVING});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
