import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_models/points/data/model/trip_point.dart';
import 'package:qareeb_models/trip_path/data/models/trip_path.dart';

part 'add_point_state.dart';

class AddPointCubit extends Cubit<AddPointInitial> {
  AddPointCubit() : super(AddPointInitial.initial());

  void addPoint({required TripPoint? point}) {
    if (point == null) return;
    state.addedPoints.add(point);
    emit(state.copyWith());
  }

  void addEdge({required int edgeId, required int pointId, required Edge edge}) {
    state.edgeIds.add(edgeId);
    state.edges.add(edge);
  }

  void removeEdge() {
    if (state.edgeIds.isEmpty) return;
    state.edgeIds.removeLast();
    state.edges.removeLast();
  }

  void update(){
    emit(state.copyWith());
  }
  void fromTempModel({required TripPath model}) {
    model.edges.forEachIndexed((i, e) {
      if (i == 0) {
        state.addedPoints.add(e.startPoint);
        state.addedPoints.add(e.endPoint);
      } else {
        state.addedPoints.add(e.endPoint);
      }
      addEdge(edgeId: e.id, pointId: e.endPointId, edge: e);
    });
  }

  TripPoint? removePoint({required int id}) {
    state.addedPoints.forEachIndexedWhile(
      (i, e) {
        if (e.id != id) return true;
        state.addedPoints.removeAt(i);
        return false;
      },
    );
    emit(state.copyWith());
    return state.addedPoints.lastOrNull;
  }

  num get getDistance => state.edges.fold<num>(0, (p, e) => p + e.distance)/1000;

  TripPoint? get getLatestPoint => state.addedPoints.lastOrNull;
}
