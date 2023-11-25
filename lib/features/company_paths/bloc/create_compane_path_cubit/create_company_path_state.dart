part of 'create_company_path_cubit.dart';

class CreateCompanyPathInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final CreateCompanyPathRequest request;
  final String error;

  const CreateCompanyPathInitial({
    required this.statuses,
    required this.result,
    required this.request,
    required this.error,
  });

  factory CreateCompanyPathInitial.initial() {
    return CreateCompanyPathInitial(
      result: false,
      request: CreateCompanyPathRequest(),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateCompanyPathInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    CreateCompanyPathRequest? request,
    String? error,
  }) {
    return CreateCompanyPathInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      request: request ?? this.request,
      error: error ?? this.error,
    );
  }
}
