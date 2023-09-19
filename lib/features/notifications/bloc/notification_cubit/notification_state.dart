part of 'notification_cubit.dart';

class CreateNotificationInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;
  final NotificationRequest request;

  const CreateNotificationInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.request,
  });

  factory CreateNotificationInitial.initial() {
    return  CreateNotificationInitial(
      result: false,
      error: '',
      request: NotificationRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateNotificationInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    NotificationRequest? request,
  }) {
    return CreateNotificationInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
