part of 'all_messages_cubit.dart';

class AllMessagesInitial extends Equatable {
  final CubitStatuses statuses;
  final List<MessageModel> result;
  final String error;

  const AllMessagesInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory AllMessagesInitial.initial() {
    return const AllMessagesInitial(
      result: <MessageModel>[],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllMessagesInitial copyWith({
    CubitStatuses? statuses,
    List<MessageModel>? result,
    String? error,
  }) {
    return AllMessagesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}