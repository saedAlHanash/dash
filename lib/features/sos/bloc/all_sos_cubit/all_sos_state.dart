part of 'all_sos_cubit.dart';

class AllSosInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Sos> result;
  final String error;
  final Command command;

  const AllSosInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllSosInitial.initial() {
    return AllSosInitial(
      result: const <Sos>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  List<SpinnerItem> get getSpinnerItem {
    final list = <SpinnerItem>[];
    for (var e in result) {
      list.add(SpinnerItem(id: e.id, name: e.id.toString(), item: e));
    }
    return list;
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllSosInitial copyWith({
    CubitStatuses? statuses,
    List<Sos>? result,
    String? error,
    Command? command,
  }) {
    return AllSosInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
