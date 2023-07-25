part of 'delete_super_user_cubit.dart';

class DeleteSuperUserInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final int id;
  final String error;

  const DeleteSuperUserInitial({
    required this.statuses,
    required this.result,
    required this.id,
    required this.error,
  });

  factory DeleteSuperUserInitial.initial() {
    return const DeleteSuperUserInitial(
      result: false,
      id: 0,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DeleteSuperUserInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    int? id,
    String? error,
  }) {
    return DeleteSuperUserInitial(
      statuses: statuses ?? this.statuses,
      id: id ?? this.id,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
