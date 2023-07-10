part of 'all_transfers_cubit.dart';

class AllTransfersInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Transfer> result;
  final String error;
  final Command command;

  const AllTransfersInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllTransfersInitial.initial() {
    return  AllTransfersInitial(
      result: const<Transfer>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  AllTransfersInitial copyWith({
    CubitStatuses? statuses,
    List<Transfer>? result,
    String? error,
    Command? command,
  }) {
    return AllTransfersInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }

}