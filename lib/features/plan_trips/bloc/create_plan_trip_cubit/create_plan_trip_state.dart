part of 'create_plan_trip_cubit.dart';

class CreatePlanTripInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final CreatePlanTripRequest request;
  final String error;

  const CreatePlanTripInitial({
    required this.statuses,
    required this.result,
    required this.request,
    required this.error,
  });

  factory CreatePlanTripInitial.initial() {
    return CreatePlanTripInitial(
      result: false,
      request: CreatePlanTripRequest(),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreatePlanTripInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    CreatePlanTripRequest? request,
    String? error,
  }) {
    return CreatePlanTripInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      request: request ?? this.request,
      error: error ?? this.error,
    );
  }
}
