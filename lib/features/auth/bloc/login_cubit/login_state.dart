part of 'login_cubit.dart';

class LoginInitial extends Equatable {
  final CubitStatuses statuses;
  final SuperUserModel result;
  final String error;
  final String phone;

  const LoginInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.phone,
  });

  factory LoginInitial.initial() {
    return LoginInitial(
      result: SuperUserModel.fromJson({}),
      error: '',
      phone: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, phone];

  LoginInitial copyWith({
    CubitStatuses? statuses,
    SuperUserModel? result,
    String? error,
    String? phone,
  }) {
    return LoginInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      phone: phone ?? this.phone,
    );
  }
}
