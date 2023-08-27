part of 'system_params_cubit.dart';

class SystemParamsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<SystemParam> result;
  final String error;
  final Command command;

  const SystemParamsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory SystemParamsInitial.initial() {
    return  SystemParamsInitial(
      result: const<SystemParam>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  SystemParamsInitial copyWith({
    CubitStatuses? statuses,
    List<SystemParam>? result,
    String? error,
    Command? command,
  }) {
    return SystemParamsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }

}