import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/system_params_response.dart';

part 'system_settings_state.dart';

class SystemSettingsCubit extends Cubit<SystemSettingsInitial> {
  SystemSettingsCubit() : super(SystemSettingsInitial.initial());

  Future<void> getSystemSettings(BuildContext context, {Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));
    final pair = await _getSystemSettingsApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      // state.command.totalCount = pair.first!.totalCount;
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first!));
    }
  }

  Future<Pair<List<SystemSetting>?, String?>> _getSystemSettingsApi() async {
    final response = await APIService().getApi(
      url: GetUrl.systemSettings,
      query: state.command.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(SystemSettingResponse.fromJson(response.json).result.items, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
