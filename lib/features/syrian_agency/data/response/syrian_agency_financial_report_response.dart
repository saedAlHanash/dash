import 'package:qareeb_models/wallet/data/response/wallet_response.dart';

class SyrianAgencyFinancialReportResponse {
  SyrianAgencyFinancialReportResponse({
    required this.result,
  });

  final SyrianAgencyFinancialReport result;

  factory SyrianAgencyFinancialReportResponse.fromJson(Map<String, dynamic> json) {
    return SyrianAgencyFinancialReportResponse(
      result: SyrianAgencyFinancialReport.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class SyrianAgencyFinancialReport {
  SyrianAgencyFinancialReport({
    required this.transactions,
    required this.requiredAmountFromCompany,
  });

  final List<Transaction> transactions;
  final num requiredAmountFromCompany;

  factory SyrianAgencyFinancialReport.fromJson(Map<String, dynamic> json) {
    return SyrianAgencyFinancialReport(
      transactions: json["transactions"] == null
          ? []
          : List<Transaction>.from(
              json["transactions"]!.map((x) => Transaction.fromJson(x))),
      requiredAmountFromCompany: json["requiredAmountFromCompany"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "transactions": transactions.map((x) => x.toJson()).toList(),
        "requiredAmountFromCompany": requiredAmountFromCompany,
      };
}
