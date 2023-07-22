part of 'create_coupon_cubit.dart';

class CreateCouponInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const CreateCouponInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory CreateCouponInitial.initial() {
    return const CreateCouponInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateCouponInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return CreateCouponInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}