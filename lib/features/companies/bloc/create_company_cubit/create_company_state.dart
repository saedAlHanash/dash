part of 'create_company_cubit.dart';

class CreateCompanyInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final CreateCompanyRequest request;
  final String error;

  const CreateCompanyInitial({
    required this.statuses,
    required this.result,
    required this.request,
    required this.error,
  });

  factory CreateCompanyInitial.initial() {
    return CreateCompanyInitial(
      result: false,
      request: CreateCompanyRequest(),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateCompanyInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    CreateCompanyRequest? request,
    String? error,
  }) {
    return CreateCompanyInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      request: request ?? this.request,
      error: error ?? this.error,
    );
  }
}
