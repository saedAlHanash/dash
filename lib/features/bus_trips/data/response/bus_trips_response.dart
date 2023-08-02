import 'package:collection/collection.dart';
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
      days: json["days"] == null
          ? []
          : List<WeekDays>.from(json["days"]!.map((x) => WeekDays.values[x])),
      id: json["id"] ?? 0,
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

class ApiServerRequest {
  ApiServerRequest({
    required this.id,
    required this.name,
    required this.tripTemplateId,
    required this.institutionId,
    required this.pathId,
    required this.path,
    required this.description,
    required this.distance,
    required this.buses,
    required this.creationDate,
    required this.startDate,
    required this.endDate,
    required this.busTripType,
    required this.days,
    required this.attendances,
  });

  final int id;
  final String name;
  final num tripTemplateId;
  final num institutionId;
  final num pathId;
  final Path? path;
  final String description;
  final num distance;
  final List<BusModel> buses;
  final DateTime? creationDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final String busTripType;
  final List<String> days;
  final List<Attendance> attendances;

  factory ApiServerRequest.fromJson(Map<String, dynamic> json) {
    return ApiServerRequest(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      tripTemplateId: json["tripTemplateId"] ?? 0,
      institutionId: json["institutionId"] ?? 0,
      pathId: json["pathId"] ?? 0,
      path: json["path"] == null ? null : Path.fromJson(json["path"]),
      description: json["description"] ?? "",
      distance: json["distance"] ?? 0,
      buses: json["buses"] == null
          ? []
          : List<BusModel>.from(json["buses"]!.map((x) => BusModel.fromJson(x))),
      creationDate: DateTime.tryParse(json["creationDate"] ?? ""),
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      endDate: DateTime.tryParse(json["endDate"] ?? ""),
      busTripType: json["busTripType"] ?? "",
      days: json["days"] == null ? [] : List<String>.from(json["days"]!.map((x) => x)),
      attendances: json["attendances"] == null
          ? []
          : List<Attendance>.from(
              json["attendances"]!.map((x) => Attendance.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tripTemplateId": tripTemplateId,
        "institutionId": institutionId,
        "pathId": pathId,
        "path": path?.toJson(),
        "description": description,
        "distance": distance,
        "buses": buses.map((x) => x?.toJson()).toList(),
        "creationDate": creationDate?.toIso8601String(),
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "busTripType": busTripType,
        "days": days.map((x) => x).toList(),
        "attendances": attendances.map((x) => x?.toJson()).toList(),
      };
}

class Attendance {
  Attendance({
    required this.id,
    required this.busTripId,
    required this.busTrip,
    required this.busMemberId,
    required this.busMember,
    required this.date,
    required this.attendanceType,
    required this.isParticipated,
  });

  final int id;
  final num busTripId;
  final String busTrip;
  final num busMemberId;
  final Member? busMember;
  final DateTime? date;
  final String attendanceType;
  final bool isParticipated;

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json["id"] ?? 0,
      busTripId: json["busTripId"] ?? 0,
      busTrip: json["busTrip"] ?? "",
      busMemberId: json["busMemberId"] ?? 0,
      busMember: json["busMember"] == null ? null : Member.fromJson(json["busMember"]),
      date: DateTime.tryParse(json["date"] ?? ""),
      attendanceType: json["attendanceType"] ?? "",
      isParticipated: json["isParticipated"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "busTripId": busTripId,
        "busTrip": busTrip,
        "busMemberId": busMemberId,
        "busMember": busMember?.toJson(),
        "date": date?.toIso8601String(),
        "attendanceType": attendanceType,
        "isParticipated": isParticipated,
      };
}

class Subscription {
  Subscription({
    required this.id,
    required this.institutionId,
    required this.institution,
    required this.memberId,
    required this.member,
    required this.supscriptionDate,
    required this.expirationDate,
    required this.isActive,
  });

  final int id;
  final num institutionId;
  final Institution? institution;
  final num memberId;
  final Member? member;
  final DateTime? supscriptionDate;
  final DateTime? expirationDate;
  final bool isActive;

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json["id"] ?? 0,
      institutionId: json["institutionId"] ?? 0,
      institution:
          json["institution"] == null ? null : Institution.fromJson(json["institution"]),
      memberId: json["memberId"] ?? 0,
      member: json["member"] == null ? null : Member.fromJson(json["member"]),
      supscriptionDate: DateTime.tryParse(json["supscriptionDate"] ?? ""),
      expirationDate: DateTime.tryParse(json["expirationDate"] ?? ""),
      isActive: json["isActive"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "institutionId": institutionId,
        "institution": institution?.toJson(),
        "memberId": memberId,
        "member": member?.toJson(),
        "supscriptionDate": supscriptionDate?.toIso8601String(),
        "expirationDate": expirationDate?.toIso8601String(),
        "isActive": isActive,
      };
}

class Member {
  Member({
    required this.id,
    required this.fullName,
    required this.imageUrl,
    required this.address,
    required this.late,
    required this.longe,
    required this.userName,
    required this.password,
    required this.institutionId,
    required this.subscriptions,
  });

  final int id;
  final String fullName;
  final String imageUrl;
  final String address;
  final num late;
  final num longe;
  final String userName;
  final String password;
  final num institutionId;
  final List<Subscription> subscriptions;

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json["id"] ?? 0,
      fullName: json["fullName"] ?? "",
      imageUrl: json["imageUrl"] ?? "",
      address: json["address"] ?? "",
      late: json["late"] ?? 0,
      longe: json["longe"] ?? 0,
      userName: json["userName"] ?? "",
      password: json["password"] ?? "",
      institutionId: json["institutionId"] ?? 0,
      subscriptions: json["subscriptions"] == null
          ? []
          : List<Subscription>.from(
              json["subscriptions"]!.map((x) => Subscription.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "imageUrl": imageUrl,
        "address": address,
        "late": late,
        "longe": longe,
        "userName": userName,
        "password": password,
        "institutionId": institutionId,
        "subscriptions": subscriptions.map((x) => x?.toJson()).toList(),
      };
}

class Institution {
  Institution({
    required this.id,
    required this.name,
    required this.government,
    required this.type,
    required this.imageUrl,
    required this.atharKey,
    required this.isActive,
  });

  final int id;
  final String name;
  final String government;
  final String type;
  final String imageUrl;
  final String atharKey;
  final bool isActive;

  factory Institution.fromJson(Map<String, dynamic> json) {
    return Institution(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      government: json["government"] ?? "",
      type: json["type"] ?? "",
      imageUrl: json["imageUrl"] ?? "",
      atharKey: json["atharKey"] ?? "",
      isActive: json["isActive"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "government": government,
        "type": type,
        "imageUrl": imageUrl,
        "atharKey": atharKey,
        "isActive": isActive,
      };
}

class Supervisor {
  Supervisor({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.userName,
    required this.password,
    required this.busId,
    required this.bus,
    required this.institutionId,
  });

  final int id;
  final String fullName;
  final String phone;
  final String userName;
  final String password;
  final num busId;
  final String bus;
  final num institutionId;

  factory Supervisor.fromJson(Map<String, dynamic> json) {
    return Supervisor(
      id: json["id"] ?? 0,
      fullName: json["fullName"] ?? "",
      phone: json["phone"] ?? "",
      userName: json["userName"] ?? "",
      password: json["password"] ?? "",
      busId: json["busId"] ?? 0,
      bus: json["bus"] ?? "",
      institutionId: json["institutionId"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "phone": phone,
        "userName": userName,
        "password": password,
        "busId": busId,
        "bus": bus,
        "institutionId": institutionId,
      };
}

class Path {
  Path({
    required this.id,
    required this.name,
    required this.arName,
    required this.edges,
  });

  final int id;
  final String name;
  final String arName;
  final List<Edge> edges;

  factory Path.fromJson(Map<String, dynamic> json) {
    return Path(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      arName: json["arName"] ?? "",
      edges: json["edges"] == null
          ? []
          : List<Edge>.from(json["edges"]!.map((x) => Edge.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "arName": arName,
        "edges": edges.map((x) => x?.toJson()).toList(),
      };
}

class Edge {
  Edge({
    required this.id,
    required this.startPoint,
    required this.startPointId,
    required this.endPoint,
    required this.endPointId,
    required this.distance,
    required this.price,
    required this.steps,
    required this.name,
    required this.arName,
  });

  final int id;
  final Point? startPoint;
  final num startPointId;
  final Point? endPoint;
  final num endPointId;
  final num distance;
  final num price;
  final String steps;
  final String name;
  final String arName;

  factory Edge.fromJson(Map<String, dynamic> json) {
    return Edge(
      id: json["id"] ?? 0,
      startPoint: json["startPoint"] == null ? null : Point.fromJson(json["startPoint"]),
      startPointId: json["startPointId"] ?? 0,
      endPoint: json["endPoint"] == null ? null : Point.fromJson(json["endPoint"]),
      endPointId: json["endPointId"] ?? 0,
      distance: json["distance"] ?? 0,
      price: json["price"] ?? 0,
      steps: json["steps"] ?? "",
      name: json["name"] ?? "",
      arName: json["arName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "startPoint": startPoint?.toJson(),
        "startPointId": startPointId,
        "endPoint": endPoint?.toJson(),
        "endPointId": endPointId,
        "distance": distance,
        "price": price,
        "steps": steps,
        "name": name,
        "arName": arName,
      };
}

class Point {
  Point({
    required this.id,
    required this.name,
    required this.arName,
    required this.latitude,
    required this.langitude,
    required this.tags,
  });

  final int id;
  final String name;
  final String arName;
  final num latitude;
  final num langitude;
  final String tags;

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      arName: json["arName"] ?? "",
      latitude: json["latitude"] ?? 0,
      langitude: json["langitude"] ?? 0,
      tags: json["tags"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "arName": arName,
        "latitude": latitude,
        "langitude": langitude,
        "tags": tags,
      };
}
