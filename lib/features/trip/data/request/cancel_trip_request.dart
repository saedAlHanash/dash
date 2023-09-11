class CancelTripRequest {
  int? tripId;
  String? note;
  String? cancelReason;

  CancelTripRequest({
    this.tripId,
    this.note,
    this.cancelReason,
  });

  CancelTripRequest copyWith({
    int? tripId,
    String? note,
    String? cancelReason,
  }) {
    return CancelTripRequest(
      tripId: tripId ?? this.tripId,
      note: note ?? this.note,
      cancelReason: cancelReason ?? this.cancelReason,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': tripId,
      'note': note,
      'cancelReasone': cancelReason,
    };
  }
}
