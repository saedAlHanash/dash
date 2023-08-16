part of 'home1_cubit.dart';

class Home1Initial extends Equatable {
  final CubitStatuses statuses;
  final Home1Result result;
  final String error;
  final Command command;

  const Home1Initial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory Home1Initial.initial() {
    return Home1Initial(
      result: Home1Result.fromJson({}),
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  Home1Initial copyWith({
    CubitStatuses? statuses,
    Home1Result? result,
    String? error,
    Command? command,
  }) {
    return Home1Initial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
