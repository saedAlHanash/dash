part of 'create_temp_trip_cubit.dart';

class CreateTempTripInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final CreateTempTripRequest request;
  final String error;

  const CreateTempTripInitial({
    required this.statuses,
    required this.result,
    required this.request,
    required this.error,
  });

  factory CreateTempTripInitial.initial() {
    return CreateTempTripInitial(
      result: false,
      request: CreateTempTripRequest(),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateTempTripInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    CreateTempTripRequest? request,
    String? error,
  }) {
    return CreateTempTripInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      request: request ?? this.request,
      error: error ?? this.error,
    );
  }
}
