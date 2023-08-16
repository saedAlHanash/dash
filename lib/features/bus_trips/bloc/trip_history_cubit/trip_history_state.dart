part of 'trip_history_cubit.dart';

class AllTripHistoryInitial extends Equatable {
  final CubitStatuses statuses;
  final List<TripHistoryItem> result;
  final String error;
  final Command command;

  const AllTripHistoryInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllTripHistoryInitial.initial() {
    return AllTripHistoryInitial(
      result: const <TripHistoryItem>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }


  @override
  List<Object> get props => [statuses, result, error];

  AllTripHistoryInitial copyWith({
    CubitStatuses? statuses,
    List<TripHistoryItem>? result,
    String? error,
    Command? command,
  }) {
    return AllTripHistoryInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
