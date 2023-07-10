class AccountAmountResponse {
  AccountAmountResponse({
    required this.result,
  });

  final AccountAmountResult result;

  factory AccountAmountResponse.fromJson(Map<String, dynamic> json) {
    return AccountAmountResponse(
      result: AccountAmountResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class AccountAmountResult {
  AccountAmountResult({
    required this.statusCode,
    required this.data,
    required this.error,
  });

  final num statusCode;
  final Data data;
  final String error;

  factory AccountAmountResult.fromJson(Map<String, dynamic> json) {
    return AccountAmountResult(
      statusCode: json["statusCode"] ?? 0,
      data:  Data.fromJson(json["data"]??{}),
      error: json["error"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data.toJson(),
        "error": error,
      };
}

class Data {
  Data({
    required this.amount,
  });

  final num amount;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      amount: json["amount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "amount": amount,
      };
}
