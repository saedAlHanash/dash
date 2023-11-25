import 'package:flutter/material.dart';
import 'package:qareeb_models/company_paths/data/response/company_paths_response.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/trip_path/data/models/trip_path.dart';

import '../../../../core/util/note_message.dart';

class CreateCompanyPathRequest {
  CreateCompanyPathRequest({
    this.description,
    this.id,
    this.companyId,
  });

  List<num> pathEdgesIds = [];
  String? description;
  int? id;
  int? companyId;

  CreateCompanyPathRequest fromCompanyPath(CompanyPath model) {
    final m = CreateCompanyPathRequest(
      description: model.description,
      id: model.id,
      companyId: model.companyId as int,
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
    if (companyId ==null ) {
      NoteMessage.showErrorSnackBar(message: 'يرجى اختيار شركة', context: context);
      return false;
    }

    return true;
  }

  Map<String, dynamic> toJson() => {
        "companyId": companyId,
        "pathEdgesIds": pathEdgesIds.map((x) => x).toList(),
        "description": description,
        "id": id,
      };
}
