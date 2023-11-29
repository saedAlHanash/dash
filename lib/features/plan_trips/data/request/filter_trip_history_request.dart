import 'package:qareeb_models/global.dart';


class FilterTripHistoryRequest {
  AttendanceType? attendanceType;
  bool? isParticipated;
  bool? isSubscribed;
  DateTime? startTime;
  DateTime? endTime;
  String? planTripTemplateName;
  String? memberName;
  String? planName;
  String? planNumber;

  FilterTripHistoryRequest({
    this.attendanceType,
    this.isParticipated,
    this.isSubscribed,
    this.startTime,
    this.endTime,
    this.planTripTemplateName,
    this.memberName,
    this.planName,
    this.planNumber,
  });

  FilterTripHistoryRequest copyWith({
    AttendanceType? attendanceType,
    bool? isParticipated,
    bool? isSubscribed,
    DateTime? startTime,
    DateTime? endTime,
    String? planTripTemplateName,
    String? memberName,
    String? planName,
    String? planNumber,
  }) {
    return FilterTripHistoryRequest(
      attendanceType: attendanceType ?? this.attendanceType,
      isParticipated: isParticipated ?? this.isParticipated,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      planTripTemplateName: planTripTemplateName ?? this.planTripTemplateName,
      memberName: memberName ?? this.memberName,
      planName: planName ?? this.planName,
      planNumber: planNumber ?? this.planNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'attendanceType': attendanceType?.index,
      'isParticipated': isParticipated,
      'isSubscribed': isSubscribed,
      'FromDate': startTime,
      'ToDate': endTime,
      'planTripTemplateName': planTripTemplateName,
      'memberName': memberName,
      'planName': planName,
      'planNumber': planNumber,
    };
  }

  factory FilterTripHistoryRequest.fromMap(Map<String, dynamic> map) {
    return FilterTripHistoryRequest(
      attendanceType: map['attendanceType'] as AttendanceType,
      isParticipated: map['isParticipated'] as bool,
      isSubscribed: map['isSubscribed'] as bool,
      startTime: map['startTime'] as DateTime,
      endTime: map['endTime'] as DateTime,
      planTripTemplateName: map['planTripTemplateName'] ?? '',
      memberName: map['memberName'] ?? '',
      planName: map['planName'] ?? '',
      planNumber: map['planNumber'] ?? '',
    );
  }

  void clearFilter() {
    attendanceType = null;
    isParticipated = null;
    isSubscribed = null;
    startTime = null;
    endTime = null;
    planTripTemplateName = null;
    memberName = null;
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
