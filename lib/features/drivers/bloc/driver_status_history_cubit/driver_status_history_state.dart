part of 'driver_status_history_cubit.dart';

class DriverStatusHistoryInitial extends Equatable {
  final CubitStatuses statuses;
  final List<DriverStatusHistory> result;
  final String error;
  final int driverId;
  final Command command;

  const DriverStatusHistoryInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.driverId,
    required this.command,
  });

  List<SpinnerItem> get getSpinnerItem {
    final list = <SpinnerItem>[];
    for (var e in result) {
      list.add(SpinnerItem(id: e.id, name: e.status.arabicName, item: e));
    }
    return list;
  }

  factory DriverStatusHistoryInitial.initial() {
    return DriverStatusHistoryInitial(
      result: const <DriverStatusHistory>[],
      error: '',
      driverId: 0,
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DriverStatusHistoryInitial copyWith({
    CubitStatuses? statuses,
    List<DriverStatusHistory>? result,
    String? error,
    int? driverId,
    Command? command,
  }) {
    return DriverStatusHistoryInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      driverId: driverId ?? this.driverId,
      command: command ?? this.command,
    );
  }
}
