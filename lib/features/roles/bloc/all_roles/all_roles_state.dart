part of 'all_roles_cubit.dart';

class AllRolesInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Role> result;
  final String error;
  final Command command;

  const AllRolesInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllRolesInitial.initial() {
    return  AllRolesInitial(
      result: const<Role>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  AllRolesInitial copyWith({
    CubitStatuses? statuses,
    List<Role>? result,
    String? error,
    Command? command,
  }) {
    return AllRolesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }

}