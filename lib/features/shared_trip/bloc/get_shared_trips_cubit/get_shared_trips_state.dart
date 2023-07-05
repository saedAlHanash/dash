part of 'get_shared_trips_cubit.dart';

class GetSharedTripsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<SharedTrip> currentTrips;

  final List<SharedTrip> oldTrips;
  final String error;

  const GetSharedTripsInitial({
    required this.statuses,
    required this.currentTrips,
    required this.oldTrips,
    required this.error,
  });

  factory GetSharedTripsInitial.initial() {
    return const GetSharedTripsInitial(
      currentTrips: [],
      oldTrips: [],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, currentTrips, error,oldTrips];

  GetSharedTripsInitial copyWith({
    CubitStatuses? statuses,
    List<SharedTrip>? currentTrips,
    List<SharedTrip>? oldTrips,
    String? error,
  }) {
    return GetSharedTripsInitial(
      statuses: statuses ?? this.statuses,
      currentTrips: currentTrips ?? this.currentTrips,
      oldTrips: oldTrips ?? this.oldTrips,
      error: error ?? this.error,
    );
  }
}
