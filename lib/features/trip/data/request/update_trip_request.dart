import 'package:qareeb_models/global.dart';

class UpdateTripRequest {
  int? tripId;
  TripStatus? status;
  int? driverId;
  String? note;

  UpdateTripRequest({
    this.tripId,
    this.status,
    this.driverId,
    this.note,
  });

  UpdateTripRequest copyWith({
    int? tripId,
    TripStatus? status,
    int? driverId,
    String? note,
  }) {
    return UpdateTripRequest(
      tripId: tripId ?? this.tripId,
      status: status ?? this.status,
      driverId: driverId ?? this.driverId,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": tripId,
      "status": status?.index,
      "driverId": driverId,
      "note": note,
    };
  }
}
