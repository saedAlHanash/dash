import 'package:flutter/material.dart';
import 'package:qareeb_dash/features/super_user/data/request/create_super_user_request.dart';

import '../../../../core/util/note_message.dart';
import '../../../../core/util/shared_preferences.dart';

class CreateSubscriptionRequest {
  CreateSubscriptionRequest({
    this.id,
    this.memberId,
    this.supscriptionDate,
    this.expirationDate,
    this.isActive = false,
  });

  int? id;
  num? memberId;
  DateTime? supscriptionDate;
  DateTime? expirationDate;
  bool isActive;

  factory CreateSubscriptionRequest.fromJson(Map<String, dynamic> json) {
    return CreateSubscriptionRequest(
      id: json["id"] ?? 0,
      memberId: json["memberId"] ?? 0,
      supscriptionDate: DateTime.tryParse(json["supscriptionDate"] ?? ""),
      expirationDate: DateTime.tryParse(json["expirationDate"] ?? ""),
      isActive: json["isActive"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "institutionId": AppSharedPreference.getInstitutionId,
        "memberId": memberId,
        "supscriptionDate": supscriptionDate?.toIso8601String(),
        "expirationDate": expirationDate?.toIso8601String(),
        "isActive": isActive,
      };

  bool validateRequest(BuildContext context) {

    if (supscriptionDate == null) {
      NoteMessage.showErrorSnackBar(
          message: 'خطأ في تاريخ بداية الاشتراك ', context: context);
      return false;
    }
    if (expirationDate == null) {
      NoteMessage.showErrorSnackBar(
          message: 'خطأ في تاريخ نهاية الاشتراك', context: context);
      return false;
    }

    return true;
  }
}
