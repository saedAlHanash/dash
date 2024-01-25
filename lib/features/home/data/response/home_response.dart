import 'package:latlong2/latlong.dart';

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
        "result": result.toJson(),
      };
}

class HomeResult {
  HomeResult({
    required this.membersCount,
    required this.membersWithSubscription,
    required this.membersWithoutSubscription,
    required this.imeis,
    required this.notificationPoints,
    required this.currentAttendencesInBuses,
  });

  final num membersCount;
  final num membersWithSubscription;
  final num membersWithoutSubscription;
  final List<Imei> imeis;
  final List<NotificationPoint> notificationPoints;
  final List<CurrentAttendencesInBus> currentAttendencesInBuses;

  List<String> get getCurrentTripIme {
    return currentAttendencesInBuses.map((e) => e.imei).toList();
  }

  int getCountByImei(String imei) {
    for (var e in currentAttendencesInBuses) {
      if (e.imei == imei) return e.countOfAttendence;
    }
    return -1;
  }

  factory HomeResult.fromJson(Map<String, dynamic> json) {
    return HomeResult(
      membersCount: json["membersCount"] ?? 0,
      membersWithSubscription: json["membersWithSubscription"] ?? 0,
      membersWithoutSubscription: json["membersWithoutSubscription"] ?? 0,
      imeis: json["imeis"] == null
          ? []
          : List<Imei>.from(json["imeis"]!.map((x) => Imei.fromJson(x))),
      notificationPoints: json["notificationPoints"] == null
          ? []
          : List<NotificationPoint>.from(
              json["notificationPoints"]!.map((x) => NotificationPoint.fromJson(x))),
      currentAttendencesInBuses: json["currentAttendencesInBuses"] == null
          ? []
          : List<CurrentAttendencesInBus>.from(json["currentAttendencesInBuses"]!
              .map((x) => CurrentAttendencesInBus.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "membersCount": membersCount,
        "membersWithSubscription": membersWithSubscription,
        "membersWithoutSubscription": membersWithoutSubscription,
        "imeis": imeis.map((x) => x.toJson()).toList(),
        "notificationPoints": notificationPoints.map((x) => x.toJson()).toList(),
        "currentAttendencesInBuses":
            currentAttendencesInBuses.map((x) => x.toJson()).toList(),
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
  final double latitude;
  final double longitude;
  final int subscriperCount;

  LatLng get getLatLng => LatLng(latitude, longitude);

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

class CurrentAttendencesInBus {
  CurrentAttendencesInBus({
    required this.imei,
    required this.countOfAttendence,
  });

  final String imei;
  final int countOfAttendence;

  factory CurrentAttendencesInBus.fromJson(Map<String, dynamic> json) {
    return CurrentAttendencesInBus(
      imei: json["imei"] ?? "",
      countOfAttendence: json["countOfAttendence"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "imei": imei,
        "countOfAttendence": countOfAttendence,
      };
}

class Imei {
  Imei({
    required this.id,
    required this.ime,
  });

  final int id;
  final String ime;

  factory Imei.fromJson(Map<String, dynamic> json) {
    return Imei(
      id: json["id"] ?? 0,
      ime: json["ime"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "ime": ime,
      };
}
