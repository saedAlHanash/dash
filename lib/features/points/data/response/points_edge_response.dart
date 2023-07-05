import 'package:qareeb_dash/features/points/data/response/points_response.dart';

class PointsEdgeResponse {
  PointsEdgeResponse({
    required this.result,
  });

  final PointsEdgeResult result;

  factory PointsEdgeResponse.fromJson(Map<String, dynamic> json) {
    return PointsEdgeResponse(
      result: PointsEdgeResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class PointsEdgeResult {
  PointsEdgeResult({
    required this.startPoint,
    required this.startPointId,
    required this.endPoint,
    required this.endPointId,
    required this.distance,
    required this.price,
    required this.steps,
    required this.name,
    required this.arName,
    required this.id,
  });

  final TripPoint startPoint;
  final TripPoint endPoint;
  final int startPointId;
  final int endPointId;
  final num distance;
  final num price;
  final String steps;
  final String name;
  final String arName;
  final int id;

  factory PointsEdgeResult.fromJson(Map<String, dynamic> json) {
    return PointsEdgeResult(
      startPoint: TripPoint.fromJson(json["startPoint"] ?? {}),
      endPoint: TripPoint.fromJson(json["endPoint"] ?? {}),
      startPointId: json["startPointId"] ?? 0,
      endPointId: json["endPointId"] ?? 0,
      distance: json["distance"] ?? 0,
      price: json["price"] ?? 0,
      steps: json["steps"] ?? "",
      name: json["name"] ?? "",
      arName: json["arName"] ?? "",
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "startPoint": startPoint.toJson(),
        "startPointId": startPointId,
        "endPoint": endPoint.toJson(),
        "endPointId": endPointId,
        "distance": distance,
        "price": price,
        "steps": steps,
        "name": name,
        "arName": arName,
        "id": id,
      };
}
