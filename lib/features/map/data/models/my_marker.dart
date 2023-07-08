import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/strings/enum_manager.dart';

class MyMarker {
  LatLng point;
  int? key;
  MyMarkerType type;
  dynamic item;

  ///Number of users pickup
  int nou;

  MyMarker({
    required this.point,
    this.key,
    this.item,
    this.nou = 0,
    this.type = MyMarkerType.location,
  });

  @override
  String toString() {
    return 'MyMarker{point: $point, key: $key, type: $type, nou: $nou}';
  }
}

class MyPolyLine {
  LatLng? endPoint;
  num? key;
  String encodedPolyLine;
  Color? color;

  MyPolyLine({
    this.endPoint,
    this.key,
    this.encodedPolyLine = '',
    this.color
  });
}
