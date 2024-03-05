import 'package:qareeb_models/global.dart';

class ChargingRequest {
  String? clientName;
  String? clientPhone;
  String? chargerName;
  String? chargerPhone;

  DateTime? startTime;
  DateTime? endTime;
  TransferStatus? status;

  ChargingRequest({
    this.startTime,
    this.endTime,
    this.status,
    this.clientName,
    this.clientPhone,
    this.chargerName,
    this.chargerPhone,
  });

  ChargingRequest copyWith({
    DateTime? startTime,
    DateTime? endTime,
    TransferStatus? status,
    String? clientName,
    String? clientPhone,
    String? chargerName,
    String? chargerPhone,
  }) {
    return ChargingRequest(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      chargerName: chargerName ?? this.chargerName,
      chargerPhone: chargerPhone ?? this.chargerPhone,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FromDate': startTime?.toIso8601String(),
      'ToDate': endTime?.toIso8601String(),
      'status': status?.index,
      'clientName': clientName,
      'clientPhone': clientPhone,
      'chargerName': chargerName,
      'chargerPhone': chargerPhone,
      'Type': 1,
    };
  }

  void clearFilter() {
    startTime = null;
    endTime = null;
    status = null;
    clientName = null;
    clientPhone = null;
    chargerName = null;
    chargerPhone = null;
  }
}
//ClientName
// string
// (query)
// ClientName
// ClientPhone
// string
// (query)
// ClientPhone
// ChargerName
// string
// (query)
// بشير
// ChargerPhone
// string
// (query)
// ChargerPhone
// FromDate
// string($date-time)
// (query)
// FromDate
// ToDate
// string($date-time)
// (query)
