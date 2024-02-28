import 'package:flutter/material.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/plans/data/response/plans_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/util/note_message.dart';
import '../response/plans_response.dart';

class CreatePlanRequest {
  int? id;
  num? price;
  String? name;
  String? description;
  UploadFile? file;
  num? maxPathMeters;
  num? maxDailyUsage;
  num? maxMonthlyUsage;
  num? activationDayNumber;
  num? maxMeters;
  PlanType type;

  CreatePlanRequest({
    this.id,
    this.price,
    this.name,
    this.description,
    this.type = PlanType.qareep,
    this.maxPathMeters,
    this.maxDailyUsage,
    this.maxMonthlyUsage,
    this.activationDayNumber,
    this.maxMeters,
  });

  Map<String, dynamic> toMap() {
    return {
      'Id': id == 0 ? null : id,
      'Price': price,
      'Name': name,
      'Description': description,
      'Type': type.index,
      'MaxPathMeters': maxPathMeters,
      'MaxDailyUsage': maxDailyUsage,
      'maxMonthlyUsage': maxMonthlyUsage,
      'activationDayNumber': activationDayNumber,
      'MaxMeters': maxMeters,
    };
  }

  CreatePlanRequest fromPlan(PlanModel model) {
    return CreatePlanRequest(
      id: model.id,
      price: model.price,
      name: model.name,
      description: model.description,
      type: model.type,
      maxPathMeters: model.maxPathMeters,
      maxDailyUsage: model.maxDailyUsage,
      maxMonthlyUsage: model.maxMonthlyUsage,
      activationDayNumber: model.activationDayNumber,
      maxMeters: model.maxMeters,
    )..file =
        UploadFile(fileBytes: null, initialImage: model.imageUrl, nameField: 'ImageFile');
  }

  bool validateRequest(BuildContext context) {
    if (name.isBlank) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الاسم', context: context);
      return false;
    }

    if (price == null || price == 0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في السعر', context: context);
      return false;
    }
    if (maxMeters == null || maxMeters == 0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في رصيد الكيلومترات', context: context);
      return false;
    }
    if (activationDayNumber == null || activationDayNumber == 0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في أيام الخطة', context: context);
      return false;
    }

    if (file == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في صورة الخطة', context: context);
      return false;
    }

    if (maxPathMeters == null || maxPathMeters == 0) {
      NoteMessage.showErrorSnackBar(
          message: 'خطأ في مسافة الطريق الخاص بالخطة', context: context);
      return false;
    }
    if (maxDailyUsage == null || maxDailyUsage == 0) {
      NoteMessage.showErrorSnackBar(
          message: 'خطأ في عدد التفعيلات اليومية', context: context);
      return false;
    }
    return true;
  }
}

/*







File
string($binary)










Birthdate
string($date-time)




 */
