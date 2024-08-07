part of 'all_coupons_cubit.dart';

class AllCouponsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Coupon> result;
  final String error;
  final FilterRequest command;

  const AllCouponsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllCouponsInitial.initial() {
    return  AllCouponsInitial(
      result: const<Coupon>[],
      error: '',
      command: FilterRequest.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  AllCouponsInitial copyWith({
    CubitStatuses? statuses,
    List<Coupon>? result,
    String? error,
    FilterRequest? command,
  })  {
    return AllCouponsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }

}