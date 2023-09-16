part of 'get_edged_point_cubit.dart';

class EdgesPointInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Edge> result;
  final String error;
  final Edge tempPoint;

  const EdgesPointInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.tempPoint,
  });

  factory EdgesPointInitial.initial() {
    return EdgesPointInitial(
      result: const [],
      error: '',
      tempPoint: Edge.fromJson({}),
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

  EdgesPointInitial copyWith({
    CubitStatuses? statuses,
    List<Edge>? result,
    String? error,
    Edge? tempPoint,
  }) {
    return EdgesPointInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      tempPoint: tempPoint ?? this.tempPoint,
    );
  }
}
