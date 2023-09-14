import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/previous_trips/data/response/trips_response.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/filter_trip_request.dart';

part 'all_trips_state.dart';

class AllTripsCubit extends Cubit<AllTripsInitial> {
  AllTripsCubit() : super(AllTripsInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getAllTrips(BuildContext context,
      {FilterTripRequest? filter, Command? command}) async {
    emit(
      state.copyWith(
        statuses: CubitStatuses.loading,
        command: command,
        filter: filter,
      ),
    );
    final pair = await _getAllTripsApi();

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

  Future<Pair<TripsResult?, String?>> _getAllTripsApi() async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getAllTrips,
        query: state.filter.toMap()..addAll(state.command.toJson()),
      );

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
