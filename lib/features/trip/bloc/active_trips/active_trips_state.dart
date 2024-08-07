part of 'active_trips_cubit.dart';

class ActiveTripsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Trip> result;
  final String error;
  final FilterRequest command;

  const ActiveTripsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory ActiveTripsInitial.initial() {
    var list = <Trip>[];
    return ActiveTripsInitial(
      result: list,
      error: '',
      command: FilterRequest.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, command];

  ActiveTripsInitial copyWith({
    CubitStatuses? statuses,
    List<Trip>? result,
    String? error,
    FilterRequest? command,
  }) {
    return ActiveTripsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
