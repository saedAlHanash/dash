part of 'financial_report_cubit.dart';

class FinancialReportInitial extends Equatable {
  final CubitStatuses statuses;
  final List<FinancialReport> result;
  final String error;
  final Command command;

  const FinancialReportInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory FinancialReportInitial.initial() {
    return  FinancialReportInitial(
      result: const[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  FinancialReportInitial copyWith({
    CubitStatuses? statuses,
    List<FinancialReport>? result,
    String? error,
    Command? command,
  }) {
    return FinancialReportInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }

}