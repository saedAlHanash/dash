class SyrianAgencyReportResponse {
  SyrianAgencyReportResponse({
    required this.result,
  });

  final List<SyrianAgencyReport> result;

  factory SyrianAgencyReportResponse.fromJson(Map<String, dynamic> json) {
    return SyrianAgencyReportResponse(
      result: json["result"] == null
          ? []
          : List<SyrianAgencyReport>.from(
              json["result"]!.map((x) => SyrianAgencyReport.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.map((x) => x.toJson()).toList(),
      };
}

class SyrianAgencyReport {
  SyrianAgencyReport({
    required this.amount,
    required this.driverShare,
    required this.companyShare,
    required this.syrianAuthorityShare,
    required this.date,
  });

  final num amount;
  final num driverShare;
  final num companyShare;
  final num syrianAuthorityShare;
  final DateTime? date;

  factory SyrianAgencyReport.fromJson(Map<String, dynamic> json) {
    return SyrianAgencyReport(
      amount: json["amount"] ?? 0,
      driverShare: json["driverShare"] ?? 0,
      companyShare: json["companyShare"] ?? 0,
      syrianAuthorityShare: json["syrianAuthorityShare"] ?? 0,
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "driverShare": driverShare,
        "companyShare": companyShare,
        "syrianAuthorityShare": syrianAuthorityShare,
        "date": date?.toIso8601String(),
      };
}
