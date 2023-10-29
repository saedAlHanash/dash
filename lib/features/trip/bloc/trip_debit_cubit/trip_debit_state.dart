part of 'trip_debit_cubit.dart';

class TripDebitInitial extends Equatable {
  final CubitStatuses statuses;
  final Debt result;
  final String error;

  const TripDebitInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory TripDebitInitial.initial() {
    return TripDebitInitial(
      result: Debt.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  TripDebitInitial copyWith({
    CubitStatuses? statuses,
    Debt? result,
    String? error,
  }) {
    return TripDebitInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}