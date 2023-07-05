part of 'previous_trips_cubit.dart';

class PreviousTripsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<TripResult> result;
  final String error;
  final Command command;

  const PreviousTripsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory PreviousTripsInitial.initial() {
    var list = <TripResult>[];
    return PreviousTripsInitial(
      result: list,
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, command];

  PreviousTripsInitial copyWith({
    CubitStatuses? statuses,
    List<TripResult>? result,
    String? error,
    Command? command,
  }) {
    return PreviousTripsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
