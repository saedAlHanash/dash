import 'dart:convert';

import '../../features/qr/data/request/report_request.dart';
import '../util/shared_preferences.dart';

class RequestsService {
  int get getCounts => AppSharedPreference.getJsonListRequest().length;

  void addToRequests(ReportRequest request) {
    final list = AppSharedPreference.getJsonListRequest();

    list.addAll(_convertToListString([request]));

    AppSharedPreference.updateRequests(list);
  }

  List<ReportRequest> getReportRequests() {
    final list = AppSharedPreference.getJsonListRequest();
    final requestList = <ReportRequest>[];
    for (var e in list) {
      requestList.add(ReportRequest.fromJson(jsonDecode(e)));
    }
    return requestList;
  }

  List<String> _convertToListString(List<ReportRequest> list) {
    return List<String>.from(list.map((e) => jsonEncode(e))).toList();
  }

  void clear() {
    AppSharedPreference.updateRequests([]);
  }
}
