part of 'bus_trip_by_id_cubit.dart';

class BusTripBuIdInitial extends Equatable {
  final CubitStatuses statuses;
  final BusTripModel result;
  final String error;

  const BusTripBuIdInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory BusTripBuIdInitial.initial() {
    return BusTripBuIdInitial(
      result: BusTripModel.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  BusTripBuIdInitial copyWith({
    CubitStatuses? statuses,
    BusTripModel? result,
    String? error,
  }) {
    return BusTripBuIdInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
