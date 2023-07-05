import '../../../../core/util/shared_preferences.dart';

class RequestCreateShared {
  RequestCreateShared({
    this.driverId,
    this.schedulingDate,
    this.tripStatus = 'Pending',
    this.seatsNumber = 5,
    this.seatCost = 5000,
    this.totalCost = 25000,
  }) {
    driverId = AppSharedPreference.getMyId;
  }

  int? driverId;

  DateTime? schedulingDate;
  String tripStatus;
  int seatsNumber;
  num seatCost;
  num totalCost;
  List<int> pathEdgesIds = [];

  //________________

  factory RequestCreateShared.fromJson(Map<String, dynamic> json) {
    return RequestCreateShared(
      driverId: json["driverId"] ?? 0,
      schedulingDate: DateTime.tryParse(json["schedulingDate"] ?? ""),
      tripStatus: json["tripStatus"] ?? "",
      seatsNumber: json["seatsNumber"] ?? 0,
      seatCost: json["seatCost"] ?? 0,
      totalCost: json["totalCost"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "driverId": driverId,
        "schedulingDate": schedulingDate?.toIso8601String(),
        "tripStatus": tripStatus,
        "seatsNumber": seatsNumber,
        "seatCost": seatCost,
        "totalCost": totalCost,
        "pathEdgesIds":pathEdgesIds.isEmpty?null: pathEdgesIds.map((x) => x).toList(),
      };
}
