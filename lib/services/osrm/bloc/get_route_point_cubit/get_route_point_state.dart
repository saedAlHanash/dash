part of 'get_route_point_cubit.dart';

class GetRoutePointInitial extends Equatable {
  final CubitStatuses statuses;
  final OsrmModel result;
  final String error;

  const GetRoutePointInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory GetRoutePointInitial.initial() {
    return GetRoutePointInitial(
      result: OsrmModel.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  GetRoutePointInitial copyWith({
    CubitStatuses? statuses,
    OsrmModel? result,
    String? error,
  }) {
    return GetRoutePointInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
