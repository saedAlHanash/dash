import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../super_user/data/request/create_super_user_request.dart';
import '../response/temp_trips_response.dart';

class CreateTempTripRequest {
  CreateTempTripRequest({
    this.description,
    this.id,
  });

  List<num> pathEdgesIds = [];
  String? description;
  int? id;

  CreateTempTripRequest fromTempTrip(TempTripModel model) {
    final m = CreateTempTripRequest(
      description: model.description,
      id: model.id,
    );

    m.pathEdgesIds
      ..clear()
      ..addAll(model.path.edges.map((e) => e.id).toList());

    return m;
  }

  bool validateRequest(BuildContext context) {
    if (description?.isBlank ?? true) {
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
        "institutionId": AppSharedPreference.getInstitutionId,
        "pathEdgesIds": pathEdgesIds.map((x) => x).toList(),
        "description": description,
        "id": id,
      };
}
