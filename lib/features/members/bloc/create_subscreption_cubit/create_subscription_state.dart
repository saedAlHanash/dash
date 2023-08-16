part of 'create_subscreption_cubit.dart';

class CreateSubscriptionInitial1 extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final CreateSubscriptionRequest request;
  final String error;

  const CreateSubscriptionInitial1({
    required this.statuses,
    required this.result,
    required this.request,
    required this.error,
  });

  factory CreateSubscriptionInitial1.initial() {
    return CreateSubscriptionInitial1(
      result: false,
      request: CreateSubscriptionRequest(),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateSubscriptionInitial1 copyWith({
    CubitStatuses? statuses,
    bool? result,
    CreateSubscriptionRequest? request,
    String? error,
  }) {
    return CreateSubscriptionInitial1(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      request: request ?? this.request,
      error: error ?? this.error,
    );
  }
}
