import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:map_package/map/data/response/ather_response.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/home/data/response/drivers_imei_response.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';

import '../strings/app_string_manager.dart';

extension CubitStateHelper1 on CubitStatuses {
  bool get loading => this == CubitStatuses.loading;

  bool get done => this == CubitStatuses.done;

  bool get error => this == CubitStatuses.error;

  bool get init => this == CubitStatuses.init;
}

extension MapResponse on http.Response {
  dynamic get json => jsonDecode(utf8.decode(bodyBytes));
}

extension NormalTripMap on Trip {
  String get getPreAcceptDistance {
    if (preAcceptDistance == 0) return '-';
    return ' $preAcceptDistance ${AppStringManager.km}';
  }
}

List<List<T>> groupingList<T>(int size, List<T> list) {
  final List<List<T>> result = [];
  for (int i = 0; i < list.length; i += size) {
    result.add(list.sublist(i, i + size > list.length ? list.length : i + size));
  }
  return result;
}

// Function to get the top 10 nearest LatLng points from a start location
List<Ime> getNearestPoints(LatLng startLocation, List<Ime> points) {
  // Sort the points based on their distance from the start location
  points.sort((a, b) {

    final  distanceToA = Geolocator.distanceBetween(
      startLocation.latitude,
      startLocation.longitude,
      a.lat,
      a.lng,
    );

    final  distanceToB = Geolocator.distanceBetween(
      startLocation.latitude,
      startLocation.longitude,
      b.lat,
      b.lng,
    );

    return distanceToA.compareTo(distanceToB);
  });

  // Return the top 10 nearest points
  return points.take(10).toList();
}



