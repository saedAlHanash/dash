part of 'get_points_edge_cubit.dart';

class PointsEdgeInitial extends Equatable {
  final CubitStatuses statuses;
  final PointsEdgeResult result;
  final String error;


  const PointsEdgeInitial({
    required this.statuses,
    required this.result,
    required this.error,

  });

  factory PointsEdgeInitial.initial() {
    return PointsEdgeInitial(
      result: PointsEdgeResult.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  PointsEdgeInitial copyWith({
    CubitStatuses? statuses,
    PointsEdgeResult? result,
    String? error,
  }) {
    return PointsEdgeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
