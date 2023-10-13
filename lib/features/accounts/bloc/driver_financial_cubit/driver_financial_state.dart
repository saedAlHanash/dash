part of 'driver_financial_cubit.dart';

class DriverFinancialInitial extends Equatable {
  final CubitStatuses statuses;
  final DriverFinancialResult result;
  final String error;
  final FinancialFilterRequest request;

  const DriverFinancialInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.request,
  });

  factory DriverFinancialInitial.initial() {
    return DriverFinancialInitial(
      result: DriverFinancialResult.fromJson({}),
      error: '',
      request: FinancialFilterRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DriverFinancialInitial copyWith({
    CubitStatuses? statuses,
    DriverFinancialResult? result,
    String? error,
    FinancialFilterRequest? request,
  }) {
    return DriverFinancialInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
