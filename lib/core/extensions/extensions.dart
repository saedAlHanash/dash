import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:map_package/map/data/models/my_marker.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';

import '../strings/app_string_manager.dart';
import '../util/shared_preferences.dart';

extension CubitStateHelper1 on CubitStatuses {
  bool get loading => this == CubitStatuses.loading;

  bool get done => this == CubitStatuses.done;

  bool get error => this == CubitStatuses.error;

  bool get init => this == CubitStatuses.init;
}

extension MapResponse on http.Response {
  dynamic get jsonBody => jsonDecode(body);
}

extension NormalTripMap on TripResult {
  List<MyMarker> get getMarkers {
    return [
      MyMarker(point: startPoint, type: MyMarkerType.sharedPint),
      MyMarker(point: endPoint, type: MyMarkerType.sharedPint),
    ];
  }

  LatLng get startPoint => currentLocation.latLng;

  LatLng get endPoint => destination.latLng;

  String get getTripsCost {
    return '$tripFare ${AppStringManager.currency}';
  }

  String get getCost {
    return '${tripFare - paidAmount} ${AppStringManager.currency}';
  }

  String get getDistance {
    return ' $distance ${AppStringManager.km}';
  }

  String get getRealDistance {
    if (realDistance == 0) return '-';
    return ' $realDistance ${AppStringManager.km}';
  }

  String get getPreAcceptDistance {
    if (preAcceptDistance == 0) return '-';
    return ' $preAcceptDistance ${AppStringManager.km}';
  }

  bool get iamDriver {
    return (driver.id == 0) || (driver.id == AppSharedPreference.getMyId);
  }
}
