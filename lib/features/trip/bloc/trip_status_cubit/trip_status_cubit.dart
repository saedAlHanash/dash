import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_package/map/bloc/ather_cubit/ather_cubit.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../data/request/update_trip_request.dart';

part 'trip_status_state.dart';

class ChangeTripStatusCubit extends Cubit<ChangeTripStatusInitial> {
  ChangeTripStatusCubit() : super(ChangeTripStatusInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> changeTripStatus(BuildContext context,
      {required UpdateTripRequest request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));

    final pair = await _changeTripStatusApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error));
    } else {
      AppSharedPreference.removeCashedTrip();
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _changeTripStatusApi() async {
    if (await network.isConnected) {
      final response = await APIService().puttApi(
        url: PutUrl.updateTrip,
        body: state.request.toJson(),
      );

      if (response.statusCode == 200) {
        return Pair(true, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
