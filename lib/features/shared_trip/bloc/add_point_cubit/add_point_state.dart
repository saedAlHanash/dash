part of 'add_point_cubit.dart';

class AddPointInitial {
  final List<TripPoint> addedPoints;
  final List<int> edgeIds;
  final List<Edge> edges;

  const AddPointInitial({
    required this.addedPoints,
    required this.edgeIds,
    required this.edges,
  });

  factory AddPointInitial.initial() {
    var list = <TripPoint>[];
    return AddPointInitial(
      addedPoints: list,
      edges: [],
      edgeIds: [],
    );
  }

  AddPointInitial copyWith({
    List<TripPoint>? addedPoints,
  }) {
    return AddPointInitial(
      addedPoints: addedPoints ?? this.addedPoints,
      edgeIds: edgeIds,
      edges: edges,
    );
  }
}
