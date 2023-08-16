part of 'delete_subscription_cubit.dart';

class DeleteSubscriptionInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final int id;
  final String error;

  const DeleteSubscriptionInitial({
    required this.statuses,
    required this.result,
    required this.id,
    required this.error,
  });

  factory DeleteSubscriptionInitial.initial() {
    return const DeleteSubscriptionInitial(
      result: false,
      id: 0,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DeleteSubscriptionInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    int? id,
    String? error,
  }) {
    return DeleteSubscriptionInitial(
      statuses: statuses ?? this.statuses,
      id: id ?? this.id,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
