import '../../../../core/strings/enum_manager.dart';

class FilterTripHistoryRequest {
  int? busTripId;
  int? busMemberId;
  AttendanceType? attendanceType;
  bool? isParticipated;
  DateTime? startTime;
  DateTime? endTime;


  FilterTripHistoryRequest({
    this.busTripId,
    this.busMemberId,
    this.attendanceType,
    this.isParticipated,
    this.startTime,
    this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'BusTripId':busTripId,
      'BusMemberId':busMemberId,
      'AttendanceType':attendanceType?.index,
      'IsParticipated':isParticipated,
      'FromDate':startTime,
      'ToDate':endTime,

    };
  }
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
