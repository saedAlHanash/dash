part of 'agencies_cubit.dart';

class AgenciesInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Agency> result;
  final String error;
  final Command command;

  const AgenciesInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  List<SpinnerItem> get getSpinnerItem {
    final list = <SpinnerItem>[];
    for (var e in result) {
      list.add(SpinnerItem(id: e.id, name: e.name, item: e));
    }
    return list;
  }

  factory AgenciesInitial.initial() {
    return AgenciesInitial(
      result: const <Agency>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AgenciesInitial copyWith({
    CubitStatuses? statuses,
    List<Agency>? result,
    String? error,
    Command? command,
  }) {
    return AgenciesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
