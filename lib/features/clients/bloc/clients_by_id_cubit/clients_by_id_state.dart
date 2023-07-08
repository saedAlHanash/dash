part of 'clients_by_id_cubit.dart';

class ClientByIdInitial extends Equatable {
  final CubitStatuses statuses;
  final DriverModel result;
  final String error;

  const ClientByIdInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory ClientByIdInitial.initial() {
    return ClientByIdInitial(
      result: DriverModel.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ClientByIdInitial copyWith({
    CubitStatuses? statuses,
    DriverModel? result,
    String? error,
  }) {
    return ClientByIdInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
