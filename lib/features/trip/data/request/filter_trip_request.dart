class FilterTripRequest {
  int? driverId;

  int? customerId;
  String? clientName;
  String? driverPhone;
  String? clientPhone;

  int? carCategoryId;

  DateTime? startTime;
  DateTime? endTime;

//<editor-fold desc="Data Methods">
  FilterTripRequest({
    this.driverId,
    this.customerId,
    this.carCategoryId,
    this.clientName,
    this.driverPhone,
    this.clientPhone,
    this.startTime,
    this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'driverId': driverId == -1 ? null : driverId,
      'customerId': customerId == -1 ? null : customerId,
      'ClientId': customerId == -1 ? null : customerId,
      'carCategoryId': carCategoryId == -1 ? null : carCategoryId,
      'startTime': startTime,
      'endTime': endTime,
      'DriverPhone': (driverPhone?.isEmpty ?? true) ? null : driverPhone,
      'ClientPhone': (clientPhone?.isEmpty ?? true) ? null : clientPhone,
    };
  }

//</editor-fold>
}
