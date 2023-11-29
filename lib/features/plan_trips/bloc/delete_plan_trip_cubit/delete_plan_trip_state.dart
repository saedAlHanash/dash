part of 'delete_plan_trip_cubit.dart';

class DeletePlanTripInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final int id;
  final String error;

  const DeletePlanTripInitial({
    required this.statuses,
    required this.result,
    required this.id,
    required this.error,
  });

  factory DeletePlanTripInitial.initial() {
    return const DeletePlanTripInitial(
      result: false,
      id: 0,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DeletePlanTripInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    int? id,
    String? error,
  }) {
    return DeletePlanTripInitial(
      statuses: statuses ?? this.statuses,
      id: id ?? this.id,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
