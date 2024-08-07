part of 'providers_cubit.dart';

class ProvidersInitial extends AbstractState<List<Provider>> {
  // final ProvidersRequest request;
  // final  bool providersParam;
  const ProvidersInitial({
    required super.result,
    required super.filterRequest,
    super.error,
    // required this.request,
    // required this.providersParam,
    super.statuses,
  });//

  factory ProvidersInitial.initial() {
    return const ProvidersInitial(
      result: [],
      filterRequest: null,
      error: '',
      // providersParam: false,
      // request: ProvidersRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  ProvidersInitial copyWith({
    CubitStatuses? statuses,
    List<Provider>? result,
    FilterRequest? filterRequest,
    String? error,
    // ProvidersRequest? request,
    // bool? providersParam,
  }) {
    return ProvidersInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      filterRequest: filterRequest ?? this.filterRequest,
      error: error ?? this.error,
      // request: request ?? this.request,
      // providersParam: providersParam ?? this.providersParam,
    );
  }
}
