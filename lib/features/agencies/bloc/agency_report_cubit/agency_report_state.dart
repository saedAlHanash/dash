part of 'agency_report_cubit.dart';

class AgencyReportInitial extends Equatable {
  final CubitStatuses statuses;
  final AgencyReport result;
  final String error;
  final int id;

  const AgencyReportInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.id,
  });

  factory AgencyReportInitial.initial() {
    return AgencyReportInitial(
      result: AgencyReport.fromJson({}),
      error: '',
      id: 0,
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AgencyReportInitial copyWith({
    CubitStatuses? statuses,
    AgencyReport? result,
    String? error,
    int? id,
  }) {
    return AgencyReportInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
    );
  }
}
