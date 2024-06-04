part of 'direct_pay_cubit.dart';

class DirectPayInitial extends AbstractState<bool> {
  final DirectPayRequest request;

  // final bool direct_payParam;

  const DirectPayInitial({
    required super.result,
    super.error,
    required this.request,
    // required this.direct_payParam,
    super.statuses,
  });

  factory DirectPayInitial.initial() {
    return DirectPayInitial(
      result: false,
      error: '',
      // direct_payParam: false,
      request: DirectPayRequest.fromJson({}),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DirectPayInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    DirectPayRequest? request,
    // bool? direct_payParam,
  }) {
    return DirectPayInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      // direct_payParam: direct_payParam ?? this.direct_payParam,
    );
  }
}
