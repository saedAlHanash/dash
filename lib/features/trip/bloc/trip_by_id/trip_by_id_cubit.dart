import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import 'package:qareeb_models/global.dart'; import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';

part 'trip_by_id_state.dart';

class TripByIdCubit extends Cubit<TripByIdInitial> {
  TripByIdCubit() : super(TripByIdInitial.initial());

  Future<void> tripById(BuildContext context, {required int tripId}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await tripByIdApi(tripId: tripId);


    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  static Future<Pair<TripResult?, String?>> tripByIdApi({required tripId}) async {
    final response =
        await APIService().getApi(url: GetUrl.tripById, query: {'Id': tripId});

    if (response.statusCode == 200) {
      final trip = TripResponse.fromJson(jsonDecode(response.body)).result;
      AppSharedPreference.cashTrip(trip);
      return Pair(trip, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
