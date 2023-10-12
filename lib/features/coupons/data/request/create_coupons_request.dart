

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



}
