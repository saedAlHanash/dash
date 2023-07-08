part of 'all_roles_cubit.dart';

class AllRolesInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Role> result;
  final String error;

  const AllRolesInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory AllRolesInitial.initial() {
    return const AllRolesInitial(
      result: <Role>[],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllRolesInitial copyWith({
    CubitStatuses? statuses,
    List<Role>? result,
    String? error,
  }) {
    return AllRolesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}