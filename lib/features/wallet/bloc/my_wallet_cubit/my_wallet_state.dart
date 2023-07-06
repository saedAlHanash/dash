part of 'my_wallet_cubit.dart';

class WalletInitial extends Equatable {
  final CubitStatuses statuses;
  final WalletResult result;
  final String error;

  const WalletInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory WalletInitial.initial() {
    return WalletInitial(
      result: WalletResult.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  WalletInitial copyWith({
    CubitStatuses? statuses,
    WalletResult? result,
    String? error,
  }) {
    return WalletInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
