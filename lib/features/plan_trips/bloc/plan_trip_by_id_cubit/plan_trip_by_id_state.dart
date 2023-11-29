part of 'plan_trip_by_id_cubit.dart';

class PlanTripBuIdInitial extends Equatable {
  final CubitStatuses statuses;
  final PlanTripModel result;
  final String error;

  const PlanTripBuIdInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory PlanTripBuIdInitial.initial() {
    return PlanTripBuIdInitial(
      result: PlanTripModel.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  PlanTripBuIdInitial copyWith({
    CubitStatuses? statuses,
    PlanTripModel? result,
    String? error,
  }) {
    return PlanTripBuIdInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
