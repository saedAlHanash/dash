part of 'syrian_agency_report_cubit.dart';

class SyrianAgencyReportInitial extends Equatable {
  final CubitStatuses statuses;
  final List<SyrianAgencyReport> result;
  final String error;
  final Command command;

  const SyrianAgencyReportInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory SyrianAgencyReportInitial.initial() {
    return  SyrianAgencyReportInitial(
      result: const [],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  SyrianAgencyReportInitial copyWith({
    CubitStatuses? statuses,
    List<SyrianAgencyReport>? result,
    String? error,
    Command? command,
  }) {
    return SyrianAgencyReportInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
