part of 'trip_status_cubit.dart';

class ChangeTripStatusInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;
  final TripStatus tripStatus;
  final UpdateTripRequest request;

  const ChangeTripStatusInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.tripStatus,
    required this.request,
  });

  factory ChangeTripStatusInitial.initial() {
    return ChangeTripStatusInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
      tripStatus: TripStatus.pending,
      request: UpdateTripRequest(),
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ChangeTripStatusInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    TripStatus? tripStatus,
    UpdateTripRequest? request,
  }) {
    return ChangeTripStatusInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      tripStatus: tripStatus ?? this.tripStatus,
      request: request ?? this.request,
    );
  }
}
