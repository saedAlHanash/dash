part of 'create_plan_cubit.dart';

class CreatePlanInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final CreatePlanRequest request;
  final String error;

  const CreatePlanInitial({
    required this.statuses,
    required this.result,
    required this.request,
    required this.error,
  });

  factory CreatePlanInitial.initial() {
    return CreatePlanInitial(
      result: false,
      request: CreatePlanRequest(),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreatePlanInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    CreatePlanRequest? request,
    String? error,
  }) {
    return CreatePlanInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      request: request ?? this.request,
      error: error ?? this.error,
    );
  }
}
