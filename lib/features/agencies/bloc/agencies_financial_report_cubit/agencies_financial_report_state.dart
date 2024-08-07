part of 'agencies_financial_report_cubit.dart';

class AgenciesReportInitial extends Equatable {
  final CubitStatuses statuses;
  final AgenciesFinancialResult result;
  final String error;
  final FilterRequest command;

  const AgenciesReportInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AgenciesReportInitial.initial() {
    return AgenciesReportInitial(
      result: AgenciesFinancialResult.fromJson({}),
      error: '',
      command: FilterRequest.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AgenciesReportInitial copyWith({
    CubitStatuses? statuses,
    AgenciesFinancialResult? result,
    String? error,
    FilterRequest? command,
  }) {
    return AgenciesReportInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
