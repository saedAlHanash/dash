part of 'create_shared_trip_cubit.dart';

class CreateSharedTripInitial extends Equatable {
  final CubitStatuses statuses;
  final SharedTrip result;
  final String error;
  final RequestCreateShared request;

  const CreateSharedTripInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.request,
  });

  factory CreateSharedTripInitial.initial() {
    return CreateSharedTripInitial(
      result: SharedTrip.fromJson({}),
      error: '',
      request: RequestCreateShared.fromJson({}),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error,request];

  CreateSharedTripInitial copyWith({
    CubitStatuses? statuses,
    SharedTrip? result,
    String? error,
    RequestCreateShared? request,
  }) {
    return CreateSharedTripInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
