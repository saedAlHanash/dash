import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

class SyrianFilterRequest {
  String? userName;
  DateTime? startTime = DateTime.now().addFromNow(month: -1);
  DateTime? endTime = DateTime.now();
  TransferType? type;
  TransferStatus? status;

  SyrianFilterRequest({
    this.userName,
    this.type,
    this.status,
  });

  SyrianFilterRequest copyWith({
    String? userName,
    DateTime? startTime,
    DateTime? endTime,
    TransferType? type,
    TransferStatus? status,
  }) {
    return SyrianFilterRequest(
      userName: userName ?? this.userName,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'FromDate': startTime?.toIso8601String(),
      'ToDate': endTime?.toIso8601String(),
      'type': type?.index,
      'status': status?.index,
    };
  }

  void clearFilter() {
    userName = null;
    startTime = null;
    endTime = null;
    type = null;
    status = null;
  }
}
