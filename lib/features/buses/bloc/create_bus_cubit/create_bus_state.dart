part of 'create_bus_cubit.dart';

class CreateBusInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final CreateBusRequest request;
  final String error;

  const CreateBusInitial({
    required this.statuses,
    required this.result,
    required this.request,
    required this.error,
  });

  factory CreateBusInitial.initial() {
    return CreateBusInitial(
      result: false,
      request: CreateBusRequest(),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateBusInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    CreateBusRequest? request,
    String? error,
  }) {
    return CreateBusInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      request: request ?? this.request,
      error: error ?? this.error,
    );
  }
}
