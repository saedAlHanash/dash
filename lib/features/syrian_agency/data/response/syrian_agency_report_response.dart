import 'package:qareeb_models/global.dart';

class SyrianAgencyReportResponse {
  SyrianAgencyReportResponse({
    required this.result,
  });

  final SyrianAgencyResult result;

  factory SyrianAgencyReportResponse.fromJson(Map<String, dynamic> json) {
    return SyrianAgencyReportResponse(
      result: SyrianAgencyResult.fromJson(json['result'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class SyrianAgencyResult {
  SyrianAgencyResult({
    required this.items,
    required this.totalCount,
  });

  final List<SyrianAgencyReport> items;
  final int totalCount;

  factory SyrianAgencyResult.fromJson(Map<String, dynamic> json) {
    return SyrianAgencyResult(
      items: json["items"] == null
          ? []
          : List<SyrianAgencyReport>.from(
              json["items"]!.map((x) => SyrianAgencyReport.fromJson(x))),
      totalCount: json["totalCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
        "totalCount": totalCount,
      };
}

class SyrianAgencyReport {
  SyrianAgencyReport({
    required this.amount,
    required this.driverShare,
    required this.companyShare,
    required this.syrianAuthorityShare,
    required this.date,
    required this.type,
  });

  final num amount;
  final num driverShare;
  final num companyShare;
  final num syrianAuthorityShare;
  final DateTime? date;
  final SyrianReportType type;

  factory SyrianAgencyReport.fromJson(Map<String, dynamic> json) {
    return SyrianAgencyReport(
      amount: json["amount"] ?? 0,
      driverShare: json["driverShare"] ?? 0,
      companyShare: json["companyShare"] ?? 0,
      syrianAuthorityShare: json["syrianAuthorityShare"] ?? 0,
      date: DateTime.tryParse(json["date"] ?? ""),
      type: SyrianReportType.values[json["type"] ?? 0],
    );
  }

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "driverShare": driverShare,
        "companyShare": companyShare,
        "syrianAuthorityShare": syrianAuthorityShare,
        "date": date?.toIso8601String(),
        "type": type,
      };
}
