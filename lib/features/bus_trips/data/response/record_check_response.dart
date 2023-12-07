import 'package:qareeb_dash/features/bus_trips/data/response/bus_trips_response.dart';
import 'package:qareeb_dash/features/buses/data/response/buses_response.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../members/data/response/member_response.dart';

class RecordCheckResponse {
  RecordCheckResponse({
    required this.result,
  });

  final RecordCheckResult result;

  factory RecordCheckResponse.fromJson(Map<String, dynamic> json) {
    return RecordCheckResponse(
      result: RecordCheckResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class RecordCheckResult {
  RecordCheckResult({
    required this.items,
    required this.totalCount,
  });

  final List<RecordCheck> items;
  final int totalCount;

  factory RecordCheckResult.fromJson(Map<String, dynamic> json) {
    return RecordCheckResult(
      items: json["items"] == null
          ? []
          : List<RecordCheck>.from(json["items"]!.map((x) => RecordCheck.fromJson(x))),
      totalCount: json["totalCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
        "totalCount": totalCount,
      };
}

class RecordCheck {
  RecordCheck({
    required this.busMemberId,
    required this.busMember,
    required this.supervisorId,
    required this.supervisor,
    required this.date,
    required this.isSubscribed,
    required this.id,
  });

  final num busMemberId;
  final Member busMember;
  final num supervisorId;
  final Supervisor supervisor;
  final DateTime? date;
  final bool isSubscribed;
  final int id;

  factory RecordCheck.fromJson(Map<String, dynamic> json) {
    return RecordCheck(
      busMemberId: json["busMemberId"] ?? 0,
      busMember: Member.fromJson(json["busMember"] ?? {}),
      supervisorId: json["supervisorId"] ?? 0,
      supervisor: Supervisor.fromJson(json["supervisor"] ?? {}),
      date: DateTime.tryParse(json["date"] ?? ""),
      isSubscribed: json["isSubscribed"] ?? false,
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "busMemberId": busMemberId,
        "busMember": busMember?.toJson(),
        "supervisorId": supervisorId,
        "supervisor": supervisor?.toJson(),
        "date": date?.toIso8601String(),
        "isSubscribed": isSubscribed,
        "id": id,
      };
}
