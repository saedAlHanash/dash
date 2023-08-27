part of 'update_system_settings_cubit.dart';

class UpdateSettingInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const UpdateSettingInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory UpdateSettingInitial.initial() {
    return const UpdateSettingInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  UpdateSettingInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return UpdateSettingInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}