part of 'route_points_cubit.dart';

class RoutePointsInitial extends Equatable {
  final CubitStatuses statuses;
  final RoutePointsResult result;
  final String error;

  const RoutePointsInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory RoutePointsInitial.initial() {
    return RoutePointsInitial(
      result: RoutePointsResult(),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  RoutePointsInitial copyWith({
    CubitStatuses? statuses,
    RoutePointsResult? result,
    String? error,
  }) {
    return RoutePointsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
