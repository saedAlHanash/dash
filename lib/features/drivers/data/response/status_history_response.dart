import 'package:qareeb_models/global.dart';

class DriverStatusHistoryResponse {
  DriverStatusHistoryResponse({
    required this.result,
  });

  final DriverStatusHistoryResult result;
//driver_status_history
  factory DriverStatusHistoryResponse.fromJson(Map<String, dynamic> json) {
    return DriverStatusHistoryResponse(
      result: DriverStatusHistoryResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class DriverStatusHistoryResult {
  DriverStatusHistoryResult({
    required this.items,
    required this.totalCount,
  });

  final List<DriverStatusHistory> items;
  final int totalCount;

  factory DriverStatusHistoryResult.fromJson(Map<String, dynamic> json) {
    return DriverStatusHistoryResult(
      items: json["items"] == null
          ? []
          : List<DriverStatusHistory>.from(
              json["items"]!.map((x) => DriverStatusHistory.fromJson(x))),
      totalCount: json["totalCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
        "totalCount": totalCount,
      };
}

class DriverStatusHistory {
  DriverStatusHistory({
    required this.id,
    required this.userId,
    required this.date,
    required this.status,
  });

  final int id;
  final num userId;
  final DateTime? date;
  final DriverStatus status;

  factory DriverStatusHistory.fromJson(Map<String, dynamic> json) {
    return DriverStatusHistory(
      id: json["id"] ?? 0,
      userId: json["userId"] ?? 0,
      date: DateTime.tryParse(json["date"] ?? ""),
      status:DriverStatus.values [json["status"] ?? 0],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "date": date?.toIso8601String(),
        "status": status.index,
      };
}
