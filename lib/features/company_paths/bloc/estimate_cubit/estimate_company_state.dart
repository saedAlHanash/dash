part of 'estimate_company_cubit.dart';

class EstimateCompanyInitial extends Equatable {
  final CubitStatuses statuses;
  final List<EstimateCompany> result;
  final String error;
  final EstimateCompanyRequest request;

  const EstimateCompanyInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.request,
  });

  factory EstimateCompanyInitial.initial() {
    return  EstimateCompanyInitial(
      result: const[],
      error: '',
      request: EstimateCompanyRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  EstimateCompanyInitial copyWith({
    CubitStatuses? statuses,
    List<EstimateCompany>? result,
    String? error,
    EstimateCompanyRequest? request,
  }) {
    return EstimateCompanyInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }

}