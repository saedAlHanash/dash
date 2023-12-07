part of 'record_check_cubit.dart';

class RecordCheckInitial extends Equatable {
  final CubitStatuses statuses;
  final List<RecordCheck> result;
  final String error;
  final Command command;

  const RecordCheckInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory RecordCheckInitial.initial() {
    return RecordCheckInitial(
      result: const <RecordCheck>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }


  @override
  List<Object> get props => [statuses, result, error];

  RecordCheckInitial copyWith({
    CubitStatuses? statuses,
    List<RecordCheck>? result,
    String? error,
    Command? command,
  }) {
    return RecordCheckInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
