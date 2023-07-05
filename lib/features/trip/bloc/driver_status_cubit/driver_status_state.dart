part of 'driver_status_cubit.dart';

class DriverStatusInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const DriverStatusInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory DriverStatusInitial.initial() {
    return const DriverStatusInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DriverStatusInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return DriverStatusInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
