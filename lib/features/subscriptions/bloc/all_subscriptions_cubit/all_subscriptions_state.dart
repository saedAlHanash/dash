part of 'all_subscriptions_cubit.dart';

class AllSubscriptionsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<SubscriptionModel> result;
  final String error;
  final Command command;

  const AllSubscriptionsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllSubscriptionsInitial.initial() {
    return AllSubscriptionsInitial(
      result: const <SubscriptionModel>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  List<SpinnerItem> get getSpinnerItem {
    final list = <SpinnerItem>[];
    for (var e in result) {
      list.add(SpinnerItem(id: e.id ?? -1, name: e.name, item: e));
    }
    return list;
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllSubscriptionsInitial copyWith({
    CubitStatuses? statuses,
    List<SubscriptionModel>? result,
    String? error,
    Command? command,
  }) {
    return AllSubscriptionsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
