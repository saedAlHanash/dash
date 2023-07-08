part of 'point_by_id_cubit.dart';

class PointByIdInitial extends Equatable {
  final CubitStatuses statuses;
  final TripPoint result;
  final String error;
  final List<TripPoint> connectedPoints;

  const PointByIdInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.connectedPoints,
  });

  factory PointByIdInitial.initial() {
    return PointByIdInitial(
      result: TripPoint.fromJson({}),
      error: '',
      connectedPoints: const <TripPoint>[],
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, connectedPoints];

  PointByIdInitial copyWith({
    CubitStatuses? statuses,
    TripPoint? result,
    String? error,
    List<TripPoint>? conecctedPoints,
  }) {
    return PointByIdInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      connectedPoints: conecctedPoints ?? this.connectedPoints,
    );
  }
}
