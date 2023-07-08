import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../services/osrm/data/response/osrm_model.dart';
import '../../data/request/create_edg_request.dart';

part 'create_edge_state.dart';

class CreateEdgeCubit extends Cubit<CreateEdgeInitial> {
  CreateEdgeCubit() : super(CreateEdgeInitial.initial());

  Future<void> createEdge(
    BuildContext context, {
    required CreateEdgeRequest request,
  }) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final saed = await APIService().getApiProxyPayed(
        url: 'https://router.project-osrm.org/route/v1/driving',
        path:
            '${request.startPointLatLng?.longitude},${request.startPointLatLng?.latitude};'
            '${request.endPointLatLng?.longitude},${request.endPointLatLng?.latitude}');

    if (saed.statusCode == 200) {
      final osrm = OsrmModel.fromJson(saed.jsonBody);

      request.distance = osrm.routes.first.distance;
      request.steps = osrm.routes.first.geometry;

      final pair = await _createEdgeApi(request: request);

      if (pair.first == null) {
        if (context.mounted) {
          NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
        }
        emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      } else {
        emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
      }
    }
  }

  Future<Pair<bool?, String?>> _createEdgeApi(
      {required CreateEdgeRequest request}) async {
    late Response response;

    if (request.id != null) {
      response = await APIService().puttApi(
        url: PutUrl.updateEdge,
        body: request.toJson(),
      );
    } else {
      response = await APIService().postApi(
        url: PostUrl.createEdge,
        body: request.toJson(),
      );
    }

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
