part of 'delete_plan_cubit.dart';

class DeletePlanInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final int id;
  final String error;

  const DeletePlanInitial({
    required this.statuses,
    required this.result,
    required this.id,
    required this.error,
  });

  factory DeletePlanInitial.initial() {
    return const DeletePlanInitial(
      result: false,
      id: 0,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DeletePlanInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    int? id,
    String? error,
  }) {
    return DeletePlanInitial(
      statuses: statuses ?? this.statuses,
      id: id ?? this.id,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
