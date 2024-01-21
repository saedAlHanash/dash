class SyrianPayRequest {
  SyrianPayRequest({
    this.amount,
    this.note,
  });

   num? amount;
   String? note;

  factory SyrianPayRequest.fromJson(Map<String, dynamic> json) {
    return SyrianPayRequest(
      amount: json["amount"] ?? 0,
      note: json["note"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "note": note,
      };
}
