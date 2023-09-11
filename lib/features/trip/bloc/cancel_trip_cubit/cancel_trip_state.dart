part of 'cancel_trip_cubit.dart';

class CancelTripInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const CancelTripInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory CancelTripInitial.initial() {
    return const CancelTripInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CancelTripInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return CancelTripInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
