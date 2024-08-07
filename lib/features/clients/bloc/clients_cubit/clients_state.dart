part of 'clients_cubit.dart';

class ClientsInitial extends AbstractState<List<Driver>> {
  // final Command request;
  // final  bool clientParam;
  const ClientsInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.clientParam,
    super.filterRequest,
    super.statuses,
  }); //

  factory ClientsInitial.initial() {
    return  ClientsInitial(
      result: [],
      error: '',
      filterRequest: FilterRequest.initial(),
      // clientParam: false,
      // request: Command(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props =>
      [statuses, result, error, if (filterRequest != null) filterRequest!];

  ClientsInitial copyWith({
    CubitStatuses? statuses,
    List<Driver>? result,
    String? error,
    FilterRequest? filterRequest,
    // bool? clientParam,
  }) {
    return ClientsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      // request: request ?? this.request,
      // clientParam: clientParam ?? this.clientParam,
    );
  }
}
