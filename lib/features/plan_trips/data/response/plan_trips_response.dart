//
// import 'package:qareeb_dash/features/plan_trips/data/response/trip_history_response.dart';
//
// class PlanTripsResponse {
//   PlanTripsResponse({
//     required this.result,
//   });
//
//   final PlanTripsResult result;
//
//   factory PlanTripsResponse.fromJson(Map<String, dynamic> json) {
//     return PlanTripsResponse(
//       result: PlanTripsResult.fromJson(json["result"] ?? {}),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "result": result.toJson(),
//       };
// }
//
// class PlanTripsResult {
//   PlanTripsResult({
//     required this.totalCount,
//     required this.items,
//   });
//
//   int totalCount;
//   final List<PlanTripModel> items;
//
//   factory PlanTripsResult.fromJson(Map<String, dynamic> json) {
//     return PlanTripsResult(
//       totalCount: json["totalCount"] ?? 0,
//       items: json["items"] == null
//           ? []
//           : List<PlanTripModel>.from(json["items"]!.map((x) => PlanTripModel.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "totalCount": totalCount,
//         "items": items.map((x) => x.toJson()).toList(),
//       };
// }
//
// class PlanTripModel {
//   PlanTripModel({
//     required this.name,
//     required this.tripTemplateId,
//     required this.institutionId,
//     required this.pathId,
//     required this.path,
//     required this.description,
//     required this.category,
//     required this.numberOfParticipation,
//     required this.isActive,
//     required this.attendances,
//     required this.participations,
//     required this.distance,
//     required this.PlanId,
//     required this.Plans,
//     required this.creationDate,
//     required this.startDate,
//     required this.endDate,
//     required this.PlanTripType,
//     required this.days,
//     required this.id,
//   });
//
//   final String name;
//   final num tripTemplateId;
//   final num institutionId;
//   final num pathId;
//   final TripPath path;
//   final String description;
//   final num distance;
//   final num PlanId;
//   final List<planModel> Plans;
//   final DateTime? creationDate;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final planTripType planTripType;
//   final List<WeekDays> days;
//   final int id;
//
//   final planTripCategory category;
//   final num numberOfParticipation;
//   final bool isActive;
//   final List<TripHistoryItem> attendances;
//   final List<Participation> participations;
//
//   factory PlanTripModel.fromJson(Map<String, dynamic> json) {
//     return PlanTripModel(
//       name: json["name"] ?? "",
//       tripTemplateId: json["tripTemplateId"] ?? 0,
//       institutionId: json["institutionId"] ?? 0,
//       pathId: json["pathId"] ?? 0,
//       path: TripPath.fromJson(json["path"] ?? {}),
//       description: json["description"] ?? "",
//       distance: json["distance"] ?? 0,
//       planId: json["planId"] ?? 0,
//       Plans: json["Plans"] == null
//           ? []
//           : List<planModel>.from(json["Plans"]!.map((x) => planModel.fromJson(x))),
//       creationDate: DateTime.tryParse(json["creationDate"] ?? ""),
//       startDate: DateTime.tryParse(json["startDate"] ?? ""),
//       endDate: DateTime.tryParse(json["endDate"] ?? ""),
//       planTripType: planTripType.values[json["planTripType"] ?? 0],
//       days: json["days"] == null
//           ? []
//           : List<WeekDays>.from(json["days"]!.map((x) => WeekDays.values[x])),
//       id: json["id"] ?? 0,
//       category: planTripCategory.values[json["category"] ?? 0],
//       numberOfParticipation: json["numberOfParticipation"] ?? 0,
//       isActive: json["isActive"] ?? false,
//       attendances: json["attendances"] == null
//           ? []
//           : List<TripHistoryItem>.from(
//               json["attendances"]!.map((x) => TripHistoryItem.fromJson(x))),
//       participations: json["participations"] == null
//           ? []
//           : List<Participation>.from(
//               json["participations"]!.map((x) => Participation.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "tripTemplateId": tripTemplateId,
//         "institutionId": institutionId,
//         "pathId": pathId,
//         "path": path.toJson(),
//         "description": description,
//         "distance": distance,
//         "planId": planId,
//         "plan": Plans.map((e) => e.toJson()),
//         "creationDate": creationDate?.toIso8601String(),
//         "startDate": startDate?.toIso8601String(),
//         "endDate": endDate?.toIso8601String(),
//         "planTripType": planTripType,
//         "days": days.map((x) => x).toList(),
//         "id": id,
//       };
// }
//
// class Participation {
//   Participation({
//     required this.id,
//     required this.planTripId,
//     required this.planMemberId,
//   });
//
//   final int id;
//   final num planTripId;
//   final num planMemberId;
//
//   factory Participation.fromJson(Map<String, dynamic> json) {
//     return Participation(
//       id: json["id"] ?? 0,
//       planTripId: json["planTripId"] ?? 0,
//       planMemberId: json["planMemberId"] ?? 0,
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "planTripId": planTripId,
//         "planMemberId": planMemberId,
//       };
// }
