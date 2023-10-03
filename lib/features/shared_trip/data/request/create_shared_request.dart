import '../../../../core/util/shared_preferences.dart';

class RequestCreateShared {
  RequestCreateShared({
    this.driverId,
    this.id,
    this.schedulingDate,
    this.tripStatus,
    this.seatsNumber,
    this.seatCost,
    this.totalCost,
  });

  int? driverId;
  int? id;

  DateTime? schedulingDate;
  String? tripStatus;
  int? seatsNumber;
  num? seatCost;
  num? totalCost;
  List<int> pathEdgesIds = [];

  //________________

  factory RequestCreateShared.fromJson(Map<String, dynamic> json) {
    return RequestCreateShared(
      driverId: json["driverId"] ?? 0,
      id: json["id"] ?? 0,
      schedulingDate: DateTime.tryParse(json["schedulingDate"] ?? ""),
      tripStatus: json["tripStatus"] ?? "",
      seatsNumber: json["seatsNumber"] ?? 0,
      seatCost: json["seatCost"] ?? 0,
      totalCost: json["totalCost"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "driverId": driverId,
        "schedulingDate": schedulingDate?.toIso8601String(),
        "tripStatus": tripStatus,
        "seatsNumber": seatsNumber,
        "seatCost": seatCost,
        "totalCost": totalCost,
        "pathEdgesIds": pathEdgesIds.isEmpty ? null : pathEdgesIds.map((x) => x).toList(),
      };
}
