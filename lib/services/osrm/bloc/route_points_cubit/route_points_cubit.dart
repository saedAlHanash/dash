import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/app/bloc/loading_cubit.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../features/map/data/response/ors_response.dart';
import '../../../../features/map/data/response/rote_points_result.dart';

part 'route_points_state.dart';

class RoutePointsCubit extends Cubit<RoutePointsInitial> {
  RoutePointsCubit({required this.network}) : super(RoutePointsInitial.initial());

  final NetworkInfo network;

  Future<void> getRotePoints(
    BuildContext context, {
    required LatLng start,
    required LatLng end,
  }) async {
    final pair = await _getRotePointsApi(start: start, end: end);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      // emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<RoutePointsResult?, String?>> _getRotePointsApi({
    required LatLng start,
    required LatLng end,
  }) async {
    if (await network.isConnected) {
      final response = await APIService()
          .getApi(url: OrsUrl.getRoutePoints, hostName: OrsUrl.hostName, query: {
        'api_key': OrsUrl.key,
        'start': '${start.longitude},${start.latitude}',
        'end': '${end.longitude},${end.latitude}',
      });

      if (response.statusCode == 200) {
        final result = OrsResponse.fromJson(jsonDecode(response.body));

        if (result.features.isEmpty || result.features[0].geometry.coordinates.isEmpty) {
          return Pair(null, 'لا يمكن رسم الطريق');
        }

        final model = RoutePointsResult();

        model.points = _getListPoint(result.features);
        model.distance = result.features[0].properties.summary.distance;
        model.duration = result.features[0].properties.summary.duration;

        return Pair(model, null);
      } else {
        return Pair(null, 'Error Map Server  code: ${response.statusCode}');
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }

  List<LatLng> _getListPoint(List<Feature> list) {
    final ss = list[0].geometry.coordinates;
    final latLgs = <LatLng>[];

    for (var e in ss) {
      latLgs.add(LatLng(e[1], e[0]));
    }

    return latLgs;
  }
}
