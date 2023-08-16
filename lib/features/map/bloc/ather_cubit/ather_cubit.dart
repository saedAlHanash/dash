import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:qareeb_dash/core/api_manager/server_proxy/server_proxy_request.dart';
import 'package:qareeb_dash/core/api_manager/server_proxy/server_proxy_service.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_dash/features/map/bloc/map_controller_cubit/map_controller_cubit.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/ather_response.dart';

part 'ather_state.dart';

const atherKey = '5BE3080722588655FE55B8E89B765827';

class AtherCubit extends Cubit<AtherInitial> {
  AtherCubit() : super(AtherInitial.initial());

  Future<void> getDriverLocation() async {
    if (isClosed) return;
    var ime = AppSharedPreference.getIme();

    if (ime.isEmpty) return;

    final pair = await _getDriverLocationApi(ime);

    if (pair.first != null) {
      if (isClosed) return;
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Ime>?, String?>> _getDriverLocationApi(List<String> ime) async {
    // var ime = '359632104211708';
    final pair = await getServerProxyApi(
      request: ApiServerRequest(
        url: APIService()
            .getUri(
              url: 'api/api.php',
              query: {
                'api': 'user',
                'ver': '1.0',
                'key': atherKey,
                'cmd': 'OBJECT_GET_LOCATIONS,${ime.join(';')}',
              },
              hostName: 'admin.alather.net',
            )
            .toString(),
      ),
    );

    if (pair.first != null) {
      return Pair(AtherResponse.fromJson(jsonDecode(pair.first), ime).imes, null);
    } else {
      return Pair(null, pair.second ?? '');
    }
  }

  static Future<num> getDriverDistance({
    required String ime,
    required DateTime? start,
    required DateTime? end,
  }) async {
    if (start == null) return 0;
    if (end == null) return 0;
    if (ime.isEmpty) return 0;
    // var ime = '359632104211708';

    final pair = await getServerProxyApi(
      request: ApiServerRequest(
        url: APIService()
            .getUri(
              url: 'api/api.php',
              query: {
                'api': 'user',
                'ver': '1.0',
                'key': atherKey,
                'cmd':
                    'OBJECT_GET_MESSAGES,$ime,${start.formatDateAther},${end.formatDateAther}',
              },
              hostName: 'admin.alather.net',
            )
            .toString(),
      ),
    );

    if (pair.first != null) {
      final list = <LatLng>[];
      var f1 = jsonDecode(pair.first);
      for (var e in f1) {
        list.add(LatLng(double.parse(e[1]), double.parse(e[2])));
      }
      var d = 0.0;
      for (var i = 1; i < list.length; i++) {
        d += distanceBetween(list[i - 1], list[i]) * 1000;
      }
      return d.roundToDouble();
    } else {
      return 0;
    }
  }
}

double calculateDistance(List<LatLng> points) {
  const double earthRadius = 6371000; // in meters
  double totalDistance = 0;

  for (int i = 0; i < points.length - 1; i++) {
    final p1 = points[i];
    final p2 = points[i + 1];

    final lat1 = p1.latitude * pi / 180;
    final lat2 = p2.latitude * pi / 180;
    final lon1 = p1.longitude * pi / 180;
    final lon2 = p2.longitude * pi / 180;

    final dLat = lat2 - lat1;
    final dLon = lon2 - lon1;

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final distance = earthRadius * c;
    totalDistance += distance;
  }

  return totalDistance;
}
