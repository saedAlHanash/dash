import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/points/data/model/trip_point.dart';
import 'package:qareeb_models/points/data/response/points_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'point_by_id_state.dart';

class PointByIdCubit extends Cubit<PointByIdInitial> {
  PointByIdCubit() : super(PointByIdInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getPointById(BuildContext context, {required int? id}) async {
    if (id == null || id == 0) return;
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getAllPointByIdApi(id: id);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      // _getConnectedPointsApi(point: pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first!));
    }
  }

  Future<void> getConnectedPointById(BuildContext context,
      {required TripPoint point}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _getConnectedPointsApi(point: point);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(
          statuses: CubitStatuses.done, conecctedPoints: pair.first!.items));
    }
  }

  Future<Pair<TripPoint?, String?>> _getAllPointByIdApi({required int id}) async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.pointById,
        query: {'Id': id},
      );

      if (response.statusCode == 200) {
        return Pair(TripPoint.fromJson(response.json['result'] ?? {}), null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }

  Future<Pair<PointsResult?, String?>> _getConnectedPointsApi(
      {required TripPoint point}) async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getConnectedPoints,
        query: {'sourcePointId': point.id},
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body)['result'];

        List<TripPoint> model = json == null
            ? <TripPoint>[]
            : List<TripPoint>.from(json!.map((x) => TripPoint.fromJson(x)));

        return Pair(PointsResult.fromJson({})..items.addAll(model), null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
