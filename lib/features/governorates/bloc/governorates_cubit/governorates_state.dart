part of 'governorates_cubit.dart';

class GovernmentsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<GovernmentModel>  result;
  final String error;
  final Command command;

  const GovernmentsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory GovernmentsInitial.initial() {
    return  GovernmentsInitial(
      result: const <GovernmentModel>[],
      error: '',
      command: Command.noPagination(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  GovernmentsInitial copyWith({
    CubitStatuses? statuses,
    List<GovernmentModel>? result,
    String? error,
    Command? command,
  }) {
    return GovernmentsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }

}