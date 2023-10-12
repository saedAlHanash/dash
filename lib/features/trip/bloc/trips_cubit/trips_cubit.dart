import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'trips_state.dart';

class TripsCubit extends Cubit<TripsInitial> {
  TripsCubit() : super(TripsInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getTrips(BuildContext context, {Command? command}) async {
    emit(
      state.copyWith(
        statuses: CubitStatuses.loading,
        command: command,
      ),
    );
    final pair = await _getTripsApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      state.command.totalCount = pair.first!.totalCount;
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first!.items));
    }
  }

  Future<Pair<TripResult?, String?>> _getTripsApi() async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getTrips,
        query: state.command.toJson(),
      );

      if (response.statusCode == 200) {
        return Pair(TripsResponse.fromJson(response.json).result, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
