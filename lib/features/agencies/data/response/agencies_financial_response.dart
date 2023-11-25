// class AgenciesFinancialResponse {
//   AgenciesFinancialResponse({
//     required this.result,
//   });
//
//   final AgenciesFinancialResult result;
//
//   factory AgenciesFinancialResponse.fromJson(Map<String, dynamic> json) {
//     return AgenciesFinancialResponse(
//       result: AgenciesFinancialResult.fromJson(json["result"] ?? {}),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "result": result.toJson(),
//       };
// }
//
// class AgenciesFinancialResult {
//   AgenciesFinancialResult({
//     required this.reports,
//     required this.totalRequiredAmountFromCompany,
//   });
//
//   final List<AgencyReport> reports;
//   final num totalRequiredAmountFromCompany;
//
//   factory AgenciesFinancialResult.fromJson(Map<String, dynamic> json) {
//     return AgenciesFinancialResult(
//       reports: json["reports"] == null
//           ? []
//           : List<AgencyReport>.from(
//               json["reports"]!.map((x) => AgencyReport.fromJson(x))),
//       totalRequiredAmountFromCompany: json["totalRequiredAmountFromCompany"] ?? 0,
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "reports": reports.map((x) => x.toJson()).toList(),
//         "totalRequiredAmountFromCompany": totalRequiredAmountFromCompany,
//       };
// }
//
// class AgencyReport {
//   AgencyReport({
//     required this.agencyId,
//     required this.agencyName,
//     required this.agencyRatio,
//     required this.transactions,
//     required this.requiredAmountFromCompany,
//   });
//
//   final num agencyId;
//   final String agencyName;
//   final num agencyRatio;
//   final List<Transaction> transactions;
//   final num requiredAmountFromCompany;
//
//   factory AgencyReport.fromJson(Map<String, dynamic> json) {
//     return AgencyReport(
//       agencyId: json["agencyId"] ?? 0,
//       agencyName: json["agencyName"] ?? "",
//       agencyRatio: json["agencyRatio"] ?? 0,
//       transactions: json["transactions"] == null
//           ? []
//           : List<Transaction>.from(
//               json["transactions"]!.map((x) => Transaction.fromJson(x))),
//       requiredAmountFromCompany: json["requiredAmountFromCompany"] ?? 0,
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "agencyId": agencyId,
//         "agencyName": agencyName,
//         "agencyRatio": agencyRatio,
//         "transactions": transactions.map((x) => x.toJson()).toList(),
//         "requiredAmountFromCompany": requiredAmountFromCompany,
//       };
// }
//
// class Transaction {
//   Transaction({
//     required this.id,
//     required this.status,
//     required this.transferDate,
//     required this.sourceId,
//     required this.sourceName,
//     required this.destinationId,
//     required this.destinationName,
//     required this.amount,
//     required this.type,
//     required this.tripId,
//     required this.sharedRequestId,
//     required this.note,
//   });
//
//   final int id;
//   final String status;
//   final DateTime? transferDate;
//   final num sourceId;
//   final String sourceName;
//   final num destinationId;
//   final String destinationName;
//   final num amount;
//   final String type;
//   final num tripId;
//   final num sharedRequestId;
//   final String note;
//
//   factory Transaction.fromJson(Map<String, dynamic> json) {
//     return Transaction(
//       id: json["id"] ?? 0,
//       status: json["status"] ?? "",
//       transferDate: DateTime.tryParse(json["transferDate"] ?? ""),
//       sourceId: json["sourceId"] ?? 0,
//       sourceName: json["sourceName"] ?? "",
//       destinationId: json["destinationId"] ?? 0,
//       destinationName: json["destinationName"] ?? "",
//       amount: json["amount"] ?? 0,
//       type: json["type"] ?? "",
//       tripId: json["tripId"] ?? 0,
//       sharedRequestId: json["sharedRequestId"] ?? 0,
//       note: json["note"] ?? "",
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "status": status,
//         "transferDate": transferDate?.toIso8601String(),
//         "sourceId": sourceId,
//         "sourceName": sourceName,
//         "destinationId": destinationId,
//         "destinationName": destinationName,
//         "amount": amount,
//         "type": type,
//         "tripId": tripId,
//         "sharedRequestId": sharedRequestId,
//         "note": note,
//       };
// }
