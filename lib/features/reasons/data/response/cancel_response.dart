class CancelReasonsResponse {
  CancelReasonsResponse({
    required this.result,
  });

  final CancelResult result;

  factory CancelReasonsResponse.fromJson(Map<String, dynamic> json) {
    return CancelReasonsResponse(
      result: CancelResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class CancelResult {
  CancelResult({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<Reasons> items;

  factory CancelResult.fromJson(Map<String, dynamic> json) {
    return CancelResult(
      totalCount: json["totalCount"] ?? 0,
      items: json["items"] == null
          ? []
          : List<Reasons>.from(json["items"]!.map((x) => Reasons.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class Reasons {
  Reasons({
    required this.name,
    required this.id,
  });

  final String name;
  final int id;

  factory Reasons.fromJson(Map<String, dynamic> json) {
    return Reasons(
      name: json["name"] ?? "",
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
