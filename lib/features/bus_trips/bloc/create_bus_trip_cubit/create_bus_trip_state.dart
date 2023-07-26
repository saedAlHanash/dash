part of 'create_bus_trip_cubit.dart';

class CreateBusTripInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final CreateBusTripRequest request;
  final String error;

  const CreateBusTripInitial({
    required this.statuses,
    required this.result,
    required this.request,
    required this.error,
  });

  factory CreateBusTripInitial.initial() {
    return CreateBusTripInitial(
      result: false,
      request: CreateBusTripRequest(),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateBusTripInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    CreateBusTripRequest? request,
    String? error,
  }) {
    return CreateBusTripInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      request: request ?? this.request,
      error: error ?? this.error,
    );
  }
}
