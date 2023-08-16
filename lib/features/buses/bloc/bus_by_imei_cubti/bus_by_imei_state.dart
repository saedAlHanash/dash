part of 'bus_by_imei_cubit.dart';

class BusByImeiInitial extends Equatable {
  final CubitStatuses statuses;
  final BusModel result;
  final String error;
  final Command command;

  const BusByImeiInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory BusByImeiInitial.initial() {
    return BusByImeiInitial(
      result:  BusModel.fromJson({}),
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }




  @override
  List<Object> get props => [statuses, result, error];

  BusByImeiInitial copyWith({
    CubitStatuses? statuses,
    BusModel? result,
    String? error,
    Command? command,
  }) {
    return BusByImeiInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
