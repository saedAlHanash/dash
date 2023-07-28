part of 'send_report_cubit.dart';

class SendReportInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const SendReportInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory SendReportInitial.initial() {
    return const SendReportInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  SendReportInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return SendReportInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}