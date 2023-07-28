part of 'create_super_user_cubit.dart';

class CreateSuperUsersInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final CreateSuperUserRequest request;
  final String error;

  const CreateSuperUsersInitial({
    required this.statuses,
    required this.result,
    required this.request,
    required this.error,
  });

  factory CreateSuperUsersInitial.initial() {
    return CreateSuperUsersInitial(
      result: false,
      request: CreateSuperUserRequest(),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateSuperUsersInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    CreateSuperUserRequest? request,
    String? error,
  }) {
    return CreateSuperUsersInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      request: request ?? this.request,
      error: error ?? this.error,
    );
  }
}
