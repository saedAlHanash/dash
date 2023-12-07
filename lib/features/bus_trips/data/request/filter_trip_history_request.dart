import '../../../../core/strings/enum_manager.dart';

class FilterAttendancesRequest {
  AttendanceType? attendanceType;
  bool? isParticipated;
  bool? isSubscribed;
  DateTime? startTime;
  DateTime? endTime;
  String? busTripTemplateName;
  String? memberName;
  String? busName;
  String? busNumber;

  FilterAttendancesRequest({
    this.attendanceType,
    this.isParticipated,
    this.isSubscribed,
    this.startTime,
    this.endTime,
    this.busTripTemplateName,
    this.memberName,
    this.busName,
    this.busNumber,
  });

  FilterAttendancesRequest copyWith({
    AttendanceType? attendanceType,
    bool? isParticipated,
    bool? isSubscribed,
    DateTime? startTime,
    DateTime? endTime,
    String? busTripTemplateName,
    String? memberName,
    String? busName,
    String? busNumber,
  }) {
    return FilterAttendancesRequest(
      attendanceType: attendanceType ?? this.attendanceType,
      isParticipated: isParticipated ?? this.isParticipated,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      busTripTemplateName: busTripTemplateName ?? this.busTripTemplateName,
      memberName: memberName ?? this.memberName,
      busName: busName ?? this.busName,
      busNumber: busNumber ?? this.busNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'attendanceType': attendanceType?.index,
      'isParticipated': isParticipated,
      'isSubscribed': isSubscribed,
      'FromDate': startTime,
      'ToDate': endTime,
      'busTripTemplateName': busTripTemplateName,
      'memberName': memberName,
      'busName': busName,
      'busNumber': busNumber,
    };
  }

  factory FilterAttendancesRequest.fromMap(Map<String, dynamic> map) {
    return FilterAttendancesRequest(
      attendanceType: map['attendanceType'] as AttendanceType,
      isParticipated: map['isParticipated'] as bool,
      isSubscribed: map['isSubscribed'] as bool,
      startTime: map['startTime'] as DateTime,
      endTime: map['endTime'] as DateTime,
      busTripTemplateName: map['busTripTemplateName'] ?? '',
      memberName: map['memberName'] ?? '',
      busName: map['busName'] ?? '',
      busNumber: map['busNumber'] ?? '',
    );
  }

  void clearFilter() {
    attendanceType = null;
    isParticipated = null;
    isSubscribed = null;
    startTime = null;
    endTime = null;
    busTripTemplateName = null;
    memberName = null;
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
