import '../../../../core/strings/enum_manager.dart';

class FilterRecordCheckRequest {
  bool? isSubscribed;
  DateTime? startTime;
  DateTime? endTime;
  String? memberName;//
  String? supervisorName;

  FilterRecordCheckRequest({
    this.isSubscribed,
    this.startTime,
    this.endTime,
    this.memberName,
    this.supervisorName,
  });

  FilterRecordCheckRequest copyWith({
    bool? isSubscribed,
    DateTime? startTime,
    DateTime? endTime,
    String? memberName,
    String? supervisorName,
  }) {
    return FilterRecordCheckRequest(
      isSubscribed: isSubscribed ?? this.isSubscribed,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      memberName: memberName ?? this.memberName,
      supervisorName: supervisorName ?? this.supervisorName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isSubscribed': isSubscribed,
      'FromDate': startTime,
      'ToDate': endTime,
      'MemberName': memberName,
      'SupervisorName': supervisorName,
    };
  }

  factory FilterRecordCheckRequest.fromMap(Map<String, dynamic> map) {
    return FilterRecordCheckRequest(
      isSubscribed: map['isSubscribed'] as bool,
      startTime: map['startTime'] as DateTime,
      endTime: map['endTime'] as DateTime,
      memberName: map['memberName'] ?? '',
      supervisorName: map['SupervisorName'] ?? '',
    );
  }

  void clearFilter() {
    isSubscribed = null;
    startTime = null;
    endTime = null;
    memberName = null;
    supervisorName = null;
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
