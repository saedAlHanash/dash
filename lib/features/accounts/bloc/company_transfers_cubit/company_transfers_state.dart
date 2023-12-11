part of 'company_transfers_cubit.dart';

class CompanyTransfersInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Transfer> result;
  final String error;
  final Command command;

  const CompanyTransfersInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory CompanyTransfersInitial.initial() {
    return  CompanyTransfersInitial(
      result: const<Transfer>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  CompanyTransfersInitial copyWith({
    CubitStatuses? statuses,
    List<Transfer>? result,
    String? error,
    Command? command,
  }) {
    return CompanyTransfersInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }

}