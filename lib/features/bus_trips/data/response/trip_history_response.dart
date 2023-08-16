import 'package:qareeb_dash/features/bus_trips/data/response/bus_trips_response.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../members/data/response/member_response.dart';

class TripHistoryResponse {
  TripHistoryResponse({
    required this.result,
  });

  final TripHistoryResult? result;

  factory TripHistoryResponse.fromJson(Map<String, dynamic> json) {
    return TripHistoryResponse(
      result: json["result"] == null ? null : TripHistoryResult.fromJson(json["result"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
      };
}

class TripHistoryResult {
  TripHistoryResult({
    required this.items,
    required this.totalCount,
  });

  final List<TripHistoryItem> items;
  final int totalCount;

  factory TripHistoryResult.fromJson(Map<String, dynamic> json) {
    return TripHistoryResult(
      items: json["items"] == null
          ? []
          : List<TripHistoryItem>.from(
              json["items"]!.map((x) => TripHistoryItem.fromJson(x))),
      totalCount: json["totalCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
        "totalCount": totalCount,
      };
}

class TripHistoryItem   {
  TripHistoryItem({
    required this.id,
    required this.busTripId,
    required this.busTrip,
    required this.busMemberId,
    required this.busMember,
    required this.date,
    required this.attendanceType,
    required this.isParticipated,
  });

  final int id;
  final num busTripId;
  final BusTripModel busTrip;
  final num busMemberId;
  final Member busMember;
  final DateTime? date;
  final AttendanceType attendanceType;
  final bool isParticipated;

  factory TripHistoryItem.fromJson(Map<String, dynamic> json) {
    return TripHistoryItem(
      id: json["id"] ?? 0,
      busTripId: json["busTripId"] ?? 0,
      busTrip: BusTripModel.fromJson(json["busTrip"] ?? {}),
      busMemberId: json["busMemberId"] ?? 0,
      busMember: Member.fromJson(json["busMember"] ?? {}),
      date: DateTime.tryParse(json["date"] ?? ""),
      attendanceType: AttendanceType.values[json["attendanceType"] ?? 0],
      isParticipated: json["isParticipated"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "busTripId": busTripId,
        "busTrip": busTrip.toJson(),
        "busMemberId": busMemberId,
        "busMember": busMember.toJson(),
        "date": date?.toIso8601String(),
        "attendanceType": attendanceType,
        "isParticipated": isParticipated,
      };
}
