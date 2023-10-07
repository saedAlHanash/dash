part of 'redeems_history_cubit.dart';

class RedeemsHistoryInitial extends Equatable {
  final CubitStatuses statuses;
  final List<RedeemHistory> result;
  final int driverId;
  final String error;

  const RedeemsHistoryInitial({
    required this.statuses,
    required this.result,
    required this.driverId,
    required this.error,
  });

  factory RedeemsHistoryInitial.initial() {
    return const RedeemsHistoryInitial(
      result:<RedeemHistory>[],
      error: '',
      driverId: 0,
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  RedeemsHistoryInitial copyWith({
    CubitStatuses? statuses,
    List<RedeemHistory> ? result,
    String? error,
    int? driverId,
  }) {
    return RedeemsHistoryInitial(
      statuses: statuses ?? this.statuses,
      driverId: driverId ?? this.driverId,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}