import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/shared_preferences.dart';

import '../response/bus_trips_response.dart';

class CreateBusTripRequest {
  CreateBusTripRequest({
    this.id,
    this.name,
    this.description,
    this.tripTemplateId,
    this.pathId,
    this.distance,

    this.startDate,
    this.endDate,
    this.busTripType = BusTripType.go,
    this.days,
  });

  int? id;
  String? name;
  num? tripTemplateId;
  num? pathId;
  String? description;
  num? distance;
  List<int> busesId = [];
  DateTime? startDate;
  DateTime? endDate;
  BusTripType busTripType;
  List<WeekDays>? days;

  List<WeekDays> get getDays {
    days ??= [];
    return days!;
  }

  factory CreateBusTripRequest.fromJson(Map<String, dynamic> json) {
    return CreateBusTripRequest(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      tripTemplateId: json["tripTemplateId"] ?? 0,
      pathId: json["pathId"] ?? 0,
      description: json["description"] ?? "",
      distance: json["distance"] ?? 0,

      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      endDate: DateTime.tryParse(json["endDate"] ?? ""),
      busTripType: json["busTripType"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tripTemplateId": tripTemplateId,
        "institutionId": AppSharedPreference.getInstitutionId,
        "pathId": pathId,
        "description": description,
        "distance": distance,
        "busIds": busesId,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "busTripType": busTripType.index,
        "days": days?.map((x) => x.index).toList(),
      };

  CreateBusTripRequest fromBusTrip(BusTripModel model) {
    return CreateBusTripRequest(
      id: model.id,
      name: model.name,
      description: model.description,
      tripTemplateId: model.tripTemplateId,
      pathId: model.pathId,
      distance: model.distance,
      startDate: model.startDate,
      endDate: model.endDate,
      busTripType: model.busTripType,
      days: model.days,
    )..busesId = model.buses.map((e) => e.id).toList();
  }

  bool validateRequest(BuildContext context) {
    if (name?.isBlank ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الاسم', context: context);
      return false;
    }
    if (tripTemplateId == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في نموذج الرحلة', context: context);
      return false;
    }

    if (pathId == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الاسم', context: context);
      return false;
    }

    if (busesId .isEmpty) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الباص', context: context);
      return false;
    }

    if (startDate == null || endDate == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في توقيت الرحلة ', context: context);
      return false;
    }

    return true;
  }
}
