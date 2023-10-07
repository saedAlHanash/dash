import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/redeems/data/response/redeems_history_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'redeems_history_state.dart';

class RedeemsHistoryCubit extends Cubit<RedeemsHistoryInitial> {
  RedeemsHistoryCubit() : super(RedeemsHistoryInitial.initial());

  Future<void> getRedeemsHistory(BuildContext context, {int? driverId}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, driverId: driverId));
    final pair = await _getRedeemsHistoryApi(driverId: driverId);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first!.items));
    }
  }

  Future<Pair<RedeemsHistoryResult?, String?>> _getRedeemsHistoryApi(
      {int? driverId}) async {
    final response = await APIService().getApi(
      url: GetUrl.allRedeems,
      query: {'DriverId': driverId},
    );

    if (response.statusCode == 200) {
      return Pair(RedeemsHistoryResponse.fromJson(response.json).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
