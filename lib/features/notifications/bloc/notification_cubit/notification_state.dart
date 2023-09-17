part of 'notification_cubit.dart';

class CreateNotificationInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const CreateNotificationInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory CreateNotificationInitial.initial() {
    return const CreateNotificationInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateNotificationInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return CreateNotificationInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
