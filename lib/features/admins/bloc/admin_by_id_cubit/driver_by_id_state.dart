part of 'driver_by_id_cubit.dart';

class DriverBuIdInitial extends Equatable {
  final CubitStatuses statuses;
  final DriverModel result;
  final String error;

  const DriverBuIdInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory DriverBuIdInitial.initial() {
    return DriverBuIdInitial(
      result: DriverModel.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DriverBuIdInitial copyWith({
    CubitStatuses? statuses,
    DriverModel? result,
    String? error,
  }) {
    return DriverBuIdInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
