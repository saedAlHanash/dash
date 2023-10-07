part of 'available_trips_cubit.dart';

class AvailableTripsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Trip> result;
  final String error;
  final Command command;

  const AvailableTripsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AvailableTripsInitial.initial() {
    var list = <Trip>[];
    return AvailableTripsInitial(
      result: list,
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, command];

  AvailableTripsInitial copyWith({
    CubitStatuses? statuses,
    List<Trip>? result,
    String? error,
    Command? command,
  }) {
    return AvailableTripsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
