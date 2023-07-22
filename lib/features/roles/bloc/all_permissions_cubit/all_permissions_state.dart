part of 'all_permissions_cubit.dart';

class AllPermissionsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Permission> result;
  final String error;
  final Command command;

  const AllPermissionsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllPermissionsInitial.initial() {
    return  AllPermissionsInitial(
      result: const<Permission>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  AllPermissionsInitial copyWith({
    CubitStatuses? statuses,
    List<Permission>? result,
    String? error,
    Command? command,
  }) {
    return AllPermissionsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }

}