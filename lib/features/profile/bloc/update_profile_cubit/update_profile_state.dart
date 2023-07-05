part of 'update_profile_cubit.dart';

class UpdateProfileInitial extends Equatable {
  final CubitStatuses statuses;
  final ProfileInfoResult result;
  final String error;

  const UpdateProfileInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory UpdateProfileInitial.initial() {
    return UpdateProfileInitial(
      result: ProfileInfoResult.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  UpdateProfileInitial copyWith({
    CubitStatuses? statuses,
    ProfileInfoResult? result,
    String? error,
  }) {
    return UpdateProfileInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}