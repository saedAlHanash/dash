part of 'redeems_cubit.dart';

class RedeemsInitial extends Equatable {
  final CubitStatuses statuses;
  final RedeemsResult result;
  final int driverId;
  final String error;

  const RedeemsInitial({
    required this.statuses,
    required this.result,
    required this.driverId,
    required this.error,
  });

  factory RedeemsInitial.initial() {
    return RedeemsInitial(
      result: RedeemsResult.fromJson({}),
      error: '',
      driverId: 0,
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  RedeemsInitial copyWith({
    CubitStatuses? statuses,
    RedeemsResult? result,
    String? error,
    int? driverId,
  }) {
    return RedeemsInitial(
      statuses: statuses ?? this.statuses,
      driverId: driverId ?? this.driverId,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}