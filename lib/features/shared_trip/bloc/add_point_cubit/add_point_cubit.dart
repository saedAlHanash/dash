import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_models/points/data/model/trip_point.dart';

import 'package:qareeb_models/points/data/response/points_response.dart';

part 'add_point_state.dart';

class AddPointCubit extends Cubit<AddPointInitial> {
  AddPointCubit() : super(AddPointInitial.initial());

  void addPoint({required TripPoint? point}) {
    if (point == null) return;
    state.addedPoints.add(point);
    emit(state.copyWith());
  }

  void addEdge({required int edgeId, required int pointId}) {
    state.edgeIds[pointId] = edgeId;
  }

  void removeEdge({int? pointId}) {
    int? keyForRemove;
    state.edgeIds.forEach((key, value) {
      if (pointId == key) {
        keyForRemove = pointId;
      }
    });

    if (keyForRemove != null) {
      state.edgeIds.remove(keyForRemove);
    }
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

  TripPoint? get getLatestPoint => state.addedPoints.lastOrNull;
}
