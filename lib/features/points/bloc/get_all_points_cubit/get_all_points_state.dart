part of 'get_all_points_cubit.dart';

class PointsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<TripPoint> result;
  final String error;
  final TripPoint tempPoint;

  const PointsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.tempPoint,
  });

  factory PointsInitial.initial() {
    return PointsInitial(
      result: const [],
      error: '',
      tempPoint: TripPoint.fromJson({}),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, tempPoint];

  List<SpinnerItem> getSpinnerItems({int? selectedId}) {
    if (result.isEmpty) {
      return [SpinnerItem(name: 'لا توجد نقاط', id: 0)];
    }
    return result
        .map((e) => SpinnerItem(
              name: e.arName,
              item: e,
              id: e.id,
              isSelected: e.id == selectedId,
            ))
        .toList();
  }

  PointsInitial copyWith({
    CubitStatuses? statuses,
    List<TripPoint>? result,
    String? error,
    TripPoint? tempPoint,
  }) {
    return PointsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      tempPoint: tempPoint ?? this.tempPoint,
    );
  }
}
