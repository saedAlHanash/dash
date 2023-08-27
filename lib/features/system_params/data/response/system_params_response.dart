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
    this.gold,
    this.oil,
    this.tire,
    required this.id,
  });

  num? gold;
  num? oil;
  num? tire;
  final int id;

  factory SystemParam.fromJson(Map<String, dynamic> json) {
    return SystemParam(
      gold: json["gold"] ?? 0,
      oil: json["oil"] ?? 0,
      tire: json["tire"] ?? 0,
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "gold": gold,
        "oil": oil,
        "tire": tire,
        "id": id,
      };

  SystemParam copyWith({
    num? gold,
    num? oil,
    num? tire,
    int? id,
  }) {
    return SystemParam(
      gold: gold ?? this.gold,
      oil: oil ?? this.oil,
      tire: tire ?? this.tire,
      id: id ?? this.id,
    );
  }
}
