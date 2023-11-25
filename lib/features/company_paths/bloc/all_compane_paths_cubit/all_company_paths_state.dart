part of 'all_company_paths_cubit.dart';

class AllCompanyPathsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<CompanyPath> result;
  final String error;
  final Command command;

  const AllCompanyPathsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllCompanyPathsInitial.initial() {
    return AllCompanyPathsInitial(
      result: const <CompanyPath>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllCompanyPathsInitial copyWith({
    CubitStatuses? statuses,
    List<CompanyPath>? result,
    String? error,
    Command? command,
  }) {
    return AllCompanyPathsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
