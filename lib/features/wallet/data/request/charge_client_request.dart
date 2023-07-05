import 'package:qareeb_dash/core/util/shared_preferences.dart';

class ChargeClientRequest {
  ChargeClientRequest({
    required this.phoneNumber,
    required this.amount,
  });

   String? phoneNumber;
   num? amount;

  factory ChargeClientRequest.fromJson(Map<String, dynamic> json) {
    return ChargeClientRequest(

      phoneNumber: json["phoneNumber"] ?? '',
      amount: json["amount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "clientPhoneNumber": phoneNumber,
        "chargerId": AppSharedPreference.getMyId,
        "amount": amount,
      };
}
