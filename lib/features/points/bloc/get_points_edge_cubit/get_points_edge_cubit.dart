import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/points_edge_response.dart';

part 'get_points_edge_state.dart';

class PointsEdgeCubit extends Cubit<PointsEdgeInitial> {
  PointsEdgeCubit() : super(PointsEdgeInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getPointsEdge(BuildContext context,
      {required int? start, required int end}) async {

    if (start == null) return;

    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _getPointsEdgeApi(start: start, end: end);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<PointsEdgeResult?, String?>> _getPointsEdgeApi(
      {required int start, required int end}) async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getPointsEdge,
        query: {
          'firstPointId': start,
          'secondPointId': end,
        },
      );

      if (response.statusCode == 200) {
        return Pair(PointsEdgeResponse.fromJson(jsonDecode(response.body)).result, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
