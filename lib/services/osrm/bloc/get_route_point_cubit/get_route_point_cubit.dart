import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/app/bloc/loading_cubit.dart';
import 'package:qareeb_dash/services/osrm/data/response/osrm_model.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'get_route_point_state.dart';

class GetRoutePointCubit extends Cubit<GetRoutePointInitial> {
  GetRoutePointCubit() : super(GetRoutePointInitial.initial());
  final network = sl<NetworkInfo>();

  Future<void> getRoutePoint(BuildContext context,
      {required LatLng start, required LatLng end}) async {

    final pair = await _getRoutePointApi(start: start, end: end);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      //  emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<OsrmModel?, String?>> _getRoutePointApi(
      {required LatLng start, required LatLng end}) async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
          url: OsrmUrl.getRoutePoints,
          hostName: OsrmUrl.hostName,
          path: '${start.longitude},${start.latitude};'
              '${end.longitude},${end.latitude}');

      if (response.statusCode == 200) {
        return Pair(OsrmModel.fromJson(jsonDecode(response.body)), null);
      } else {
        return Pair(null, 'error');
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
