part of 'create_policy_cubit.dart';

class CreatePolicyInitial extends Equatable {
  final CubitStatuses statuses;
  final PolicyResult result;
  final String error;

  const CreatePolicyInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory CreatePolicyInitial.initial() {
    return CreatePolicyInitial(
      result: PolicyResult.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreatePolicyInitial copyWith({
    CubitStatuses? statuses,
    PolicyResult? result,
    String? error,
  }) {
    return CreatePolicyInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
