part of 'create_role_cubit.dart';

class CreateRoleInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const CreateRoleInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory CreateRoleInitial.initial() {
    return const CreateRoleInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateRoleInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return CreateRoleInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}