import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/trip_process/data/response/candidate_drivers_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'candidate_drivers_state.dart';

//CandidateDrivers_drivers_cubit
class CandidateDriversCubit extends Cubit<CandidateDriversInitial> {
  CandidateDriversCubit() : super(CandidateDriversInitial.initial());
  final network = sl<NetworkInfo>();

  Future<void> getCandidateDrivers(BuildContext context, {required int tripId}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await getCandidateDriversApi(tripId: tripId);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  static Future<Pair<List<CandidateDriver>?, String?>> getCandidateDriversApi(
      {required tripId}) async {
    if (tripId == 0) return Pair(null, 'no result with ID:0');
    final response = await APIService().getApi(
      url: GetUrl.getCandidateDrivers,
      query: {'Id': tripId},
    );

    if (response.statusCode == 200) {
      final drivers = CandidateDriversResponse.fromJson(jsonDecode(response.body)).result;
      return Pair(drivers, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
