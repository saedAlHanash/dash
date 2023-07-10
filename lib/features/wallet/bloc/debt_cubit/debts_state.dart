part of 'debts_cubit.dart';

class DebtsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Debt> result;
  final String error;
  final Command command;
  final int id;

  const DebtsInitial({
    required this.statuses,
    required this.result,
    required this.command,
    required this.id,
    required this.error,
  });

  factory DebtsInitial.initial() {
    return  DebtsInitial(
      result: const <Debt>[],
      error: '',
      statuses: CubitStatuses.init,
      command: Command.initial(),
      id: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DebtsInitial copyWith({
    CubitStatuses? statuses,
    List<Debt>? result,
    String? error,
    Command? command,
    int? id,
  }) {
    return DebtsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
      id: id ?? this.id,
    );
  }
}
