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
  final int totalCount;

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
    required this.driverShare,
    required this.totalCost,
    required this.sharedRequestId,
    required this.tripId,
    required this.driverId,
    required this.date,
    required this.oilShare,
    required this.goldShare,
    required this.tiresShare,
  });

  final int id;
  final num driverShare;
  final num totalCost;
  final num sharedRequestId;
  final num tripId;
  final num driverId;
  final DateTime? date;
  final num oilShare;
  final num goldShare;
  final num tiresShare;

  factory Debt.fromJson(Map<String, dynamic> json) {
    return Debt(
      id: json["id"] ?? 0,
      driverShare: json["driverShare"] ?? 0,
      totalCost: json["totalCost"] ?? 0,
      sharedRequestId: json["sharedRequestId"] ?? 0,
      tripId: json["tripId"] ?? 0,
      driverId: json["driverId"] ?? 0,
      date: DateTime.tryParse(json["date"] ?? ""),
      oilShare: json["oilShare"] ?? 0,
      goldShare: json["goldShare"] ?? 0,
      tiresShare: json["tiresShare"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "driverShare": driverShare,
        "totalCost": totalCost,
        "sharedRequestId": sharedRequestId,
        "tripId": tripId,
        "driverId": driverId,
        "date": date?.toIso8601String(),
        "oilShare": oilShare,
        "goldShare": goldShare,
        "tiresShare": tiresShare,
      };
}
