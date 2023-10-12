import 'package:flutter/material.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/note_message.dart';

class CouponsResponse {
  CouponsResponse({
    required this.result,
  });

  final CouponsResult result;

  factory CouponsResponse.fromJson(Map<String, dynamic> json) {
    return CouponsResponse(
      result: CouponsResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class CouponsResult {
  CouponsResult({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<Coupon> items;

  factory CouponsResult.fromJson(Map<String, dynamic> json) {
    return CouponsResult(
      totalCount: json["totalCount"] ?? 0,
      items: json["items"] == null
          ? []
          : List<Coupon>.from(json["items"]!.map((x) => Coupon.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class Coupon {
  Coupon({
    required this.couponCode,
    required this.discountValue,
    required this.maxActivation,
    required this.isActive,
    required this.expireDate,
    required this.id,
  });

   String couponCode;
   num? discountValue;
   num? maxActivation;
   bool isActive;
   DateTime? expireDate;
   int id;

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      couponCode: json["couponCode"] ?? "",
      discountValue: json["discountValue"] ?? 0,
      maxActivation: json["maxActivation"] ?? 0,
      isActive: json["isActive"] ?? false,
      expireDate: DateTime.tryParse(json["expireDate"] ?? ""),
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "couponCode": couponCode,
        "discountValue": discountValue,
        "maxActivation": maxActivation,
        "isActive": isActive,
        "expireDate": expireDate?.toIso8601String(),
        "id": id,
      };

  bool validateRequest(BuildContext context) {
    if (maxActivation ==0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في عدد التفعيلات', context: context);
      return false;
    }
    if (couponCode.isBlank) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الكود', context: context);
      return false;
    }
    if (discountValue == 0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في القيمة', context: context);
      return false;
    }
    if (expireDate == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في تاريخ النهاية', context: context);
      return false;
    }

    return true;
  }

}
