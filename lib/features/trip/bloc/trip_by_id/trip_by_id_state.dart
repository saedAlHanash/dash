part of 'trip_by_id_cubit.dart';

class TripByIdInitial extends Equatable {
  final CubitStatuses statuses;
  final TripResult result;
  final String error;

  const TripByIdInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory TripByIdInitial.initial() {
    return TripByIdInitial(
      result: TripResult.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  TripByIdInitial copyWith({
    CubitStatuses? statuses,
    TripResult? result,
    String? error,
  }) {
    return TripByIdInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}