part of 'all_member_cubit.dart';

class AllMembersInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Member> result;
  final String error;
  final Command command;

  const AllMembersInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllMembersInitial.initial() {
    return AllMembersInitial(
      result: const <Member>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  List<SpinnerItem> get getSpinnerItem {
    final list = <SpinnerItem>[];
    for (var e in result) {
      list.add(SpinnerItem(id: e.id, name: e.fullName, item: e));
    }
    return list;
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllMembersInitial copyWith({
    CubitStatuses? statuses,
    List<Member>? result,
    String? error,
    Command? command,
  }) {
    return AllMembersInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
