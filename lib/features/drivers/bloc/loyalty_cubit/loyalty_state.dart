part of 'loyalty_cubit.dart';

class LoyaltyInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final int  id;
  final String error;

  const LoyaltyInitial({
    required this.statuses,
    required this.result,
    required this.id,
    required this.error,
  });

  factory LoyaltyInitial.initial() {
    return const LoyaltyInitial(
      result: false,
      id: 0,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  LoyaltyInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    int? id,
    String? error,
  }) {
    return LoyaltyInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      id: id ?? this.id,
      error: error ?? this.error,
    );
  }

}