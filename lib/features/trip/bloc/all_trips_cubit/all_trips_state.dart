part of 'all_trips_cubit.dart';

class AllTripsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<TripResult> result;
  final String error;
  final Command command;
  final FilterTripRequest filter;

  const AllTripsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
    required this.filter,
  });

  factory AllTripsInitial.initial() {
    var list = <TripResult>[];
    return AllTripsInitial(
      result: list,
      error: '',
      command: Command.initial(),
      filter: FilterTripRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllTripsInitial copyWith({
    CubitStatuses? statuses,
    List<TripResult>? result,
    String? error,
    Command? command,
    FilterTripRequest? filter,
  }) {
    return AllTripsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
      filter: filter ?? this.filter,
    );
  }
}
