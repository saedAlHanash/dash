import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../map/bloc/ather_cubit/ather_cubit.dart';
import '../../data/response/shared_trip.dart';

part 'update_shared_state.dart';

class UpdateSharedCubit extends Cubit<UpdateSharedInitial> {
  UpdateSharedCubit() : super(UpdateSharedInitial.initial());
  final network = sl<NetworkInfo>();

  Future<void> updateSharedTrip(
    BuildContext context, {
    required SharedTrip trip,
    required SharedTripStatus tState,
  }) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, trip: trip, tState: tState));

    final pair = await _updateSharedTripApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<SharedTrip?, String?>> _updateSharedTripApi() async {
    num distance = 0;
    try {
      distance = await AtherCubit.getDriverDistance(
        ime: '359632107579978',
        start: state.trip.startDate,
        end: await APIService().getServerTime(),
      );
    } on Exception {
      loggerObject.e('error');
    }
    if (await network.isConnected) {
      final response = await APIService().patchApi(
        url: PathUrl.updateSharedTrip,
        body: {
          "tripId": state.trip.id,
          "status": state.tState.upperFirst,
        },
        query: {'distance': distance},
      );

      if (response.statusCode == 200) {
        return Pair(SharedTripResponse.fromJson(response.jsonBody).result, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
