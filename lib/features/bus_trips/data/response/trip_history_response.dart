import 'package:qareeb_dash/features/bus_trips/data/response/bus_trips_response.dart';
import 'package:qareeb_dash/features/buses/data/response/buses_response.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../members/data/response/member_response.dart';

class TripHistoryResponse {
  TripHistoryResponse({
    required this.result,
  });

  final TripHistoryResult result;

  factory TripHistoryResponse.fromJson(Map<String, dynamic> json) {
    return TripHistoryResponse(
      result: TripHistoryResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
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

class TripHistoryItem {
  TripHistoryItem({
    required this.id,
    required this.busId,
    required this.bus,
    required this.busTripId,
    required this.busTrip,
    required this.busMemberId,
    required this.busMember,
    required this.date,
    required this.attendanceType,
    required this.isParticipated,
    required this.isSubscribed,
  });

  final int id;
  final num busId;
  final BusModel bus;
  final num busTripId;
  final BusTripModel busTrip;
  final num busMemberId;
  final Member busMember;
  final DateTime? date;
  final AttendanceType attendanceType;
  final bool isParticipated;
  final bool isSubscribed;

  factory TripHistoryItem.fromJson(Map<String, dynamic> json) {
    return TripHistoryItem(
      id: json["id"] ?? 0,
      busId: json["busId"] ?? 0,
      bus: BusModel.fromJson(json["bus"] ?? {}),
      busTripId: json["busTripId"] ?? 0,
      busTrip: BusTripModel.fromJson(json["busTrip"] ?? {}),
      busMemberId: json["busMemberId"] ?? 0,
      busMember: Member.fromJson(json["busMember"] ?? {}),
      date: DateTime.tryParse(json["date"] ?? ""),
      attendanceType: AttendanceType.values[json["attendanceType"] ?? 0],
      isParticipated: json["isParticipated"] ?? false,
      isSubscribed: json["isSubscribed"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "busId": busId,
        "bus": bus.toJson(),
        "busTripId": busTripId,
        "busTrip": busTrip.toJson(),
        "busMemberId": busMemberId,
        "busMember": busMember.toJson(),
        "date": date?.toIso8601String(),
        "attendanceType": attendanceType,
        "isParticipated": isParticipated,
        "isSubscribed": isSubscribed,
      };
}
