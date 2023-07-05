part of 'policy_cubit.dart';

class PolicyInitial extends Equatable {
  final CubitStatuses statuses;
  final PolicyResult result;
  final String error;

  const PolicyInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory PolicyInitial.initial() {
    return PolicyInitial(
      result: PolicyResult.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  PolicyInitial copyWith({
    CubitStatuses? statuses,
    PolicyResult? result,
    String? error,
  }) {
    return PolicyInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
