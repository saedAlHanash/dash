part of 'get_shared_trips_cubit.dart';

class GetSharedTripsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<SharedTrip> currentTrips;

  final List<SharedTrip> oldTrips;
  final String error;
  final Command command;
  final FilterTripRequest filter;

  const GetSharedTripsInitial({
    required this.statuses,
    required this.currentTrips,
    required this.oldTrips,
    required this.error,
    required this.command,
    required this.filter,
  });

  factory GetSharedTripsInitial.initial() {
    return GetSharedTripsInitial(
      currentTrips: const [],
      oldTrips: const [],
      error: '',
      command: Command.initial(),
      filter: FilterTripRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, currentTrips, error, oldTrips];

  GetSharedTripsInitial copyWith({
    CubitStatuses? statuses,
    List<SharedTrip>? currentTrips,
    List<SharedTrip>? oldTrips,
    String? error,
    Command? command,
    FilterTripRequest? filter,
  }) {
    return GetSharedTripsInitial(
      statuses: statuses ?? this.statuses,
      currentTrips: currentTrips ?? this.currentTrips,
      oldTrips: oldTrips ?? this.oldTrips,
      error: error ?? this.error,
      command: command ?? this.command,
      filter: filter ?? this.filter,
    );
  }
}
