part of 'update_shared_cubit.dart';


class UpdateSharedInitial extends Equatable {
  final CubitStatuses statuses;
  final SharedTrip result;
  final String error;
  final SharedTrip trip;
  final SharedTripStatus tState;
  final RequestCreateShared request;

  const UpdateSharedInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.tState,
    required this.request,
    required this.trip,
  });

  factory UpdateSharedInitial.initial() {
    return UpdateSharedInitial(
      result: SharedTrip.fromJson({}),
      error: '',
      trip: SharedTrip.fromJson({}),
      statuses: CubitStatuses.init,
      tState: SharedTripStatus.pending,
      request: RequestCreateShared(),
    );
  }

  @override
  List<Object> get props => [statuses, result, error, trip,tState];

  UpdateSharedInitial copyWith({
    CubitStatuses? statuses,
    SharedTrip? result,
    String? error,
    SharedTrip? trip,
    SharedTripStatus? tState,
    RequestCreateShared? request,
  }) {
    return UpdateSharedInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      trip: trip ?? this.trip,
      tState: tState ?? this.tState,
      request: request ?? this.request,
    );
  }
}

