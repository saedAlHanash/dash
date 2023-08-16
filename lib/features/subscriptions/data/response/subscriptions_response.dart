import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';

import '../../../../core/util/note_message.dart';

class SubscriptionsResponse {
  SubscriptionsResponse({
    required this.result,
  });

  final SubscriptionsResult result;

  factory SubscriptionsResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionsResponse(
      result: SubscriptionsResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
      };
}

class SubscriptionsResult {
  SubscriptionsResult({
    required this.items,
    required this.totalCount,
  });

  final List<SubscriptionModel> items;
  final int totalCount;

  factory SubscriptionsResult.fromJson(Map<String, dynamic> json) {
    return SubscriptionsResult(
      items: json["items"] == null
          ? []
          : List<SubscriptionModel>.from(
              json["items"]!.map((x) => SubscriptionModel.fromJson(x))),
      totalCount: json["totalCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x?.toJson()).toList(),
        "totalCount": totalCount,
      };
}

class SubscriptionModel {
  SubscriptionModel({
    this.id,
    this.name = '',
    this.supscriptionDate,
    this.expirationDate,
    this.institutionId,
  });

  int? id;
  String name;
  DateTime? supscriptionDate;
  DateTime? expirationDate;
  num? institutionId;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      supscriptionDate: DateTime.tryParse(json["supscriptionDate"] ?? ""),
      expirationDate: DateTime.tryParse(json["expirationDate"] ?? ""),
      institutionId: json["institutionId"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "supscriptionDate": supscriptionDate?.toIso8601String(),
        "expirationDate": expirationDate?.toIso8601String(),
        "institutionId": AppSharedPreference.getInstitutionId,
      };

  bool validateRequest(BuildContext context) {
    if (supscriptionDate == null) {
      NoteMessage.showErrorSnackBar(message: 'يرجى تحديد التاريخ', context: context);
      return false;
    }
    if (expirationDate == null) {
      NoteMessage.showErrorSnackBar(message: 'يرجى تحديد التاريخ', context: context);
      return false;
    }
    return true;
  }
}
