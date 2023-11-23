part of 'delete_company_cubit.dart';

class DeleteCompanyInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final int id;
  final String error;

  const DeleteCompanyInitial({
    required this.statuses,
    required this.result,
    required this.id,
    required this.error,
  });

  factory DeleteCompanyInitial.initial() {
    return const DeleteCompanyInitial(
      result: false,
      id: 0,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DeleteCompanyInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    int? id,
    String? error,
  }) {
    return DeleteCompanyInitial(
      statuses: statuses ?? this.statuses,
      id: id ?? this.id,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
