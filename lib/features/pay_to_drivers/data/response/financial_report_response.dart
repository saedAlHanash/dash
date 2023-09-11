class FinancialReportResponse {
  FinancialReportResponse({
    required this.result,
  });

  final FinancialReportResult result;

  factory FinancialReportResponse.fromJson(Map<String, dynamic> json) {
    return FinancialReportResponse(
      result:  FinancialReportResult.fromJson(json["result"]??{}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class FinancialReportResult {
  FinancialReportResult({
    required this.items,
    required this.totalCount,
  });

  final List<FinancialReport> items;
  final int totalCount;

  factory FinancialReportResult.fromJson(Map<String, dynamic> json) {
    return FinancialReportResult(
      items: json["items"] == null
          ? []
          : List<FinancialReport>.from(json["items"]!.map((x) => FinancialReport.fromJson(x))),
      totalCount: json["totalCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
        "totalCount": totalCount,
      };
}

class FinancialReport {
  FinancialReport({
    required this.driverId,
    required this.driverName,
    required this.driverPhoneNo,
    required this.requiredAmountFromDriver,
    required this.requiredAmountFromCompany,
  });

  final num driverId;
  final String driverName;
  final String driverPhoneNo;
  final num requiredAmountFromDriver;
  final num requiredAmountFromCompany;

  factory FinancialReport.fromJson(Map<String, dynamic> json) {
    return FinancialReport(
      driverId: json["driverId"] ?? 0,
      driverName: json["driverName"] ?? "",
      driverPhoneNo: json["driverPhoneNo"] ?? "",
      requiredAmountFromDriver: json["requiredAmountFromDriver"] ?? 0,
      requiredAmountFromCompany: json["requiredAmountFromCompany"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "driverId": driverId,
        "driverName": driverName,
        "driverPhoneNo": driverPhoneNo,
        "requiredAmountFromDriver": requiredAmountFromDriver,
        "requiredAmountFromCompany": requiredAmountFromCompany,
      };
}
