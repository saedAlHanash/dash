part of 'all_admins_cubit.dart';

class AllAdminsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<DriverModel> result;
  final String error;
  final Command command;

  const AllAdminsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllAdminsInitial.initial() {
    return  AllAdminsInitial(
      result: const<DriverModel>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  AllAdminsInitial copyWith({
    CubitStatuses? statuses,
    List<DriverModel>? result,
    String? error,
    Command? command,
  }) {
    return AllAdminsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }

}