class RePayRequest {
  String? phone;
  String? note;
  num? amount;

  RePayRequest({
    this.phone,
    this.note,
    this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'clientPhone': phone,
      'note': note,
      'amount': amount,
    };
  }

  factory RePayRequest.fromJson(Map<String, dynamic> map) {
    return RePayRequest(
      phone: map['phone'] as String,
      note: map['note'] as String,
      amount: map['amount'] as num,
    );
  }
}
