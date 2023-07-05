import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';

part 'driver_status_state.dart';

class DriverStatusCubit extends Cubit<DriverStatusInitial> {
  DriverStatusCubit() : super(DriverStatusInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> makeDriverAvailable(
    BuildContext context, {
    required bool available,
  }) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _makeDriverAvailableApi(available: available);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      AppSharedPreference.cashDriverAvailable(available);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _makeDriverAvailableApi({
    required bool available,
  }) async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: available ? GetUrl.driverAvailable : GetUrl.driverUnAvailable,
      );

      if (response.statusCode == 200) {
        if (available) {
          try {
            AppSharedPreference.cashIme(response.json['result']['imei']);
          } on Exception {
            loggerObject.e('error get ime from response');
          }
        } else {}

        return Pair(true, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
