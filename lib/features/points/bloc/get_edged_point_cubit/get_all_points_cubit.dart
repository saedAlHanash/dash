import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/features/points/data/response/points_response.dart';
import 'package:qareeb_models/points/data/model/trip_point.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import 'package:qareeb_models/global.dart'; import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/widgets/spinner_widget.dart';import '../../../../core/widgets/spinner_widget.dart'; import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/points/data/response/points_response.dart';
part 'get_all_points_state.dart';

class PointsCubit extends Cubit<PointsInitial> {
  PointsCubit() : super(PointsInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getAllPoints(BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getAllPointsApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first!.items));
    }
  }

  Future<void> getConnectedPoints(BuildContext context,
      {required TripPoint? point}) async {
    if (point == null) {
      getAllPoints(context);
      return;
    }

    emit(state.copyWith(statuses: CubitStatuses.loading, tempPoint: point));

    final pair = await _getConnectedPointsApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first!.items));
    }
  }

  Future<Pair<PointsResult?, String?>> _getAllPointsApi() async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getAllPoints,
        query: Command.noPagination().toJson(),
      );

      if (response.statusCode == 200) {
        return Pair(PointsResponse.fromJson(jsonDecode(response.body)).result, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }

  Future<Pair<PointsResult?, String?>> _getConnectedPointsApi() async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getConnectedPoints,
        query: {'sourcePointId': state.tempPoint.id},
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
