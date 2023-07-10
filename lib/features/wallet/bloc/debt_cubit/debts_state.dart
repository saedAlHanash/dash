part of 'debts_cubit.dart';

class DebtsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Debt> result;
  final String error;
  final Command command;

  const DebtsInitial({
    required this.statuses,
    required this.result,
    required this.command,
    required this.error,
  });

  factory DebtsInitial.initial() {
    return  DebtsInitial(
      result: const <Debt>[],
      error: '',
      statuses: CubitStatuses.init,
      command: Command.initial(),
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DebtsInitial copyWith({
    CubitStatuses? statuses,
    List<Debt>? result,
    String? error,
    Command? command,
  }) {
    return DebtsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
