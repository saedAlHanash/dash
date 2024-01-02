import 'package:qareeb_models/global.dart';

class PlanAttendanceFilter {
  int? userId;
  int? companyId;
  int? driverId;

  int? planId;
  int? planTripId;

  String? driverName;
  String? companyName;
  String? userName;

  DateTime? startTime;
  DateTime? endTime;

//<editor-fold desc="Data Methods">
  PlanAttendanceFilter({
    this.userId,
    this.companyId,
    this.driverId,
    this.userName,
    this.driverName,
    this.companyName,
    this.startTime,
    this.endTime,
    this.planId,
    this.planTripId,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'driverName': driverName,
      'companyName': companyName,
      'userId': userId,
      'driverId': driverId,
      'planTripId': planTripId,
      'planId': planId,
      'companyId': companyId,
      'fromDate': startTime?.toIso8601String(),
      'toDate': endTime?.toIso8601String(),
    };
  }

  void clearFilter() {
    userName = null;
    driverName = null;
    companyName = null;
    userId = null;
    driverId = null;
    planTripId = null;
    planId = null;
    companyId = null;
    startTime = null;
    endTime = null;
  }

//</editor-fold>
}
