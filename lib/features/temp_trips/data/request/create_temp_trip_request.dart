import 'package:flutter/material.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/trip_path/data/models/trip_path.dart';

import '../../../../core/util/note_message.dart';

class CreateTempTripRequest {
  CreateTempTripRequest({
    this.arName,
    this.id,
  });

  List<num> pathEdgesIds = [];
  String? arName;
  int? id;

  CreateTempTripRequest fromTempTrip(TripPath model) {
    final m = CreateTempTripRequest(
      arName: model.arName,
      id: model.id,
    );

    m.pathEdgesIds
      ..clear()
      ..addAll(model.edges.map((e) => e.id).toList());

    return m;
  }

  bool validateRequest(BuildContext context) {
    if (arName?.isBlank ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الاسم', context: context);
      return false;
    }
    if (pathEdgesIds.length <= 1) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في  النقاط', context: context);
      return false;
    }
    return true;
  }

  Map<String, dynamic> toJson() => {
        "edgesIds": pathEdgesIds.map((x) => x).toList(),
        "arName": arName,
        "name": arName,
        "id": id,
      };
}
