import 'package:qareeb_models/global.dart';

class TransfersResponse {
  TransfersResponse({
    required this.result,
  });

  final TransfersResult result;

  factory TransfersResponse.fromJson(Map<String, dynamic> json) {
    return TransfersResponse(
      result: TransfersResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class TransfersResult {
  TransfersResult({
    required this.items,
    required this.totalCount,
  });

  final List<Transfer> items;
  final int totalCount;

  factory TransfersResult.fromJson(Map<String, dynamic> json) {
    return TransfersResult(
      items: json["items"] == null
          ? []
          : List<Transfer>.from(json["items"]!.map((x) => Transfer.fromJson(x))),
      totalCount: json["totalCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
        "totalCount": totalCount,
      };
}

class Transfer {
  Transfer({
    required this.id,
    required this.status,
    required this.transferDate,
    required this.sourceId,
    required this.sourceName,
    required this.destinationId,
    required this.destinationName,
    required this.amount,
    required this.type,
    required this.tripId,
    required this.sharedRequestId,
  });

  final int id;
  final TransferStatus? status;
  final DateTime? transferDate;
  final num sourceId;
  final String sourceName;
  final num destinationId;
  final String destinationName;
  final num amount;
  final TransferType? type;
  final num tripId;
  final num sharedRequestId;

  factory Transfer.fromJson(Map<String, dynamic> json) {
    return Transfer(
      id: json["id"] ?? 0,
      status: json["status"] == null ? null : TransferStatus.values[json["status"]],
      transferDate: DateTime.tryParse(json["transferDate"] ?? ""),
      sourceId: json["sourceId"] ?? 0,
      sourceName: json["sourceName"] ?? "قريب",
      destinationId: json["destinationId"] ?? 0,
      destinationName: json["destinationName"] ?? "",
      amount: json["amount"] ?? 0,
      type: json["type"] == null ? null : TransferType.values[json["type"]],
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
        "amount": amount,
        "type": type,
        "tripId": tripId,
        "sharedRequestId": sharedRequestId,
      };
}
