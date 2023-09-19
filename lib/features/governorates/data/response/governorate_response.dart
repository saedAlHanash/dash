class GovernorateResponse {
  GovernorateResponse({
    required this.result,
  });

  final GovernorateResult result;

  factory GovernorateResponse.fromJson(Map<String, dynamic> json) {
    return GovernorateResponse(
      result: GovernorateResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class GovernorateResult {
  GovernorateResult({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<GovernorateModel> items;

  factory GovernorateResult.fromJson(Map<String, dynamic> json) {
    return GovernorateResult(
      totalCount: json["totalCount"] ?? 0,
      items: json["items"] == null
          ? []
          : List<GovernorateModel>.from(json["items"]!.map((x) => GovernorateModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class GovernorateModel {
  GovernorateModel({
    required this.id,
    required this.name,
  });

  final int id;
   String name;
  factory GovernorateModel.fromJson(Map<String, dynamic> json) {
    return GovernorateModel(
      name: json["name"] ?? "",
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
