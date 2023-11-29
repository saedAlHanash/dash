import 'package:flutter/material.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/plan_trips/data/response/plan_trips_response.dart';

import '../../../../core/util/note_message.dart';

class CreatePlanTripRequest {
  CreatePlanTripRequest({
    this.id,
    this.name,
    this.description,
    this.companyPathId,
    this.companyId,
    this.startDate,
    this.endDate,
    this.days,
  });

  int? id;
  String? name;
  int? companyPathId;
  int? companyId;
  String? description;
  List<int> driversIds = [];
  DateTime? startDate;
  DateTime? endDate;

  List<WeekDays>? days;

  List<WeekDays> get getDays {
    days ??= WeekDays.values;
    return days!;
  }

  factory CreatePlanTripRequest.fromJson(Map<String, dynamic> json) {
    return CreatePlanTripRequest(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      companyPathId: json["companyPathId"] ?? 0,
      companyId: json["companyId"] ?? 0,
      description: json["description"] ?? "",
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      endDate: DateTime.tryParse(json["endDate"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "companyPathId": companyPathId,
        "companyId": companyId,
        "description": description,
        "driversIds": driversIds,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "days": days?.map((x) => x.index).toList(),
      };

  CreatePlanTripRequest fromPlanTrip(PlanTripModel model) {
    return CreatePlanTripRequest(
      id: model.id,
      name: model.name,
      description: model.description,
      companyPathId: model.companyPathId,
      companyId: model.companyId,
      startDate: model.startDate,
      endDate: model.endDate,
      days: model.days,
    )..driversIds = model.drivers.map((e) => e.id).toList();
  }

  bool validateRequest(BuildContext context) {
    if (name.isBlank) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الاسم', context: context);
      return false;
    }

    if (companyPathId.isEmpty) {
      NoteMessage.showErrorSnackBar(message: 'يرجى اختيار مسار', context: context);
      return false;
    }

    if (companyPathId.isEmpty) {
      NoteMessage.showErrorSnackBar(message: 'يرجى اختيار شركة', context: context);
      return false;
    }

    if (driversIds.isEmpty) {
      NoteMessage.showErrorSnackBar(message: 'يرجى اختيار سائقين', context: context);
      return false;
    }

    if (startDate == null || endDate == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في توقيت الرحلة ', context: context);
      return false;
    }

    return true;
  }
}
