part of 'forgot_password_cubit.dart';

class ForgotPasswordInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const ForgotPasswordInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory ForgotPasswordInitial.initial() {
    return const ForgotPasswordInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ForgotPasswordInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return ForgotPasswordInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
