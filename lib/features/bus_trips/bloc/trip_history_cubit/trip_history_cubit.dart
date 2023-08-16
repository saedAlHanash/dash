import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/trip_history_response.dart';


part 'trip_history_state.dart';

class AllTripHistoryCubit extends Cubit<AllTripHistoryInitial> {
  AllTripHistoryCubit() : super(AllTripHistoryInitial.initial());

  Future<void> getTripHistory(BuildContext context, {Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));
    final pair = await _getTripHistoryApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      state.command.totalCount = pair.first!.totalCount;
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first?.items));
    }
  }

  Future<Pair<TripHistoryResult?, String?>> _getTripHistoryApi() async {
    final response = await APIService().getApi(
      url: GetUrl.tripHistory,
      query: state.command.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(TripHistoryResponse.fromJson(response.jsonBody).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  void update() {
    emit(state.copyWith());
  }
}
