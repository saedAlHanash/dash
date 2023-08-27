part of 'update_system_params_cubit.dart';

class UpdateParamsInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const UpdateParamsInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory UpdateParamsInitial.initial() {
    return const UpdateParamsInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  UpdateParamsInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return UpdateParamsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}