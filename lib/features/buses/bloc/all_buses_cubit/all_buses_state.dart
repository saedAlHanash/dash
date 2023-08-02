part of 'all_buses_cubit.dart';

class AllBusesInitial extends Equatable {
  final CubitStatuses statuses;
  final List<BusModel> result;
  final String error;
  final Command command;

  const AllBusesInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllBusesInitial.initial() {
    return AllBusesInitial(
      result: const <BusModel>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  List<SpinnerItem> get getSpinnerItem {
    final list = <SpinnerItem>[];
    for (var e in result) {
      list.add(SpinnerItem(id: e.id, name: e.driverName, item: e));
    }
    return list;
  }

  List<String> getNames(List<int> selected) {
    final list = <String>[];
    for (var e in result) {
      if (!selected.contains(e.id)) continue;
      list.add(e.driverName);
    }
    return list;
  }

  List<SpinnerItem> getSpinnerSuperUser({int? selected}) {
    final list = <SpinnerItem>[];
    for (var e in result) {
      list.add(SpinnerItem(
          id: e.id,
          name: e.driverName,
          item: e,
          enable: e.supervisors.isEmpty,
          isSelected: selected == e.id));
    }
    return list;
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllBusesInitial copyWith({
    CubitStatuses? statuses,
    List<BusModel>? result,
    String? error,
    Command? command,
  }) {
    return AllBusesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
