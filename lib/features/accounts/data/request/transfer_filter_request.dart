import 'package:qareeb_models/global.dart';
import '../../../../core/strings/enum_manager.dart';

class TransferFilterRequest{
  int? userId;
  DateTime ?fromDateTime;
  DateTime ?toDateTime;
  TransferType? type;
  TransferStatus? status;

  TransferFilterRequest({
    this.userId,
    this.fromDateTime,
    this.toDateTime,
    this.type,
    this.status,
  });

  TransferFilterRequest copyWith({
    int? userId,
    DateTime? fromDateTime,
    DateTime? toDateTime,
    TransferType? type,
    TransferStatus? status,
  }) {
    return TransferFilterRequest(
      userId: userId ?? this.userId,
      fromDateTime: fromDateTime ?? this.fromDateTime,
      toDateTime: toDateTime ?? this.toDateTime,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fromDateTime': fromDateTime?.toIso8601String(),
      'toDateTime': toDateTime?.toIso8601String(),
      'type': type?.index,
      'status': status?.index,
    };
  }


}