import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/drivers/data/response/status_history_response.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'driver_status_history_state.dart';

class DriverStatusHistoryCubit extends Cubit<DriverStatusHistoryInitial> {
  DriverStatusHistoryCubit() : super(DriverStatusHistoryInitial.initial());

  Future<void> getDriverStatusHistory(BuildContext context,
      {Command? command, int? driverId}) async {
    emit(state.copyWith(
        statuses: CubitStatuses.loading, command: command, driverId: driverId));
    final pair = await _getDriverStatusHistoryApi();

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

  Future<Pair<DriverStatusHistoryResult?, String?>> _getDriverStatusHistoryApi() async {
    final response = await APIService().getApi(
      url: GetUrl.driverStatusHistory,
      query: state.command.toJson()..addAll({'Id': state.driverId}),
    );

    if (response.statusCode == 200) {
      return Pair(DriverStatusHistoryResponse.fromJson(response.json).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  void update() {
    emit(state.copyWith());
  }
}
