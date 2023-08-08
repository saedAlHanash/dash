import 'package:qareeb_super_user/core/util/shared_preferences.dart';

class ReportRequest {
  ReportRequest({
    required this.busMemberId,
    required this.date,
  });

  num busMemberId;
  DateTime date;

  factory ReportRequest.fromJson(Map<String, dynamic> json) {
    return ReportRequest(
      busMemberId: json["busMemberId"] ?? 0,
      date: DateTime.parse(json["date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "busId": AppSharedPreference.getBusId,
        "busMemberId": busMemberId,
        "date": date.toIso8601String(),
      };
}
