part of 'pay_to_cubit.dart';

class PayToInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const PayToInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory PayToInitial.initial() {
    return const PayToInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  PayToInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return PayToInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}