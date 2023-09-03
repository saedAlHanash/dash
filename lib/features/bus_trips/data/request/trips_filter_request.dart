import '../../../../core/strings/enum_manager.dart';

class TripsFilterRequest {
  bool? isActive;
  DateTime? startTime;
  DateTime? endTime;
  String? busTripTemplateName;
  String? name;
  String? busName;
  String? busNumber;

  TripsFilterRequest({
    this.isActive,
    this.startTime,
    this.endTime,
    this.busTripTemplateName,
    this.name,
    this.busName,
    this.busNumber,
  });

  TripsFilterRequest copyWith({
    bool? isActive,
    DateTime? startTime,
    DateTime? endTime,
    String? busTripTemplateName,
    String? name,
    String? busName,
    String? busNumber,
  }) {
    return TripsFilterRequest(
      isActive: isActive ?? this.isActive,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      busTripTemplateName: busTripTemplateName ?? this.busTripTemplateName,
      name: name ?? this.name,
      busName: busName ?? this.busName,
      busNumber: busNumber ?? this.busNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isActive': isActive,
      'startTime': startTime,
      'endTime': endTime,
      'busTripTemplateName': busTripTemplateName,
      'name': name,
      'busName': busName,
      'busNumber': busNumber,
    };
  }

  factory TripsFilterRequest.fromMap(Map<String, dynamic> map) {
    return TripsFilterRequest(
      isActive: map['isActive'] as bool,
      startTime: map['startTime'] as DateTime,
      endTime: map['endTime'] as DateTime,
      busTripTemplateName: map['busTripTemplateName'] ?? '',
      name: map['name'] ?? '',
      busName: map['busName'] ?? '',
      busNumber: map['busNumber'] ?? '',
    );
  }

  void clearFilter() {
    isActive = null;
    startTime = null;
    endTime = null;
    busTripTemplateName = null;
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
