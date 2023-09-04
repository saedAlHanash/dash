import '../../../../core/strings/enum_manager.dart';

/*

 */
class TripsFilterRequest {
  DateTime? startTime;
  DateTime? endTime;
  String? name;
  String? busName;
  String? busNumber;

  TripsFilterRequest({
    this.startTime,
    this.endTime,
    this.name,
    this.busName,
    this.busNumber,
  });

  TripsFilterRequest copyWith({
    DateTime? startTime,
    DateTime? endTime,
    String? name,
    String? busName,
    String? busNumber,
  }) {
    return TripsFilterRequest(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      name: name ?? this.name,
      busName: busName ?? this.busName,
      busNumber: busNumber ?? this.busNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'busName': busName,
      'busNumber': busNumber,
      'fromDate': startTime,
      'toDate': endTime,
    };
  }

  factory TripsFilterRequest.fromMap(Map<String, dynamic> map) {
    return TripsFilterRequest(
      startTime: map['startTime'] as DateTime,
      endTime: map['endTime'] as DateTime,
      name: map['name'] ?? '',
      busName: map['busName'] ?? '',
      busNumber: map['busNumber'] ?? '',
    );
  }

  void clearFilter() {
    startTime = null;
    endTime = null;

    name = null;
    busName = null;
    busNumber = null;
  }

//</editor-fold>
}

/*
BusTripId
integer($int32)
(query)
BusTripId
BusMemberId
integer($int32)
(query)
BusMemberId
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
