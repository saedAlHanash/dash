part of 'create_agency_cubit.dart';

class CreateAgencyInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final AgencyRequest request;
  final String error;

  const CreateAgencyInitial({
    required this.statuses,
    required this.result,
    required this.request,
    required this.error,
  });

  factory CreateAgencyInitial.initial() {
    return CreateAgencyInitial(
      result: false,
      request: AgencyRequest(),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateAgencyInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    AgencyRequest? request,
    String? error,
  }) {
    return CreateAgencyInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      request: request ?? this.request,
      error: error ?? this.error,
    );
  }
}
