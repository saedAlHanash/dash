class RedeemsResponse {
  RedeemsResponse({
    required this.result,
  });

  final RedeemsResult result;

  factory RedeemsResponse.fromJson(Map<String, dynamic> json) {
    return RedeemsResponse(
      result: RedeemsResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class RedeemsResult {
  RedeemsResult({
    required this.systemParameters,
    required this.totals,
    required this.totalMeters,
  });

  final SystemParameters systemParameters;
  final List<Total> totals;
  final num totalMeters;

  factory RedeemsResult.fromJson(Map<String, dynamic> json) {
    return RedeemsResult(
      systemParameters: SystemParameters.fromJson(json["systemParameters"] ?? {}),
      totals: json["totals"] == null
          ? []
          : List<Total>.from(json["totals"]!.map((x) => Total.fromJson(x))),
      totalMeters: json["totalMeters"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "systemParameters": systemParameters.toJson(),
        "totals": totals.map((x) => x.toJson()).toList(),
        "totalMeters": totalMeters,
      };
}

class SystemParameters {
  SystemParameters({
    required this.id,
    required this.gold,
    required this.oil,
    required this.tire,
  });

  final int id;
  final num gold;
  final num oil;
  final num tire;

  factory SystemParameters.fromJson(Map<String, dynamic> json) {
    return SystemParameters(
      id: json["id"] ?? 0,
      gold: json["gold"] ?? 0,
      oil: json["oil"] ?? 0,
      tire: json["tire"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "gold": gold,
        "oil": oil,
        "tire": tire,
      };
}

class Total {
  Total({
    required this.value,
    required this.key,
  });

  final num value;
  final String key;

  factory Total.fromJson(Map<String, dynamic> json) {
    return Total(
      value: json["value"] ?? 0,
      key: json["key"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "value": value,
        "key": key,
      };
}
