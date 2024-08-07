part of 'financial_report_cubit.dart';

class FinancialReportInitial extends Equatable {
  final CubitStatuses statuses;
  final List<FinancialResult> result;
  final String error;
  final FinancialReportResult response;
  final FilterRequest command;

  const FinancialReportInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.response,
    required this.command,
  });

  factory FinancialReportInitial.initial() {
    return  FinancialReportInitial(
      result: const[],
      error: '',
      response: FinancialReportResult.fromJson({}),
      command: FilterRequest.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  FinancialReportInitial copyWith({
    CubitStatuses? statuses,
    List<FinancialResult>? result,
    String? error,
    FinancialReportResult? response,
    FilterRequest? command,
  }) {
    return FinancialReportInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      response: response ?? this.response,
      command: command ?? this.command,
    );
  }

}