part of 'change_coupon_state_cubit.dart';

class ChangeCouponStateInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final int id;
  final String error;

  const ChangeCouponStateInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.id,
  });

  factory ChangeCouponStateInitial.initial() {
    return const ChangeCouponStateInitial(
      result: false,
      error: '',
      id: 0,
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ChangeCouponStateInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    int? id,
    String? error,
  }) {
    return ChangeCouponStateInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
    );
  }

}