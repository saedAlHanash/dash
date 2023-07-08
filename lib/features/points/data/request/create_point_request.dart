
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:qareeb_dash/features/points/data/response/points_response.dart';

import '../../../../core/util/note_message.dart';

class CreatePointRequest {
  CreatePointRequest({
    this.id,
    this.name,
    this.arName,
    this.lng,
    this.lat,
    this.tags,
  });

  int? id;
  String? name;
  String? arName;
  double? lng;
  double? lat;
  String? tags;

  LatLng? get getLatLng => lat == null ? null : LatLng(lat!, lng!);

  factory CreatePointRequest.fromJson(Map<String, dynamic> json) {
    return CreatePointRequest(
      name: json["name"] ?? "",
      arName: json["arName"] ?? "",
      lng: json["latitude"] ?? 0,
      lat: json["langitude"] ?? 0,
      tags: json["tags"] ?? "",
      id: json["id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "arName": arName,
        "latitude": lat,
        "langitude": lng,
        "tags": tags,
      };

  void initFromPoint(TripPoint result) {
    id = result.id;
    name = result.name;
    arName = result.arName;
    lng = result.lng;
    lat = result.lat;
    tags = result.tags;
  }

  bool validateRequest(BuildContext context) {
    if ((name?.isEmpty ?? true)||(arName?.isEmpty ?? true)) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الاسم', context: context);
      return false;
    }
    if (tags?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الوسوم', context: context);
      return false;
    }
    if (lat ==null||lng==null) {
      NoteMessage.showErrorSnackBar(message: 'يرجى اختيار نقطة', context: context);
      return false;
    }
    return true;
  }
}
