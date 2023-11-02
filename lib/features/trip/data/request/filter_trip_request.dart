import 'package:qareeb_models/global.dart';

class FilterTripRequest {
  int? clientId;
  int? driverId;
  int? agencyId;
  int? carCategoryId;

  String? driverName;
  String? clientName;

  String? driverPhone;
  String? clientPhone;

  TripStatus? tripStatus;
  TripType? tripType;
  DateTime? startTime;
  DateTime? endTime;

//<editor-fold desc="Data Methods">
  FilterTripRequest({
    this.clientId,
    this.driverId,
    this.agencyId,
    this.carCategoryId,
    this.clientName,
    this.driverName,
    this.clientPhone,
    this.driverPhone,
    this.startTime,
    this.endTime,
    this.tripStatus,
    this.tripType,
  });

  Map<String, dynamic> toMap() {
    return {
      'ClientId': clientId,
      'DriverId': driverId,
      'agencyId': agencyId,
      'carCategoryId': carCategoryId,
      'DriverName': driverName,
      'ClientName': clientName,
      'DriverPhone': driverPhone,
      'ClientPhone': clientPhone,
      'Status': tripStatus?.index,
      'Type': tripType?.index,
      'FromDate': startTime?.toIso8601String(),
      'ToDate': endTime?.toIso8601String(),
    };
  }

  void clearFilter() {
    clientId = null;
    driverId = null;
    carCategoryId = null;
    agencyId = null;
    driverName = null;
    clientName = null;
    driverPhone = null;
    clientPhone = null;
    startTime = null;
    endTime = null;
    tripStatus = null;
    tripType = null;
  }

//</editor-fold>
}
