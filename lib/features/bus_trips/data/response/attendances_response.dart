import 'package:qareeb_dash/features/bus_trips/data/response/bus_trips_response.dart';
import 'package:qareeb_dash/features/buses/data/response/buses_response.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../members/data/response/member_response.dart';

class AttendancesResponse {
  AttendancesResponse({
    required this.result,
  });

  final AttendancesResult result;

  factory AttendancesResponse.fromJson(Map<String, dynamic> json) {
    return AttendancesResponse(
      result: AttendancesResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class AttendancesResult {
  AttendancesResult({
    required this.items,
    required this.totalCount,
  });

  final List<AttendancesItem> items;
  final int totalCount;

  factory AttendancesResult.fromJson(Map<String, dynamic> json) {
    return AttendancesResult(
      items: json["items"] == null
          ? []
          : List<AttendancesItem>.from(
              json["items"]!.map((x) => AttendancesItem.fromJson(x))),
      totalCount: json["totalCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
        "totalCount": totalCount,
      };
}

class AttendancesItem {
  AttendancesItem({
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

  factory AttendancesItem.fromJson(Map<String, dynamic> json) {
    return AttendancesItem(
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
