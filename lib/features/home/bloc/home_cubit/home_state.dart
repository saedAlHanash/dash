part of 'home_cubit.dart';

class HomeInitial extends Equatable {
  final CubitStatuses statuses;
  final HomeResult result;
  final String error;
  final Command command;

  const HomeInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory HomeInitial.initial() {
    return HomeInitial(
      result: HomeResult.fromJson({}),
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  HomeInitial copyWith({
    CubitStatuses? statuses,
    HomeResult? result,
    String? error,
    Command? command,
  }) {
    return HomeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
