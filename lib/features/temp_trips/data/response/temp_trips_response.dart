import '../../../../services/trip_path/data/models/trip_path.dart';

class TempTripsResponse {
  TempTripsResponse({
    required this.result,
  });

  final TempTripsResult result;

  factory TempTripsResponse.fromJson(Map<String, dynamic> json) {
    return TempTripsResponse(
      result: TempTripsResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class TempTripsResult {
  TempTripsResult({
    required this.totalCount,
    required this.items,
  });

  int totalCount;
  final List<TempTripModel> items;

  factory TempTripsResult.fromJson(Map<String, dynamic> json) {
    return TempTripsResult(
      totalCount: json["totalCount"] ?? 0,
      items: json["items"] == null
          ? []
          : List<TempTripModel>.from(
              json["items"]!.map((x) => TempTripModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class TempTripModel {
  TempTripModel({
    required this.id,
    required this.institutionId,
    required this.pathId,
    required this.path,
    required this.description,
    required this.distance,
  });

  final int id;
  final num institutionId;
  final num pathId;
  final TripPath path;
  final String description;
  final num distance;

  factory TempTripModel.fromJson(Map<String, dynamic> json) {
    return TempTripModel(
      id: json["id"] ?? 0,
      institutionId: json["institutionId"] ?? 0,
      pathId: json["pathId"] ?? 0,
      path: TripPath.fromJson(json["path"] ?? {}),
      description: json["description"] ?? "",
      distance: json["distance"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "institutionId": institutionId,
        "pathId": pathId,
        "path": path.toJson(),
        "description": description,
        "distance": distance,
      };
}
