part of 'all_bus_trips_cubit.dart';

class AllBusTripsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<BusTripModel> result;
  final String error;
  final Command command;

  const AllBusTripsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllBusTripsInitial.initial() {
    return AllBusTripsInitial(
      result: const <BusTripModel>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  List<SpinnerItem> get getSpinnerItem {
    final list = <SpinnerItem>[];
    for (var e in result) {
      list.add(SpinnerItem(id: e.id, name: e.description, item: e));
    }
    return list;
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllBusTripsInitial copyWith({
    CubitStatuses? statuses,
    List<BusTripModel>? result,
    String? error,
    Command? command,
  }) {
    return AllBusTripsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
