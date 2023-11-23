part of 'plans_cubit.dart';

class AllPlansInitial extends Equatable {
  final CubitStatuses statuses;
  final List<PlanModel> result;
  final String error;
  final Command command;

  const AllPlansInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllPlansInitial.initial() {
    return AllPlansInitial(
      result: const <PlanModel>[],
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

  AllPlansInitial copyWith({
    CubitStatuses? statuses,
    List<PlanModel>? result,
    String? error,
    Command? command,
  }) {
    return AllPlansInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
