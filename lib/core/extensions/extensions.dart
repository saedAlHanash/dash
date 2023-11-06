import 'dart:convert';

import 'package:http/http.dart' as http;
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
  dynamic get json => jsonDecode(body);
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