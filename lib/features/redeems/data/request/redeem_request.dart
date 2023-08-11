import 'package:qareeb_models/global.dart'; import '../../../../core/strings/enum_manager.dart';

class RedeemRequest {
  RedeemRequest({
    this.driverId,
    this.type,
  });

  int? id;
  num? driverId;
  RedeemType? type;

  factory RedeemRequest.fromJson(Map<String, dynamic> json) {
    return RedeemRequest(
      driverId: json["driverId"] ?? 0,
      type: json["type"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "driverId": driverId,
        "type": type?.index,
      };
}
