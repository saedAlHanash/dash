import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/util/note_message.dart';
import '../response/coupons_response.dart';

class CreateCouponRequest {
  CreateCouponRequest({
    this.discountValue,
    this.couponName,
    this.couponCode,
    this.expireDate,
    this.id,
  });

   String? couponName;
   String? couponCode;
   num? discountValue;
   DateTime? expireDate;
   int? id;

  Map<String, dynamic> toJson() => {
        "couponName": couponName,
        "couponCode": couponCode,
        "discountValue": discountValue,
        "isActive": true,
        "expireDate": expireDate?.toIso8601String(),
        "id": id,
      };

  bool validateRequest(BuildContext context) {
    if (couponName.isBlank) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الاسم', context: context);
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

  static CreateCouponRequest fromCoupon(Coupon adminModel) {
    return CreateCouponRequest(
      id: adminModel.id,
      couponName: adminModel.couponName,
      couponCode: adminModel.couponCode,
      discountValue: adminModel.discountValue,
      expireDate: adminModel.expireDate,
    );
  }
}
