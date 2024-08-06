import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:map_package/map/data/response/ather_response.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';

import '../../services/caching_service/caching_service.dart';
import '../error/error_manager.dart';
import '../strings/app_string_manager.dart';
import '../strings/enum_manager.dart';
import '../util/pair_class.dart';

extension CubitStateHelper1 on CubitStatuses {
  bool get loading => this == CubitStatuses.loading;

  bool get done => this == CubitStatuses.done;

  bool get error => this == CubitStatuses.error;

  bool get init => this == CubitStatuses.init;
}

extension MapResponse on http.Response {
  dynamic get json => jsonDecode(utf8.decode(bodyBytes));

  bool get success => (statusCode >= 200 && statusCode <= 210);

  get getPairError {
    return Pair(null, ErrorManager.getApiError(this));
  }
}

extension NormalTripMap on Trip {
  String get getPreAcceptDistance {
    if (preAcceptDistance == 0) return '-';
    return ' $preAcceptDistance ${AppStringManager.km}';
  }
}

extension NumH on num {
  int getLengthForList({int count = 3}) {
    return ((this + count) % count) > 0 ? (this ~/ count) + 1 : this ~/ count;
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
    final distanceToA = Geolocator.distanceBetween(
      startLocation.latitude,
      startLocation.longitude,
      a.lat,
      a.lng,
    );

    final distanceToB = Geolocator.distanceBetween(
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

extension NeedUpdateEnumH on NeedUpdateEnum {
  bool get loading => this == NeedUpdateEnum.withLoading;

  bool get haveData =>
      this == NeedUpdateEnum.no || this == NeedUpdateEnum.noLoading;

  CubitStatuses get getState {
    switch (this) {
      case NeedUpdateEnum.no:
        return CubitStatuses.done;
      case NeedUpdateEnum.withLoading:
        return CubitStatuses.loading;
      case NeedUpdateEnum.noLoading:
        return CubitStatuses.done;
    }
  }
}
