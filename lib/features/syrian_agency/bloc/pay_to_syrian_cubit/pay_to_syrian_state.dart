part of 'pay_to_syrian_cubit.dart';

class PayToSyrianInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final SyrianPayRequest request;
  final String error;

  const PayToSyrianInitial({
    required this.statuses,
    required this.result,
    required this.request,
    required this.error,
  });

  factory PayToSyrianInitial.initial() {
    return PayToSyrianInitial(
      result: false,
      request: SyrianPayRequest(),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  PayToSyrianInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    SyrianPayRequest? request,
    String? error,
  }) {
    return PayToSyrianInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      request: request ?? this.request,
      error: error ?? this.error,
    );
  }
}
