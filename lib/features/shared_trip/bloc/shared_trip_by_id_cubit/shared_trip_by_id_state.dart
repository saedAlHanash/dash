part of 'shared_trip_by_id_cubit.dart';

class SharedTripByIdInitial extends Equatable {
  final CubitStatuses statuses;
  final SharedTrip result;
  final String error;
  final int id;

  const SharedTripByIdInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.id,
  });

  factory SharedTripByIdInitial.initial() {
    return SharedTripByIdInitial(
      result: SharedTrip.fromJson({}),
      error: '',
      id: 0,
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, id];

  SharedTripByIdInitial copyWith({
    CubitStatuses? statuses,
    SharedTrip? result,
    String? error,
    int? id,
  }) {
    return SharedTripByIdInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
    );
  }
}
