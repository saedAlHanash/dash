class DirectPayRequest {
  DirectPayRequest({
    this.tripId,
    this.sharedRequestId,
    this.planId,
    this.companyId,
    required this.userPhoneNo,
    required this.amount,
  });

  int? tripId;
  int? sharedRequestId;
  int? planId;
  int? companyId;
  final String userPhoneNo;
  final num amount;

  factory DirectPayRequest.fromJson(Map<String, dynamic> json) {
    return DirectPayRequest(
      tripId: json["tripId"] ?? 0,
      sharedRequestId: json["sharedRequestId"] ?? 0,
      planId: json["planId"] ?? 0,
      userPhoneNo: json["userPhoneNo"] ?? "",
      companyId: json["companyId"] ?? 0,
      amount: json["amount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "tripId": tripId == 0 ? null : tripId,
        "sharedRequestId": sharedRequestId == 0 ? null : sharedRequestId,
        "planId": planId == 0 ? null : planId,
        "companyId": companyId == 0 ? null : companyId,
        "userPhoneNo": userPhoneNo,
        "amount": amount,
      };
}
