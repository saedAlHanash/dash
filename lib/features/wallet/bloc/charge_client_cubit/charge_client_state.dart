part of 'charge_client_cubit.dart';

class ChargeClientInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;
  final ChargeClientRequest request;

  const ChargeClientInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.request,
  });

  factory ChargeClientInitial.initial() {
    return ChargeClientInitial(
      result: false,
      error: '',
      request: ChargeClientRequest.fromJson({}),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ChargeClientInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    ChargeClientRequest? request,
  }) {
    return ChargeClientInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
