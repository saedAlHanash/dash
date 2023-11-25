part of 'company_path_by_id_cubit.dart';

class CompanyPathBuIdInitial extends Equatable {
  final CubitStatuses statuses;
  final CompanyPath result;
  final String error;

  const CompanyPathBuIdInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory CompanyPathBuIdInitial.initial() {
    return CompanyPathBuIdInitial(
      result: CompanyPath.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CompanyPathBuIdInitial copyWith({
    CubitStatuses? statuses,
    CompanyPath? result,
    String? error,
  }) {
    return CompanyPathBuIdInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
