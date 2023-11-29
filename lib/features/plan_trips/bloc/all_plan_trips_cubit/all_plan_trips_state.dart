part of 'all_plan_trips_cubit.dart';

class AllPlanTripsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<PlanTripModel> result;
  final String error;
  final Command command;

  const AllPlanTripsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllPlanTripsInitial.initial() {
    return AllPlanTripsInitial(
      result: const <PlanTripModel>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  List<SpinnerItem> get getSpinnerItem {
    final list = <SpinnerItem>[];
    for (var e in result) {
      list.add(SpinnerItem(id: e.id, name: e.name, item: e));
    }
    return list;
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllPlanTripsInitial copyWith({
    CubitStatuses? statuses,
    List<PlanTripModel>? result,
    String? error,
    Command? command,
  }) {
    return AllPlanTripsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
