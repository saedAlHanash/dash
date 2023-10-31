part of 'driver_financial_cubit.dart';

class DriverFinancialInitial extends Equatable {
  final CubitStatuses statuses;
  final DriverFinancialResult result;
  final String error;
  final DriverFinancialFilterRequest request;

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
      request: DriverFinancialFilterRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DriverFinancialInitial copyWith({
    CubitStatuses? statuses,
    DriverFinancialResult? result,
    String? error,
    DriverFinancialFilterRequest? request,
  }) {
    return DriverFinancialInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
