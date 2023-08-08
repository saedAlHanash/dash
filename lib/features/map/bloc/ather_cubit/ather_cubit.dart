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


class AtherCubit extends Cubit<AtherInitial> {
  AtherCubit() : super(AtherInitial.initial());

  final network = sl<NetworkInfo>();

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
    if (await network.isConnected) {
      final response = await APIService().getApi(
          url: 'api/api.php',
          query: {
            'api': 'user',
            'ver': '1.0',
            'key': '719FE559BD77F2F3461C0D29D305FA6E',
            'cmd': 'OBJECT_GET_LOCATIONS,${ime.join(';')}',
          },
          hostName: 'admin.alather.net');

      if (response.statusCode == 200) {
        return Pair(AtherResponse.fromJson(response.jsonBody, ime).imes, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
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
