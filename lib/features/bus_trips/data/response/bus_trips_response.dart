import 'package:collection/collection.dart';
import 'package:qareeb_dash/features/bus_trips/data/response/trip_history_response.dart';
import 'package:qareeb_dash/features/buses/data/response/buses_response.dart';
import 'package:qareeb_dash/services/trip_path/data/models/trip_path.dart';

import '../../../../core/strings/enum_manager.dart';

class BusTripsResponse {
  BusTripsResponse({
    required this.result,
  });

  final BusTripsResult result;

  factory BusTripsResponse.fromJson(Map<String, dynamic> json) {
    return BusTripsResponse(
      result: BusTripsResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class BusTripsResult {
  BusTripsResult({
    required this.totalCount,
    required this.items,
  });

  int totalCount;
  final List<BusTripModel> items;

  factory BusTripsResult.fromJson(Map<String, dynamic> json) {
    return BusTripsResult(
      totalCount: json["totalCount"] ?? 0,
      items: json["items"] == null
          ? []
          : List<BusTripModel>.from(json["items"]!.map((x) => BusTripModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class BusTripModel {
  BusTripModel({
    required this.name,
    required this.tripTemplateId,
    required this.institutionId,
    required this.pathId,
    required this.path,
    required this.description,
    required this.category,
    required this.numberOfParticipation,
    required this.isActive,
    required this.attendances,
    required this.participations,
    required this.distance,
    required this.busId,
    required this.buses,
    required this.creationDate,
    required this.startDate,
    required this.endDate,
    required this.busTripType,
    required this.days,
    required this.id,
  });

  final String name;
  final num tripTemplateId;
  final num institutionId;
  final num pathId;
  final TripPath path;
  final String description;
  final num distance;
  final num busId;
  final List<BusModel> buses;
  final DateTime? creationDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final BusTripType busTripType;
  final List<WeekDays> days;
  final int id;

  final BusTripCategory category;
  final num numberOfParticipation;
  final bool isActive;
  final List<TripHistoryItem> attendances;
  final List<Participation> participations;

  factory BusTripModel.fromJson(Map<String, dynamic> json) {
    return BusTripModel(
      name: json["name"] ?? "",
      tripTemplateId: json["tripTemplateId"] ?? 0,
      institutionId: json["institutionId"] ?? 0,
      pathId: json["pathId"] ?? 0,
      path: TripPath.fromJson(json["path"] ?? {}),
      description: json["description"] ?? "",
      distance: json["distance"] ?? 0,
      busId: json["busId"] ?? 0,
      buses: json["buses"] == null
          ? []
          : List<BusModel>.from(json["buses"]!.map((x) => BusModel.fromJson(x))),
      creationDate: DateTime.tryParse(json["creationDate"] ?? ""),
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      endDate: DateTime.tryParse(json["endDate"] ?? ""),
      busTripType: BusTripType.values[json["busTripType"] ?? 0],
      days: json["days"] == null ? [] : List<WeekDays>.from(json["days"]!.map((x) => WeekDays.values[x])),
      id: json["id"] ?? 0,
      category: BusTripCategory.values[json["category"] ?? 0],
      numberOfParticipation: json["numberOfParticipation"] ?? 0,
      isActive: json["isActive"] ?? false,
      attendances: json["attendances"] == null
          ? []
          : List<TripHistoryItem>.from(
              json["attendances"]!.map((x) => TripHistoryItem.fromJson(x))),
      participations: json["participations"] == null
          ? []
          : List<Participation>.from(
              json["participations"]!.map((x) => Participation.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "tripTemplateId": tripTemplateId,
        "institutionId": institutionId,
        "pathId": pathId,
        "path": path.toJson(),
        "description": description,
        "distance": distance,
        "busId": busId,
        "bus": buses.map((e) => e.toJson()),
        "creationDate": creationDate?.toIso8601String(),
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "busTripType": busTripType,
        "days": days.map((x) => x).toList(),
        "id": id,
      };
}

class Participation {
  Participation({
    required this.id,
    required this.busTripId,
    required this.busMemberId,
  });

  final int id;
  final num busTripId;
  final num busMemberId;

  factory Participation.fromJson(Map<String, dynamic> json) {
    return Participation(
      id: json["id"] ?? 0,
      busTripId: json["busTripId"] ?? 0,
      busMemberId: json["busMemberId"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "busTripId": busTripId,
        "busMemberId": busMemberId,
      };
}
