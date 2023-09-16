part of 'all_messages_cubit.dart';

class AllMessagesInitial extends Equatable {
  final CubitStatuses statuses;
  final List<MessageModel> result;
  final String error;
  final Command command;

  const AllMessagesInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllMessagesInitial.initial() {
    return  AllMessagesInitial(
      result: const <MessageModel>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllMessagesInitial copyWith({
    CubitStatuses? statuses,
    List<MessageModel>? result,
    String? error,
    Command? command,
  }) {
    return AllMessagesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }

}