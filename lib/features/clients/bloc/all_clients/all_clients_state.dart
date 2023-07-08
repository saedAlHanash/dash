part of 'all_clients_cubit.dart';

class AllClientsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<DriverModel> result;
  final String error;

  const AllClientsInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory AllClientsInitial.initial() {
    return const AllClientsInitial(
      result: <DriverModel>[],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllClientsInitial copyWith({
    CubitStatuses? statuses,
    List<DriverModel>? result,
    String? error,
  }) {
    return AllClientsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}