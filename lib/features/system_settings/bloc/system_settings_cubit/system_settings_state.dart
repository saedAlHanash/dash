part of 'system_settings_cubit.dart';

class SystemSettingsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<SystemSetting> result;
  final String error;
  final Command command;

  const SystemSettingsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory SystemSettingsInitial.initial() {
    return  SystemSettingsInitial(
      result: const<SystemSetting>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  SystemSettingsInitial copyWith({
    CubitStatuses? statuses,
    List<SystemSetting>? result,
    String? error,
    Command? command,
  }) {
    return SystemSettingsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }

}