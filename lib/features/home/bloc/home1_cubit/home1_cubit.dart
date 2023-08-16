import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_dash/features/home/data/response/home_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/home1_response.dart';

part 'home1_state.dart';

class Home1Cubit extends Cubit<Home1Initial> {
  Home1Cubit() : super(Home1Initial.initial());

  Future<void> getHome1(BuildContext context, {Command? command}) async {
    if (!AppSharedPreference.isLogin) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));

    final pair = await _getHome1Api();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<Home1Result?, String?>> _getHome1Api() async {
    final response = await APIService().getApi(
      url: GetUrl.home1,
      query: state.command.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(Home1Response.fromJson(response.jsonBody).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  void update() {
    emit(state.copyWith());
  }
}
