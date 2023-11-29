import '../../../../core/strings/enum_manager.dart';

/*

 */
class TripsFilterRequest {
  DateTime? startTime;
  DateTime? endTime;
  String? name;
  String? planName;
  String? planNumber;

  TripsFilterRequest({
    this.startTime,
    this.endTime,
    this.name,
    this.planName,
    this.planNumber,
  });

  TripsFilterRequest copyWith({
    DateTime? startTime,
    DateTime? endTime,
    String? name,
    String? planName,
    String? planNumber,
  }) {
    return TripsFilterRequest(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      name: name ?? this.name,
      planName: planName ?? this.planName,
      planNumber: planNumber ?? this.planNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'planName': planName,
      'planNumber': planNumber,
      'fromDate': startTime,
      'toDate': endTime,
    };
  }

  factory TripsFilterRequest.fromMap(Map<String, dynamic> map) {
    return TripsFilterRequest(
      startTime: map['startTime'] as DateTime,
      endTime: map['endTime'] as DateTime,
      name: map['name'] ?? '',
      planName: map['planName'] ?? '',
      planNumber: map['planNumber'] ?? '',
    );
  }

  void clearFilter() {
    startTime = null;
    endTime = null;

    name = null;
    planName = null;
    planNumber = null;
  }

//</editor-fold>
}

/*
planTripId
integer($int32)
(query)
planTripId
planMemberId
integer($int32)
(query)
planMemberId
FromDate
string($date-time)
(query)
FromDate
ToDate
string($date-time)
(query)
ToDate
AttendanceType
string
(query)
Available values : up, down, unknowin


--
IsParticipated
 */
