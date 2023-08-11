import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/previous_trips/data/response/trips_response.dart';
import '../../../../../core/strings/enum_manager.dart';
import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';

part 'previous_trips_state.dart';

class PreviousTripsCubit extends Cubit<PreviousTripsInitial> {
  PreviousTripsCubit() : super(PreviousTripsInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getPreviousTrips(BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getPreviousTripsApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first?.items));
    }
  }

  Future<Pair<TripsResult?, String?>> _getPreviousTripsApi() async {
    if (await network.isConnected) {
      final response = await APIService().getApi(url: GetUrl.getPreviousTrips);

      if (response.statusCode == 200) {
        return Pair(TripsResponse.fromJson(response.jsonBody).result, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
