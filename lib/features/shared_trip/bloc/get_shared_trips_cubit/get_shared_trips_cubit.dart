import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/features/shared_trip/data/response/shared_trip.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../trip/data/request/filter_trip_request.dart';

part 'get_shared_trips_state.dart';

class GetSharedTripsCubit extends Cubit<GetSharedTripsInitial> {
  GetSharedTripsCubit() : super(GetSharedTripsInitial.initial());

  Future<void> getSharesTrip(
    BuildContext context, {
    List<SharedTripStatus>? tripState,
    FilterTripRequest? filter,
    Command? command,
  }) async {
    emit(
      state.copyWith(
        statuses: CubitStatuses.loading,
        command: command,
        filter: filter,
      ),
    );
    final pair = await getSharesTripApi(tripState: tripState);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      state.command.totalCount = pair.first!.totalCount;
      emit(
        state.copyWith(
          statuses: CubitStatuses.done,
          currentTrips: tripState == null ? pair.first!.items : null,
          oldTrips: tripState != null ? pair.first!.items : null,
        ),
      );
    }
  }

  Future<Pair<SharedTripsResponse?, String?>> getSharesTripApi(
      {List<SharedTripStatus>? tripState}) async {
    final network = sl<NetworkInfo>();

    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getAllSharedTrips,
        query: state.filter.toMap(),
      );

      if (response.statusCode == 200) {
        return Pair(SharedTripsResponse.fromJson(jsonDecode(response.body)), null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
