part of 'subscriptions_by_id_cubit.dart';

class SubscriptionBuIdInitial extends Equatable {
  final CubitStatuses statuses;
  final SubscriptionModel result;
  final String error;

  const SubscriptionBuIdInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory SubscriptionBuIdInitial.initial() {
    return SubscriptionBuIdInitial(
      result: SubscriptionModel.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  SubscriptionBuIdInitial copyWith({
    CubitStatuses? statuses,
    SubscriptionModel? result,
    String? error,
  }) {
    return SubscriptionBuIdInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
