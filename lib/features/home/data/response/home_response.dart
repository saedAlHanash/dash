class HomeResponse {
  HomeResponse({
    required this.result,
  });

  final HomeResult result;

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      result: HomeResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
      };
}

class HomeResult {
  HomeResult({
    required this.membersCount,
    required this.imeis,
    required this.notificationPoints,
  });

  final num membersCount;
  final List<String> imeis;
  final List<NotificationPoint> notificationPoints;

  factory HomeResult.fromJson(Map<String, dynamic> json) {
    return HomeResult(
      membersCount: json["membersCount"] ?? 0,
      imeis: json["imeis"] == null ? [] : List<String>.from(json["imeis"]!.map((x) => x)),
      notificationPoints: json["notificationPoints"] == null
          ? []
          : List<NotificationPoint>.from(
              json["notificationPoints"]!.map((x) => NotificationPoint.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "membersCount": membersCount,
        "imeis": imeis.map((x) => x).toList(),
        "notificationPoints": notificationPoints.map((x) => x?.toJson()).toList(),
      };
}

class NotificationPoint {
  NotificationPoint({
    required this.pointId,
    required this.pointName,
    required this.pointArName,
    required this.latitude,
    required this.longitude,
    required this.subscriperCount,
  });

  final num pointId;
  final String pointName;
  final String pointArName;
  final num latitude;
  final num longitude;
  final num subscriperCount;

  factory NotificationPoint.fromJson(Map<String, dynamic> json) {
    return NotificationPoint(
      pointId: json["pointId"] ?? 0,
      pointName: json["pointName"] ?? "",
      pointArName: json["pointArName"] ?? "",
      latitude: json["latitude"] ?? 0,
      longitude: json["longitude"] ?? 0,
      subscriperCount: json["subscriperCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "pointId": pointId,
        "pointName": pointName,
        "pointArName": pointArName,
        "latitude": latitude,
        "longitude": longitude,
        "subscriperCount": subscriperCount,
      };
}
