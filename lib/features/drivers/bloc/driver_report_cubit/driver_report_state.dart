part of 'driver_report_cubit.dart';

class DriverReportInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;
  final String processId;

  const DriverReportInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.processId,
  });

  factory DriverReportInitial.initial() {
    return const DriverReportInitial(
      result: false,
      error: '',
      processId: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DriverReportInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    String? processId,
  }) {
    return DriverReportInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      processId: processId ?? this.processId,
    );
  }

}