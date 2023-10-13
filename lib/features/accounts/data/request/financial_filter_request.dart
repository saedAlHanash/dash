import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_models/extensions.dart';

class FinancialFilterRequest {
  int? driverId;
  DateTime? startTime;
  DateTime? endTime;

  FinancialFilterRequest({
    this.driverId,
    this.startTime,
    this.endTime,
  });

  FinancialFilterRequest week() {
    return copyWith(startTime: getServerDate.addFromNow(day: -7));
  }

  FinancialFilterRequest month() {
    return copyWith(startTime: getServerDate.addFromNow(month: -1));
  }

  FinancialFilterRequest year() {
    return copyWith(startTime: getServerDate.addFromNow(year: -1));
  }

  FinancialFilterRequest copyWith({
    int? driverId,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return FinancialFilterRequest(
      driverId: driverId ?? this.driverId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'driverId': driverId,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String() ?? getServerDate,
    };
  }

  void clearFilter() {
    driverId = null;
    startTime = null;
    endTime = null;
  }
}
