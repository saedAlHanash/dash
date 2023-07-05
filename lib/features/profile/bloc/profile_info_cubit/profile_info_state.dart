part of 'profile_info_cubit.dart';

class ProfileInfoInitial extends Equatable {
  final CubitStatuses statuses;
  final ProfileInfoResult result;
  final String error;

  const ProfileInfoInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory ProfileInfoInitial.initial() {
    return ProfileInfoInitial(
      result: AppSharedPreference.getProfileInfo() ?? ProfileInfoResult.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ProfileInfoInitial copyWith({
    CubitStatuses? statuses,
    ProfileInfoResult? result,
    String? error,
  }) {
    return ProfileInfoInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
