class FilterTripRequest {
  int? driverId;

  int? customerId;

  int? carCategoryId;

  DateTime? startTime;
  DateTime? endTime;

  void reset() {
    driverId;
    customerId;
    carCategoryId;
    startTime = null;
    endTime = null;
  }

//<editor-fold desc="Data Methods">
  FilterTripRequest({
    this.driverId,
    this.customerId,
    this.carCategoryId,
    this.startTime,
    this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'driverId': driverId,
      'customerId': customerId,
      'carCategoryId': carCategoryId,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

//</editor-fold>
}
