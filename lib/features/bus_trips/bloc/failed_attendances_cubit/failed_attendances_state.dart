part of 'failed_attendances_cubit.dart';

class FailedAttendancesInitial extends Equatable {
  final CubitStatuses statuses;
  final List<AttendancesItem> result;
  final String error;
  final Command command;

  const FailedAttendancesInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory FailedAttendancesInitial.initial() {
    return FailedAttendancesInitial(
      result: const <AttendancesItem>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }


  @override
  List<Object> get props => [statuses, result, error];

  FailedAttendancesInitial copyWith({
    CubitStatuses? statuses,
    List<AttendancesItem>? result,
    String? error,
    Command? command,
  }) {
    return FailedAttendancesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}