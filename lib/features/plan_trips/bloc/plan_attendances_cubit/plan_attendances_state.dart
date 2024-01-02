part of 'plan_attendances_cubit.dart';

class PlanAttendancesInitial extends Equatable {
  final CubitStatuses statuses;
  final List<PlanAttendance> result;
  final String error;
  final PlanAttendanceFilter request;
  final Command command;

  const PlanAttendancesInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.request,
    required this.command,
  });

  factory PlanAttendancesInitial.initial() {
    return PlanAttendancesInitial(
      result: const <PlanAttendance>[],
      error: '',
      request: PlanAttendanceFilter(),
      command: Command.noPagination(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  PlanAttendancesInitial copyWith({
    CubitStatuses? statuses,
    List<PlanAttendance>? result,
    String? error,
    PlanAttendanceFilter? request,
    Command? command,
  }) {
    return PlanAttendancesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      command: command ?? this.command,
    );
  }
}
