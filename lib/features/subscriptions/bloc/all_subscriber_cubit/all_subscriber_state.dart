part of 'all_subscriber_cubit.dart';

class AllSubscriberInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Subscriber> result;
  final String error;
  final Command command;

  const AllSubscriberInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllSubscriberInitial.initial() {
    return AllSubscriberInitial(
      result: const <Subscriber>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  List<Subscriber> filter(String q) {
    if (q.isEmpty) return result;
    final filterList = <Subscriber>[];
    for (var e in result) {
      if (e.fullName.contains(q)) filterList.add(e);
    }
    return filterList;
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

  AllSubscriberInitial copyWith({
    CubitStatuses? statuses,
    List<Subscriber>? result,
    String? error,
    Command? command,
  }) {
    return AllSubscriberInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
