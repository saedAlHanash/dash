part of 'all_member_without_subscription_cubit.dart';

class AllMemberWithoutSubscriptionInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Subscriber> result;
  final String error;
  final Command command;

  const AllMemberWithoutSubscriptionInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllMemberWithoutSubscriptionInitial.initial() {
    return AllMemberWithoutSubscriptionInitial(
      result: const <Subscriber>[],
      error: '',
      command: Command.noPagination(),
      statuses: CubitStatuses.init,
    );
  }

  List<SpinnerItem> get getSpinnerItem {
    final list = <SpinnerItem>[];
    for (var e in result) {
      list.add(SpinnerItem(id: e.id ?? -1, name: e.fullName, item: e));
    }
    return list;
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllMemberWithoutSubscriptionInitial copyWith({
    CubitStatuses? statuses,
    List<Subscriber>? result,
    String? error,
    Command? command,
  }) {
    return AllMemberWithoutSubscriptionInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
