part of 'all_clients_cubit.dart';

class AllClientsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Driver> result;
  final String error;
  final FilterRequest command;

  const AllClientsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllClientsInitial.initial() {
    return  AllClientsInitial(
      result: const<Driver>[],
      error: '',
      command: FilterRequest.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  AllClientsInitial copyWith({
    CubitStatuses? statuses,
    List<Driver>? result,
    String? error,
    FilterRequest? command,
  }) {
    return AllClientsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }

}