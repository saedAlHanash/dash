part of 'attendances_cubit.dart';

class AllAttendancesInitial extends Equatable {
  final CubitStatuses statuses;
  final List<AttendancesItem> result;
  final String error;
  final Command command;

  const AllAttendancesInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllAttendancesInitial.initial() {
    return AllAttendancesInitial(
      result: const <AttendancesItem>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }


  @override
  List<Object> get props => [statuses, result, error];

  AllAttendancesInitial copyWith({
    CubitStatuses? statuses,
    List<AttendancesItem>? result,
    String? error,
    Command? command,
  }) {
    return AllAttendancesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
