part of 'login_cubit.dart';

class LoginInitial extends Equatable {

  final CubitStatuses statuses;
  final UserModel result;
  final String error;
  final LoginRequest request;


  const LoginInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.request,
  });

  factory LoginInitial.initial() {
    return  LoginInitial(
      result: UserModel.fromJson({}),
      error: '',
      request: LoginRequest.fromJson({}),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error,request];

  LoginInitial copyWith({
    CubitStatuses? statuses,
    UserModel? result,
    String? error,
    LoginRequest? request,
  }) {
    return LoginInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
