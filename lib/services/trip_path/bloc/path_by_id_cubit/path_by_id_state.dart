part of 'path_by_id_cubit.dart';

class PathByIdInitial extends Equatable {
  final CubitStatuses statuses;
  final TripPath result;
  final String error;
  final num id;

  const PathByIdInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.id,
  });

  factory PathByIdInitial.initial() {
    return PathByIdInitial(
      result: TripPath.fromJson({}),
      error: '',
      id: 0,
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, id];

  PathByIdInitial copyWith({
    CubitStatuses? statuses,
    TripPath? result,
    String? error,
    num? id,
  }) {
    return PathByIdInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
    );
  }
}
