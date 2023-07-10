part of 'account_amount_cubit.dart';

class AccountAmountInitial extends Equatable {
  final CubitStatuses statuses;
  final num driverAmount;
  final num companyAmount;
  final String error;

  const AccountAmountInitial({
    required this.statuses,
    required this.driverAmount,
    required this.companyAmount,
    required this.error,
  });

  factory AccountAmountInitial.initial() {
    return const AccountAmountInitial(
      driverAmount: 0,
      companyAmount: 0,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, driverAmount, error];


  AccountAmountInitial copyWith({
    CubitStatuses? statuses,
    num? driverAmount,
    num? companyAmount,
    String? error,
  }) {
    return AccountAmountInitial(
      statuses: statuses ?? this.statuses,
      driverAmount: driverAmount ?? this.driverAmount,
      companyAmount: companyAmount ?? this.companyAmount,
      error: error ?? this.error,
    );
  }

}