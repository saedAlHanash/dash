import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/features/members/data/response/member_response.dart';
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

  bool get isNotExpired {
    final r= expirationDate?.isAfter(getServerDate) ?? false;
    loggerObject.w(r);
    return r;
  }

  factory CreateSubscriptionRequest.fromJson(Map<String, dynamic> json) {
    return CreateSubscriptionRequest(
      id: json["id"],
      memberId: json["memberId"] ?? 0,
      supscriptionDate: DateTime.tryParse(json["supscriptionDate"] ?? ""),
      expirationDate: DateTime.tryParse(json["expirationDate"] ?? ""),
      isActive: json["isActive"] ?? false,
    );
  }

  factory CreateSubscriptionRequest.fromMember(Member member) {
    return CreateSubscriptionRequest(
      id: member.subscriptions.lastOrNull?.id,
      memberId: member.id,
      supscriptionDate: member.subscriptions.lastOrNull?.supscriptionDate,
      expirationDate: member.subscriptions.lastOrNull?.expirationDate,
      isActive: member.subscriptions.lastOrNull?.isActive ?? false,
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
