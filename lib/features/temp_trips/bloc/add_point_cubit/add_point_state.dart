part of 'add_point_cubit.dart';

class AddPointInitial {
  final List<TripPoint> addedPoints;
  final Map<int, int> edgeIds;

  const AddPointInitial({
    required this.addedPoints,
    required this.edgeIds,
  });

  factory AddPointInitial.initial() {
    var list = <TripPoint>[];
    return AddPointInitial(
      addedPoints: list,
      edgeIds: <int, int>{},
    );
  }

  AddPointInitial copyWith({
    List<TripPoint>? addedPoints,
  }) {
    return AddPointInitial(
      addedPoints: addedPoints ?? this.addedPoints,
      edgeIds: edgeIds,
    );
  }
}
