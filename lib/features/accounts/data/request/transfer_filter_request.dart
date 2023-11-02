import 'package:qareeb_models/global.dart';

class TransferFilterRequest{
  String? userName;
  DateTime ?startTime;
  DateTime ?endTime;
  TransferType? type;
  TransferStatus? status;

  TransferFilterRequest({
    this.userName,
    this.startTime,
    this.endTime,
    this.type,
    this.status,
  });

  TransferFilterRequest copyWith({
    String? userName,
    DateTime? startTime,
    DateTime? endTime,
    TransferType? type,
    TransferStatus? status,
  }) {
    return TransferFilterRequest(
      userName: userName ?? this.userName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'FromDateTime': startTime?.toIso8601String(),
      'ToDateTime': endTime?.toIso8601String(),
      'type': type?.index,
      'status': status?.index,
    };
  }

  void clearFilter() {

    userName= null;
    startTime= null;
    endTime= null;
    type= null;
    status= null;
  }

}