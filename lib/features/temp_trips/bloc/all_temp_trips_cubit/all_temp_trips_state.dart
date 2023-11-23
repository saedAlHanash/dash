part of 'all_temp_trips_cubit.dart';

class AllTempTripsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<TempTripModel> result;
  final String error;
  final Command command;

  const AllTempTripsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllTempTripsInitial.initial() {
    return AllTempTripsInitial(
      result: const <TempTripModel>[],
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

  List<SpinnerItem> getSpinnerItems({int? selectedId}) {
    if (result.isEmpty) {
      return [SpinnerItem(name: 'لا يوجد', id: 0)];
    }
    return result
        .map((e) => SpinnerItem(
              id: e.id,
              name: e.description,
              item: e,
              isSelected: e.id == selectedId,
            ))
        .toList();
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllTempTripsInitial copyWith({
    CubitStatuses? statuses,
    List<TempTripModel>? result,
    String? error,
    Command? command,
  }) {
    return AllTempTripsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
