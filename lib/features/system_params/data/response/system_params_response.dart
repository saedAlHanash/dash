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
    required this.onlySelectedCarCategory ,
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

  factory SystemParam.fromJson(Map<String, dynamic> json){
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
  }) {
    return SystemParam(
      id: id ?? this.id,
      gold: gold ?? this.gold,
      oil: oil ?? this.oil,
      tire: tire ?? this.tire,
      gas: gas ?? this.gas,
      autoCancelTripAfterMinutes: autoCancelTripAfterMinutes ?? this.autoCancelTripAfterMinutes,
      sosMessage: sosMessage ?? this.sosMessage,
      tripSearchRadius: tripSearchRadius ?? this.tripSearchRadius,
      onlySelectedCarCategory: onlySelectedCarCategory ?? this.onlySelectedCarCategory,
    );
  }
}

