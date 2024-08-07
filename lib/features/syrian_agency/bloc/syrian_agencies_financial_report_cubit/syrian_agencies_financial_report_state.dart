part of 'syrian_agencies_financial_report_cubit.dart';

class SyrianAgenciesFinancialReportInitial extends Equatable {
  final CubitStatuses statuses;
  final SyrianAgencyFinancialReport result;
  final String error;
  final FilterRequest command;

  const SyrianAgenciesFinancialReportInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory SyrianAgenciesFinancialReportInitial.initial() {
    return SyrianAgenciesFinancialReportInitial(
      result: SyrianAgencyFinancialReport.fromJson({}),
      error: '',
      command: FilterRequest.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  SyrianAgenciesFinancialReportInitial copyWith({
    CubitStatuses? statuses,
    SyrianAgencyFinancialReport? result,
    String? error,
    FilterRequest? command,
  }) {
    return SyrianAgenciesFinancialReportInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
