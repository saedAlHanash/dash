part of 'estimate_cubit.dart';

class EstimateInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Estimate> result;
  final String error;
  final EstimateRequest request;

  const EstimateInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.request,
  });

  factory EstimateInitial.initial() {
    return  EstimateInitial(
      result: const[],
      error: '',
      request: EstimateRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  EstimateInitial copyWith({
    CubitStatuses? statuses,
    List<Estimate>? result,
    String? error,
    EstimateRequest? request,
  }) {
    return EstimateInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }

}