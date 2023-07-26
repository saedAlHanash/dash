part of 'create_member_cubit.dart';

class CreateMemberInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final CreateMemberRequest request;
  final String error;

  const CreateMemberInitial({
    required this.statuses,
    required this.result,
    required this.request,
    required this.error,
  });

  factory CreateMemberInitial.initial() {
    return CreateMemberInitial(
      result: false,
      request: CreateMemberRequest(),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateMemberInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    CreateMemberRequest? request,
    String? error,
  }) {
    return CreateMemberInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      request: request ?? this.request,
      error: error ?? this.error,
    );
  }
}
