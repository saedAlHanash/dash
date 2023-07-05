part of 'debts_cubit.dart';

class DebtsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Debt> result;
  final String error;

  const DebtsInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory DebtsInitial.initial() {
    return const DebtsInitial(
      result: <Debt>[],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DebtsInitial copyWith({
    CubitStatuses? statuses,
    List<Debt>? result,
    String? error,
  }) {
    return DebtsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
