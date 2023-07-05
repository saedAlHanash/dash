class DebtsResponse {
  DebtsResponse({
    required this.result,
  });

  final DebtsResult result;

  factory DebtsResponse.fromJson(Map<String, dynamic> json) {
    return DebtsResponse(
      result: DebtsResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class DebtsResult {
  DebtsResult({
    required this.items,
    required this.totalCount,
  });

  final List<Debt> items;
  final num totalCount;

  factory DebtsResult.fromJson(Map<String, dynamic> json) {
    return DebtsResult(
      items: json["items"] == null
          ? []
          : List<Debt>.from(json["items"]!.map((x) => Debt.fromJson(x))),
      totalCount: json["totalCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
        "totalCount": totalCount,
      };
}

class Debt {
  Debt({
    required this.id,
    required this.amount,
    required this.sharedRequestId,
    required this.tripId,
    required this.driverId,
    required this.date,
  });

  final int id;
  final num amount;
  final num sharedRequestId;
  final num tripId;
  final num driverId;
  final DateTime? date;

  factory Debt.fromJson(Map<String, dynamic> json) {
    return Debt(
      id: json["id"] ?? 0,
      amount: json["amount"] ?? 0,
      sharedRequestId: json["sharedRequestId"] ?? 0,
      tripId: json["tripId"] ?? 0,
      driverId: json["driverId"] ?? 0,
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "sharedRequestId": sharedRequestId,
        "tripId": tripId,
        "driverId": driverId,
        "date": date?.toIso8601String(),
      };
}
