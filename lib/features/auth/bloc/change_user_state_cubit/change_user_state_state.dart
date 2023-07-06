part of 'change_user_state_cubit.dart';

class ChangeUserStateInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final int id;
  final String error;

  const ChangeUserStateInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.id,
  });

  factory ChangeUserStateInitial.initial() {
    return const ChangeUserStateInitial(
      result: false,
      error: '',
      id: 0,
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ChangeUserStateInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    int? id,
    String? error,
  }) {
    return ChangeUserStateInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
    );
  }

}