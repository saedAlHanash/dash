import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../services/trip_path/data/models/trip_path.dart';
import '../../../drivers/data/response/drivers_response.dart';
import '../../../points/data/response/points_response.dart';

class SharedTripsResponse {
  SharedTripsResponse({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<SharedTrip> items;

  factory SharedTripsResponse.fromJson(Map<String, dynamic> json) {
    return SharedTripsResponse(
      totalCount: json['result']["totalCount"] ?? 0,
      items: json['result']["items"] == null
          ? []
          : List<SharedTrip>.from(json['result']["items"]!.map((x) => SharedTrip.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "items": items.map((x) => x.toJson()).toList(),
  };
}


class SharedTripResponse {
  SharedTripResponse({
    required this.result,
  });

  final SharedTrip result;

  factory SharedTripResponse.fromJson(Map<String, dynamic> json) {
    return SharedTripResponse(
      result: SharedTrip.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class SharedTrip {
  SharedTrip({
    required this.id,
    required this.driverId,
    required this.pathId,
    required this.path,
    required this.sharedRequests,
    required this.creationDate,
    required this.schedulingDate,
    required this.startDate,
    required this.endDate,
    required this.tripStatus,

    required this.seatCost,
    required this.totalCost,
    required this.note,
    required this.driver,
    required this.availableSeats,
    required this.reservedSeats,
  });

  final int id;
  final num driverId;
  final num pathId;
  final TripPath path;
  final List<SharedRequest> sharedRequests;
  final DateTime? creationDate;
  final DateTime? schedulingDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final dynamic tripStatus;

  final num seatCost;
  final num totalCost;
  final String note;
  final Driver driver;
  final num availableSeats;
  final num reservedSeats;

  String get cost {
    return '${seatCost * reservedSeats} ${AppStringManager.currency}';
  }

  bool get isStart => startDate != null;

  bool get isEnd => endDate != null;

  String get dateTrip {
    if (isStart && !isEnd) {
      return 'حالية';
    } else if (isEnd) {
      return endDate!.formatFullDate;
    }
    return schedulingDate?.formatFullDate ?? '';
  }

  SharedRequest? get myRequest {
    int myId = AppSharedPreference.getMyId;
    for (var e in sharedRequests) {
      if (e.clientId == myId) return e;
    }
    return null;
  }

  int status() {
    if (tripStatus == null) return 0;

    if (tripStatus is num) {
      return tripStatus;
    } else if (tripStatus is String) {
      return int.parse(tripStatus);
    }
    return 0;
  }

  factory SharedTrip.fromJson(Map<String, dynamic> json) {
    return SharedTrip(
      id: json["id"] ?? 0,
      driverId: json["driverId"] ?? 0,
      pathId: json["pathId"] ?? 0,
      path: TripPath.fromJson(json["path"] ?? {}),
      sharedRequests: json["sharedRequests"] == null
          ? []
          : List<SharedRequest>.from(
              json["sharedRequests"]!.map((x) => SharedRequest.fromJson(x))),
      creationDate: DateTime.tryParse(json["creationDate"] ?? ""),
      schedulingDate: DateTime.tryParse(json["schedulingDate"] ?? ""),
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      endDate: DateTime.tryParse(json["endDate"] ?? ""),
      tripStatus: json["tripStatus"],

      seatCost: json["seatCost"] ?? 0,
      totalCost: json["totalCost"] ?? 0,
      availableSeats: json["availableSeats"] ?? 0,
      reservedSeats: json["reservedSeats"] ?? 0,
      note: json["note"] ?? "",
      driver: Driver.fromJson(json["driver"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "driverId": driverId,
        "pathId": pathId,
        "path": path.toJson(),
        "sharedRequests": sharedRequests.map((x) => x.toJson()).toList(),
        "creationDate": creationDate?.toIso8601String(),
        "schedulingDate": schedulingDate?.toIso8601String(),
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "tripStatus": tripStatus,
        "seatCost": seatCost,
        "totalCost": totalCost,
        "availableSeats": availableSeats,
        "reservedSeats": reservedSeats,
        "note": note,
      };
}

class SharedRequest {
  SharedRequest({
    required this.id,
    required this.sharedTripId,
    required this.clientId,
    required this.client,
    required this.status,
    required this.seatNumber,
    required this.dropPointId,
    required this.dropPoint,
    required this.pickupPointId,
    required this.pickupPoint,
    required this.amount,
  });

  final int id;
  final num sharedTripId;
  final num clientId;
  final Client client;
  final num status;
  final int seatNumber;
  final num dropPointId;
  final TripPoint dropPoint;
  final num pickupPointId;
  final TripPoint pickupPoint;
  final num amount;

  factory SharedRequest.fromJson(Map<String, dynamic> json) {
    return SharedRequest(
      id: json["id"] ?? 0,
      sharedTripId: json["sharedTripId"] ?? 0,
      clientId: json["clientId"] ?? 0,
      client: Client.fromJson(json["client"] ?? {}),
      status: json["status"] ?? 0,
      seatNumber: json["seatNumber"] ?? 0,
      dropPointId: json["dropPointId"] ?? 0,
      dropPoint: TripPoint.fromJson(json["dropPoint"] ?? {}),
      pickupPointId: json["pickupPointId"] ?? 0,
      pickupPoint: TripPoint.fromJson(json["pickupPoint"] ?? {}),
      amount: json["amount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "sharedTripId": sharedTripId,
        "clientId": clientId,
        "client": client.toJson(),
        "status": status,
        "seatNumber": seatNumber,
        "dropPointId": dropPointId,
        "dropPoint": dropPoint.toJson(),
        "pickupPointId": pickupPointId,
        "pickupPoint": pickupPoint.toJson(),
        "amount": amount,
      };
}

class Client {
  Client({
    required this.userName,
    required this.fullName,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.avatar,
  });

  final String userName;
  final String fullName;
  final String name;
  final String surname;
  final String phoneNumber;
  final String avatar;

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      userName: json["userName"] ?? "",
      fullName: json["fullName"] ?? "",
      name: json["name"] ?? "",
      surname: json["surname"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      avatar: json["avatar"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "fullName": fullName,
        "name": name,
        "surname": surname,
        "phoneNumber": phoneNumber,
        "avatar": avatar,
      };
}

class Driver {
  Driver({
    required this.id,
    required this.userName,
    required this.fullName,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.imei,
    required this.avatar,
    required this.carType,
  });

  final int id;
  final String userName;
  final String fullName;
  final String name;
  final String surname;
  final String phoneNumber;
  final String imei;
  final String avatar;
  final CarType carType;

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json["id"] ?? 0,
      userName: json["userName"] ?? "",
      fullName: json["fullName"] ?? "",
      name: json["name"] ?? "",
      surname: json["surname"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      imei: json["imei"] ?? "",
      avatar: json["avatar"] ?? "",
      carType: CarType.fromJson(json["carType"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "fullName": fullName,
        "name": name,
        "surname": surname,
        "phoneNumber": phoneNumber,
        "imei": imei,
        "avatar": avatar,
        "carType": carType.toJson(),
      };
}
