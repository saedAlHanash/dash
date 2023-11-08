import 'package:qareeb_models/global.dart';

class PayToRequest {
  PayToRequest({
     this.amount,
     this.driverId,
     this.note,
  });

   num? amount;
   num? driverId;
  TransferPayType? state;
   String? note;

  factory PayToRequest.fromJson(Map<String, dynamic> json){
    return PayToRequest(
      amount: json["amount"] ?? 0,
      driverId: json["driverId"] ?? 0,

      note: json["note"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "driverId": driverId,
    "note": note,
  };

}
