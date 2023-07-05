part of 'my_wallet_cubit.dart';

class MyWalletInitial extends Equatable {
  final CubitStatuses statuses;
  final MyWalletResult result;
  final String error;

  const MyWalletInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory MyWalletInitial.initial() {
    return MyWalletInitial(
      result: MyWalletResult.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  MyWalletInitial copyWith({
    CubitStatuses? statuses,
    MyWalletResult? result,
    String? error,
  }) {
    return MyWalletInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
