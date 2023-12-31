import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/home/data/response/home_response.dart';
import 'package:qareeb_models/global.dart';

import '../../../../../core/api_manager/api_service.dart';
import '../../../../../core/error/error_manager.dart';
import '../../../../../core/util/note_message.dart';
import '../../../../../core/util/pair_class.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeInitial> {
  HomeCubit() : super(HomeInitial.initial());

  Future<void> getHome(BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getHomeApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<HomeResult?, String?>> _getHomeApi() async {
    final response = await APIService().getApi(
      url: GetUrl.getHome,
      query: Command.initial().toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(HomeResponse.fromJson(response.json).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
