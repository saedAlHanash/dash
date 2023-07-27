part of 'create_institution_cubit.dart';

class CreateInstitutionInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final CreateInstitutionRequest request;
  final String error;

  const CreateInstitutionInitial({
    required this.statuses,
    required this.result,
    required this.request,
    required this.error,
  });

  factory CreateInstitutionInitial.initial() {
    return CreateInstitutionInitial(
      result: false,
      request: CreateInstitutionRequest(),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateInstitutionInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    CreateInstitutionRequest? request,
    String? error,
  }) {
    return CreateInstitutionInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      request: request ?? this.request,
      error: error ?? this.error,
    );
  }
}
