part of 'providers_cubit.dart';

class ProvidersInitial extends Equatable {
  final CubitStatuses statuses;
  final List<EpayItem> result;
  final String error;

  const ProvidersInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory ProvidersInitial.initial() {
    return const ProvidersInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ProvidersInitial copyWith({
    CubitStatuses? statuses,
    List<EpayItem>? result,
    String? error,
  }) {
    return ProvidersInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
