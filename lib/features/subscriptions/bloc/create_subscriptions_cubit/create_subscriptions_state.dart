part of 'create_subscriptions_cubit.dart';

class CreateSubscriptionInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final SubscriptionModel request;
  final String error;

  const CreateSubscriptionInitial({
    required this.statuses,
    required this.result,
    required this.request,
    required this.error,
  });

  factory CreateSubscriptionInitial.initial() {
    return CreateSubscriptionInitial(
      result: false,
      request: SubscriptionModel(),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateSubscriptionInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    SubscriptionModel? request,
    String? error,
  }) {
    return CreateSubscriptionInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      request: request ?? this.request,
      error: error ?? this.error,
    );
  }
}
