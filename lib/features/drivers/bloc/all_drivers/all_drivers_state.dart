part of 'all_drivers_cubit.dart';

class AllDriversInitial extends Equatable {
  final CubitStatuses statuses;
  final List<DriverModel> result;
  final String error;
  final Command command;

  const AllDriversInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  List<SpinnerItem> get getSpinnerItem {
    final list = <SpinnerItem>[];
    for (var e in result) {
      list.add(SpinnerItem(id: e.id, name: e.fullName, item: e));
    }
    return list;
  }

  factory AllDriversInitial.initial() {
    return AllDriversInitial(
      result: const <DriverModel>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllDriversInitial copyWith({
    CubitStatuses? statuses,
    List<DriverModel>? result,
    String? error,
    Command? command,
  }) {
    return AllDriversInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
