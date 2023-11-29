//
// class TripHistoryResponse {
//   TripHistoryResponse({
//     required this.result,
//   });
//
//   final TripHistoryResult result;
//
//   factory TripHistoryResponse.fromJson(Map<String, dynamic> json) {
//     return TripHistoryResponse(
//       result: TripHistoryResult.fromJson(json["result"] ?? {}),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "result": result.toJson(),
//       };
// }
//
// class TripHistoryResult {
//   TripHistoryResult({
//     required this.items,
//     required this.totalCount,
//   });
//
//   final List<TripHistoryItem> items;
//   final int totalCount;
//
//   factory TripHistoryResult.fromJson(Map<String, dynamic> json) {
//     return TripHistoryResult(
//       items: json["items"] == null
//           ? []
//           : List<TripHistoryItem>.from(
//               json["items"]!.map((x) => TripHistoryItem.fromJson(x))),
//       totalCount: json["totalCount"] ?? 0,
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "items": items.map((x) => x.toJson()).toList(),
//         "totalCount": totalCount,
//       };
// }
//
// class TripHistoryItem {
//   TripHistoryItem({
//     required this.id,
//     required this.planId,
//     required this.plan,
//     required this.planTripId,
//     required this.planTrip,
//     required this.planMemberId,
//     required this.planMember,
//     required this.date,
//     required this.attendanceType,
//     required this.isParticipated,
//     required this.isSubscribed,
//   });
//
//   final int id;
//   final num planId;
//   final planModel plan;
//   final num planTripId;
//   final PlanTripModel planTrip;
//   final num planMemberId;
//   final Member planMember;
//   final DateTime? date;
//   final AttendanceType attendanceType;
//   final bool isParticipated;
//   final bool isSubscribed;
//
//   factory TripHistoryItem.fromJson(Map<String, dynamic> json) {
//     return TripHistoryItem(
//       id: json["id"] ?? 0,
//       planId: json["planId"] ?? 0,
//       plan: planModel.fromJson(json["plan"] ?? {}),
//       planTripId: json["planTripId"] ?? 0,
//       planTrip: PlanTripModel.fromJson(json["planTrip"] ?? {}),
//       planMemberId: json["planMemberId"] ?? 0,
//       planMember: Member.fromJson(json["planMember"] ?? {}),
//       date: DateTime.tryParse(json["date"] ?? ""),
//       attendanceType: AttendanceType.values[json["attendanceType"] ?? 0],
//       isParticipated: json["isParticipated"] ?? false,
//       isSubscribed: json["isSubscribed"] ?? false,
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "planId": planId,
//         "plan": plan.toJson(),
//         "planTripId": planTripId,
//         "planTrip": planTrip.toJson(),
//         "planMemberId": planMemberId,
//         "planMember": planMember.toJson(),
//         "date": date?.toIso8601String(),
//         "attendanceType": attendanceType,
//         "isParticipated": isParticipated,
//         "isSubscribed": isSubscribed,
//       };
// }
