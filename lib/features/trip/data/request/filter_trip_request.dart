class FilterTripRequest {

  int? clientId;
  int? driverId;

  String? driverName;
  String? clientName;

  String? driverPhone;
  String? clientPhone;


  DateTime? startTime;
  DateTime? endTime;

//<editor-fold desc="Data Methods">
  FilterTripRequest({
    this.clientId,
    this.driverId,
    this.clientName,
    this.driverName,
    this.clientPhone,
    this.driverPhone,
    this.startTime,
    this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'ClientId': clientId ,
      'DriverId': driverId ,
      'DriverName': driverName ,
      'ClientName': clientName ,
      'DriverPhone':  driverPhone,
      'ClientPhone':  clientPhone,
      'FromDate': startTime?.toIso8601String(),
      'ToDate': endTime?.toIso8601String(),
    };
  }
  void clearFilter() {
    clientId = null;
    driverId = null;
    driverName = null;
    clientName = null;
    driverPhone = null;
    clientPhone = null;
    startTime = null;
    endTime = null;
  }

//</editor-fold>
}
