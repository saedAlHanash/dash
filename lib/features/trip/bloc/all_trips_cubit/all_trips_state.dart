part of 'all_trips_cubit.dart';

class AllTripsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<TripResult> result;
  final String error;
  final Command command;

  const AllTripsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllTripsInitial.initial() {
    var list = <TripResult>[];
    return AllTripsInitial(
      result: list,
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, command];

  AllTripsInitial copyWith({
    CubitStatuses? statuses,
    List<TripResult>? result,
    String? error,
    Command? command,
  }) {
    return AllTripsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
