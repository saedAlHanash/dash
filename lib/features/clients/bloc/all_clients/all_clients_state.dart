part of 'all_clients_cubit.dart';

class AllClientsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<DriverModel> result;
  final String error;
  final Command command;

  const AllClientsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllClientsInitial.initial() {
    return  AllClientsInitial(
      result: const<DriverModel>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  AllClientsInitial copyWith({
    CubitStatuses? statuses,
    List<DriverModel>? result,
    String? error,
    Command? command,
  }) {
    return AllClientsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }

}