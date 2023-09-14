import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/osm_name_model.dart';

part 'location_name_state.dart';

class LocationNameCubit extends Cubit<LocationNameInitial> {
  LocationNameCubit({required this.network})
      : super(LocationNameInitial.initial());

  final NetworkInfo network;

  Future<void> getLocationName(
    BuildContext context, {
    required LatLng latLng,
    required bool isStart,
  }) async {

    final pair = await getLocationNameApi(latLng: latLng);



    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      // emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      if (context.mounted) {

      }

      emit(state.copyWith(
          statuses: CubitStatuses.done,
          startLocationName: isStart ? pair.first : null,
          endLocationName: isStart ? null : pair.first,
          request: latLng,
          isStart: isStart));
    }
  }



static  Future<Pair<String?, String?>> getLocationNameApi({
    required LatLng latLng,
  }) async {
      final response = await APIService().getApi(
          url: OsrmUrl.getLocationName,
          hostName: OsrmUrl.hostOsmName,
          query: {
            'lat': '${latLng.latitude}',
            'lon': '${latLng.longitude}',
            'format': 'json',
          });

      if (response.statusCode == 200) {
        final result = OsmNameModel.fromJson(jsonDecode(response.body));

        return Pair(result.address.getName(), null);
      } else {
        return Pair(null, 'Error Map Server  code: ${response.statusCode}');
      }

  }
}
