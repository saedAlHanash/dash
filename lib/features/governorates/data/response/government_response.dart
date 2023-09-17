class GovernmentResponse {
  GovernmentResponse({
    required this.result,
  });

  final GovernmentResult result;

  factory GovernmentResponse.fromJson(Map<String, dynamic> json) {
    return GovernmentResponse(
      result: GovernmentResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class GovernmentResult {
  GovernmentResult({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<GovernmentModel> items;

  factory GovernmentResult.fromJson(Map<String, dynamic> json) {
    return GovernmentResult(
      totalCount: json["totalCount"] ?? 0,
      items: json["items"] == null
          ? []
          : List<GovernmentModel>.from(json["items"]!.map((x) => GovernmentModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class GovernmentModel {
  GovernmentModel({
    required this.id,
    required this.name,
  });

  final int id;
   String name;

  factory GovernmentModel.fromJson(Map<String, dynamic> json) {
    return GovernmentModel(
      name: json["name"] ?? "",
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
