class ReportRequest {
  ReportRequest({
    this.busTripId,
    this.busMemberId,
    this.date,
    this.attendanceType,
  });

  num? busTripId;
  num? busMemberId;
  DateTime? date;
  String? attendanceType;

  factory ReportRequest.fromJson(Map<String, dynamic> json) {
    return ReportRequest(
      busTripId: json["busTripId"] ?? 0,
      busMemberId: json["busMemberId"] ?? 0,
      date: DateTime.tryParse(json["date"] ?? ""),
      attendanceType: json["attendanceType"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "busTripId": busTripId,
        "busMemberId": busMemberId,
        "date": date?.toIso8601String(),
        "attendanceType": attendanceType,
      };
}
