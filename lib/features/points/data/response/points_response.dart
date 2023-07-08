class PointsResponse {
  PointsResponse({
    required this.result,
  });

  final PointsResult result;

  factory PointsResponse.fromJson(Map<String, dynamic> json) {
    return PointsResponse(
      result: PointsResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class PointsResult {
  PointsResult({
    required this.totalCount,
    required this.items,
  });

  final num totalCount;
  final List<TripPoint> items;

  factory PointsResult.fromJson(Map<String, dynamic> json) {
    return PointsResult(
      totalCount: json["totalCount"] ?? 0,
      items: json["items"] == null
          ? []
          : List<TripPoint>.from(json["items"]!.map((x) => TripPoint.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class TripPoint {
  TripPoint({
    required this.id,
    required this.name,
    required this.arName,
    required this.tags,
    required this.lat,
    required this.lng,
  });

  final int id;
  final String name;
  final String arName;
  final String tags;
  final double lat;
  final double lng;

  factory TripPoint.fromJson(Map<String, dynamic> json) {
    return TripPoint(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      tags: json["tags"] ?? "",
      arName: json["arName"] ?? "",
      lat: json["latitude"] ?? 0,
      lng: json["langitude"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "arName": arName,
        "tags": tags,
        "latitude": lat,
        "langitude": lng,
      };
}
