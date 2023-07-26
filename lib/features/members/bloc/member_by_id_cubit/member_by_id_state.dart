part of 'member_by_id_cubit.dart';

class MemberBuIdInitial extends Equatable {
  final CubitStatuses statuses;
  final Member result;
  final String error;

  const MemberBuIdInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory MemberBuIdInitial.initial() {
    return MemberBuIdInitial(
      result: Member.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  MemberBuIdInitial copyWith({
    CubitStatuses? statuses,
    Member? result,
    String? error,
  }) {
    return MemberBuIdInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
