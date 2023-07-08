class TransfersResponse {
  TransfersResponse({
    required this.result,
  });

  final List<TransferResult> result;

  factory TransfersResponse.fromJson(Map<String, dynamic> json) {
    return TransfersResponse(
      result: json["result"] == null
          ? []
          : List<TransferResult>.from(
              json["result"]!.map((x) => TransferResult.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.map((x) => x.toJson()).toList(),
      };
}

class TransferResult {
  TransferResult({
    required this.id,
    required this.status,
    required this.transferDate,
    required this.sourceId,
    required this.sourceName,
    required this.destinationId,
    required this.destinationName,
    required this.userName,
    required this.amount,
    required this.type,
    required this.tripId,
    required this.sharedRequestId,
  });

  final int id;
  final num status;
  final DateTime? transferDate;
  final num sourceId;
  final String sourceName;
  final num destinationId;
  final String destinationName;
  final String userName;
  final num amount;
  final num type;
  final num tripId;
  final num sharedRequestId;

  factory TransferResult.fromJson(Map<String, dynamic> json) {
    return TransferResult(
      id: json["id"] ?? 0,
      status: json["status"] ?? "",
      transferDate: DateTime.tryParse(json["transferDate"] ?? ""),
      sourceId: json["sourceId"] ?? 0,
      sourceName: json["sourceName"] ?? "",
      destinationId: json["destinationId"] ?? 0,
      destinationName: json["destinationName"] ?? "",
      userName: json["userName"] ?? "",
      amount: json["amount"] ?? 0,
      type: json["type"] ?? "",
      tripId: json["tripId"] ?? 0,
      sharedRequestId: json["sharedRequestId"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "transferDate": transferDate?.toIso8601String(),
        "sourceId": sourceId,
        "sourceName": sourceName,
        "destinationId": destinationId,
        "destinationName": destinationName,
        "userName": userName,
        "amount": amount,
        "type": type,
        "tripId": tripId,
        "sharedRequestId": sharedRequestId,
      };
}
