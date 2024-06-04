part of 'providers_cubit.dart';

class ProvidersInitial extends AbstractCubit<List<Provider>> {
  // final ProvidersRequest request;
  // final  bool providersParam;
  const ProvidersInitial({
    required super.result,
    required super.command,
    super.error,
    // required this.request,
    // required this.providersParam,
    super.statuses,
  });//

  factory ProvidersInitial.initial() {
    return const ProvidersInitial(
      result: [],
      command: null,
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
    Command? command,
    String? error,
    // ProvidersRequest? request,
    // bool? providersParam,
  }) {
    return ProvidersInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      command: command ?? this.command,
      error: error ?? this.error,
      // request: request ?? this.request,
      // providersParam: providersParam ?? this.providersParam,
    );
  }
}
