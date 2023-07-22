class CouponsResponse {
  CouponsResponse({
    required this.result,
  });

  final CouponsResult result;

  factory CouponsResponse.fromJson(Map<String, dynamic> json) {
    return CouponsResponse(
      result: CouponsResult.fromJson(json["result"]??{}),
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
    required this.couponName,
    required this.couponCode,
    required this.discountValue,
    required this.isActive,
    required this.expireDate,
    required this.id,
  });

  final String couponName;
  final String couponCode;
  final num discountValue;
  final bool isActive;
  final DateTime? expireDate;
  final int id;

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      couponName: json["couponName"] ?? "",
      couponCode: json["couponCode"] ?? "",
      discountValue: json["discountValue"] ?? 0,
      isActive: json["isActive"] ?? false,
      expireDate: DateTime.tryParse(json["expireDate"] ?? ""),
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "couponName": couponName,
        "couponCode": couponCode,
        "discountValue": discountValue,
        "isActive": isActive,
        "expireDate": expireDate?.toIso8601String(),
        "id": id,
      };
}
