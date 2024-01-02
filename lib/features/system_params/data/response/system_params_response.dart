class SystemParamsResponse {
  SystemParamsResponse({
    required this.result,
  });

  final SystemParamsResult result;

  factory SystemParamsResponse.fromJson(Map<String, dynamic> json) {
    return SystemParamsResponse(
      result: SystemParamsResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class SystemParamsResult {
  SystemParamsResult({
    required this.totalCount,
    required this.items,
  });

  final num totalCount;
  final List<SystemParam> items;

  factory SystemParamsResult.fromJson(Map<String, dynamic> json) {
    return SystemParamsResult(
      totalCount: json["totalCount"] ?? 0,
      items: json["items"] == null
          ? []
          : List<SystemParam>.from(json["items"]!.map((x) => SystemParam.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class SystemParam {
  SystemParam({
    required this.id,
    required this.gold,
    required this.oil,
    required this.tire,
    required this.gas,
    required this.autoCancelTripAfterMinutes,
    required this.sosMessage,
    required this.tripSearchRadius,
    required this.onlySelectedCarCategory,
    required this.companyPhoneNumber,
    required this.minDriverCompensationDistance,
    required this.maxDriverCompensationDistance,
    required this.driverCompensationKmPrice,
  });

  int id;
  num? gold;
  num? oil;
  num? tire;
  num? gas;
  num? autoCancelTripAfterMinutes;
  String sosMessage;
  num? tripSearchRadius;
  bool onlySelectedCarCategory;

  String? companyPhoneNumber;
  num? minDriverCompensationDistance;
  num? maxDriverCompensationDistance;
  num? driverCompensationKmPrice;

  factory SystemParam.fromJson(Map<String, dynamic> json) {
    return SystemParam(
      id: json["id"] ?? 0,
      gold: json["gold"] ?? 0,
      oil: json["oil"] ?? 0,
      tire: json["tire"] ?? 0,
      gas: json["gas"] ?? 0,
      autoCancelTripAfterMinutes: json["autoCancelTripAfterMinutes"] ?? 0,
      sosMessage: json["sosMessage"] ?? "",
      tripSearchRadius: json["tripSearchRadius"] ?? 0,
      onlySelectedCarCategory: json["onlySelectedCarCategory"] ?? false,
      companyPhoneNumber: json["companyPhoneNumber"] ?? '',
      minDriverCompensationDistance: json["minDriverCompensationDistance"] ?? 0,
      maxDriverCompensationDistance: json["maxDriverCompensationDistance"] ?? 0,
      driverCompensationKmPrice: json["driverCompensationKmPrice"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "gold": gold,
        "oil": oil,
        "tire": tire,
        "gas": gas,
        "autoCancelTripAfterMinutes": autoCancelTripAfterMinutes,
        "sosMessage": sosMessage,
        "tripSearchRadius": tripSearchRadius,
        "onlySelectedCarCategory": onlySelectedCarCategory,
        "companyPhoneNumber": companyPhoneNumber,
        "minDriverCompensationDistance": minDriverCompensationDistance,
        "maxDriverCompensationDistance": maxDriverCompensationDistance,
        "driverCompensationKmPrice": driverCompensationKmPrice,
      };

  SystemParam copyWith({
    int? id,
    num? gold,
    num? oil,
    num? tire,
    num? gas,
    num? autoCancelTripAfterMinutes,
    String? sosMessage,
    num? tripSearchRadius,
    bool? onlySelectedCarCategory,
    String? companyPhoneNumber,
    num? minDriverCompensationDistance,
    num? maxDriverCompensationDistance,
    num? driverCompensationKmPrice,
  }) {
    return SystemParam(
      id: id ?? this.id,
      gold: gold ?? this.gold,
      oil: oil ?? this.oil,
      tire: tire ?? this.tire,
      gas: gas ?? this.gas,
      autoCancelTripAfterMinutes:
          autoCancelTripAfterMinutes ?? this.autoCancelTripAfterMinutes,
      sosMessage: sosMessage ?? this.sosMessage,
      tripSearchRadius: tripSearchRadius ?? this.tripSearchRadius,
      onlySelectedCarCategory: onlySelectedCarCategory ?? this.onlySelectedCarCategory,
      companyPhoneNumber: companyPhoneNumber ?? this.companyPhoneNumber,
      minDriverCompensationDistance:
          minDriverCompensationDistance ?? this.minDriverCompensationDistance,
      maxDriverCompensationDistance:
          maxDriverCompensationDistance ?? this.maxDriverCompensationDistance,
      driverCompensationKmPrice:
          driverCompensationKmPrice ?? this.driverCompensationKmPrice,
    );
  }
}
