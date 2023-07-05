part of 'trip_status_cubit.dart';

class TripStatusInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;
  final TripStatus tripStatus;
  final num tripId;

  const TripStatusInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.tripStatus,
    required this.tripId,
  });

  factory TripStatusInitial.initial() {
    return const TripStatusInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
      tripStatus: TripStatus.non,
      tripId: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  TripStatusInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    TripStatus? tripStatus,
    num? tripId,
  }) {
    return TripStatusInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      tripStatus: tripStatus ?? this.tripStatus,
      tripId: tripId ?? this.tripId,
    );
  }
}
