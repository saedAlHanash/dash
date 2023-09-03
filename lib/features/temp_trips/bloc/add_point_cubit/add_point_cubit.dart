import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';

import '../../../points/data/response/points_response.dart';

import '../../data/response/temp_trips_response.dart';

part 'add_point_state.dart';

class AddPointCubit extends Cubit<AddPointInitial> {
  AddPointCubit() : super(AddPointInitial.initial());

  void addPoint({required TripPoint? point}) {
    if (point == null) return;
    state.addedPoints.add(point);
    emit(state.copyWith());
  }

  void addEdge({required int edgeId, required int pointId}) {
    state.edgeIds.add( edgeId);
  }

  void removeEdge() {

    state.edgeIds.removeLast();
  }

  void fromTempModel({required TempTripModel model}) {
    model.path.edges.forEachIndexed((i, e) {
      if (i == 0) {
        state.addedPoints.add(e.startPoint);
        state.addedPoints.add(e.endPoint);
      } else {
        state.addedPoints.add(e.endPoint);
      }
      addEdge(edgeId: e.id, pointId: e.endPointId);
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

  TripPoint? get getLatestPoint => state.addedPoints.lastOrNull;
}
