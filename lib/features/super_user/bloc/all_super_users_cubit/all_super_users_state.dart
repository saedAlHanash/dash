part of 'all_super_users_cubit.dart';

class AllSuperUsersInitial extends Equatable {
  final CubitStatuses statuses;
  final List<SuperUserModel> result;
  final String error;
  final Command command;

  const AllSuperUsersInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllSuperUsersInitial.initial() {
    return AllSuperUsersInitial(
      result: const <SuperUserModel>[],
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

  AllSuperUsersInitial copyWith({
    CubitStatuses? statuses,
    List<SuperUserModel>? result,
    String? error,
    Command? command,
  }) {
    return AllSuperUsersInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
