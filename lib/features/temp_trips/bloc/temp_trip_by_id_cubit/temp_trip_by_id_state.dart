part of 'temp_trip_by_id_cubit.dart';

class TempTripBuIdInitial extends Equatable {
  final CubitStatuses statuses;
  final TempTripModel result;
  final String error;

  const TempTripBuIdInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory TempTripBuIdInitial.initial() {
    return TempTripBuIdInitial(
      result: TempTripModel.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  TempTripBuIdInitial copyWith({
    CubitStatuses? statuses,
    TempTripModel? result,
    String? error,
  }) {
    return TempTripBuIdInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
