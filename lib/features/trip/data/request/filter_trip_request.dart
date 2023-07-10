class FilterTripRequest {
  int? driverId;
  int? customerId;
  int? carCategoryId;
  DateTime? startTime;
  DateTime? endTime;
  int? skipCount;
  int? maxResultCount;

//<editor-fold desc="Data Methods">
  FilterTripRequest({
    this.driverId,
    this.customerId,
    this.carCategoryId,
    this.startTime,
    this.endTime,
    this.skipCount,
    this.maxResultCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'driverId': driverId,
      'customerId': customerId,
      'carCategoryId': carCategoryId,
      'startTime': startTime,
      'endTime': endTime,
      'skipCount': skipCount,
      'maxResultCount': maxResultCount,
    };
  }

//</editor-fold>
}
