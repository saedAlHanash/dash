part of 'trips_cubit.dart';

class TripsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Trip> result;
  final String error;
  final Command command;

  const TripsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory TripsInitial.initial() {
    var list = <Trip>[];
    return TripsInitial(
      result: list,
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  TripsInitial copyWith({
    CubitStatuses? statuses,
    List<Trip>? result,
    String? error,
    Command? command,
  }) {
    return TripsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
